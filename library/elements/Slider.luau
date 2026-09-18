-- // Slider
Elements.Register("Slider", function(section, options)
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
        DescriptionText = Color3.fromRGB(105, 105, 115),
        ThumbBg = Color3.fromRGB(255, 255, 255),
        ThumbBorder = Color3.fromRGB(200, 200, 200),
    }

    local TITLE_SIZE = 13
    local DESC_SIZE = 11
    local BADGE_SIZE = 11
    local TRACK_H = 6
    local THUMB_SIZE = 14
    local BASE_H = 36
    local WORD_MAX = 20

    local function warnNotify(msg)
        pcall(function()
            Notify({ Title = "CodyWas | Slider", Description = msg, Duration = 5 })
        end)
    end

    local function breakLongWords(text, maxLen)
        local result = {}
        for word in text:gmatch("%S+") do
            while #word > maxLen do
                table.insert(result, word:sub(1, maxLen))
                word = word:sub(maxLen + 1)
            end
            table.insert(result, word)
        end
        return table.concat(result, " ")
    end

    local function round(value, decimals)
        local m = 10 ^ decimals
        return math.floor(value * m + 0.5) / m
    end

    local title = options.title or options.Name or "Slider"
    local description = options.description or ""
    local min = options.min or options.Min or 0
    local max = options.max or options.Max or 100
    local rounding = options.rounding or 0
    local suffix = options.suffix or options.ValueName or ""
    local default = options.default or options.Default or min
    local disabled = options.disabled or false
    local callback = options.callback or options.Callback or function() end

    local displayDescription = breakLongWords(description, WORD_MAX)
    local hasDescription = description ~= ""

    default = round(math.clamp(default, min, max), rounding)

    local data = {
        value = default,
        disabled = disabled,
    }

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

    local label = Instance.new("TextLabel")
    label.Name = "Title"
    label.Size = UDim2.new(1, -58, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = COLORS.TextActive
    label.TextSize = TITLE_SIZE
    label.Font = FONT_BOLD or Enum.Font.SourceSansBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = topRow

    local valueBadge = Instance.new("TextLabel")
    valueBadge.Name = "ValueBadge"
    valueBadge.Size = UDim2.new(0, 52, 1, 0)
    valueBadge.Position = UDim2.new(1, 0, 0, 0)
    valueBadge.AnchorPoint = Vector2.new(1, 0)
    valueBadge.BackgroundColor3 = COLORS.BadgeBg
    valueBadge.BorderSizePixel = 0
    valueBadge.Text = tostring(default) .. suffix
    valueBadge.TextColor3 = COLORS.BadgeText
    valueBadge.TextSize = BADGE_SIZE
    valueBadge.Font = FONT_BOLD or Enum.Font.SourceSansBold
    valueBadge.TextXAlignment = Enum.TextXAlignment.Center
    valueBadge.TextYAlignment = Enum.TextYAlignment.Center
    valueBadge.Parent = topRow

    local badgeCorner = Instance.new("UICorner")
    badgeCorner.CornerRadius = UDim.new(0, 4)
    badgeCorner.Parent = valueBadge

    local badgeStroke = Instance.new("UIStroke")
    badgeStroke.Color = COLORS.Line
    badgeStroke.Thickness = 1
    badgeStroke.Parent = valueBadge

    local descLabel
    if hasDescription then
        descLabel = Instance.new("TextLabel")
        descLabel.Name = "Description"
        descLabel.Size = UDim2.new(1, 0, 0, 0)
        descLabel.AutomaticSize = Enum.AutomaticSize.Y
        descLabel.BackgroundTransparency = 1
        descLabel.Text = displayDescription
        descLabel.TextColor3 = COLORS.DescriptionText
        descLabel.TextSize = DESC_SIZE
        descLabel.Font = FONT or Enum.Font.SourceSans
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.TextYAlignment = Enum.TextYAlignment.Top
        descLabel.TextWrapped = true
        descLabel.LineHeight = 1.15
        descLabel.LayoutOrder = 1
        descLabel.Parent = container
    end

    local trackWrapper = Instance.new("Frame")
    trackWrapper.Name = "TrackWrapper"
    trackWrapper.Size = UDim2.new(1, 0, 0, THUMB_SIZE)
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
        local contentH = mainLayout.AbsoluteContentSize.Y
        container.Size = UDim2.new(1, 0, 0, math.max(contentH + 4, BASE_H))
    end

    local function updateVisuals(animate)
        local alpha = math.clamp((data.value - min) / (max - min), 0, 1)
        local fillColor = data.disabled and COLORS.FillDisabled or COLORS.Fill
        local thumbColor = data.disabled and COLORS.FillDisabled or COLORS.ThumbBg
        local textColor = data.disabled and COLORS.TextDisabled or COLORS.TextActive

        valueBadge.Text = tostring(data.value) .. suffix
        label.TextColor3 = textColor
        clickArea.Active = not data.disabled

        if animate then
            local ti = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(fill, ti, { Size = UDim2.new(alpha, 0, 1, 0), BackgroundColor3 = fillColor }):Play()
            TweenService:Create(thumb, ti, { Position = UDim2.new(alpha, 0, 0.5, 0), BackgroundColor3 = thumbColor }):Play()
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

    local function setFromAlpha(alpha, animate)
        alpha = math.clamp(alpha, 0, 1)
        local newValue = round(min + (max - min) * alpha, rounding)
        if newValue == data.value then return end
        data.value = newValue
        updateVisuals(animate)
        fireCallback(data.value)
    end

    local function getAlphaFromX(xPos)
        local absPos = track.AbsolutePosition.X
        local absSize = track.AbsoluteSize.X
        if absSize <= 0 then return 0 end
        return (xPos - absPos) / absSize
    end

    local dragging = false

    clickArea.InputBegan:Connect(function(input)
        if data.disabled then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setFromAlpha(getAlphaFromX(input.Position.X), true)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            setFromAlpha(getAlphaFromX(input.Position.X), false)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    clickArea.MouseEnter:Connect(function()
        if data.disabled then return end
        TweenService:Create(thumb, TweenInfo.new(0.1), { Size = UDim2.new(0, THUMB_SIZE + 3, 0, THUMB_SIZE + 3) }):Play()
    end)

    clickArea.MouseLeave:Connect(function()
        if dragging then return end
        TweenService:Create(thumb, TweenInfo.new(0.1), { Size = UDim2.new(0, THUMB_SIZE, 0, THUMB_SIZE) }):Play()
    end)

    if hasDescription then
        descLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(resizeContainer)
    end

    mainLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeContainer)

    resizeContainer()
    updateVisuals(false)
    fireCallback(data.value)

    function data:Set(value)
        value = round(math.clamp(value, min, max), rounding)
        data.value = value
        updateVisuals(true)
        fireCallback(value)
    end

    function data:Get()
        return data.value
    end

    function data:SetMin(newMin)
        min = newMin
        data.value = round(math.clamp(data.value, min, max), rounding)
        updateVisuals(true)
    end

    function data:SetMax(newMax)
        max = newMax
        data.value = round(math.clamp(data.value, min, max), rounding)
        updateVisuals(true)
    end

    function data:SetDisabled(value)
        data.disabled = value
        updateVisuals(true)
    end

    function data:SetTitle(newTitle)
        label.Text = newTitle
    end

    function data:SetDescription(newDesc)
        if not descLabel then
            warnNotify(("Slider '%s': sem descricao inicial."):format(title))
            return
        end
        descLabel.Text = breakLongWords(newDesc, WORD_MAX)
        resizeContainer()
    end

    function data:SetSuffix(newSuffix)
        suffix = newSuffix
        updateVisuals(false)
    end

    function data:Destroy()
        container:Destroy()
    end

    return data
end)