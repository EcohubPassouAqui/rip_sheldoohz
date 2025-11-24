--System (Bypass)
if getgenv().EcoHubKernel then 
    warn("[ECOHUB] Sistema já inicializado!")
    return 
end

local KERNEL = {
    Version = "1.0",
    Build = "ECOHUB-MODE",
    Initialized = false,
    StartTime = tick()
}

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Utils = {}

function Utils.GenerateSecureName()
    local prefixes = {"Sys", "Core", "Kernel", "Driver", "Module", "Service"}
    local suffixes = {"Exec", "Handler", "Manager", "Controller", "Engine"}
    local random = math.random(1000, 9999)
    return prefixes[math.random(#prefixes)] .. suffixes[math.random(#suffixes)] .. random
end

function Utils.SafeGetService(serviceName)
    local success, service = pcall(function()
        return game:GetService(serviceName)
    end)
    return success and service or nil
end

local Services = {
    Players = Utils.SafeGetService("Players"),
    RunService = Utils.SafeGetService("RunService"),
    UserInputService = Utils.SafeGetService("UserInputService"),
    CoreGui = Utils.SafeGetService("CoreGui")
}

local Platform = {
    IsMobile = false,
    IsPC = true,
    IsConsole = false
}

pcall(function()
    if Services.UserInputService then
        Platform.IsMobile = Services.UserInputService.TouchEnabled and 
                           not Services.UserInputService.KeyboardEnabled
        Platform.IsPC = not Platform.IsMobile
    end
end)

print("[Plataforma]", Platform.IsMobile and "Mobile Detectado" or "PC Detectado")

local Player = Services.Players.LocalPlayer
if not Player then
    Services.Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    Player = Services.Players.LocalPlayer
end

local KernelConfig = {
    Active = true,
    Protected = true,
    
    TotalRemoved = 0,
    TotalBlocked = 0,
    TotalProtected = 0,
    
    CleanupInterval = Platform.IsMobile and 240 or 60,
    ProcessDelay = Platform.IsMobile and 0.8 or 0.15,
    MaxObjectsPerCycle = Platform.IsMobile and 3 or 15,
    MonitorInterval = Platform.IsMobile and 45 or 20,
    
    LastCleanup = 0,
    LastMonitor = 0,
    
    ProtectionLevel = 3,
    
    SecureID = Utils.GenerateSecureName()
}

print("[Seguranca] ID:", KernelConfig.SecureID)

local Patterns = {
    AntiCheat = {
        "anticheat", "anti_cheat", "anti%-cheat",
        "ac_", "ac%-", "anticheats",
        "cheatdetect", "cheatcheck"
    },
    
    Detection = {
        "detect", "detection", "detector",
        "monitor", "monitoring", "scanner",
        "scan", "check", "checker",
        "guard", "watcher", "observer"
    },
    
    Security = {
        "security", "secure", "protection",
        "antihack", "anti_hack", "anti%-hack",
        "antiexploit", "anti_exploit"
    },
    
    Punishment = {
        "ban", "kick", "remove",
        "punish", "punishment", "blacklist"
    },
    
    Admin = {
        "admin", "mod", "moderator",
        "staff", "owner", "developer"
    }
}

local ProtectedNames = {
    "ecohub", "fluent", "library", "interface",
    "menu", "gui", "ui", "panel", "akali",
    "notif", "notification",
    KernelConfig.SecureID:lower()
}

local DetectionEngine = {}

function DetectionEngine.IsProtected(object)
    if not object or not object.Name then return false end
    
    local name = string.lower(object.Name)
    
    for _, protected in ipairs(ProtectedNames) do
        if string.find(name, protected, 1, true) then
            return true
        end
    end
    
    return false
end

function DetectionEngine.IsSuspicious(name)
    if not name or type(name) ~= "string" then return false end
    
    local lowername = string.lower(name)
    
    for category, patterns in pairs(Patterns) do
        for _, pattern in ipairs(patterns) do
            if string.find(lowername, pattern, 1, true) then
                return true, category
            end
        end
    end
    
    return false
end

function DetectionEngine.GetThreatLevel(object)
    if not object then return 0 end
    
    local level = 0
    local isSuspicious, category = DetectionEngine.IsSuspicious(object.Name)
    
    if isSuspicious then
        if category == "Punishment" then level = 5
        elseif category == "AntiCheat" then level = 4
        elseif category == "Security" then level = 3
        elseif category == "Detection" then level = 2
        else level = 1 end
    end
    
    if object:IsA("LocalScript") or object:IsA("Script") then
        level = level + 1
    end
    
    return level
end

local RemovalEngine = {}

function RemovalEngine.SafeDestroy(object)
    if not object or not object.Parent then return false end
    
    if DetectionEngine.IsProtected(object) then 
        KernelConfig.TotalProtected = KernelConfig.TotalProtected + 1
        return false 
    end
    
    local success = pcall(function()
        if object:IsA("LocalScript") or object:IsA("Script") then
            object.Disabled = true
        end
        
        if object:IsA("BindableEvent") or object:IsA("RemoteEvent") then
            pcall(function() object:Destroy() end)
        end
        
        object.Parent = nil
        object:Destroy()
    end)
    
    if success then
        KernelConfig.TotalRemoved = KernelConfig.TotalRemoved + 1
        return true
    end
    
    return false
end

function RemovalEngine.CleanupCycle()
    local now = tick()
    if now - KernelConfig.LastCleanup < KernelConfig.CleanupInterval then 
        return 
    end
    KernelConfig.LastCleanup = now
    
    task.spawn(function()
        if not KernelConfig.Active or not Player or not Player.PlayerGui then 
            return 
        end
        
        local removed = 0
        local scanned = 0
        
        pcall(function()
            local objects = Player.PlayerGui:GetChildren()
            
            for _, object in ipairs(objects) do
                if removed >= KernelConfig.MaxObjectsPerCycle then break end
                if not KernelConfig.Active then break end
                
                scanned = scanned + 1
                
                local threatLevel = DetectionEngine.GetThreatLevel(object)
                
                if threatLevel >= KernelConfig.ProtectionLevel then
                    if RemovalEngine.SafeDestroy(object) then
                        print(string.format("[Remocao] %s removido [Ameaca: %d]", object.Name, threatLevel))
                        removed = removed + 1
                        task.wait(KernelConfig.ProcessDelay)
                    end
                end
            end
            
            if removed > 0 then
                print(string.format("[Limpeza Completa] %d objetos suspeitos removidos", removed))
            end
        end)
    end)
end

local HookManager = {}

function HookManager.InstallKickProtection()
    if not hookmetamethod then 
        print("[Aviso] hookmetamethod nao disponivel")
        return false
    end
    
    local success = pcall(function()
        local originalNamecall
        originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if method == "Kick" then
                if self == Player or self.Parent == Player then
                    print("[Protecao Ativa] Tentativa de KICK bloqueada!")
                    KernelConfig.TotalBlocked = KernelConfig.TotalBlocked + 1
                    return nil
                end
            end
            
            if method == "Ban" or method == "BanAsync" then
                print("[Protecao Ativa] Tentativa de BAN bloqueada!")
                KernelConfig.TotalBlocked = KernelConfig.TotalBlocked + 1
                return nil
            end
            
            return originalNamecall(self, ...)
        end)
        
        print("[Hook] Protecao Kick/Ban instalada")
    end)
    
    return success
end

function HookManager.InstallUIProtection()
    if not hookmetamethod then return false end
    
    local success = pcall(function()
        local originalNewIndex
        originalNewIndex = hookmetamethod(game, "__newindex", function(self, key, value)
            if KernelConfig.Active and DetectionEngine.IsProtected(self) then
                if (key == "Visible" or key == "Enabled") and value == false then
                    print("[Protecao UI] UI protegida de desativacao")
                    KernelConfig.TotalProtected = KernelConfig.TotalProtected + 1
                    return
                end
            end
            
            return originalNewIndex(self, key, value)
        end)
        
        print("[Hook] Protecao de UI instalada")
    end)
    
    return success
end

local Monitor = {}

function Monitor.LightweightCheck()
    local now = tick()
    if now - KernelConfig.LastMonitor < KernelConfig.MonitorInterval then 
        return 
    end
    KernelConfig.LastMonitor = now
    
    RemovalEngine.CleanupCycle()
end

function Monitor.Start()
    if not Services.RunService then 
        print("[Erro] RunService nao disponivel")
        return false
    end
    
    Services.RunService.Heartbeat:Connect(function()
        if KernelConfig.Active then
            Monitor.LightweightCheck()
        end
    end)
    
    print("[Monitor] Sistema de monitoramento ativo")
    return true
end

local KernelAPI = {}

function KernelAPI.GetStatus()
    return {
        Active = KernelConfig.Active,
        Protected = KernelConfig.Protected,
        Uptime = tick() - KERNEL.StartTime,
        Stats = {
            Removed = KernelConfig.TotalRemoved,
            Blocked = KernelConfig.TotalBlocked,
            Protected = KernelConfig.TotalProtected
        }
    }
end

function KernelAPI.SetProtectionLevel(level)
    if level >= 1 and level <= 3 then
        KernelConfig.ProtectionLevel = level
        print(string.format("[Configuracao] Protecao nivel %d ativada", level))
        return true
    end
    return false
end

function KernelAPI.Enable()
    KernelConfig.Active = true
    print("[Sistema] Protecao ativada")
end

function KernelAPI.Disable()
    KernelConfig.Active = false
    print("[Sistema] Protecao desativada")
end

function KernelAPI.PrintStats()
    local status = KernelAPI.GetStatus()
    
    print(string.format("[Estatisticas EcoHub] Removidos: %d | Bloqueados: %d | Protegidos: %d | Tempo: %ds", 
        status.Stats.Removed, status.Stats.Blocked, status.Stats.Protected, 
        math.floor(status.Uptime)))
end

local function Initialize()
    print("[EcoHub] Iniciando sistema de protecao...")
    print("[Versao]", KERNEL.Version, "|", KERNEL.Build)
    
    local initDelay = Platform.IsMobile and 10 or 4
    
    task.spawn(function()
        task.wait(initDelay)
        
        print("[Instalacao] Instalando protecoes...")
        task.wait(0.5)
        HookManager.InstallKickProtection()
        task.wait(0.5)
        HookManager.InstallUIProtection()
        task.wait(0.5)
        
        Monitor.Start()
        task.wait(0.5)
        
        KERNEL.Initialized = true
        KernelConfig.Active = true
        
        print(string.format("[Sistema Ativo] EcoHub Protecao Nivel %d ativada!", KernelConfig.ProtectionLevel))
    end)
end

getgenv().EcoHubKernel = {
    Version = KERNEL.Version,
    API = KernelAPI,
    Utils = Utils
}

Initialize()

--Painel
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/main/Library/Library.lua'))()

local Window = Library:Window({
    Text = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. " | Eco Hub"
})

local CreditsTab = Window:Tab({
   Text = "Credits"
})

local CombatTab = Window:Tab({
   Text = "Combat"
})

local LocalPlayerTab = Window:Tab({
   Text = "Local Player"
})

local VisualTab = Window:Tab({
   Text = "Visuals"
})


--VisualTab Paginas

--Arrows
local Arrows = VisualTab:Section({
   Text = "Arrows"
})

-- Configurações
local ArrowsEnabled = false
local ArrowConfig = {
   DistFromCenter = 80,
   TriangleHeight = 16,
   TriangleWidth = 16,
   TriangleFilled = true,
   TriangleTransparency = 0,
   TriangleThickness = 1,
   TriangleColor = Color3.fromRGB(255, 255, 255),
   AntiAliasing = false
}

-- Serviços
local Players = game:service("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RS = game:service("RunService")
local V3 = Vector3.new
local V2 = Vector2.new
local CF = CFrame.new
local COS = math.cos
local SIN = math.sin
local RAD = math.rad
local DRAWING = Drawing.new
local CWRAP = coroutine.wrap
local ROUND = math.round

-- Funções
local function GetRelative(pos, char)
    if not char then return V2(0,0) end
    local rootP = char.PrimaryPart.Position
    local camP = Camera.CFrame.Position
    local relative = CF(V3(rootP.X, camP.Y, rootP.Z), camP):PointToObjectSpace(pos)
    return V2(relative.X, relative.Z)
end

local function RelativeToCenter(v)
    return Camera.ViewportSize/2 - v
end

local function RotateVect(v, a)
    a = RAD(a)
    local x = v.x * COS(a) - v.y * SIN(a)
    local y = v.x * SIN(a) + v.y * COS(a)
    return V2(x, y)
end

local function DrawTriangle(color)
    local l = DRAWING("Triangle")
    l.Visible = false
    l.Color = color
    l.Filled = ArrowConfig.TriangleFilled
    l.Thickness = ArrowConfig.TriangleThickness
    l.Transparency = 1-ArrowConfig.TriangleTransparency
    return l
end

local function AntiA(v)
    if (not ArrowConfig.AntiAliasing) then return v end
    return V2(ROUND(v.x), ROUND(v.y))
end

local ActiveArrows = {}

local function ShowArrow(PLAYER)
    local Arrow = DrawTriangle(ArrowConfig.TriangleColor)
    ActiveArrows[PLAYER] = Arrow
    
    local function Update()
        local c ; c = RS.RenderStepped:Connect(function()
            if not ArrowsEnabled then
                Arrow.Visible = false
                return
            end
            
            if PLAYER and PLAYER.Character then
                local CHAR = PLAYER.Character
                local HUM = CHAR:FindFirstChildOfClass("Humanoid")
                if HUM and CHAR.PrimaryPart ~= nil and HUM.Health > 0 then
                    local _,vis = Camera:WorldToViewportPoint(CHAR.PrimaryPart.Position)
                    if vis == false then
                        local rel = GetRelative(CHAR.PrimaryPart.Position, Player.Character)
                        local direction = rel.unit
                        local base  = direction * ArrowConfig.DistFromCenter
                        local sideLength = ArrowConfig.TriangleWidth/2
                        local baseL = base + RotateVect(direction, 90) * sideLength
                        local baseR = base + RotateVect(direction, -90) * sideLength
                        local tip = direction * (ArrowConfig.DistFromCenter + ArrowConfig.TriangleHeight)
                        
                        Arrow.PointA = AntiA(RelativeToCenter(baseL))
                        Arrow.PointB = AntiA(RelativeToCenter(baseR))
                        Arrow.PointC = AntiA(RelativeToCenter(tip))
                        Arrow.Visible = true
                    else Arrow.Visible = false end
                else Arrow.Visible = false end
            else 
                Arrow.Visible = false
                if not PLAYER or not PLAYER.Parent then
                    Arrow:Remove()
                    ActiveArrows[PLAYER] = nil
                    c:Disconnect()
                end
            end
        end)
    end
    CWRAP(Update)()
end

-- UI
Arrows:Check({
   Text = "Enabled",
   Callback = function(bool)
       ArrowsEnabled = bool
       if not bool then
           for _, arrow in pairs(ActiveArrows) do
               arrow.Visible = false
           end
       end
   end
})

Arrows:Slider({
   Text = "Distance From Center",
   Minimum = 50,
   Default = 80,
   Maximum = 150,
   Callback = function(n)
       ArrowConfig.DistFromCenter = n
   end
})

Arrows:Slider({
   Text = "Triangle Size",
   Minimum = 8,
   Default = 16,
   Maximum = 32,
   Callback = function(n)
       ArrowConfig.TriangleHeight = n
       ArrowConfig.TriangleWidth = n
   end
})

-- Inicialização
for _,v in pairs(Players:GetChildren()) do
    if v.Name ~= Player.Name then
        ShowArrow(v)
    end
end

Players.PlayerAdded:Connect(function(v)
    if v.Name ~= Player.Name then
        ShowArrow(v)
    end
end)

--Cornerbox
local CornerBox = VisualTab:Section({
   Text = "Corner Box"
})

-- Configurações
local BoxSettings = {
    Enabled = false,
    Box_Color = Color3.fromRGB(255, 0, 0),
    Box_Thickness = 2,
    Team_Check = false,
    Team_Color = false,
    Autothickness = true,
    Rainbow = false
}

-- Serviços
local Space = game:GetService("Workspace")
local Player = game:GetService("Players").LocalPlayer
local Camera = Space.CurrentCamera
local RS = game:GetService("RunService")

-- Funções auxiliares
local function NewLine(color, thickness)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color
    line.Thickness = thickness
    line.Transparency = 1
    return line
end

local function Vis(lib, state)
    for i, v in pairs(lib) do
        v.Visible = state
    end
end

local function Colorize(lib, color)
    for i, v in pairs(lib) do
        v.Color = color
    end
end

local function Rainbow(lib, delay)
    while BoxSettings.Rainbow do
        for hue = 0, 1, 1/30 do
            if not BoxSettings.Rainbow then break end
            local color = Color3.fromHSV(hue, 0.6, 1)
            Colorize(lib, color)
            wait(delay)
        end
    end
end

-- Função principal de desenho
local function Main(plr)
    repeat wait() until plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil
    
    local Library = {
        TL1 = NewLine(BoxSettings.Box_Color, BoxSettings.Box_Thickness),
        TL2 = NewLine(BoxSettings.Box_Color, BoxSettings.Box_Thickness),
        TR1 = NewLine(BoxSettings.Box_Color, BoxSettings.Box_Thickness),
        TR2 = NewLine(BoxSettings.Box_Color, BoxSettings.Box_Thickness),
        BL1 = NewLine(BoxSettings.Box_Color, BoxSettings.Box_Thickness),
        BL2 = NewLine(BoxSettings.Box_Color, BoxSettings.Box_Thickness),
        BR1 = NewLine(BoxSettings.Box_Color, BoxSettings.Box_Thickness),
        BR2 = NewLine(BoxSettings.Box_Color, BoxSettings.Box_Thickness)
    }
    
    local oripart = Instance.new("Part")
    oripart.Parent = Space
    oripart.Transparency = 1
    oripart.CanCollide = false
    oripart.Size = Vector3.new(1, 1, 1)
    oripart.Position = Vector3.new(0, 0, 0)
    
    local rainbowCoroutine
    
    local function Updater()
        local c
        c = RS.RenderStepped:Connect(function()
            if not BoxSettings.Enabled then
                Vis(Library, false)
                return
            end
            
            if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and 
               plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and 
               plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                
                local Hum = plr.Character
                local HumPos, vis = Camera:WorldToViewportPoint(Hum.HumanoidRootPart.Position)
                
                if vis then
                    oripart.Size = Vector3.new(Hum.HumanoidRootPart.Size.X, Hum.HumanoidRootPart.Size.Y*1.5, Hum.HumanoidRootPart.Size.Z)
                    oripart.CFrame = CFrame.new(Hum.HumanoidRootPart.CFrame.Position, Camera.CFrame.Position)
                    
                    local SizeX = oripart.Size.X
                    local SizeY = oripart.Size.Y
                    local TL = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(SizeX, SizeY, 0)).p)
                    local TR = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(-SizeX, SizeY, 0)).p)
                    local BL = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(SizeX, -SizeY, 0)).p)
                    local BR = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(-SizeX, -SizeY, 0)).p)

                    if not BoxSettings.Rainbow then
                        if BoxSettings.Team_Check then
                            if plr.TeamColor == Player.TeamColor then
                                Colorize(Library, Color3.fromRGB(0, 255, 0))
                            else 
                                Colorize(Library, Color3.fromRGB(255, 0, 0))
                            end
                        elseif BoxSettings.Team_Color then
                            Colorize(Library, plr.TeamColor.Color)
                        else
                            Colorize(Library, BoxSettings.Box_Color)
                        end
                    end

                    local ratio = (Camera.CFrame.p - Hum.HumanoidRootPart.Position).magnitude
                    local offset = math.clamp(1/ratio*750, 2, 300)

                    Library.TL1.From = Vector2.new(TL.X, TL.Y)
                    Library.TL1.To = Vector2.new(TL.X + offset, TL.Y)
                    Library.TL2.From = Vector2.new(TL.X, TL.Y)
                    Library.TL2.To = Vector2.new(TL.X, TL.Y + offset)

                    Library.TR1.From = Vector2.new(TR.X, TR.Y)
                    Library.TR1.To = Vector2.new(TR.X - offset, TR.Y)
                    Library.TR2.From = Vector2.new(TR.X, TR.Y)
                    Library.TR2.To = Vector2.new(TR.X, TR.Y + offset)

                    Library.BL1.From = Vector2.new(BL.X, BL.Y)
                    Library.BL1.To = Vector2.new(BL.X + offset, BL.Y)
                    Library.BL2.From = Vector2.new(BL.X, BL.Y)
                    Library.BL2.To = Vector2.new(BL.X, BL.Y - offset)

                    Library.BR1.From = Vector2.new(BR.X, BR.Y)
                    Library.BR1.To = Vector2.new(BR.X - offset, BR.Y)
                    Library.BR2.From = Vector2.new(BR.X, BR.Y)
                    Library.BR2.To = Vector2.new(BR.X, BR.Y - offset)

                    if BoxSettings.Autothickness then
                        local distance = (Player.Character.HumanoidRootPart.Position - oripart.Position).magnitude
                        local value = math.clamp(1/distance*100, 1, 4)
                        for u, x in pairs(Library) do
                            x.Thickness = value
                        end
                    else 
                        for u, x in pairs(Library) do
                            x.Thickness = BoxSettings.Box_Thickness
                        end
                    end

                    Vis(Library, true)
                else 
                    Vis(Library, false)
                end
            else 
                Vis(Library, false)
                if game:GetService("Players"):FindFirstChild(plr.Name) == nil then
                    for i, v in pairs(Library) do
                        v:Remove()
                    end
                    oripart:Destroy()
                    c:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Updater)()
    
    if BoxSettings.Rainbow then
        rainbowCoroutine = coroutine.wrap(Rainbow)(Library, 0.15)
    end
