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

local notificationColors = {
    success = Color3.fromRGB(76, 175, 80),
    error = Color3.fromRGB(244, 67, 54),
    warning = Color3.fromRGB(255, 193, 7),
    info = Color3.fromRGB(33, 150, 243),
    loading = Color3.fromRGB(156, 39, 176),
    default = Color3.fromRGB(255, 255, 255)
}

local notificationTextColors = {
    success = Color3.fromRGB(255, 255, 255),
    error = Color3.fromRGB(255, 255, 255),
    warning = Color3.fromRGB(0, 0, 0),
    info = Color3.fromRGB(255, 255, 255),
    loading = Color3.fromRGB(255, 255, 255),
    default = Color3.fromRGB(0, 0, 0)
}

-- // protectScreenGui
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

-- // createObject
local function createObject(className, properties)
    local instance = newInstance(className)
    for index, value in next, properties do 
        instance[index] = value 
    end
    return instance
end

-- // getTextSize
local function getTextSize(text, textSize, font)
    local bounds = textService:GetTextSize(text, textSize, font, Vector2.new(600, 100))
    return bounds.X
end

-- // fadeObject
local function fadeObject(object, onTweenCompleted)
    local tweenInformation = tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    })
    
    tweenInformation.Completed:Connect(onTweenCompleted)
    tweenInformation:Play()
end

-- // safeCall
local function safeCall(fn, ...)
    local success, result = pcall(fn, ...)
    if not success then
        return false, tostring(result)
    end
    return true, result
end

local notifications = {}

-- // new
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

-- // SetNotificationLifetime
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

-- // SetTextColor
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

-- // SetTextSize
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

-- // SetTextStrokeTransparency
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

-- // SetTextStrokeColor
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

-- // SetTextFont
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

-- // SetIconSize
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

-- // SetWidthLimits
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

-- // SetErrorCallback
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

-- // BuildNotificationUI
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

-- // Show
function notifications:Show(options)
    local success, error = safeCall(function()
        assert(options, "missing argument #1 in function Show(options)")
        assert(typeof(options) == "table", format("expected table for argument #1, got %s", typeof(options)))
        
        local message = options.message
        local notificationType = options.type or "default"
        local delay = options.delay or 0
        
        assert(message, "missing 'message' in options table")
        assert(typeof(message) == "string", format("expected string for 'message', got %s", typeof(message)))
        
        if delay and delay > 0 then
            task.delay(delay, function()
                self:Show({
                    message = message,
                    type = notificationType
                })
            end)
            return true
        end
        
        if not self.ui.notificationsFrame then
            self:BuildNotificationUI()
        end

        local textWidth = getTextSize(message, self.TextSize, self.TextFont)
        local width = math.max(self.MinWidth, math.min(textWidth + 48, self.MaxWidth))
        local iconText = (notificationType and ICONS and ICONS[notificationType]) or ""
        local hasIcon = notificationType and ICONS and ICONS[notificationType]
        
        if hasIcon then
            width = math.max(self.MinWidth, math.min(textWidth + self.IconSize + self.IconPadding + 32, self.MaxWidth))
        end

        local bgColor = notificationColors[notificationType] or notificationColors.default
        local textColor = notificationTextColors[notificationType] or notificationTextColors.default

        local notificationContainer = createObject("Frame", {
            Name = "notificationContainer",
            Parent = self.ui.notificationsFrame,
            BackgroundColor3 = bgColor,
            BackgroundTransparency = 0,
            Size = UDim2.new(0, width, 0, self.IconSize + 8),
            LayoutOrder = #self.activeNotifications + 1
        })

        local uiCorner = createObject("UICorner", {
            Name = "UICorner",
            Parent = notificationContainer,
            CornerRadius = UDim.new(0, 6)
        })

        local containerLayout = createObject("UIListLayout", {
            Name = "containerLayout",
            Parent = notificationContainer,
            Padding = UDim.new(0, self.IconPadding),
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center
        })

        local uiPadding = createObject("UIPadding", {
            Name = "UIPadding",
            Parent = notificationContainer,
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 4),
            PaddingBottom = UDim.new(0, 4)
        })

        local iconLabel = nil
        if hasIcon then
            iconLabel = createObject("TextLabel", {
                Name = "icon",
                Parent = notificationContainer,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, self.IconSize, 0, self.IconSize),
                Text = iconText,
                Font = self.TextFont,
                TextColor3 = textColor,
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
            Size = UDim2.new(0, width - (hasIcon and self.IconSize + self.IconPadding or 0) - 16, 0, self.IconSize),
            Text = message,
            Font = self.TextFont,
            TextColor3 = textColor,
            TextSize = self.TextSize,
            TextStrokeColor3 = self.TextStrokeColor,
            TextStrokeTransparency = self.TextStrokeTransparency,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2
        })

        local notifObject = {
            container = notificationContainer,
            textLabel = notification,
            iconLabel = iconLabel,
            lifetime = self.NotificationLifetime
        }

        insert(self.activeNotifications, notifObject)

        task.delay(self.NotificationLifetime, function()
            if notificationContainer.Parent then
                if iconLabel then
                    fadeObject(iconLabel, function() end)
                end
                
                fadeObject(notification, function()
                    notificationContainer:Destroy()
                    remove(self.activeNotifications, find(self.activeNotifications, notifObject))
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

-- // Update
function notifications:Update(index, newMessage)
    local success, error = safeCall(function()
        assert(index, "missing argument #1 in function Update(index, newMessage)")
        assert(typeof(index) == "number", format("expected number for 'index', got %s", typeof(index)))
        assert(newMessage, "missing argument #2 in function Update(index, newMessage)")
        assert(typeof(newMessage) == "string", format("expected string for 'newMessage', got %s", typeof(newMessage)))
        
        if self.activeNotifications[index] then
            local notifObject = self.activeNotifications[index]
            notifObject.textLabel.Text = newMessage
        end
    end)
    
    if not success then
        warn("Notification Error (Update): " .. error)
        if self.errorCallback then
            self.errorCallback("Update", error)
        end
        return false
    end
    
    return true
end

-- // Notify
function notifications:Notify(text, iconType)
    return self:Show({
        message = text,
        type = iconType or "default"
    })
end

-- // Success
function notifications:Success(text)
    return self:Show({
        message = text,
        type = "success"
    })
end

-- // Error
function notifications:Error(text, errorDetails)
    if errorDetails then
        warn("Notification Error Details: " .. tostring(errorDetails))
    end
    return self:Show({
        message = text,
        type = "error"
    })
end

-- // Warning
function notifications:Warning(text)
    return self:Show({
        message = text,
        type = "warning"
    })
end

-- // Info
function notifications:Info(text)
    return self:Show({
        message = text,
        type = "info"
    })
end

-- // Loading
function notifications:Loading(text)
    return self:Show({
        message = text,
        type = "loading"
    })
end

-- // Clear
function notifications:Clear()
    local success, error = safeCall(function()
        for _, notifObject in ipairs(self.activeNotifications) do
            if notifObject.container.Parent then
                notifObject.container:Destroy()
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

-- // Destroy
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
