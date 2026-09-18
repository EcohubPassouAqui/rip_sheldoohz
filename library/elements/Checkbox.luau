-- // CheckBox
Elements.Register("Checkbox", function(section, options)
    local COLORS = {
        Active = Color3.fromRGB(255, 255, 255),
        Inactive = Color3.fromRGB(20, 20, 20),
        TextActive = Color3.fromRGB(255, 255, 255),
        TextInactive = Color3.fromRGB(105, 105, 115),
        TextDisabled = Color3.fromRGB(70, 70, 78),
        Line = Color3.fromRGB(32, 32, 32),
        Icon = Color3.fromRGB(20, 20, 20),
        DescriptionText = Color3.fromRGB(105, 105, 115),
        KeyBindBg = Color3.fromRGB(30, 30, 32),
        KeyBindBorder = Color3.fromRGB(55, 55, 60),
        KeyBindText = Color3.fromRGB(180, 180, 190),
        KeyBindHover = Color3.fromRGB(40, 40, 44),
        KeyBindListening = Color3.fromRGB(50, 50, 56),
        KeyBindListenText = Color3.fromRGB(220, 220, 255),
    }

    local TITLE_SIZE = 13
    local DESC_SIZE = 11
    local KEY_SIZE = 11
    local BOX = 18
    local PILL_W = 46
    local PILL_H = 20
    local WORD_MAX = 20
    local BASE_H = 36

    local function warnNotify(msg)
        pcall(function()
            Notify({ Title = "CodyWas | Checkbox", Description = msg, Duration = 5 })
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

    local KEY_NAMES = {
        [Enum.KeyCode.A] = "A", [Enum.KeyCode.B] = "B", [Enum.KeyCode.C] = "C",
        [Enum.KeyCode.D] = "D", [Enum.KeyCode.E] = "E", [Enum.KeyCode.F] = "F",
        [Enum.KeyCode.G] = "G", [Enum.KeyCode.H] = "H", [Enum.KeyCode.I] = "I",
        [Enum.KeyCode.J] = "J", [Enum.KeyCode.K] = "K", [Enum.KeyCode.L] = "L",
        [Enum.KeyCode.M] = "M", [Enum.KeyCode.N] = "N", [Enum.KeyCode.O] = "O",
        [Enum.KeyCode.P] = "P", [Enum.KeyCode.Q] = "Q", [Enum.KeyCode.R] = "R",
        [Enum.KeyCode.S] = "S", [Enum.KeyCode.T] = "T", [Enum.KeyCode.U] = "U",
        [Enum.KeyCode.V] = "V", [Enum.KeyCode.W] = "W", [Enum.KeyCode.X] = "X",
        [Enum.KeyCode.Y] = "Y", [Enum.KeyCode.Z] = "Z",
        [Enum.KeyCode.Zero] = "0", [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2", [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4", [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6", [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8", [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.F1] = "F1", [Enum.KeyCode.F2] = "F2",
        [Enum.KeyCode.F3] = "F3", [Enum.KeyCode.F4] = "F4",
        [Enum.KeyCode.F5] = "F5", [Enum.KeyCode.F6] = "F6",
        [Enum.KeyCode.F7] = "F7", [Enum.KeyCode.F8] = "F8",
        [Enum.KeyCode.F9] = "F9", [Enum.KeyCode.F10] = "F10",
        [Enum.KeyCode.F11] = "F11", [Enum.KeyCode.F12] = "F12",
        [Enum.KeyCode.LeftShift] = "LShift", [Enum.KeyCode.RightShift] = "RShift",
        [Enum.KeyCode.LeftControl] = "LCtrl", [Enum.KeyCode.RightControl] = "RCtrl",
        [Enum.KeyCode.LeftAlt] = "LAlt", [Enum.KeyCode.RightAlt] = "RAlt",
        [Enum.KeyCode.Tab] = "Tab", [Enum.KeyCode.CapsLock] = "Caps",
        [Enum.KeyCode.Space] = "Space", [Enum.KeyCode.Return] = "Enter",
        [Enum.KeyCode.Backspace] = "Back", [Enum.KeyCode.Delete] = "Del",
        [Enum.KeyCode.Insert] = "Ins", [Enum.KeyCode.Home] = "Home",
        [Enum.KeyCode.End] = "End", [Enum.KeyCode.PageUp] = "PgUp",
        [Enum.KeyCode.PageDown] = "PgDn", [Enum.KeyCode.Escape] = "Esc",
        [Enum.KeyCode.Up] = "Up", [Enum.KeyCode.Down] = "Down",
        [Enum.KeyCode.Left] = "Left", [Enum.KeyCode.Right] = "Right",
        [Enum.KeyCode.KeypadZero] = "Num0", [Enum.KeyCode.KeypadOne] = "Num1",
        [Enum.KeyCode.KeypadTwo] = "Num2", [Enum.KeyCode.KeypadThree] = "Num3",
        [Enum.KeyCode.KeypadFour] = "Num4", [Enum.KeyCode.KeypadFive] = "Num5",
        [Enum.KeyCode.KeypadSix] = "Num6", [Enum.KeyCode.KeypadSeven] = "Num7",
        [Enum.KeyCode.KeypadEight] = "Num8", [Enum.KeyCode.KeypadNine] = "Num9",
        [Enum.UserInputType.MouseButton1] = "M1",
        [Enum.UserInputType.MouseButton2] = "M2",
        [Enum.UserInputType.MouseButton3] = "M3",
    }

    local function getKeyName(binding)
        if not binding then return "None" end
        return KEY_NAMES[binding] or tostring(binding):match("%.(%w+)$") or "?"
    end

    local function isKeyCode(binding)
        if typeof(binding) ~= "EnumItem" then return false end
        return tostring(binding.EnumType) == "KeyCode"
    end

    local function isMouseButton(binding)
        if typeof(binding) ~= "EnumItem" then return false end
        local t = tostring(binding.EnumType)
        return t == "UserInputType"
    end

    local function matchInput(binding, input)
        if isKeyCode(binding) then
            if input.UserInputType ~= Enum.UserInputType.Keyboard then return false end
            return tostring(input.KeyCode) == tostring(binding)
        elseif isMouseButton(binding) then
            return tostring(input.UserInputType) == tostring(binding)
        end
        return false
    end

    local title = options.title or options.Name or "Checkbox"
    local description = options.description or ""
    local default = options.default or options.Default or false
    local disabled = options.disabled or false
    local callback = options.callback or options.Callback or function() end
    local keybind = options.keybind
    local keybindCb = options.keybindCallback

    local displayDescription = breakLongWords(description, WORD_MAX)
    local hasDescription = description ~= ""
    local hasKeybind = keybind ~= nil

    local data = {
        state = default,
        disabled = disabled,
        keybind = keybind,
        listening = false,
    }

    local rightReserve = BOX + 4
    if hasKeybind then
        rightReserve = rightReserve + PILL_W + 6
    end

    local container = Instance.new("Frame")
    container.Name = title .. "_Checkbox"
    container.Size = UDim2.new(1, 0, 0, BASE_H)
    container.BackgroundTransparency = 1
    container.Parent = section.frame

    local clickArea = Instance.new("TextButton")
    clickArea.Name = "ClickArea"
    clickArea.Size = UDim2.new(1, -rightReserve, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.AutoButtonColor = false
    clickArea.Selectable = false
    clickArea.Parent = container

    local textFrame = Instance.new("Frame")
    textFrame.Size = UDim2.new(1, 0, 1, 0)
    textFrame.BackgroundTransparency = 1
    textFrame.Parent = clickArea

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
    label.TextColor3 = default and COLORS.TextActive or COLORS.TextInactive
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

    local box = Instance.new("Frame")
    box.Name = "Box"
    box.Size = UDim2.new(0, BOX, 0, BOX)
    box.Position = UDim2.new(1, 0, 0.5, -BOX / 2)
    box.AnchorPoint = Vector2.new(1, 0)
    box.BackgroundColor3 = default and COLORS.Active or COLORS.Inactive
    box.BorderSizePixel = 0
    box.Parent = container

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = box

    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = default and COLORS.Active or COLORS.Line
    boxStroke.Thickness = 1.2
    boxStroke.Parent = box

    local checkIcon = Instance.new("ImageLabel")
    checkIcon.Size = UDim2.new(0, 12, 0, 12)
    checkIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    checkIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    checkIcon.BackgroundTransparency = 1
    checkIcon.Image = (ICONS and ICONS.assets and ICONS.assets["lucide-check"]) or "rbxassetid://10709790644"
    checkIcon.ImageColor3 = COLORS.Icon
    checkIcon.ImageTransparency = default and 0 or 1
    checkIcon.Selectable = false
    checkIcon.Parent = box

    local keyBtn, keyLabel, keyStroke
    if hasKeybind then
        keyBtn = Instance.new("TextButton")
        keyBtn.Name = "KeyBind"
        keyBtn.Size = UDim2.new(0, PILL_W, 0, PILL_H)
        keyBtn.Position = UDim2.new(1, -(BOX + 4 + PILL_W), 0.5, -PILL_H / 2)
        keyBtn.AnchorPoint = Vector2.new(0, 0)
        keyBtn.BackgroundColor3 = COLORS.KeyBindBg
        keyBtn.BorderSizePixel = 0
        keyBtn.Text = ""
        keyBtn.AutoButtonColor = false
        keyBtn.Parent = container

        local keyCorner = Instance.new("UICorner")
        keyCorner.CornerRadius = UDim.new(0, 4)
        keyCorner.Parent = keyBtn

        keyStroke = Instance.new("UIStroke")
        keyStroke.Color = COLORS.KeyBindBorder
        keyStroke.Thickness = 1
        keyStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        keyStroke.Parent = keyBtn

        keyLabel = Instance.new("TextLabel")
        keyLabel.Size = UDim2.new(1, 0, 1, 0)
        keyLabel.BackgroundTransparency = 1
        keyLabel.Text = getKeyName(data.keybind)
        keyLabel.TextColor3 = COLORS.KeyBindText
        keyLabel.TextSize = KEY_SIZE
        keyLabel.Font = FONT_BOLD or Enum.Font.SourceSansBold
        keyLabel.TextXAlignment = Enum.TextXAlignment.Center
        keyLabel.TextYAlignment = Enum.TextYAlignment.Center
        keyLabel.Parent = keyBtn
    end

    local function resizeContainer()
        if not hasDescription then return end
        local contentH = textLayout.AbsoluteContentSize.Y
        local totalH = math.max(contentH + 14, BASE_H)
        container.Size = UDim2.new(1, 0, 0, totalH)
    end

    local function updateVisuals(animate)
        local boxColor = data.state and COLORS.Active or COLORS.Inactive
        local strokeColor = data.state and COLORS.Active or COLORS.Line
        local checkT = data.state and 0 or 1
        local textColor = data.state and COLORS.TextActive or COLORS.TextInactive

        if data.disabled then
            boxColor = COLORS.Inactive
            strokeColor = COLORS.Line
            textColor = COLORS.TextDisabled
        end

        if animate then
            local ti = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(box, ti, { BackgroundColor3 = boxColor }):Play()
            TweenService:Create(boxStroke, ti, { Color = strokeColor }):Play()
            TweenService:Create(checkIcon, ti, { ImageTransparency = data.disabled and 1 or checkT, ImageColor3 = COLORS.Icon }):Play()
            TweenService:Create(label, ti, { TextColor3 = textColor }):Play()
        else
            box.BackgroundColor3 = boxColor
            boxStroke.Color = strokeColor
            checkIcon.ImageTransparency = data.disabled and 1 or checkT
            checkIcon.ImageColor3 = COLORS.Icon
            label.TextColor3 = textColor
        end

        clickArea.Active = not data.disabled
    end

    local function fireCallback(value)
        local ok, err = pcall(callback, value)
        if not ok then
            warnNotify(("Checkbox '%s': %s"):format(title, tostring(err)))
        end
    end

    local function fireKeybindCallback(value)
        if keybindCb then
            local ok, err = pcall(keybindCb, value)
            if not ok then
                warnNotify(("Checkbox '%s' (keybind): %s"):format(title, tostring(err)))
            end
        end
    end

    local function toggle()
        if data.disabled then return end
        data.state = not data.state
        updateVisuals(true)
        fireCallback(data.state)
    end

    local listeningConnection
    local function enterListenMode()
        if not hasKeybind or data.disabled or data.listening then return end
        data.listening = true

        TweenService:Create(keyBtn, TweenInfo.new(0.1), { BackgroundColor3 = COLORS.KeyBindListening }):Play()
        TweenService:Create(keyStroke, TweenInfo.new(0.1), { Color = COLORS.KeyBindListenText }):Play()
        keyLabel.Text = "..."
        keyLabel.TextColor3 = COLORS.KeyBindListenText

        listeningConnection = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end

            local newBind = nil

            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.MouseButton2
            or input.UserInputType == Enum.UserInputType.MouseButton3 then
                newBind = input.UserInputType
            elseif input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.Escape then
                    data.keybind = nil
                    data.listening = false
                    listeningConnection:Disconnect()
                    listeningConnection = nil
                    TweenService:Create(keyBtn, TweenInfo.new(0.1), { BackgroundColor3 = COLORS.KeyBindBg }):Play()
                    TweenService:Create(keyStroke, TweenInfo.new(0.1), { Color = COLORS.KeyBindBorder }):Play()
                    keyLabel.Text = "None"
                    keyLabel.TextColor3 = COLORS.KeyBindText
                    Notify({ Title = "CodyWas | KeyBind", Description = ("Bind de '%s' removido."):format(title), Duration = 3 })
                    return
                end
                newBind = input.KeyCode
            end

            if newBind then
                data.keybind = newBind
                data.listening = false
                listeningConnection:Disconnect()
                listeningConnection = nil
                TweenService:Create(keyBtn, TweenInfo.new(0.1), { BackgroundColor3 = COLORS.KeyBindBg }):Play()
                TweenService:Create(keyStroke, TweenInfo.new(0.1), { Color = COLORS.KeyBindBorder }):Play()
                keyLabel.Text = getKeyName(newBind)
                keyLabel.TextColor3 = COLORS.KeyBindText
                Notify({
                    Title = "CodyWas | KeyBind",
                    Description = ("'%s' -> %s"):format(title, getKeyName(newBind)),
                    Duration = 3
                })
            end
        end)
    end

    local keyTriggerConnection
    if hasKeybind then
        keyTriggerConnection = UserInputService.InputBegan:Connect(function(input, gp)
            if gp or data.disabled or data.listening then return end
            if not data.keybind then return end
            if matchInput(data.keybind, input) then
                toggle()
                fireKeybindCallback(data.state)
            end
        end)
    end

    clickArea.MouseButton1Click:Connect(toggle)

    clickArea.MouseEnter:Connect(function()
        if data.disabled then return end
        local ti = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(boxStroke, ti, { Color = COLORS.Active, Thickness = 1.4 }):Play()
        if not data.state then
            TweenService:Create(checkIcon, ti, { ImageTransparency = 0.55, ImageColor3 = COLORS.Active }):Play()
        end
    end)

    clickArea.MouseLeave:Connect(function()
        if data.disabled then return end
        local ti = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(boxStroke, ti, { Color = data.state and COLORS.Active or COLORS.Line, Thickness = 1.2 }):Play()
        if not data.state then
            TweenService:Create(checkIcon, ti, { ImageTransparency = 1, ImageColor3 = COLORS.Icon }):Play()
        end
    end)

    if hasKeybind then
        keyBtn.MouseButton1Click:Connect(enterListenMode)

        keyBtn.MouseEnter:Connect(function()
            if data.disabled or data.listening then return end
            TweenService:Create(keyBtn, TweenInfo.new(0.1), { BackgroundColor3 = COLORS.KeyBindHover }):Play()
        end)

        keyBtn.MouseLeave:Connect(function()
            if data.listening then return end
            TweenService:Create(keyBtn, TweenInfo.new(0.1), { BackgroundColor3 = COLORS.KeyBindBg }):Play()
        end)
    end

    if hasDescription then
        textLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeContainer)
        resizeContainer()
    end

    updateVisuals(false)
    if default then fireCallback(default) end

    function data:Set(value)
        data.state = value
        updateVisuals(true)
        fireCallback(value)
    end

    function data:Get()
        return data.state
    end

    function data:Toggle()
        toggle()
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
            warnNotify(("Checkbox '%s': sem descricao inicial."):format(title))
            return
        end
        descLabel.Text = breakLongWords(newDesc, WORD_MAX)
        resizeContainer()
    end

    function data:SetKeybind(newBind)
        data.keybind = newBind
        if keyLabel then
            keyLabel.Text = getKeyName(newBind)
        end
    end

    function data:GetKeybind()
        return data.keybind
    end

    function data:ClearKeybind()
        data.keybind = nil
        if keyLabel then keyLabel.Text = "None" end
    end

    function data:Destroy()
        if keyTriggerConnection then keyTriggerConnection:Disconnect() end
        if listeningConnection then listeningConnection:Disconnect() end
        container:Destroy()
    end

    return data
end)