end

-- UI
CornerBox:Check({
   Text = "Enabled",
   Callback = function(bool)
       BoxSettings.Enabled = bool
   end
})

CornerBox:Check({
   Text = "Rainbow",
   Callback = function(bool)
       BoxSettings.Rainbow = bool
   end
})

CornerBox:Check({
   Text = "Team Check",
   Callback = function(bool)
       BoxSettings.Team_Check = bool
   end
})

CornerBox:Check({
   Text = "Team Color",
   Callback = function(bool)
       BoxSettings.Team_Color = bool
   end
})

CornerBox:Check({
   Text = "Auto Thickness",
   Callback = function(bool)
       BoxSettings.Autothickness = bool
   end
})

CornerBox:Slider({
   Text = "Box Thickness",
   Minimum = 1,
   Default = 2,
   Maximum = 6,
   Callback = function(n)
       BoxSettings.Box_Thickness = n
   end
})

-- Inicialização
for i, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.Name ~= Player.Name then
        coroutine.wrap(Main)(v)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(newplr)
    coroutine.wrap(Main)(newplr)
end)

--Sense
local ESPLocal = VisualTab:Section({
   Text = "ESP Local",
   Side = "Right"
})

local ESPSettings = {
    Enabled = false,
    Box = false,
    BoxColor = Color3.new(1, 0, 0),
    Name = false,
    NameColor = Color3.new(1, 1, 1),
    Distance = false,
    DistanceColor = Color3.new(1, 1, 1),
    HealthBar = false,
    Tracer = false,
    TracerColor = Color3.new(1, 0, 0),
    TracerOrigin = "Bottom",
    Chams = false,
    ChamsColor = Color3.new(1, 0, 0),
    TeamCheck = false
}

