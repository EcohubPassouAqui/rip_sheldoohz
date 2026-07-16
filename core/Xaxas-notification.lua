local tweenService = game:GetService("TweenService")
local coreGui = game:GetService("CoreGui")
local textService = game:GetService("TextService")

local insert, find, remove = table.insert, table.find, table.remove 
local format = string.format

local newInstance = Instance.new

local ICONS = {}
local iconsOk, iconsResult = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/src/Icons.lua"))()
end)
if iconsOk and type(iconsResult) == "table" then
    ICONS = iconsResult
end

local notificationPositions = {
    ["Middle"] = UDim2.new(0.445, 0, 0.7, 0),
    ["MiddleRight"] = UDim2.new(0.85, 0, 0.7, 0),
    ["MiddleLeft"] = UDim2.new(0.01, 0, 0.7, 0),
    
    ["Top"] = UDim2.new(0.445, 0, 0.007, 0),
    ["TopLeft"] = UDim2.new(0.06, 0, 0.001, 0),
    ["TopRight"] = UDim2.new(0.8, 0, 0.001, 0),
}

local function protectScreenGui(screenGui)
    if syn and syn.protect_gui then 
        syn.protect_gui(screenGui)
        screenGui.Parent = coreGui
    elseif gethui then 
        screenGui.Parent = gethui()
    else 
        screenGui.Parent = coreGui
    end
end

local function createObject(className, properties)
    local instance = newInstance(className)
    for index, value in next, properties do 
        instance[index] = value 
    end
    return instance
end

local function getTextSize(text, textSize, font)
    local bounds = textService:GetTextSize(text, textSize, font, Vector2.new(600, 100))
    return bounds.X
end

local function fadeObject(object, onTweenCompleted)
    local tweenInformation = tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    })
    
    tweenInformation.Completed:Connect(onTweenCompleted)
    tweenInformation:Play()
end

local function safeCall(fn, ...)
    local success, result = pcall(fn, ...)
    if not success then
        return false, tostring(result)
    end
    return true, result
end

local notifications = {}

function notifications.new(settings)
    local success, error = safeCall(function()
        assert(settings, "missing argument #1 in function notifications.new(settings)")
        assert(typeof(settings) == "table", format("expected table for argument #1 in function notifications.new(settings), got %s", typeof(settings)))
    end)
    
    if not success then
        warn("Notification Error: " .. error)
        return nil
    end
    
    local notificationSettings = {
        ui = {notificationsFrame = nil, notificationsFrame_UIListLayout = nil},
        NotificationLifetime = 3,
        NotificationPosition = "Middle",
        TextFont = Enum.Font.GothamMedium,
        TextColor = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        TextStrokeTransparency = 0,
        TextStrokeColor = Color3.fromRGB(0, 0, 0),
        IconSize = 20,
        MinWidth = 236,
        MaxWidth = 600,
        IconPadding = 8,
        activeNotifications = {},
        screenGui = nil,
        errorCallback = nil
    }
    
    for setting, value in next, settings do 
        notificationSettings[setting] = value 
    end
    
    setmetatable(notificationSettings, {__index = notifications})
    return notificationSettings
end

function notifications:SetNotificationLifetime(number)
    local success, error = safeCall(function()
        assert(number, "missing argument #1 in function SetNotificationLifetime(number)")
        assert(typeof(number) == "number", format("expected number for argument #1 in function SetNotificationLifetime, got %s", typeof(number)))
    end)
    
    if not success then
        warn("Notification Error: " .. error)
        return false
    end
    
    self.NotificationLifetime = number
    return true
end

function notifications:SetTextColor(color3)
    local success, error = safeCall(function()
        assert(color3, "missing argument #1 in function SetTextColor(Color3)")
        assert(typeof(color3) == "Color3", format("expected Color3 for argument #1 in function SetTextColor, got %s", typeof(color3)))
    end)
    
    if not success then
        warn("Notification Error: " .. error)
        return false
    end
    
    self.TextColor = color3
    return true
end

function notifications:SetTextSize(number)
    local success, error = safeCall(function()
        assert(number, "missing argument #1 in function SetTextSize(number)")
        assert(typeof(number) == "number", format("expected number for argument #1 in function SetTextSize, got %s", typeof(number)))
    end)
    
    if not success then
        warn("Notification Error: " .. error)
        return false
    end
    
    self.TextSize = number
    return true
