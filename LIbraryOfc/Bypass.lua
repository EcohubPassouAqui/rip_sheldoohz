local Console = loadstring(game:HttpGet("https://pastebin.com/raw/z3uYzH0Q"))()
local progress = Console.custom_console_progressbar("[SPICY]: Initializing protection system...")
local startTime = os.clock()

for i = 1, 5 do
    progress.update_progress(i)
    task.wait(0.05)
end

-- Initialization Check
if getgenv().EcoHubKernel then 
    progress.update_message(
        "[SPICY]: [   FAILED   ]   -   System already active!",
        "rbxasset://textures/DevConsole/error.png",
        Color3.fromRGB(255, 50, 50)
    )
    return 
end

for i = 6, 10 do
    progress.update_progress(i)
    task.wait(0.05)
end

progress.update_message(
    "[SPICY]: Configuring kernel...",
    "rbxasset://textures/ui/TopBar/inventoryOn.png",
    Color3.fromRGB(85, 170, 255)
)

-- Kernel Configuration
local KERNEL = {
    Version = "1.0.2",
    Build = "SPICY-PROTECTED",
    Initialized = false,
    StartTime = tick()
}

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Utilities
local Utils = {}

function Utils.GenerateSecureName()
    local prefixes = {"Sys", "Core", "Kernel", "Driver", "Module", "Service", "Runtime", "Proc"}
    local suffixes = {"Exec", "Handler", "Manager", "Controller", "Engine", "Guard", "Shield"}
    local random = math.random(10000, 99999)
    return prefixes[math.random(#prefixes)] .. suffixes[math.random(#suffixes)] .. tostring(random)
end

function Utils.SafeGetService(serviceName)
    local success, service = pcall(function()
        return game:GetService(serviceName)
    end)
    return success and service or nil
end

for i = 11, 13 do
    progress.update_progress(i)
    task.wait(0.05)
end

progress.update_message(
    "[SPICY]: Loading services...",
    "rbxasset://textures/ui/TopBar/inventoryOn.png",
    Color3.fromRGB(85, 170, 255)
)

-- Services
local Services = {
    Players = Utils.SafeGetService("Players"),
    RunService = Utils.SafeGetService("RunService"),
    UserInputService = Utils.SafeGetService("UserInputService"),
    CoreGui = Utils.SafeGetService("CoreGui"),
    ReplicatedStorage = Utils.SafeGetService("ReplicatedStorage")
}

-- Platform Detection
local Platform = {
    IsMobile = false,
    IsPC = true,
    IsConsole = false,
    ExecutorName = identifyexecutor and identifyexecutor() or "Unknown"
}

pcall(function()
    if Services.UserInputService then
        Platform.IsMobile = Services.UserInputService.TouchEnabled and 
                           not Services.UserInputService.KeyboardEnabled
        Platform.IsPC = not Platform.IsMobile
    end
end)

for i = 14, 16 do
    progress.update_progress(i)
    task.wait(0.05)
end

progress.update_message(
    "[SPICY]: Platform detected - " .. (Platform.IsMobile and "Mobile" or "PC"),
    "rbxasset://textures/ui/TopBar/inventoryOn.png",
    Color3.fromRGB(85, 170, 255)
)

-- Player
local Player = Services.Players.LocalPlayer
if not Player then
    Services.Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    Player = Services.Players.LocalPlayer
end

-- System Configuration
local KernelConfig = {
    Active = true,
    Protected = true,
    Stealth = true,
    
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
    
    SecureID = Utils.GenerateSecureName(),
    SessionID = tostring(tick()):gsub("%.", "")
}

for i = 17, 19 do
    progress.update_progress(i)
    task.wait(0.05)
end

progress.update_message(
    "[SPICY]: Secure ID generated - " .. KernelConfig.SecureID,
    "rbxasset://textures/ui/TopBar/inventoryOn.png",
    Color3.fromRGB(85, 170, 255)
)

-- Advanced Detection Patterns
local Patterns = {
    AntiCheat = {
        "anticheat", "anti_cheat", "anti%-cheat", "antichts",
        "ac_", "ac%-", "anticheats", "a_c", "a%-c",
        "cheatdetect", "cheatcheck", "cheatmon", "antiscript"
    },
    
    Detection = {
        "detect", "detection", "detector", "dtc",
        "monitor", "monitoring", "scanner", "scan",
        "check", "checker", "validate", "validator",
        "guard", "watcher", "observer", "inspect"
    },
    
    Security = {
        "security", "secure", "protection", "protect",
        "antihack", "anti_hack", "anti%-hack", "ahack",
        "antiexploit", "anti_exploit", "aexploit",
        "antisploit", "antix", "shield"
    },
    
    Punishment = {
        "ban", "kick", "remove", "delete",
        "punish", "punishment", "blacklist", "blist",
        "tempban", "permban", "autoban", "autokick"
    },
    
    Admin = {
        "admin", "mod", "moderator", "modpanel",
        "staff", "owner", "developer", "adonis",
        "hd_admin", "hdadmin", "basicadmin"
    },
    
    Logging = {
        "log", "logger", "logging", "report",
        "analytics", "telemetry", "tracker", "track"
    }
}

-- Expanded Protected Names
local ProtectedNames = {
    "ecohub", "eco_hub", "eco%-hub",
    "fluent", "Spicy", "interface",
    "menu", "gui", "ui", "panel",
    "akali", "notif", "notification",
    "console", "progressbar", "progress",
    KernelConfig.SecureID:lower(),
    KernelConfig.SessionID:lower()
}

for i = 20, 21 do
    progress.update_progress(i)
    task.wait(0.05)
end

progress.update_message(
    "[SPICY]: Configuring detection engine...",
    "rbxasset://textures/ui/TopBar/inventoryOn.png",
    Color3.fromRGB(85, 170, 255)
)

-- Advanced Detection Engine
local DetectionEngine = {}

function DetectionEngine.IsProtected(object)
    if not object or not object.Name then return false end
    
    local name = string.lower(object.Name)
    
    for _, protected in ipairs(ProtectedNames) do
        if string.find(name, protected, 1, true) then
            return true
        end
    end
    
    if object:FindFirstAncestor("PlayerGui") then
        local parent = object.Parent
        while parent do
            if DetectionEngine.IsProtected(parent) then
                return true
            end
            parent = parent.Parent
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
        elseif category == "Logging" then level = 2
        else level = 1 end
    end
    
    if object:IsA("LocalScript") or object:IsA("Script") then
        level = level + 1
    end
    
    if object:IsA("RemoteEvent") or object:IsA("RemoteFunction") then
        if DetectionEngine.IsSuspicious(object.Name) then
            level = level + 1
        end
    end
    
    return level
end

-- Advanced Removal Engine
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
            task.wait(0.1)
        end
        
        if object:IsA("BindableEvent") or object:IsA("RemoteEvent") then
            pcall(function() 
                object:Destroy() 
            end)
        end
        
        object.Parent = nil
        task.wait(0.05)
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
            local objects = Player.PlayerGui:GetDescendants()
            
            for _, object in ipairs(objects) do
                if removed >= KernelConfig.MaxObjectsPerCycle then break end
                if not KernelConfig.Active then break end
                
                scanned = scanned + 1
                
                local threatLevel = DetectionEngine.GetThreatLevel(object)
                
                if threatLevel >= KernelConfig.ProtectionLevel then
                    if RemovalEngine.SafeDestroy(object) then
                        removed = removed + 1
                        task.wait(KernelConfig.ProcessDelay)
                    end
                end
            end
        end)
    end)
