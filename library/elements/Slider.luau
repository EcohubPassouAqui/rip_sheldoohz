-- // Slider
Elements.Register("Slider", function(section, options)
    options = type(options) == "table" and options or {}

    local COLORS = {
        Active = Color3.fromRGB(255, 255, 255),
        Inactive = Color3.fromRGB(20, 20, 20),
        TextActive = Color3.fromRGB(255, 255, 255),
        TextInactive = Color3.fromRGB(105, 105, 115),
        TextDisabled = Color3.fromRGB(70, 70, 78),
        Line = Color3.fromRGB(32, 32, 32),
        Track = Color3.fromRGB(30, 30, 30),
        Fill = Color3.fromRGB(255, 255, 255),
        FillDisabled = Color3.fromRGB(60, 60, 65),
        BadgeBg = Color3.fromRGB(25, 25, 25),
        BadgeText = Color3.fromRGB(255, 255, 255),
        BadgeTextDisabled = Color3.fromRGB(70, 70, 78),
        DescriptionText = Color3.fromRGB(105, 105, 115),
        ThumbBg = Color3.fromRGB(255, 255, 255),
        ThumbBorder = Color3.fromRGB(200, 200, 200),
    }

    local TITLE_SIZE = 13
    local DESC_SIZE = 11
    local BADGE_SIZE = 11
    local TRACK_H = 6
    local THUMB_SIZE = 14
    local THUMB_HOVER = 3
    local BASE_H = 36
    local WORD_MAX = 20
    local BADGE_MIN_W = 40

    local tweenService = TweenService or game:GetService("TweenService")
    local userInputService = UserInputService or game:GetService("UserInputService")
    local fontBold = FONT_BOLD or Enum.Font.SourceSansBold
    local fontRegular = FONT or Enum.Font.SourceSans

    local TI_FILL = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local TI_HOVER = TweenInfo.new(0.1)

    local connections = {}
    local destroyed = false
    local dragging = false
    local hovering = false

    local function connect(signal, fn)
        local conn = signal:Connect(fn)
        table.insert(connections, conn)
        return conn
    end

    local function warnNotify(msg)
        pcall(function()
            Notify({ Title = "CodyWas | Slider", Description = msg, Duration = 5 })
        end)
    end

    local function breakLongWords(text, maxLen)
        text = tostring(text or "")
        local lines = {}
        for line in (text .. "\n"):gmatch("(.-)\n") do
            local result = {}
            for word in line:gmatch("%S+") do
                while #word > maxLen do
                    table.insert(result, word:sub(1, maxLen))
                    word = word:sub(maxLen + 1)
                end
                table.insert(result, word)
            end
            table.insert(lines, table.concat(result, " "))
        end
        return table.concat(lines, "\n")
    end

    local function isFiniteNumber(v)
        return type(v) == "number" and v == v and v ~= math.huge and v ~= -math.huge
    end

    local function round(value, decimals)
        local m = 10 ^ decimals
        return math.floor(value * m + 0.5) / m
    end

    local function isPointerInput(input)
        return input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
    end

    local title = tostring(options.title or options.Name or "Slider")
    local description = tostring(options.description or "")
    local min = tonumber(options.min or options.Min)
    local max = tonumber(options.max or options.Max)
    local rounding = tonumber(options.rounding)
    local suffix = tostring(options.suffix or options.ValueName or "")
    local default = tonumber(options.default or options.Default)
    local disabled = options.disabled == true
    local callback = options.callback or options.Callback

    if not isFiniteNumber(min) then min = 0 end
    if not isFiniteNumber(max) then max = 100 end
    if min > max then min, max = max, min end
    if min == max then max = min + 1 end

    if not isFiniteNumber(rounding) or rounding < 0 then rounding = 0 end
    rounding = math.floor(rounding)

    if not isFiniteNumber(default) then default = min end

    if type(callback) ~= "function" then
        callback = function() end
    end

    default = round(math.clamp(default, min, max), rounding)

    local data = {
        value = default,
        disabled = disabled,
    }

    local function formatValue(v)
        if rounding <= 0 then
            return tostring(math.floor(v + 0.5)) .. suffix
        end
        return string.format("%." .. rounding .. "f", v) .. suffix
    end

    local container = Instance.new("Frame")
    container.Name = title .. "_Slider"
    container.Size = UDim2.new(1, 0, 0, BASE_H)
    container.BackgroundTransparency = 1
    container.Parent = section.frame

    local mainLayout = Instance.new("UIListLayout")
    mainLayout.FillDirection = Enum.FillDirection.Vertical
    mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
    mainLayout.Padding = UDim.new(0, 6)
    mainLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    mainLayout.Parent = container

    local topRow = Instance.new("Frame")
    topRow.Name = "TopRow"
    topRow.Size = UDim2.new(1, 0, 0, 16)
    topRow.BackgroundTransparency = 1
    topRow.LayoutOrder = 0
    topRow.Parent = container

    local topLayout = Instance.new("UIListLayout")
    topLayout.FillDirection = Enum.FillDirection.Horizontal
    topLayout.SortOrder = Enum.SortOrder.LayoutOrder
    topLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    topLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    topLayout.Padding = UDim.new(0, 6)
    topLayout.Parent = topRow

    local valueBadge = Instance.new("TextLabel")
    valueBadge.Name = "ValueBadge"
    valueBadge.Size = UDim2.new(0, BADGE_MIN_W, 1, 0)
    valueBadge.AutomaticSize = Enum.AutomaticSize.X
    valueBadge.BackgroundColor3 = COLORS.BadgeBg
    valueBadge.BorderSizePixel = 0
    valueBadge.Text = formatValue(default)
    valueBadge.TextColor3 = COLORS.BadgeText
    valueBadge.TextSize = BADGE_SIZE
    valueBadge.Font = fontBold
    valueBadge.TextXAlignment = Enum.TextXAlignment.Center
    valueBadge.TextYAlignment = Enum.TextYAlignment.Center
    valueBadge.LayoutOrder = 2
    valueBadge.Parent = topRow

    local badgePad = Instance.new("UIPadding")
    badgePad.PaddingLeft = UDim.new(0, 6)
    badgePad.PaddingRight = UDim.new(0, 6)
    badgePad.Parent = valueBadge

    local badgeCorner = Instance.new("UICorner")
    badgeCorner.CornerRadius = UDim.new(0, 4)
    badgeCorner.Parent = valueBadge

    local badgeStroke = Instance.new("UIStroke")
    badgeStroke.Color = COLORS.Line
    badgeStroke.Thickness = 1
    badgeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    badgeStroke.Parent = valueBadge

    local label = Instance.new("TextLabel")
    label.Name = "Title"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = COLORS.TextActive
    label.TextSize = TITLE_SIZE
    label.Font = fontBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.LayoutOrder = 1
    label.Parent = topRow

    local titleFlex = Instance.new("UIFlexItem")
    titleFlex.FlexMode = Enum.UIFlexMode.Fill
    titleFlex.Parent = label

    local descLabel

    local function createDescription(text)
        descLabel = Instance.new("TextLabel")
        descLabel.Name = "Description"
        descLabel.Size = UDim2.new(1, 0, 0, 0)
        descLabel.AutomaticSize = Enum.AutomaticSize.Y
        descLabel.BackgroundTransparency = 1
        descLabel.Text = breakLongWords(text, WORD_MAX)
        descLabel.TextColor3 = COLORS.DescriptionText
        descLabel.TextSize = DESC_SIZE
        descLabel.Font = fontRegular
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.TextYAlignment = Enum.TextYAlignment.Top
        descLabel.TextWrapped = true
        descLabel.LineHeight = 1.15
        descLabel.LayoutOrder = 1
        descLabel.Parent = container
    end

    if description ~= "" then
        createDescription(description)
    end

    local trackWrapper = Instance.new("Frame")
    trackWrapper.Name = "TrackWrapper"
    trackWrapper.Size = UDim2.new(1, 0, 0, THUMB_SIZE + 6)
    trackWrapper.BackgroundTransparency = 1
    trackWrapper.LayoutOrder = 2
    trackWrapper.Parent = container

    local track = Instance.new("Frame")
    track.Name = "Track"
    track.Size = UDim2.new(1, 0, 0, TRACK_H)
    track.Position = UDim2.new(0, 0, 0.5, -TRACK_H / 2)
    track.BackgroundColor3 = COLORS.Track
    track.BorderSizePixel = 0
    track.ClipsDescendants = false
    track.Parent = trackWrapper

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track

    local trackStroke = Instance.new("UIStroke")
    trackStroke.Color = COLORS.Line
    trackStroke.Thickness = 1
    trackStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    trackStroke.Parent = track

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = COLORS.Fill
    fill.BorderSizePixel = 0
    fill.ZIndex = 1
    fill.ClipsDescendants = false
    fill.Parent = track

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    local thumb = Instance.new("Frame")
    thumb.Name = "Thumb"
    thumb.Size = UDim2.new(0, THUMB_SIZE, 0, THUMB_SIZE)
    thumb.AnchorPoint = Vector2.new(0.5, 0.5)
    thumb.Position = UDim2.new(0, 0, 0.5, 0)
    thumb.BackgroundColor3 = COLORS.ThumbBg
    thumb.BorderSizePixel = 0
    thumb.ZIndex = 4
    thumb.Parent = track

    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = thumb

    local thumbStroke = Instance.new("UIStroke")
    thumbStroke.Color = COLORS.ThumbBorder
    thumbStroke.Thickness = 1.5
    thumbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    thumbStroke.Parent = thumb

    local clickArea = Instance.new("TextButton")
    clickArea.Name = "ClickArea"
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.AutoButtonColor = false
    clickArea.Selectable = false
    clickArea.ZIndex = 5
    clickArea.Parent = trackWrapper

    local function resizeContainer()
        if destroyed then return end
        local contentH = mainLayout.AbsoluteContentSize.Y
        container.Size = UDim2.new(1, 0, 0, math.max(contentH + 4, BASE_H))
    end

    local function getAlpha(value)
        local range = max - min
        if range <= 0 then return 0 end
        return math.clamp((value - min) / range, 0, 1)
    end

    local function updateThumbSize()
        if destroyed then return end
        local grown = (hovering or dragging) and not data.disabled
        local size = grown and (THUMB_SIZE + THUMB_HOVER) or THUMB_SIZE
        tweenService:Create(thumb, TI_HOVER, { Size = UDim2.new(0, size, 0, size) }):Play()
    end

    local function updateVisuals(animate)
        if destroyed then return end

        local alpha = getAlpha(data.value)
        local fillColor = data.disabled and COLORS.FillDisabled or COLORS.Fill
        local thumbColor = data.disabled and COLORS.FillDisabled or COLORS.ThumbBg
        local textColor = data.disabled and COLORS.TextDisabled or COLORS.TextActive
        local badgeColor = data.disabled and COLORS.BadgeTextDisabled or COLORS.BadgeText

        valueBadge.Text = formatValue(data.value)
        valueBadge.TextColor3 = badgeColor
        label.TextColor3 = textColor
        clickArea.Active = not data.disabled

        if animate then
            tweenService:Create(fill, TI_FILL, { Size = UDim2.new(alpha, 0, 1, 0), BackgroundColor3 = fillColor }):Play()
            tweenService:Create(thumb, TI_FILL, { Position = UDim2.new(alpha, 0, 0.5, 0), BackgroundColor3 = thumbColor }):Play()
        else
            fill.Size = UDim2.new(alpha, 0, 1, 0)
            fill.BackgroundColor3 = fillColor
            thumb.Position = UDim2.new(alpha, 0, 0.5, 0)
            thumb.BackgroundColor3 = thumbColor
        end
    end

    local function fireCallback(value)
        local ok, err = pcall(callback, value)
        if not ok then
            warnNotify(("Slider '%s': %s"):format(title, tostring(err)))
        end
    end

    local function setValue(newValue, animate, silent)
        newValue = round(math.clamp(newValue, min, max), rounding)
        local changed = newValue ~= data.value
        data.value = newValue
        updateVisuals(animate)
        if changed and not silent then
            fireCallback(data.value)
        end
        return changed
    end

    local function setFromAlpha(alpha, animate)
        alpha = math.clamp(alpha, 0, 1)
        setValue(min + (max - min) * alpha, animate)
    end

    local function getAlphaFromX(xPos)
        local absPos = track.AbsolutePosition.X
        local absSize = track.AbsoluteSize.X
        if absSize <= 0 then return 0 end
        return (xPos - absPos) / absSize
    end

    local function stopDragging()
        if not dragging then return end
        dragging = false
        updateThumbSize()
    end

    connect(clickArea.InputBegan, function(input)
        if destroyed or data.disabled then return end
        if isPointerInput(input) then
            dragging = true
            updateThumbSize()
            setFromAlpha(getAlphaFromX(input.Position.X), true)
        end
    end)

    connect(userInputService.InputChanged, function(input)
        if destroyed or not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            setFromAlpha(getAlphaFromX(input.Position.X), false)
        end
    end)

    connect(userInputService.InputEnded, function(input)
        if isPointerInput(input) then
            stopDragging()
        end
    end)

    connect(clickArea.MouseEnter, function()
        hovering = true
        updateThumbSize()
    end)

    connect(clickArea.MouseLeave, function()
        hovering = false
        updateThumbSize()
    end)

    connect(mainLayout:GetPropertyChangedSignal("AbsoluteContentSize"), resizeContainer)

    resizeContainer()
    updateVisuals(false)
    fireCallback(data.value)

    function data:Set(value)
        if destroyed then return end
        value = tonumber(value)
        if not isFiniteNumber(value) then
            warnNotify(("Slider '%s': valor invalido em Set()."):format(title))
            return
        end
        setValue(value, true)
    end

    function data:Get()
        return data.value
    end

    function data:SetMin(newMin)
        if destroyed then return end
        newMin = tonumber(newMin)
        if not isFiniteNumber(newMin) or newMin >= max then
            warnNotify(("Slider '%s': min invalido."):format(title))
            return
        end
        min = newMin
        setValue(data.value, true)
    end

    function data:SetMax(newMax)
        if destroyed then return end
        newMax = tonumber(newMax)
        if not isFiniteNumber(newMax) or newMax <= min then
            warnNotify(("Slider '%s': max invalido."):format(title))
            return
        end
        max = newMax
        setValue(data.value, true)
    end

    function data:SetDisabled(value)
        if destroyed then return end
        data.disabled = value == true
        if data.disabled then
            stopDragging()
        end
        updateVisuals(true)
        updateThumbSize()
    end

    function data:SetTitle(newTitle)
        if destroyed then return end
        title = tostring(newTitle or "")
        label.Text = title
        container.Name = title .. "_Slider"
    end

    function data:SetDescription(newDesc)
        if destroyed then return end
        newDesc = tostring(newDesc or "")
        if newDesc == "" then
            if descLabel then
                descLabel:Destroy()
                descLabel = nil
            end
            resizeContainer()
            return
        end
        if not descLabel then
            createDescription(newDesc)
        else
            descLabel.Text = breakLongWords(newDesc, WORD_MAX)
        end
        resizeContainer()
    end

    function data:SetSuffix(newSuffix)
        if destroyed then return end
        suffix = tostring(newSuffix or "")
        updateVisuals(false)
    end

    function data:Destroy()
        if destroyed then return end
        destroyed = true
        dragging = false
        for _, conn in ipairs(connections) do
            conn:Disconnect()
        end
        table.clear(connections)
        container:Destroy()
    end

    return data
end)