end

function notifications:SetTextStrokeTransparency(number)
    local success, error = safeCall(function()
        assert(number, "missing argument #1 in function SetTextStrokeTransparency(number)")
        assert(typeof(number) == "number", format("expected number for argument #1 in function SetTextStrokeTransparency, got %s", typeof(number)))
    end)
    
    if not success then
        warn("Notification Error: " .. error)
        return false
    end
    
    self.TextStrokeTransparency = number
    return true
end

function notifications:SetTextStrokeColor(color3)
    local success, error = safeCall(function()
        assert(color3, "missing argument #1 in function SetTextStrokeColor(Color3)")
        assert(typeof(color3) == "Color3", format("expected Color3 for argument #1 in function SetTextStrokeColor, got %s", typeof(color3)))
    end)
    
    if not success then
        warn("Notification Error: " .. error)
        return false
    end
    
    self.TextStrokeColor = color3
    return true
end

function notifications:SetTextFont(font)
    local success, error = safeCall(function()
        assert(font, "missing argument #1 in function SetTextFont(Font)")
        assert((typeof(font) == "string" or typeof(font) == "EnumItem"), "invalid font type")
        self.TextFont = (typeof(font) == "string") and Enum.Font[font] or font
    end)
    
    if not success then
        warn("Notification Error: " .. error)
        return false
    end
    
    return true
end

function notifications:SetIconSize(number)
    local success, error = safeCall(function()
        assert(number, "missing argument #1 in function SetIconSize(number)")
        assert(typeof(number) == "number", format("expected number for argument #1 in function SetIconSize, got %s", typeof(number)))
    end)
    
    if not success then
        warn("Notification Error: " .. error)
        return false
    end
    
    self.IconSize = number
    return true
end

function notifications:SetWidthLimits(minWidth, maxWidth)
    local success, error = safeCall(function()
        assert(minWidth, "missing argument #1 in function SetWidthLimits(minWidth, maxWidth)")
        assert(maxWidth, "missing argument #2 in function SetWidthLimits(minWidth, maxWidth)")
        assert(typeof(minWidth) == "number", format("expected number for argument #1, got %s", typeof(minWidth)))
        assert(typeof(maxWidth) == "number", format("expected number for argument #2, got %s", typeof(maxWidth)))
    end)
    
    if not success then
        warn("Notification Error: " .. error)
        return false
    end
    
    self.MinWidth = minWidth
    self.MaxWidth = maxWidth
    return true
end

function notifications:SetErrorCallback(callback)
    local success, error = safeCall(function()
        assert(callback, "missing argument #1 in function SetErrorCallback(callback)")
        assert(typeof(callback) == "function", format("expected function for argument #1, got %s", typeof(callback)))
    end)
    
    if not success then
        warn("Notification Error: " .. error)
        return false
    end
    
    self.errorCallback = callback
    return true
end

function notifications:BuildNotificationUI()
    local success, error = safeCall(function()
        if self.screenGui then 
            self.screenGui:Destroy()
            self.screenGui = nil
        end
        
        self.screenGui = createObject("ScreenGui", {
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            ResetOnSpawn = false,
            Enabled = true
        })
        protectScreenGui(self.screenGui)

        self.ui.notificationsFrame = createObject("Frame", {
            Name = "notificationsFrame",
            Parent = self.screenGui,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = notificationPositions[self.NotificationPosition],
            Size = UDim2.new(0, self.MaxWidth, 0, 215),
            ClipsDescendants = true
        })

        self.ui.notificationsFrame_UIListLayout = createObject("UIListLayout", {
            Name = "notificationsFrame_UIListLayout",
            Parent = self.ui.notificationsFrame,
            Padding = UDim.new(0, 1),
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical
        })
    end)
    
    if not success then
        warn("Notification Error (BuildNotificationUI): " .. error)
        if self.errorCallback then
            self.errorCallback("BuildNotificationUI", error)
        end
        return false
    end
    
    return true
end

