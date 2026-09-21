-- // Button
Elements.Register("Button", function(section, options)
    options = type(options) == "table" and options or {}

    local COLORS = {
        Background = Color3.fromRGB(20, 20, 20),
        BackgroundHover = Color3.fromRGB(32, 32, 32),
        Border = Color3.fromRGB(40, 40, 40),
        BorderHover = Color3.fromRGB(70, 70, 80),
        TextActive = Color3.fromRGB(220, 220, 220),
        TextDisabled = Color3.fromRGB(70, 70, 78),
        DescriptionText = Color3.fromRGB(100, 100, 110),
    }

    local TITLE_SIZE = 13
    local DESC_SIZE = 11
    local WORD_MAX = 20
    local BASE_H = 30
    local TWEEN_INFO = TweenInfo.new(0.1)

    local tweenService = TweenService or game:GetService("TweenService")
    local fontBold = FONT_BOLD or Enum.Font.SourceSansBold
    local fontRegular = FONT or Enum.Font.SourceSans

    local connections = {}
    local destroyed = false
    local hovering = false

    local function connect(signal, fn)
        local conn = signal:Connect(fn)
        table.insert(connections, conn)
        return conn
    end

    local function warnNotify(msg)
        pcall(function()
            Notify({ Title = "CodyWas | Button", Description = msg, Duration = 5 })
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

    local title = tostring(options.title or options.Name or "Button")
    local description = tostring(options.description or "")
    local disabled = options.disabled == true
    local callback = options.callback or options.Callback

    if type(callback) ~= "function" then
        callback = function() end
    end

    local data = {
        disabled = disabled,
    }

    local container = Instance.new("Frame")
    container.Name = title .. "_Button"
    container.Size = UDim2.new(1, 0, 0, BASE_H)
    container.BackgroundColor3 = COLORS.Background
    container.BorderSizePixel = 0
    container.ClipsDescendants = true
    container.Parent = section.frame

    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 4)
    containerCorner.Parent = container

    local containerStroke = Instance.new("UIStroke")
    containerStroke.Color = COLORS.Border
    containerStroke.Thickness = 1
    containerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    containerStroke.Parent = container

    local textFrame = Instance.new("Frame")
    textFrame.Name = "TextFrame"
    textFrame.Size = UDim2.new(1, -20, 1, 0)
    textFrame.Position = UDim2.new(0, 10, 0, 0)
    textFrame.BackgroundTransparency = 1
    textFrame.ZIndex = 1
    textFrame.Parent = container

    local textLayout = Instance.new("UIListLayout")
    textLayout.FillDirection = Enum.FillDirection.Vertical
    textLayout.SortOrder = Enum.SortOrder.LayoutOrder
    textLayout.Padding = UDim.new(0, 2)
    textLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    textLayout.Parent = textFrame

    local label = Instance.new("TextLabel")
    label.Name = "Title"
    label.Size = UDim2.new(1, 0, 0, TITLE_SIZE + 3)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = disabled and COLORS.TextDisabled or COLORS.TextActive
    label.TextSize = TITLE_SIZE
    label.Font = fontBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.LayoutOrder = 0
    label.ZIndex = 1
    label.Parent = textFrame

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
        descLabel.ZIndex = 1
        descLabel.Parent = textFrame
    end

    local clickArea = Instance.new("TextButton")
    clickArea.Name = "ClickArea"
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.AutoButtonColor = false
    clickArea.Selectable = false
    clickArea.ZIndex = 2
    clickArea.Parent = container

    local function resizeContainer()
        if destroyed then return end
        if not descLabel then
            container.Size = UDim2.new(1, 0, 0, BASE_H)
            return
        end
        local contentH = textLayout.AbsoluteContentSize.Y
        local totalH = math.max(contentH + 14, BASE_H)
        container.Size = UDim2.new(1, 0, 0, totalH)
    end

    local function tweenHover(state)
        if destroyed then return end
        local bg = state and COLORS.BackgroundHover or COLORS.Background
        local border = state and COLORS.BorderHover or COLORS.Border
        tweenService:Create(container, TWEEN_INFO, { BackgroundColor3 = bg }):Play()
        tweenService:Create(containerStroke, TWEEN_INFO, { Color = border }):Play()
    end

    local function updateVisuals()
        if destroyed then return end
        label.TextColor3 = data.disabled and COLORS.TextDisabled or COLORS.TextActive
        clickArea.Active = not data.disabled
        tweenHover(hovering and not data.disabled)
    end

    local function fireCallback()
        local ok, err = pcall(callback)
        if not ok then
            warnNotify(("Button '%s': %s"):format(title, tostring(err)))
        end
    end

    local function press()
        if destroyed or data.disabled then return end
        fireCallback()
    end

    connect(clickArea.MouseButton1Click, press)

    connect(clickArea.MouseEnter, function()
        hovering = true
        if data.disabled then return end
        tweenHover(true)
    end)

    connect(clickArea.MouseLeave, function()
        hovering = false
        if data.disabled then return end
        tweenHover(false)
    end)

    connect(textLayout:GetPropertyChangedSignal("AbsoluteContentSize"), resizeContainer)

    if description ~= "" then
        createDescription(description)
    end

    resizeContainer()
    updateVisuals()

    function data:SetDisabled(value)
        if destroyed then return end
        data.disabled = value == true
        updateVisuals()
    end

    function data:SetTitle(newTitle)
        if destroyed then return end
        label.Text = tostring(newTitle or "")
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

    function data:Fire()
        press()
    end

    function data:Destroy()
        if destroyed then return end
        destroyed = true
        for _, conn in ipairs(connections) do
            conn:Disconnect()
        end
        table.clear(connections)
        container:Destroy()
    end

    return data
end)