end

for i = 22, 23 do
    progress.update_progress(i)
    task.wait(0.05)
end

progress.update_message(
    "[SPICY]: Installing protection hooks...",
    "rbxasset://textures/ui/TopBar/inventoryOn.png",
    Color3.fromRGB(85, 170, 255)
)

-- Advanced Hook Manager
local HookManager = {}
local hookSuccess = {
    kick = false,
    ui = false,
    remote = false
}

function HookManager.InstallKickProtection()
    if not hookmetamethod then 
        return false
    end
    
    local success = pcall(function()
        local originalNamecall
        originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if method == "Kick" then
                if self == Player or self.Parent == Player then
                    KernelConfig.TotalBlocked = KernelConfig.TotalBlocked + 1
                    return nil
                end
            end
            
            if method == "Ban" or method == "BanAsync" then
                KernelConfig.TotalBlocked = KernelConfig.TotalBlocked + 1
                return nil
            end
            
            return originalNamecall(self, ...)
        end)
    end)
    
    hookSuccess.kick = success
    return success
end

function HookManager.InstallUIProtection()
    if not hookmetamethod then return false end
    
    local success = pcall(function()
        local originalNewIndex
        originalNewIndex = hookmetamethod(game, "__newindex", function(self, key, value)
            if KernelConfig.Active and DetectionEngine.IsProtected(self) then
                if (key == "Visible" or key == "Enabled") and value == false then
                    KernelConfig.TotalProtected = KernelConfig.TotalProtected + 1
                    return
                end
                
                if key == "Parent" and value == nil then
                    KernelConfig.TotalProtected = KernelConfig.TotalProtected + 1
                    return
                end
            end
            
            return originalNewIndex(self, key, value)
        end)
    end)
    
    hookSuccess.ui = success
    return success
end

function HookManager.InstallRemoteProtection()
    if not hookfunction then return false end
    
    local success = pcall(function()
        local suspiciousRemotes = {}
        
        for _, service in pairs({Services.ReplicatedStorage, game}) do
            if service then
                for _, descendant in pairs(service:GetDescendants()) do
                    if descendant:IsA("RemoteEvent") or descendant:IsA("RemoteFunction") then
                        if DetectionEngine.IsSuspicious(descendant.Name) then
                            table.insert(suspiciousRemotes, descendant)
                        end
                    end
                end
            end
        end
        
        for _, remote in pairs(suspiciousRemotes) do
            if remote:IsA("RemoteEvent") then
                local old
                old = hookfunction(remote.FireServer, function(...)
                    KernelConfig.TotalBlocked = KernelConfig.TotalBlocked + 1
                    return nil
                end)
            end
        end
    end)
    
    hookSuccess.remote = success
    return success