local runService = game:GetService("RunService")
local players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local localPlayer = players.LocalPlayer
local camera = workspace.CurrentCamera
local viewportSize = camera.ViewportSize
local container = Instance.new("Folder", gethui and gethui() or game:GetService("CoreGui"))

local floor = math.floor
local round = math.round
local sin = math.sin
local cos = math.cos
local clear = table.clear
local unpack = table.unpack
local find = table.find
local create = table.create
local fromMatrix = CFrame.fromMatrix

local wtvp = camera.WorldToViewportPoint
local isA = workspace.IsA
local getPivot = workspace.GetPivot
local findFirstChild = workspace.FindFirstChild
local findFirstChildOfClass = workspace.FindFirstChildOfClass
local getChildren = workspace.GetChildren
local toOrientation = CFrame.identity.ToOrientation
local pointToObjectSpace = CFrame.identity.PointToObjectSpace
local lerpColor = Color3.new().Lerp
local min2 = Vector2.zero.Min
local max2 = Vector2.zero.Max
local lerp2 = Vector2.zero.Lerp
local min3 = Vector3.zero.Min
local max3 = Vector3.zero.Max

local HEALTH_BAR_OFFSET = Vector2.new(5, 0)
local HEALTH_TEXT_OFFSET = Vector2.new(3, 0)
local HEALTH_BAR_OUTLINE_OFFSET = Vector2.new(0, 1)
local NAME_OFFSET = Vector2.new(0, 2)
local DISTANCE_OFFSET = Vector2.new(0, 2)
local VERTICES = {
    Vector3.new(-1, -1, -1),
    Vector3.new(-1, 1, -1),
    Vector3.new(-1, 1, 1),
    Vector3.new(-1, -1, 1),
    Vector3.new(1, -1, -1),
    Vector3.new(1, 1, -1),
    Vector3.new(1, 1, 1),
    Vector3.new(1, -1, 1)
}

