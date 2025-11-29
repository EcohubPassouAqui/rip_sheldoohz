-- ========================================
-- SISTEMA COMPLETO DE FARM - FISH IT
-- ========================================

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- ========================================
-- CONFIGURAÇÕES GLOBAIS
-- ========================================

local FarmSettings = {
    -- Auto Fish V1
    AutoFishV1Enabled = false,
    AutoFishV1Delay = 3,
    MinSafeDelay = 1.6,
    
    -- Auto Fish V2
    AutoFishV2Enabled = false,
    ClickHoldTime = 0.4,
    ClickReleaseTime = 0.2,
    
    -- Auto Instant Complete
    AutoInstantEnabled = true,
    InstantDelay = 0.1,
    
    -- Auto Sell
    AutoSellEnabled = false,
    SellInterval = 3,
    
    -- Animations
    CurrentAnimations = nil,
    IsAnimationLoopActive = false
}

-- ========================================
-- SISTEMA DE ANIMAÇÕES
-- ========================================

local AnimationIDs = {
    idle = "rbxassetid://96586569072385",
    cast = "rbxassetid://180435571",
    wait = "rbxassetid://92624107165273",
    reel = "rbxassetid://134965425664034"
}

local function GetAnimator()
    local humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid", 5)
    if humanoid then
        return humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
    end
    warn("[Farm System]: Failed to find Humanoid")
    return nil
end

local function LoadAnimations()
    local animator = GetAnimator()
    if not animator then
        warn("[Farm System]: Could not load animations - Animator not found")
        return nil
    end
    
    local animations = {}
    
    for animName, animId in pairs(AnimationIDs) do
        local success, result = pcall(function()
            local anim = Instance.new("Animation")
            anim.AnimationId = animId
            return animator:LoadAnimation(anim)
        end)
        
        if success and result then
            animations[animName] = result
        else
            warn("[Farm System]: Failed to load animation:", animName)
        end
    end
    
    return animations
end

local function StopAllAnimations()
    if FarmSettings.CurrentAnimations then
        for _, anim in pairs(FarmSettings.CurrentAnimations) do
            if anim then
                anim.Looped = false
                anim:Stop(0)
            end
        end
        FarmSettings.CurrentAnimations = nil
    end
end

-- Recarregar animações ao trocar de personagem
LocalPlayer.CharacterAdded:Connect(function()
    FarmSettings.CurrentAnimations = LoadAnimations()
end)

if LocalPlayer.Character then
    FarmSettings.CurrentAnimations = LoadAnimations()
end

-- ========================================
-- AUTO FISH V1 - Sistema Principal
-- ========================================

local function StartAutoFishV1()
    print("[Farm System]: Auto Fish V1 Started")
    
    -- Carregar animações se necessário
    FarmSettings.CurrentAnimations = LocalPlayer.Character and FarmSettings.CurrentAnimations or LoadAnimations()
    
    if not FarmSettings.CurrentAnimations then
        warn("[Farm System]: Failed to initialize Auto Fish V1 - Animations not loaded")
        FarmSettings.AutoFishV1Enabled = false
        return
    end
    
    -- Localizar remotes necessários
    local netFolder = ReplicatedStorage:FindFirstChild("Packages") 
        and ReplicatedStorage.Packages:FindFirstChild("_Index") 
        and ReplicatedStorage.Packages._Index:FindFirstChild("sleitnick_net@0.2.0")
    
    if netFolder then
        netFolder = netFolder:FindFirstChild("net")
    end
    
    if not netFolder then
        warn("[Farm System]: Network folder not found")
        FarmSettings.AutoFishV1Enabled = false
        return
    end
    
    local EquipToolRemote = netFolder:FindFirstChild("RE/EquipToolFromHotbar")
    local StartFishingRemote = netFolder:FindFirstChild("RF/RequestFishingMinigameStarted")
    local ChargeRodRemote = netFolder:FindFirstChild("RF/ChargeFishingRod")
    
    if not (EquipToolRemote and StartFishingRemote and ChargeRodRemote) then
        warn("[Farm System]: Required remotes not found")
        FarmSettings.AutoFishV1Enabled = false
        return
    end
    
    -- Equipar vara de pesca
    pcall(function()
        EquipToolRemote:FireServer(1)
    end)
    
    -- Tocar animação idle
    if FarmSettings.CurrentAnimations.idle then
        FarmSettings.CurrentAnimations.idle.Looped = true
        FarmSettings.CurrentAnimations.idle:Play()
    end
    
    -- Loop de pesca
    if not FarmSettings.IsAnimationLoopActive then
        FarmSettings.IsAnimationLoopActive = true
        
        task.spawn(function()
            while FarmSettings.AutoFishV1Enabled do
                local success, error = pcall(function()
                    -- Recarregar animações se personagem mudou
                    FarmSettings.CurrentAnimations = LocalPlayer.Character 
                        and LocalPlayer.Character:FindFirstChild("Humanoid") 
                        or LoadAnimations()
                    
                    if FarmSettings.CurrentAnimations then
                        -- Cast animation
                        if FarmSettings.CurrentAnimations.cast then
                            FarmSettings.CurrentAnimations.cast:Play()
                        end
                        
                        StartFishingRemote:InvokeServer(-0.7499996423721313, 1)
                        task.wait(0.2)
                        
                        -- Wait animation
                        if FarmSettings.CurrentAnimations.wait then
                            FarmSettings.CurrentAnimations.wait:Play()
                        end
                        task.wait(0.2)
                        
                        -- Reel animation
                        if FarmSettings.CurrentAnimations.reel then
                            FarmSettings.CurrentAnimations.reel:Play()
                        end
                        
                        ChargeRodRemote:InvokeServer(workspace:GetServerTimeNow())
                        task.wait(0.2)
                        
                        StartFishingRemote:InvokeServer(-0.7499996423721313, 1)
                    end
                end)
                
                if not success then
                    warn("[Farm System]: Auto Fish error:", error)
                end
                
                task.wait(math.max(FarmSettings.AutoFishV1Delay, FarmSettings.MinSafeDelay))
            end
            
            FarmSettings.IsAnimationLoopActive = false
        end)
    end