end

-- Advanced Monitor
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
        return false
    end
    
    Services.RunService.Heartbeat:Connect(function()
        if KernelConfig.Active then
            Monitor.LightweightCheck()
        end
    end)
    
    return true
end

for i = 24, 25 do
    progress.update_progress(i)
    task.wait(0.05)
end

-- Kernel API
local KernelAPI = {}

function KernelAPI.GetStatus()
    return {
        Active = KernelConfig.Active,
        Protected = KernelConfig.Protected,
        Stealth = KernelConfig.Stealth,
        Uptime = tick() - KERNEL.StartTime,
        Platform = Platform.IsMobile and "Mobile" or "PC",
        Stats = {
            Removed = KernelConfig.TotalRemoved,
            Blocked = KernelConfig.TotalBlocked,
            Protected = KernelConfig.TotalProtected
        }
    }
end

function KernelAPI.SetProtectionLevel(level)
    if level >= 1 and level <= 5 then
        KernelConfig.ProtectionLevel = level
        return true
    end
    return false
end

function KernelAPI.SetStealth(enabled)
    KernelConfig.Stealth = enabled
end

function KernelAPI.Enable()
    KernelConfig.Active = true
end

function KernelAPI.Disable()
    KernelConfig.Active = false
end

function KernelAPI.ForceCleanup()
    RemovalEngine.CleanupCycle()
end

function KernelAPI.PrintStats()
    local status = KernelAPI.GetStatus()
    print(string.format("[SPICY]: Stats - Removed: %d | Blocked: %d | Protected: %d | Uptime: %ds", 
        status.Stats.Removed, status.Stats.Blocked, status.Stats.Protected, 
        math.floor(status.Uptime)))
end

-- Initialization
local function Initialize()
    local initDelay = Platform.IsMobile and 10 or 4
    
    task.spawn(function()
        task.wait(initDelay)
        
        progress.update_message(
            "[SPICY]: Installing kick and ban protection...",
            "rbxasset://textures/ui/TopBar/inventoryOn.png",
            Color3.fromRGB(85, 170, 255)
        )
        task.wait(0.5)
        
        HookManager.InstallKickProtection()
        task.wait(0.3)
        
        progress.update_message(
            "[SPICY]: Installing UI protection...",
            "rbxasset://textures/ui/TopBar/inventoryOn.png",
            Color3.fromRGB(85, 170, 255)
        )
        task.wait(0.3)
        
        HookManager.InstallUIProtection()
        task.wait(0.3)
        
        progress.update_message(
            "[SPICY]: Installing Remote Events protection...",
            "rbxasset://textures/ui/TopBar/inventoryOn.png",
            Color3.fromRGB(85, 170, 255)
        )
        task.wait(0.3)
        
        HookManager.InstallRemoteProtection()
        task.wait(0.3)
        
        progress.update_message(
            "[SPICY]: Starting monitoring system...",
            "rbxasset://textures/ui/TopBar/inventoryOn.png",
            Color3.fromRGB(85, 170, 255)
        )
        task.wait(0.3)
        
        Monitor.Start()
        task.wait(0.5)
        
        KERNEL.Initialized = true
        KernelConfig.Active = true
        
        local loadTime = os.clock() - startTime
        local allHooksSuccess = hookSuccess.kick and hookSuccess.ui and hookSuccess.remote
        
        if allHooksSuccess then
            progress.update_message(
                string.format("[SPICY]: [   SUCCESS   ]   -   Protection activated in %.10f seconds.", loadTime),
                "rbxasset://textures/DevConsole/done.png",
                Color3.fromRGB(51, 255, 85)
            )
        else
            local failedHooks = {}
            if not hookSuccess.kick then table.insert(failedHooks, "Kick/Ban") end
            if not hookSuccess.ui then table.insert(failedHooks, "UI") end
            if not hookSuccess.remote then table.insert(failedHooks, "Remote") end
            
            progress.update_message(
                string.format("[SPICY]: [   WARNING   ]   -   Some protections failed: %s", table.concat(failedHooks, ", ")),
                "rbxasset://textures/ui/ErrorIcon.png",
                Color3.fromRGB(255, 170, 0)
            )
        end
        
        task.wait(2)
        
        print(string.format("[SPICY]: System active | Platform: %s | Executor: %s | Protection Level: %d", 
            Platform.IsMobile and "Mobile" or "PC", 
            Platform.ExecutorName, 
            KernelConfig.ProtectionLevel))
    end)
end

-- Export API
getgenv().EcoHubKernel = {
    Version = KERNEL.Version,
    Build = KERNEL.Build,
    API = KernelAPI,
    Utils = Utils,
    Config = KernelConfig
}

Initialize()