function notifications:Show(options)
    local success, error = safeCall(function()
        assert(options, "missing argument #1 in function Show(options)")
        assert(typeof(options) == "table", format("expected table for argument #1, got %s", typeof(options)))
        
        local message = options.message
        local icon = options.icon
        
        assert(message, "missing 'message' in options table")
        assert(typeof(message) == "string", format("expected string for 'message', got %s", typeof(message)))
        
        if icon then
            assert(typeof(icon) == "string", format("expected string for 'icon', got %s", typeof(icon)))
        end
        
        if not self.ui.notificationsFrame then
            self:BuildNotificationUI()
        end

        local textWidth = getTextSize(message, self.TextSize, self.TextFont)
        local width = math.max(self.MinWidth, math.min(textWidth + 48, self.MaxWidth))
        local hasIcon = icon and ICONS and ICONS[icon]
        
        if hasIcon then
            width = math.max(self.MinWidth, math.min(textWidth + self.IconSize + self.IconPadding + 32, self.MaxWidth))
        end

        local notificationContainer = createObject("Frame", {
            Name = "notificationContainer",
            Parent = self.ui.notificationsFrame,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, width, 0, self.IconSize + 4),
            LayoutOrder = #self.activeNotifications + 1
        })

        local containerLayout = createObject("UIListLayout", {
            Name = "containerLayout",
            Parent = notificationContainer,
            Padding = UDim.new(0, self.IconPadding),
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center
        })

        if hasIcon then
            local iconLabel = createObject("TextLabel", {
                Name = "icon",
                Parent = notificationContainer,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, self.IconSize, 0, self.IconSize),
                Text = ICONS[icon],
                Font = self.TextFont,
                TextColor3 = self.TextColor,
                TextSize = self.IconSize,
                TextStrokeColor3 = self.TextStrokeColor,
                TextStrokeTransparency = self.TextStrokeTransparency,
                LayoutOrder = 1
            })
        end

        local notification = createObject("TextLabel", {
            Name = "notification",
            Parent = notificationContainer,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, width - (hasIcon and self.IconSize + self.IconPadding or 0) - 8, 0, self.IconSize),
            Text = message,
            Font = self.TextFont,
            TextColor3 = self.TextColor,
            TextSize = self.TextSize,
            TextStrokeColor3 = self.TextStrokeColor,
            TextStrokeTransparency = self.TextStrokeTransparency,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2
        })

        insert(self.activeNotifications, notificationContainer)

        task.delay(self.NotificationLifetime, function()
            if notificationContainer.Parent then
                local icon = notificationContainer:FindFirstChild("icon")
                local textLabel = notificationContainer:FindFirstChild("notification")
                
                if icon then
                    fadeObject(icon, function() end)
                end
                
                fadeObject(textLabel, function()
                    notificationContainer:Destroy()
                    remove(self.activeNotifications, find(self.activeNotifications, notificationContainer))
                end)
            end
        end)
    end)
    
    if not success then
        warn("Notification Error (Show): " .. error)
        if self.errorCallback then
            self.errorCallback("Show", error)
        end
        return false
    end
    
    return true
end

function notifications:Notify(text, iconName)
    return self:Show({
        message = text,
        icon = iconName
    })
end

function notifications:Success(text)
    return self:Show({
        message = text,
        icon = "success"
    })
end

function notifications:Error(text, errorDetails)
    if errorDetails then
        warn("Notification Error Details: " .. tostring(errorDetails))
    end
    return self:Show({
        message = text,
        icon = "error"
    })
end

function notifications:Warning(text)
    return self:Show({
        message = text,
        icon = "warning"
    })
end

function notifications:Info(text)
    return self:Show({
        message = text,
        icon = "info"
    })
end

function notifications:Loading(text)
    return self:Show({
        message = text,
        icon = "loading"
    })
end

function notifications:Clear()
    local success, error = safeCall(function()
        for _, notification in ipairs(self.activeNotifications) do
            if notification.Parent then
                notification:Destroy()
            end
        end
        self.activeNotifications = {}
    end)
    
    if not success then
        warn("Notification Error (Clear): " .. error)
        if self.errorCallback then
            self.errorCallback("Clear", error)
        end
        return false
    end
    
    return true
end

function notifications:Destroy()
    local success, error = safeCall(function()
        if self.screenGui then
            self.screenGui:Destroy()
            self.screenGui = nil
        end
        self.activeNotifications = {}
    end)
    
    if not success then
        warn("Notification Error (Destroy): " .. error)
        if self.errorCallback then
            self.errorCallback("Destroy", error)
        end
        return false
    end
    
    return true
end

return notifications