local function isBodyPart(name)
    return name == "Head" or name:find("Torso") or name:find("Leg") or name:find("Arm")
end

local function getBoundingBox(parts)
    local min, max
    for i = 1, #parts do
        local part = parts[i]
        local cframe, size = part.CFrame, part.Size
        min = min3(min or cframe.Position, (cframe - size*0.5).Position)
        max = max3(max or cframe.Position, (cframe + size*0.5).Position)
    end
    local center = (min + max)*0.5
    local front = Vector3.new(center.X, center.Y, max.Z)
    return CFrame.new(center, front), max - min
end

local function worldToScreen(world)
    local screen, inBounds = wtvp(camera, world)
    return Vector2.new(screen.X, screen.Y), inBounds, screen.Z
end

local function calculateCorners(cframe, size)
    local corners = create(#VERTICES)
    for i = 1, #VERTICES do
        corners[i] = worldToScreen((cframe + size*0.5*VERTICES[i]).Position)
    end
    local min = min2(viewportSize, unpack(corners))
    local max = max2(Vector2.zero, unpack(corners))
    return {
        corners = corners,
        topLeft = Vector2.new(floor(min.X), floor(min.Y)),
        topRight = Vector2.new(floor(max.X), floor(min.Y)),
        bottomLeft = Vector2.new(floor(min.X), floor(max.Y)),
        bottomRight = Vector2.new(floor(max.X), floor(max.Y))
    }
end

local EspObject = {}
EspObject.__index = EspObject

function EspObject.new(player)
    local self = setmetatable({}, EspObject)
    self.player = player
    self:Construct()
    return self
end

function EspObject:_create(class, properties)
    local drawing = Drawing.new(class)
    for property, value in next, properties do
        pcall(function() drawing[property] = value end)
    end
    self.bin[#self.bin + 1] = drawing
    return drawing
end

function EspObject:Construct()
    self.charCache = {}
    self.childCount = 0
    self.bin = {}
    self.drawings = {
        visible = {
            boxOutline = self:_create("Square", { Thickness = 3, Visible = false }),
            box = self:_create("Square", { Thickness = 1, Visible = false }),
            healthBarOutline = self:_create("Line", { Thickness = 3, Visible = false }),
            healthBar = self:_create("Line", { Thickness = 1, Visible = false }),
            name = self:_create("Text", { Text = self.player.DisplayName, Center = true, Visible = false }),
            distance = self:_create("Text", { Center = true, Visible = false }),
            tracerOutline = self:_create("Line", { Thickness = 3, Visible = false }),
            tracer = self:_create("Line", { Thickness = 1, Visible = false })
        }
    }

    self.renderConnection = runService.Heartbeat:Connect(function()
        self:Update()
        self:Render()
    end)
end

function EspObject:Destruct()
    self.renderConnection:Disconnect()
    for i = 1, #self.bin do
        self.bin[i]:Remove()
    end
    clear(self)
end

function EspObject:Update()
    self.character = self.player.Character
    self.health, self.maxHealth = 100, 100
    
    if self.character then
        local humanoid = findFirstChildOfClass(self.character, "Humanoid")
        if humanoid then
            self.health = humanoid.Health
            self.maxHealth = humanoid.MaxHealth
        end
    end
    
    self.enabled = ESPSettings.Enabled and self.character

    local head = self.enabled and findFirstChild(self.character, "Head")
    if not head then
        self.charCache = {}
        self.onScreen = false
        return
    end

    local _, onScreen, depth = worldToScreen(head.Position)
    self.onScreen = onScreen
    self.distance = depth

    if self.onScreen then
        local cache = self.charCache
        local children = getChildren(self.character)
        if not cache[1] or self.childCount ~= #children then
            clear(cache)
            for i = 1, #children do
                local part = children[i]
                if isA(part, "BasePart") and isBodyPart(part.Name) then
                    cache[#cache + 1] = part
                end
            end
            self.childCount = #children
        end
        self.corners = calculateCorners(getBoundingBox(cache))
    end
end

function EspObject:Render()
    local onScreen = self.onScreen or false
    local enabled = self.enabled or false
    local visible = self.drawings.visible
    local corners = self.corners

    visible.box.Visible = enabled and onScreen and ESPSettings.Box
    visible.boxOutline.Visible = visible.box.Visible
    if visible.box.Visible then
        local box = visible.box
        box.Position = corners.topLeft
        box.Size = corners.bottomRight - corners.topLeft
        box.Color = ESPSettings.BoxColor
        box.Transparency = 1

        local boxOutline = visible.boxOutline
        boxOutline.Position = box.Position
        boxOutline.Size = box.Size
        boxOutline.Color = Color3.new()
        boxOutline.Transparency = 1
    end

    visible.healthBar.Visible = enabled and onScreen and ESPSettings.HealthBar
    visible.healthBarOutline.Visible = visible.healthBar.Visible
    if visible.healthBar.Visible then
        local barFrom = corners.topLeft - HEALTH_BAR_OFFSET
        local barTo = corners.bottomLeft - HEALTH_BAR_OFFSET

        local healthBar = visible.healthBar
        healthBar.To = barTo
        healthBar.From = lerp2(barTo, barFrom, self.health/self.maxHealth)
        healthBar.Color = lerpColor(Color3.new(1,0,0), Color3.new(0,1,0), self.health/self.maxHealth)

        local healthBarOutline = visible.healthBarOutline
        healthBarOutline.To = barTo + HEALTH_BAR_OUTLINE_OFFSET
        healthBarOutline.From = barFrom - HEALTH_BAR_OUTLINE_OFFSET
        healthBarOutline.Color = Color3.new()
        healthBarOutline.Transparency = 0.5
    end

    visible.name.Visible = enabled and onScreen and ESPSettings.Name
    if visible.name.Visible then
        local name = visible.name
        name.Size = 13
        name.Font = 2
        name.Color = ESPSettings.NameColor
        name.Transparency = 1
        name.Outline = true
        name.OutlineColor = Color3.new()
        name.Position = (corners.topLeft + corners.topRight)*0.5 - Vector2.yAxis*name.TextBounds.Y - NAME_OFFSET
    end

    visible.distance.Visible = enabled and onScreen and self.distance and ESPSettings.Distance
    if visible.distance.Visible then
        local distance = visible.distance
        distance.Text = round(self.distance) .. " studs"
        distance.Size = 13
        distance.Font = 2
        distance.Color = ESPSettings.DistanceColor
        distance.Transparency = 1
        distance.Outline = true
        distance.OutlineColor = Color3.new()
        distance.Position = (corners.bottomLeft + corners.bottomRight)*0.5 + DISTANCE_OFFSET
    end

    visible.tracer.Visible = enabled and onScreen and ESPSettings.Tracer
    visible.tracerOutline.Visible = visible.tracer.Visible
    if visible.tracer.Visible then
        local tracer = visible.tracer
        tracer.Color = ESPSettings.TracerColor
        tracer.Transparency = 1
        tracer.To = (corners.bottomLeft + corners.bottomRight)*0.5
        tracer.From = 
            ESPSettings.TracerOrigin == "Middle" and viewportSize*0.5 or
            ESPSettings.TracerOrigin == "Top" and viewportSize*Vector2.new(0.5, 0) or
            viewportSize*Vector2.new(0.5, 1)

        local tracerOutline = visible.tracerOutline
        tracerOutline.Color = Color3.new()
        tracerOutline.Transparency = 1
        tracerOutline.To = tracer.To
        tracerOutline.From = tracer.From
    end
end

local ChamObject = {}
ChamObject.__index = ChamObject

function ChamObject.new(player)
    local self = setmetatable({}, ChamObject)
    self.player = player
    self:Construct()
    return self
end

function ChamObject:Construct()
    self.highlight = Instance.new("Highlight", container)
    self.updateConnection = runService.Heartbeat:Connect(function()
        self:Update()
    end)
end

function ChamObject:Destruct()
    self.updateConnection:Disconnect()
    self.highlight:Destroy()
    clear(self)
end

function ChamObject:Update()
    local highlight = self.highlight
    local character = self.player.Character
    local enabled = ESPSettings.Enabled and ESPSettings.Chams and character

    highlight.Enabled = enabled
    if highlight.Enabled then
        highlight.Adornee = character
        highlight.FillColor = ESPSettings.ChamsColor
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = ESPSettings.ChamsColor
        highlight.OutlineTransparency = 0
        highlight.DepthMode = "AlwaysOnTop"
    end
end

local objectCache = {}

local function createObject(player)
    if player ~= localPlayer then
        objectCache[player] = {
            EspObject.new(player),
            ChamObject.new(player)
        }
    end
end

local function removeObject(player)
    local object = objectCache[player]
    if object then
        for i = 1, #object do
            object[i]:Destruct()
        end
        objectCache[player] = nil
    end
end

for _, player in pairs(players:GetPlayers()) do
    createObject(player)
end

players.PlayerAdded:Connect(createObject)
players.PlayerRemoving:Connect(removeObject)

ESPLocal:Check({
   Text = "Enabled",
   Callback = function(bool)
       ESPSettings.Enabled = bool
   end
})

ESPLocal:Check({
   Text = "Box",
   Callback = function(bool)
       ESPSettings.Box = bool
   end
})

ESPLocal:Check({
   Text = "Name",
   Callback = function(bool)
       ESPSettings.Name = bool
   end
})

ESPLocal:Check({
   Text = "Distance",
   Callback = function(bool)
       ESPSettings.Distance = bool
   end
})

ESPLocal:Check({
   Text = "Health Bar",
   Callback = function(bool)
       ESPSettings.HealthBar = bool
   end
})

ESPLocal:Check({
   Text = "Tracer",
   Callback = function(bool)
       ESPSettings.Tracer = bool
   end
})

ESPLocal:Check({
   Text = "Chams",
   Callback = function(bool)
       ESPSettings.Chams = bool
   end
})

ESPLocal:Check({
   Text = "Team Check",
   Callback = function(bool)
       ESPSettings.TeamCheck = bool
   end
})

--Radar
local RadarMap = VisualTab:Section({
   Text = "Radar Map",
   Side = "Right"
})

-- Configurações
local RadarSettings = {
    Enabled = false,
    Position = Vector2.new(200, 200),
    Radius = 100,
    Scale = 1,
    RadarBack = Color3.fromRGB(10, 10, 10),
    RadarBorder = Color3.fromRGB(75, 75, 75),
    LocalPlayerDot = Color3.fromRGB(255, 255, 255),
    PlayerDot = Color3.fromRGB(60, 170, 255),
    Team = Color3.fromRGB(0, 255, 0),
    Enemy = Color3.fromRGB(255, 0, 0),
    Health_Color = false,
    Team_Check = true
}

-- Serviços
local Players = game:service("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = game:service("Workspace").CurrentCamera
local RS = game:service("RunService")
local UIS = game:service("UserInputService")

repeat wait() until Player.Character ~= nil and Player.Character.PrimaryPart ~= nil

local LerpColorModule = loadstring(game:HttpGet("https://pastebin.com/raw/wRnsJeid"))()
local HealthBarLerp = LerpColorModule:Lerp(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0))

-- Funções auxiliares
local function NewCircle(Transparency, Color, Radius, Filled, Thickness)
    local c = Drawing.new("Circle")
    c.Transparency = Transparency
    c.Color = Color
    c.Visible = false
    c.Thickness = Thickness
    c.Position = Vector2.new(0, 0)
    c.Radius = Radius
    c.NumSides = math.clamp(Radius*55/100, 10, 75)
    c.Filled = Filled
    return c
end

local RadarBackground = NewCircle(0.9, RadarSettings.RadarBack, RadarSettings.Radius, true, 1)
local RadarBorder = NewCircle(0.75, RadarSettings.RadarBorder, RadarSettings.Radius, false, 3)

local function GetRelative(pos)
    local char = Player.Character
    if char ~= nil and char.PrimaryPart ~= nil then
        local pmpart = char.PrimaryPart
        local camerapos = Vector3.new(Camera.CFrame.Position.X, pmpart.Position.Y, Camera.CFrame.Position.Z)
        local newcf = CFrame.new(pmpart.Position, camerapos)
        local r = newcf:PointToObjectSpace(pos)
        return r.X, r.Z
    else
        return 0, 0
    end
end

local ActiveDots = {}

local function PlaceDot(plr)
    local PlayerDot = NewCircle(1, RadarSettings.PlayerDot, 3, true, 1)
    ActiveDots[plr] = PlayerDot

    local function Update()
        local c 
        c = RS.RenderStepped:Connect(function()
            if not RadarSettings.Enabled then
                PlayerDot.Visible = false
                return
            end

            local char = plr.Character
            if char and char:FindFirstChildOfClass("Humanoid") and char.PrimaryPart ~= nil and char:FindFirstChildOfClass("Humanoid").Health > 0 then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local scale = RadarSettings.Scale
                local relx, rely = GetRelative(char.PrimaryPart.Position)
                local newpos = RadarSettings.Position - Vector2.new(relx * scale, rely * scale) 
                
                if (newpos - RadarSettings.Position).magnitude < RadarSettings.Radius-2 then 
                    PlayerDot.Radius = 3   
                    PlayerDot.Position = newpos
                    PlayerDot.Visible = true
                else 
                    local dist = (RadarSettings.Position - newpos).magnitude
                    local calc = (RadarSettings.Position - newpos).unit * (dist - RadarSettings.Radius)
                    local inside = Vector2.new(newpos.X + calc.X, newpos.Y + calc.Y)
                    PlayerDot.Radius = 2
                    PlayerDot.Position = inside
                    PlayerDot.Visible = true
                end

                PlayerDot.Color = RadarSettings.PlayerDot
                if RadarSettings.Team_Check then
                    if plr.TeamColor == Player.TeamColor then
                        PlayerDot.Color = RadarSettings.Team
                    else
                        PlayerDot.Color = RadarSettings.Enemy
                    end
                end

                if RadarSettings.Health_Color then
                    PlayerDot.Color = HealthBarLerp(hum.Health / hum.MaxHealth)
                end
            else 
                PlayerDot.Visible = false
                if Players:FindFirstChild(plr.Name) == nil then
                    PlayerDot:Remove()
                    ActiveDots[plr] = nil
                    c:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
end

local function NewLocalDot()
    local d = Drawing.new("Triangle")
    d.Visible = false
    d.Thickness = 1
    d.Filled = true
    d.Color = RadarSettings.LocalPlayerDot
    d.PointA = RadarSettings.Position + Vector2.new(0, -6)
    d.PointB = RadarSettings.Position + Vector2.new(-3, 6)
    d.PointC = RadarSettings.Position + Vector2.new(3, 6)
    return d
end

local LocalPlayerDot = NewLocalDot()

-- Inicialização
for _,v in pairs(Players:GetChildren()) do
    if v.Name ~= Player.Name then
        PlaceDot(v)
    end
end

Players.PlayerAdded:Connect(function(v)
    if v.Name ~= Player.Name then
        PlaceDot(v)
    end
    LocalPlayerDot:Remove()
    LocalPlayerDot = NewLocalDot()
end)

-- Loop de atualização
coroutine.wrap(function()
    local c 
    c = RS.RenderStepped:Connect(function()
        if RadarSettings.Enabled then
            RadarBackground.Visible = true
            RadarBorder.Visible = true
            LocalPlayerDot.Visible = true
        else
            RadarBackground.Visible = false
            RadarBorder.Visible = false
            LocalPlayerDot.Visible = false
        end

        if LocalPlayerDot ~= nil then
            LocalPlayerDot.Color = RadarSettings.LocalPlayerDot
            LocalPlayerDot.PointA = RadarSettings.Position + Vector2.new(0, -6)
            LocalPlayerDot.PointB = RadarSettings.Position + Vector2.new(-3, 6)
            LocalPlayerDot.PointC = RadarSettings.Position + Vector2.new(3, 6)
        end
        
        RadarBackground.Position = RadarSettings.Position
        RadarBackground.Radius = RadarSettings.Radius
        RadarBackground.Color = RadarSettings.RadarBack

        RadarBorder.Position = RadarSettings.Position
        RadarBorder.Radius = RadarSettings.Radius
        RadarBorder.Color = RadarSettings.RadarBorder
    end)
end)()

-- Draggable
local inset = game:service("GuiService"):GetGuiInset()
local dragging = false
local offset = Vector2.new(0, 0)

UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and (Vector2.new(Mouse.X, Mouse.Y + inset.Y) - RadarSettings.Position).magnitude < RadarSettings.Radius then
        offset = RadarSettings.Position - Vector2.new(Mouse.X, Mouse.Y)
        dragging = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

coroutine.wrap(function()
    local dot = NewCircle(1, Color3.fromRGB(255, 255, 255), 3, true, 1)
    local c 
    c = RS.RenderStepped:Connect(function()
        if (Vector2.new(Mouse.X, Mouse.Y + inset.Y) - RadarSettings.Position).magnitude < RadarSettings.Radius then
            dot.Position = Vector2.new(Mouse.X, Mouse.Y + inset.Y)
            dot.Visible = true
        else 
            dot.Visible = false
        end
        if dragging then
            RadarSettings.Position = Vector2.new(Mouse.X, Mouse.Y) + offset
        end
    end)
end)()

-- UI
RadarMap:Check({
   Text = "Enabled",
   Callback = function(bool)
       RadarSettings.Enabled = bool
   end
})

RadarMap:Check({
   Text = "Team Check",
   Callback = function(bool)
       RadarSettings.Team_Check = bool
   end
})

RadarMap:Check({
   Text = "Health Color",
   Callback = function(bool)
       RadarSettings.Health_Color = bool
   end
})

RadarMap:Slider({
   Text = "Radar Size",
   Minimum = 50,
   Default = 100,
   Maximum = 200,
   Callback = function(n)
       RadarSettings.Radius = n
   end
})

RadarMap:Slider({
   Text = "Scale",
   Minimum = 1,
   Default = 1,
   Maximum = 5,
   Callback = function(n)
       RadarSettings.Scale = n
   end
})

--LocalPlayerTab Paginas

--Todos 
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local SpeedSettings = {
    Enabled = false,
    Speed = 50
}

local FlySettings = {
    Enabled = false,
    Speed = 50
}

local JumpSettings = {
    InfiniteJump = false,
    SuperJump = false,
    AutoJump = false,
    JumpPower = 100
}

local NoClipSettings = {
    Enabled = false
}

local GodModeSettings = {
    Enabled = false
}

local InvisibilitySettings = {
    Enabled = false
}

local StaminaSettings = {
    Infinite = false
}

local GravitySettings = {
    Enabled = false,
    Gravity = 196.2
}

local FlyConnection = nil
local NoClipConnection = nil
local AutoJumpConnection = nil
local InfiniteJumpConnection = nil
local SpeedConnection = nil
local GodModeConnection = nil
local StaminaConnection = nil
local OriginalWalkSpeed = 16
local OriginalJumpPower = 50
local OriginalGravity = 196.2

local function ToggleSpeed(enabled)
    if SpeedConnection then
        SpeedConnection:Disconnect()
        SpeedConnection = nil
    end
    
    if enabled then
        SpeedConnection = RunService.Heartbeat:Connect(function()
            if SpeedSettings.Enabled and Humanoid then
                Humanoid.WalkSpeed = SpeedSettings.Speed
            end
        end)
    else
        if Humanoid then
            Humanoid.WalkSpeed = OriginalWalkSpeed
        end
    end
end

local function UpdateSpeed(speed)
    SpeedSettings.Speed = speed
end

local function ToggleFly(enabled)
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
    
    if HumanoidRootPart then
        if HumanoidRootPart:FindFirstChild("BodyVelocity") then
            HumanoidRootPart.BodyVelocity:Destroy()
        end
        if HumanoidRootPart:FindFirstChild("BodyGyro") then
            HumanoidRootPart.BodyGyro:Destroy()
        end
    end
    
    if enabled then
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Name = "BodyVelocity"
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        BodyVelocity.Parent = HumanoidRootPart
        
        local BodyGyro = Instance.new("BodyGyro")
        BodyGyro.Name = "BodyGyro"
        BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        BodyGyro.P = 9e9
        BodyGyro.Parent = HumanoidRootPart
        
        FlyConnection = RunService.Heartbeat:Connect(function()
            if not FlySettings.Enabled or not HumanoidRootPart then return end
            
            local BV = HumanoidRootPart:FindFirstChild("BodyVelocity")
            local BG = HumanoidRootPart:FindFirstChild("BodyGyro")
            
            if not BV or not BG then
                ToggleFly(true)
                return
            end
            
            local Camera = Workspace.CurrentCamera
            local MoveDirection = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                MoveDirection = MoveDirection + Camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                MoveDirection = MoveDirection - Camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                MoveDirection = MoveDirection - Camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                MoveDirection = MoveDirection + Camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                MoveDirection = MoveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                MoveDirection = MoveDirection - Vector3.new(0, 1, 0)
            end
            
            BV.Velocity = MoveDirection * FlySettings.Speed
            BG.CFrame = Camera.CFrame
        end)
    end
end

local function UpdateFlySpeed(speed)
    FlySettings.Speed = speed
end

local function ToggleInfiniteJump(enabled)
    if InfiniteJumpConnection then
        InfiniteJumpConnection:Disconnect()
        InfiniteJumpConnection = nil
    end
    
    if enabled then
        InfiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            if JumpSettings.InfiniteJump and Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

local function ToggleSuperJump(enabled)
    if enabled then
        if Humanoid then
            Humanoid.JumpPower = JumpSettings.JumpPower
        end
    else
        if Humanoid then
            Humanoid.JumpPower = OriginalJumpPower
        end
    end
end

local function UpdateJumpPower(power)
    JumpSettings.JumpPower = power
    if JumpSettings.SuperJump and Humanoid then
        Humanoid.JumpPower = power
    end
end

local function ToggleAutoJump(enabled)
    if AutoJumpConnection then
        AutoJumpConnection:Disconnect()
        AutoJumpConnection = nil
    end
    
    if enabled then
        AutoJumpConnection = RunService.Heartbeat:Connect(function()
            if not JumpSettings.AutoJump or not Humanoid then return end
            if Humanoid.FloorMaterial ~= Enum.Material.Air then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

local function ToggleNoClip(enabled)
    if NoClipConnection then
        NoClipConnection:Disconnect()
        NoClipConnection = nil
    end
    
    if enabled then
        NoClipConnection = RunService.Stepped:Connect(function()
            if not NoClipSettings.Enabled or not Character then return end
            
            for _, part in ipairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        if Character then
            for _, part in ipairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

local function ToggleGodMode(enabled)
    if GodModeConnection then
        GodModeConnection:Disconnect()
        GodModeConnection = nil
    end
    
    if enabled then
        if Humanoid then
            Humanoid.MaxHealth = math.huge
            Humanoid.Health = math.huge
        end
        
        GodModeConnection = RunService.Heartbeat:Connect(function()
            if GodModeSettings.Enabled and Humanoid then
                Humanoid.Health = math.huge
            end
        end)
    else
        if Humanoid then
            Humanoid.MaxHealth = 100
            Humanoid.Health = 100
        end
    end
end

local function ToggleInvisibility(enabled)
    if not Character then return end
    
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = enabled and 1 or 0
        end
        if part:IsA("Decal") then
            part.Transparency = enabled and 1 or 0
        end
        if part:IsA("Accessory") and part:FindFirstChild("Handle") then
            part.Handle.Transparency = enabled and 1 or 0
        end
    end
    
    if Character:FindFirstChild("Head") then
        local face = Character.Head:FindFirstChild("face")
        if face then
            face.Transparency = enabled and 1 or 0
        end
    end
end

local function ToggleInfiniteStamina(enabled)
    if StaminaConnection then
        StaminaConnection:Disconnect()
        StaminaConnection = nil
    end
    
    if enabled then
        StaminaConnection = RunService.Heartbeat:Connect(function()
            if not StaminaSettings.Infinite then return end
            
            local StaminaFolder = LocalPlayer:FindFirstChild("Stamina")
            if StaminaFolder then
                for _, value in ipairs(StaminaFolder:GetChildren()) do
                    if value:IsA("NumberValue") or value:IsA("IntValue") then
                        value.Value = 100
                    end
                end
            end
        end)
    end
end

local function ToggleGravity(enabled)
    if enabled then
        Workspace.Gravity = GravitySettings.Gravity
    else
        Workspace.Gravity = OriginalGravity
    end
end

local function UpdateGravity(gravity)
    GravitySettings.Gravity = gravity
    if GravitySettings.Enabled then
        Workspace.Gravity = gravity
    end
end

local function ReapplyAllSettings()
    if SpeedSettings.Enabled then
        ToggleSpeed(true)
    end
    
    if FlySettings.Enabled then
        ToggleFly(true)
    end
    
    if JumpSettings.InfiniteJump then
        ToggleInfiniteJump(true)
    end
    
    if JumpSettings.SuperJump then
        ToggleSuperJump(true)
    end
    
    if JumpSettings.AutoJump then
        ToggleAutoJump(true)
    end
    
    if NoClipSettings.Enabled then
        ToggleNoClip(true)
    end
    
    if GodModeSettings.Enabled then
        ToggleGodMode(true)
    end
    
    if InvisibilitySettings.Enabled then
        task.wait(0.1)
        ToggleInvisibility(true)
    end
    
    if StaminaSettings.Infinite then
        ToggleInfiniteStamina(true)
    end
    
    if GravitySettings.Enabled then
        ToggleGravity(true)
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    OriginalWalkSpeed = Humanoid.WalkSpeed
    OriginalJumpPower = Humanoid.JumpPower
    
    task.wait(0.2)
    ReapplyAllSettings()
end)

local Speed = LocalPlayerTab:Section({
   Text = "Velocidade"
})

Speed:Check({
   Text = "Ativar Speed",
   Callback = function(value)
       SpeedSettings.Enabled = value
       ToggleSpeed(value)
   end
})

Speed:Slider({
   Text = "Velocidade",
   Minimum = 16,
   Default = 50,
   Maximum = 300,
   Callback = function(value)
       UpdateSpeed(value)
   end
})

local Fly = LocalPlayerTab:Section({
   Text = "Fly",
   Side = "Right"
})

Fly:Check({
   Text = "Ativar Fly",
   Callback = function(value)
       FlySettings.Enabled = value
       ToggleFly(value)
   end
})

Fly:Slider({
   Text = "Velocidade Fly",
   Minimum = 10,
   Default = 50,
   Maximum = 300,
   Callback = function(value)
       UpdateFlySpeed(value)
   end
})

local Jump = LocalPlayerTab:Section({
   Text = "Pulo"
})

Jump:Check({
   Text = "Pulo Infinito",
   Callback = function(value)
       JumpSettings.InfiniteJump = value
       ToggleInfiniteJump(value)
   end
})

Jump:Check({
   Text = "Super Pulo",
   Callback = function(value)
       JumpSettings.SuperJump = value
       ToggleSuperJump(value)
   end
})

Jump:Check({
   Text = "Auto Pulo",
   Callback = function(value)
       JumpSettings.AutoJump = value
       ToggleAutoJump(value)
   end
})

Jump:Slider({
   Text = "Força do Pulo",
   Minimum = 50,
   Default = 100,
   Maximum = 500,
   Callback = function(value)
       UpdateJumpPower(value)
   end
})

local NoClip = LocalPlayerTab:Section({
   Text = "NoClip",
   Side = "Right"
})

NoClip:Check({
   Text = "Ativar NoClip",
   Callback = function(value)
       NoClipSettings.Enabled = value
       ToggleNoClip(value)
   end
})

local Combat = LocalPlayerTab:Section({
   Text = "Combate"
})

Combat:Check({
   Text = "God Mode",
   Callback = function(value)
       GodModeSettings.Enabled = value
       ToggleGodMode(value)
   end
})

Combat:Check({
   Text = "Invisibilidade",
   Callback = function(value)
       InvisibilitySettings.Enabled = value
       ToggleInvisibility(value)
   end
})

Combat:Check({
   Text = "Stamina Infinita",
   Callback = function(value)
       StaminaSettings.Infinite = value
       ToggleInfiniteStamina(value)
   end
})

local Physics = LocalPlayerTab:Section({
   Text = "Fisica",
   Side = "Right"
})

Physics:Check({
   Text = "Gravidade Customizada",
   Callback = function(value)
       GravitySettings.Enabled = value
       ToggleGravity(value)
   end
})

Physics:Slider({
   Text = "Gravidade",
   Minimum = 0,
   Default = 196,
   Maximum = 500,
   Callback = function(value)
       UpdateGravity(value)
   end
})

--CombatTab Paginas

--Aimbot
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local AimbotSettings = {
    Enabled = false,
    TargetPart = "Head",
    HitChance = 100,
    FOVRadius = 150,
    FOVVisible = false,
    FOVColor = Color3.fromRGB(255, 255, 255),
    Smoothness = 0.2,
    TeamCheck = false,
    LockStrength = 0.5,
    WallCheck = true,
    CameraControl = 0.3,
    HeadLockIntensity = 0.7
}

local CurrentTarget = nil
local IsAimbotActive = false

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 64
FOVCircle.Filled = false
FOVCircle.Visible = false
FOVCircle.ZIndex = 999
FOVCircle.Transparency = 1

local function UpdateFOVCircle()
    local ViewportSize = Camera.ViewportSize
    FOVCircle.Position = Vector2.new(ViewportSize.X / 2, ViewportSize.Y / 2)
    FOVCircle.Radius = AimbotSettings.FOVRadius
    FOVCircle.Visible = AimbotSettings.Enabled and AimbotSettings.FOVVisible
    FOVCircle.Color = AimbotSettings.FOVColor
end

local function IsPlayerValid(character)
    if not character then return false end
    local Humanoid = character:FindFirstChildOfClass("Humanoid")
    return Humanoid and Humanoid.Health > 0 and character:FindFirstChild("Head")
end

local function IsVisible(targetPart)
    if not AimbotSettings.WallCheck then return true end
    
    local Origin = Camera.CFrame.Position
    local Direction = (targetPart.Position - Origin)
    
    local RayParams = RaycastParams.new()
    RayParams.FilterType = Enum.RaycastFilterType.Blacklist
    RayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    RayParams.IgnoreWater = true
    
    local Result = Workspace:Raycast(Origin, Direction, RayParams)
    
    return not Result or Result.Instance:IsDescendantOf(targetPart.Parent)
end

local function GetTargetPart(character)
    if AimbotSettings.TargetPart == "Head" then
        return character:FindFirstChild("Head")
    elseif AimbotSettings.TargetPart == "Torso" then
        return character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart")
    else
        local parts = {"Head", "UpperTorso", "LowerTorso", "LeftUpperLeg", "RightUpperLeg"}
        for _, partName in ipairs(parts) do
            local part = character:FindFirstChild(partName)
            if part then return part end
        end
    end
end

local function GetClosestTarget()
    local ClosestTarget = nil
    local ShortestDistance = math.huge
    local ViewportSize = Camera.ViewportSize
    local FOVCenter = Vector2.new(ViewportSize.X / 2, ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer or not player.Character then continue end
        
        local Character = player.Character
        
        if AimbotSettings.TeamCheck and player.Team == LocalPlayer.Team then continue end
        if not IsPlayerValid(Character) then continue end
        
        local TargetPart = GetTargetPart(Character)
        if not TargetPart or not IsVisible(TargetPart) then continue end
        
        local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(TargetPart.Position)
        if not OnScreen then continue end
        
        local Distance = (FOVCenter - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
        
        if Distance <= AimbotSettings.FOVRadius and Distance < ShortestDistance then
            if math.random(1, 100) <= AimbotSettings.HitChance then
                ClosestTarget = TargetPart
                ShortestDistance = Distance
            end
        end
    end

    return ClosestTarget
end

local function AimAtTarget(targetPosition)
    local CurrentCFrame = Camera.CFrame
    local TargetCFrame = CFrame.new(CurrentCFrame.Position, targetPosition)
    
    local LerpValue = math.clamp(
        AimbotSettings.Smoothness * AimbotSettings.CameraControl + 
        AimbotSettings.HeadLockIntensity * AimbotSettings.LockStrength,
        0.05, 1
    )
    
    Camera.CFrame = CurrentCFrame:Lerp(TargetCFrame, LerpValue)
end

RunService.RenderStepped:Connect(function()
    UpdateFOVCircle()
    
    if not AimbotSettings.Enabled then
        CurrentTarget = nil
        IsAimbotActive = false
        return
    end
    
    local Target = GetClosestTarget()
    
    if Target and Target.Parent and IsPlayerValid(Target.Parent) and IsVisible(Target) then
        CurrentTarget = Target
        IsAimbotActive = true
        AimAtTarget(Target.Position)
    else
        CurrentTarget = nil
        IsAimbotActive = false
    end
end)

local Aimbot = CombatTab:Section({Text = "Aimbot"})

Aimbot:Check({
   Text = "Enable Aimbot",
   Callback = function(value) AimbotSettings.Enabled = value end
})

Aimbot:Dropdown({
   Text = "Target Part",
   List = {"Head", "Torso", "Random"},
   Callback = function(value) AimbotSettings.TargetPart = value end
})

Aimbot:Check({
   Text = "Team Check",
   Callback = function(value) AimbotSettings.TeamCheck = value end
})

Aimbot:Check({
   Text = "Wall Check",
   Callback = function(value) AimbotSettings.WallCheck = value end
})

Aimbot:Check({
   Text = "Show FOV Circle",
   Callback = function(value) AimbotSettings.FOVVisible = value end
})

local AimbotConfig = CombatTab:Section({
   Text = "Aimbot Configuration",
   Side = "Right"
})

AimbotConfig:Slider({
   Text = "Hit Chance",
   Minimum = 0,
   Default = 100,
   Maximum = 100,
   Postfix = "%",
   Callback = function(value) AimbotSettings.HitChance = value end
})

AimbotConfig:Slider({
   Text = "Smoothness",
   Minimum = 0.05,
   Default = 0.2,
   Maximum = 1,
   Callback = function(value) AimbotSettings.Smoothness = value end
})

AimbotConfig:Slider({
   Text = "FOV Size",
   Minimum = 50,
   Default = 150,
   Maximum = 500,
   Callback = function(value) AimbotSettings.FOVRadius = value end
})

AimbotConfig:Slider({
   Text = "Camera Control",
   Minimum = 0.1,
   Default = 0.3,
   Maximum = 1,
   Callback = function(value) AimbotSettings.CameraControl = value end
})

AimbotConfig:Slider({
   Text = "Head Lock Intensity",
   Minimum = 0.1,
   Default = 0.7,
   Maximum = 1,
   Callback = function(value) AimbotSettings.HeadLockIntensity = value end
})

AimbotConfig:Slider({
   Text = "Lock Strength",
   Minimum = 0.1,
   Default = 0.5,
   Maximum = 1,
   Callback = function(value) AimbotSettings.LockStrength = value end
})

--CreditsTab Paginas

--Creditos
local Credits1 = CreditsTab:Section({
   Text = "Developer"
})

Credits1:Label({
   Text = "Owner: rip_sheldoohz#0000",
   Color = Color3.fromRGB(255, 255, 255)
})

Credits1:Label({
   Text = "Version: 1.0.0",
   Color = Color3.fromRGB(255, 255, 255)
})

Credits1:Button({
   Text = "Join Discord Server",
   Callback = function()
      setclipboard("https://discord.gg/5Zrw5qZMsm")
   end
})

local Update2 = CreditsTab:Section({
   Text = "Updates",
   Side = "Right"
})

Update2:Label({
   Text = "Latest Update: No changes in this version",
   Color = Color3.fromRGB(57, 255, 240)
})

local System1 = CreditsTab:Section({
   Text = "Server Hop"
})

System1:Button({
   Text = "Find Crowded Server",
   Callback = function()
      local Http = game:GetService("HttpService")
      local TPS = game:GetService("TeleportService")
      local Api = "https://games.roblox.com/v1/games/"
      local _place = game.PlaceId
      local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"
      
      local function ListServers(cursor)
         local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
         return Http:JSONDecode(Raw)
      end
      
      local Server, Next
      repeat
         local Servers = ListServers(Next)
         Server = Servers.data[1]
         Next = Servers.nextPageCursor
      until Server
      
      TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
   end
})

System1:Button({
   Text = "Find Low Population Server",
   Callback = function()
      local Http = game:GetService("HttpService")
      local TPS = game:GetService("TeleportService")
      local Api = "https://games.roblox.com/v1/games/"
      local _place = game.PlaceId
      local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
      
      local function ListServers(cursor)
         local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
         return Http:JSONDecode(Raw)
      end
      
      local Server, Next
      repeat
         local Servers = ListServers(Next)
         for i,v in pairs(Servers.data) do
            if v.playing < v.maxPlayers - 10 then
               Server = v
               break
            end
         end
         Next = Servers.nextPageCursor
      until Server
      
      TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
   end
})

System1:Button({
   Text = "Find Empty Server",
   Callback = function()
      local Http = game:GetService("HttpService")
      local TPS = game:GetService("TeleportService")
      local Api = "https://games.roblox.com/v1/games/"
      local _place = game.PlaceId
      local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
      
      local function ListServers(cursor)
         local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
         return Http:JSONDecode(Raw)
      end
      
      local Server, Next
      repeat
         local Servers = ListServers(Next)
         for i,v in pairs(Servers.data) do
            if v.playing <= 5 then
               Server = v
               break
            end
         end
         Next = Servers.nextPageCursor
      until Server
      
      TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
   end
})

CreditsTab:Select()