end

local function StopAutoFishV1()
    print("[Farm System]: Auto Fish V1 Stopped")
    FarmSettings.AutoFishV1Enabled = false
    StopAllAnimations()
    FarmSettings.IsAnimationLoopActive = false
end

-- ========================================
-- AUTO FISH V2 - Sistema Alternativo
-- ========================================

local function StartAutoFishV2()
    print("[Farm System]: Auto Fish V2 Started")
    
    local camera = Workspace.CurrentCamera
    local netFolder = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net
    local EquipToolRemote = netFolder["RE/EquipToolFromHotbar"]
    
    task.spawn(function()
        while FarmSettings.AutoFishV2Enabled do
            pcall(function()
                EquipToolRemote:FireServer(1)
                
                local x = 5
                local y = camera.ViewportSize.Y - 5
                
                VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
                task.wait(FarmSettings.ClickHoldTime)
                VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
            end)
            
            task.wait(FarmSettings.ClickReleaseTime)
            RunService.Heartbeat:Wait()
        end
    end)
end

local function StopAutoFishV2()
    print("[Farm System]: Auto Fish V2 Stopped")
    FarmSettings.AutoFishV2Enabled = false
end

-- ========================================
-- AUTO INSTANT COMPLETE
-- ========================================

local function StartAutoInstantComplete()
    print("[Farm System]: Auto Instant Complete Started")
    
    local netFolder = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net
    local CompleteRemote = netFolder["RE/FishingCompleted"]
    
    task.spawn(function()
        while FarmSettings.AutoInstantEnabled do
            pcall(function()
                CompleteRemote:FireServer()
            end)
            task.wait(FarmSettings.InstantDelay)
        end
    end)
end

local function StopAutoInstantComplete()
    print("[Farm System]: Auto Instant Complete Stopped")
    FarmSettings.AutoInstantEnabled = false
end

-- ========================================
-- AUTO SELL
-- ========================================

local function SellAllItems()
    local netFolder = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net
    local SellRemote = netFolder["RF/SellAllItems"]
    
    pcall(function()
        SellRemote:InvokeServer()
    end)
end

local function StartAutoSell()
    print("[Farm System]: Auto Sell Started")
    
    task.spawn(function()
        while FarmSettings.AutoSellEnabled do
            SellAllItems()
            task.wait(FarmSettings.SellInterval)
        end
    end)
end

local function StopAutoSell()
    print("[Farm System]: Auto Sell Stopped")
    FarmSettings.AutoSellEnabled = false
end

-- ========================================
-- FUNÇÕES PÚBLICAS DE CONTROLE
-- ========================================

local FarmSystem = {}

-- Auto Fish V1
function FarmSystem:ToggleAutoFishV1(enabled)
    FarmSettings.AutoFishV1Enabled = enabled
    if enabled then
        StartAutoFishV1()
    else
        StopAutoFishV1()
    end
end

function FarmSystem:SetAutoFishV1Delay(delay)
    if delay and delay >= 0.1 and delay <= 4 then
        FarmSettings.AutoFishV1Delay = delay
        print("[Farm System]: Delay set to " .. delay .. "s")
        return true
    end
    return false
end

-- Auto Fish V2
function FarmSystem:ToggleAutoFishV2(enabled)
    FarmSettings.AutoFishV2Enabled = enabled
    if enabled then
        StartAutoFishV2()
    else
        StopAutoFishV2()
    end
end

-- Auto Instant Complete
function FarmSystem:ToggleAutoInstant(enabled)
    FarmSettings.AutoInstantEnabled = enabled
    if enabled then
        StartAutoInstantComplete()
    else
        StopAutoInstantComplete()
    end
end

-- Auto Sell
function FarmSystem:ToggleAutoSell(enabled)
    FarmSettings.AutoSellEnabled = enabled
    if enabled then
        StartAutoSell()
    else
        StopAutoSell()
    end
end

function FarmSystem:SellNow()
    SellAllItems()
end

-- ========================================
-- RETORNAR SISTEMA
-- ========================================

print("[Farm System]: Loaded successfully!")
return FarmSystem
