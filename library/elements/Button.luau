-- // Button
Elements.Register("Button", function(section, options)
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

    local function warnNotify(msg)
        pcall(function()
            Notify({ Title = "CodyWas | Button", Description = msg, Duration = 5 })
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

    local title = options.title or options.Name or "Button"
    local description = options.description or ""
    local disabled = options.disabled or false
    local callback = options.callback or options.Callback or function() end

    local displayDescription = breakLongWords(description, WORD_MAX)
    local hasDescription = description ~= ""

    local data = {
        disabled = disabled,
    }

    local container = Instance.new("Frame")
    container.Name = title .. "_Button"
    container.Size = UDim2.new(1, 0, 0, BASE_H)
    container.BackgroundColor3 = COLORS.Background
    container.BorderSizePixel = 0
    container.Parent = section.frame

    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 4)
    containerCorner.Parent = container

    local containerStroke = Instance.new("UIStroke")
    containerStroke.Color = COLORS.Border
    containerStroke.Thickness = 1
    containerStroke.Parent = container

    local clickArea = Instance.new("TextButton")
    clickArea.Name = "ClickArea"
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.AutoButtonColor = false
    clickArea.Selectable = false
    clickArea.Parent = container

    local textFrame = Instance.new("Frame")
    textFrame.Size = UDim2.new(1, -20, 1, 0)
    textFrame.Position = UDim2.new(0, 10, 0, 0)
    textFrame.BackgroundTransparency = 1
    textFrame.Parent = container

    local textLayout = Instance.new("UIListLayout")
    textLayout.FillDirection = Enum.FillDirection.Vertical
    textLayout.SortOrder = Enum.SortOrder.LayoutOrder
    textLayout.Padding = UDim.new(0, 2)
    textLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    textLayout.Parent = textFrame

    local label = Instance.new("TextLabel")
    label.Name = "Title"
    label.Size = UDim2.new(1, 0, 0, 16)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = disabled and COLORS.TextDisabled or COLORS.TextActive
    label.TextSize = TITLE_SIZE
    label.Font = FONT_BOLD or Enum.Font.SourceSansBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.LayoutOrder = 0
    label.Parent = textFrame

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
        descLabel.Parent = textFrame
    end

    local function resizeContainer()
        if not hasDescription then return end
        local contentH = textLayout.AbsoluteContentSize.Y
        local totalH = math.max(contentH + 14, BASE_H)
        container.Size = UDim2.new(1, 0, 0, totalH)
    end

    local function updateVisuals()
        label.TextColor3 = data.disabled and COLORS.TextDisabled or COLORS.TextActive
        clickArea.Active = not data.disabled
    end

    local function fireCallback()
        local ok, err = pcall(callback)
        if not ok then
            warnNotify(("Button '%s': %s"):format(title, tostring(err)))
        end
    end

    local function press()
        if data.disabled then return end
        fireCallback()
    end

    clickArea.MouseButton1Click:Connect(press)

    clickArea.MouseEnter:Connect(function()
        if data.disabled then return end
        TweenService:Create(container, TweenInfo.new(0.1), { BackgroundColor3 = COLORS.BackgroundHover }):Play()
        TweenService:Create(containerStroke, TweenInfo.new(0.1), { Color = COLORS.BorderHover }):Play()
    end)

    clickArea.MouseLeave:Connect(function()
        if data.disabled then return end
        TweenService:Create(container, TweenInfo.new(0.1), { BackgroundColor3 = COLORS.Background }):Play()
        TweenService:Create(containerStroke, TweenInfo.new(0.1), { Color = COLORS.Border }):Play()
    end)

    if hasDescription then
        textLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeContainer)
        resizeContainer()
    end

    updateVisuals()

    function data:SetDisabled(value)
        data.disabled = value
        updateVisuals()
    end

    function data:SetTitle(newTitle)
        label.Text = newTitle
    end

    function data:SetDescription(newDesc)
        if not descLabel then
            warnNotify(("Button '%s': sem descricao inicial."):format(title))
            return
        end
        descLabel.Text = breakLongWords(newDesc, WORD_MAX)
        resizeContainer()
    end

    function data:Fire()
        press()
    end

    function data:Destroy()
        container:Destroy()
    end

    return data
end)