-- // CheckBox
Elements.Register("Checkbox", function(section, options)
    options = type(options) == "table" and options or {}

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
    local HITBOX_PAD = 10 -- expande a area de toque do quadrado sem mudar o visual
    local PILL_W = 46
    local PILL_H = 20
    local WORD_MAX = 20
    local BASE_H = 36

    local userInputService = UserInputService or game:GetService("UserInputService")
    local fontBold = FONT_BOLD or Enum.Font.SourceSansBold
    local fontRegular = FONT or Enum.Font.SourceSans

    local connections = {}
    local destroyed = false
    local listeningConnection
    local listenStartedAt = 0

    local function connect(signal, fn)
        local conn = signal:Connect(fn)
        table.insert(connections, conn)
        return conn
    end

    local function warnNotify(msg)
        pcall(function()
            Notify({ Title = "CodyWas | Checkbox", Description = msg, Duration = 5 })
        end)
    end

    local function infoNotify(msg)
        pcall(function()
            Notify({ Title = "CodyWas | KeyBind", Description = msg, Duration = 3 })
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

    local function isValidBinding(binding)
        if typeof(binding) ~= "EnumItem" then return false end
        return binding.EnumType == Enum.KeyCode or binding.EnumType == Enum.UserInputType
    end

    local function matchInput(binding, input)
        if typeof(binding) ~= "EnumItem" then return false end
        if binding.EnumType == Enum.KeyCode then
            return input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == binding
        elseif binding.EnumType == Enum.UserInputType then
            return input.UserInputType == binding
        end
        return false
    end

    local title = tostring(options.title or options.Name or "Checkbox")
    local description = tostring(options.description or "")
    local default = (options.default or options.Default) == true
    local disabled = options.disabled == true
    local callback = options.callback or options.Callback
    local keybind = options.keybind
    local keybindCb = options.keybindCallback

    if type(callback) ~= "function" then
        callback = function() end
    end

    if type(keybindCb) ~= "function" then
        keybindCb = nil
    end

    if keybind ~= nil and not isValidBinding(keybind) then
        keybind = nil
    end

    local hasKeybind = options.keybind ~= nil

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

    -- Area de texto: apenas exibe titulo/descricao, NAO ativa o checkbox
    local textFrame = Instance.new("Frame")
    textFrame.Name = "TextFrame"
    textFrame.Size = UDim2.new(1, -rightReserve, 1, 0)
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
    label.Size = UDim2.new(1, 0, 0, TITLE_SIZE + 3)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = default and COLORS.TextActive or COLORS.TextInactive
    label.TextSize = TITLE_SIZE
    label.Font = fontBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.LayoutOrder = 0
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
        descLabel.Parent = textFrame
    end

    -- Botao real do quadrado. Hitbox maior que o visual (HITBOX_PAD) pra
    -- funcionar bem no toque, mas so ativa se clicar/tocar NELE, nao no resto.
    local boxButton = Instance.new("TextButton")
    boxButton.Name = "BoxButton"
    boxButton.Size = UDim2.new(0, BOX + HITBOX_PAD * 2, 0, BOX + HITBOX_PAD * 2)
    boxButton.Position = UDim2.new(1, 0, 0.5, 0)
    boxButton.AnchorPoint = Vector2.new(1, 0.5)
    boxButton.BackgroundTransparency = 1
    boxButton.Text = ""
    boxButton.AutoButtonColor = false
    boxButton.Selectable = false
    boxButton.ZIndex = 2
    boxButton.Parent = container

    local box = Instance.new("Frame")
    box.Name = "Box"
    box.Size = UDim2.new(0, BOX, 0, BOX)
    box.Position = UDim2.new(0.5, 0, 0.5, 0)
    box.AnchorPoint = Vector2.new(0.5, 0.5)
    box.BackgroundColor3 = default and COLORS.Active or COLORS.Inactive
    box.BorderSizePixel = 0
    box.Parent = boxButton

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = box

    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = default and COLORS.Active or COLORS.Line
    boxStroke.Thickness = 1.2
    boxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    boxStroke.Parent = box

    local checkIcon = Instance.new("ImageLabel")
    checkIcon.Name = "Check"
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
        keyBtn.Position = UDim2.new(1, -(BOX + HITBOX_PAD * 2 + 4 + PILL_W), 0.5, -PILL_H / 2)
        keyBtn.AnchorPoint = Vector2.new(0, 0)
        keyBtn.BackgroundColor3 = COLORS.KeyBindBg
        keyBtn.BorderSizePixel = 0
        keyBtn.Text = ""
        keyBtn.AutoButtonColor = false
        keyBtn.Selectable = false
        keyBtn.ZIndex = 2
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
        keyLabel.Name = "KeyLabel"
        keyLabel.Size = UDim2.new(1, 0, 1, 0)
        keyLabel.BackgroundTransparency = 1
        keyLabel.Text = getKeyName(data.keybind)
        keyLabel.TextColor3 = COLORS.KeyBindText
        keyLabel.TextSize = KEY_SIZE
        keyLabel.Font = fontBold
        keyLabel.TextXAlignment = Enum.TextXAlignment.Center
        keyLabel.TextYAlignment = Enum.TextYAlignment.Center
        keyLabel.TextTruncate = Enum.TextTruncate.AtEnd
        keyLabel.Parent = keyBtn
    end

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

    -- Sem tweens: aplica o estado visual instantaneamente
    local function updateVisuals()
        if destroyed then return end

        local boxColor = data.state and COLORS.Active or COLORS.Inactive
        local strokeColor = data.state and COLORS.Active or COLORS.Line
        local checkT = data.state and 0 or 1
        local textColor = data.state and COLORS.TextActive or COLORS.TextInactive

        if data.disabled then
            boxColor = COLORS.Inactive
            strokeColor = COLORS.Line
            textColor = COLORS.TextDisabled
            checkT = 1
        end

        box.BackgroundColor3 = boxColor
        boxStroke.Color = strokeColor
        boxStroke.Thickness = 1.2
        checkIcon.ImageTransparency = checkT
        checkIcon.ImageColor3 = COLORS.Icon
        label.TextColor3 = textColor

        boxButton.Active = not data.disabled
    end

    local function fireCallback(value)
        local ok, err = pcall(callback, value)
        if not ok then
            warnNotify(("Checkbox '%s': %s"):format(title, tostring(err)))
        end
    end

    local function fireKeybindCallback(value)
        if not keybindCb then return end
        local ok, err = pcall(keybindCb, value)
        if not ok then
            warnNotify(("Checkbox '%s' (keybind): %s"):format(title, tostring(err)))
        end
    end

    local function toggle()
        if destroyed or data.disabled then return end
        data.state = not data.state
        updateVisuals()
        fireCallback(data.state)
    end

    local function resetKeyVisual()
        if not keyBtn then return end
        keyBtn.BackgroundColor3 = COLORS.KeyBindBg
        keyStroke.Color = COLORS.KeyBindBorder
        keyLabel.Text = getKeyName(data.keybind)
        keyLabel.TextColor3 = COLORS.KeyBindText
    end

    local function stopListening()
        if listeningConnection then
            listeningConnection:Disconnect()
            listeningConnection = nil
        end
        data.listening = false
        resetKeyVisual()
    end

    local function enterListenMode()
        if destroyed or not hasKeybind or data.disabled or data.listening then return end
        data.listening = true
        listenStartedAt = os.clock()

        keyBtn.BackgroundColor3 = COLORS.KeyBindListening
        keyStroke.Color = COLORS.KeyBindListenText
        keyLabel.Text = "..."
        keyLabel.TextColor3 = COLORS.KeyBindListenText

        listeningConnection = userInputService.InputBegan:Connect(function(input)
            if destroyed or not data.listening then return end
            if os.clock() - listenStartedAt < 0.15 then return end

            local newBind

            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.MouseButton2
            or input.UserInputType == Enum.UserInputType.MouseButton3 then
                newBind = input.UserInputType
            elseif input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.Escape then
                    data.keybind = nil
                    stopListening()
                    infoNotify(("Bind de '%s' removido."):format(title))
                    return
                end
                newBind = input.KeyCode
            end

            if newBind then
                data.keybind = newBind
                stopListening()
                infoNotify(("'%s' -> %s"):format(title, getKeyName(newBind)))
            end
        end)
    end

    -- Toggle via keybind global (funciona igual antes)
    if hasKeybind then
        connect(userInputService.InputBegan, function(input, gp)
            if destroyed or gp or data.disabled or data.listening then return end
            if not data.keybind then return end
            if matchInput(data.keybind, input) then
                toggle()
                fireKeybindCallback(data.state)
            end
        end)
    end

    -- Ativa o checkbox APENAS pelo quadrado (boxButton), com hitbox
    -- ampliada para toque. Funciona com mouse (PC) e touch (mobile) porque
    -- MouseButton1Click do TextButton dispara em ambos automaticamente.
    connect(boxButton.MouseButton1Click, toggle)

    -- Suporte extra explicito a touch (alguns executores/clientes mobile
    -- nao repassam MouseButton1Click corretamente para TextButton)
    connect(boxButton.TouchTap, function()
        toggle()
    end)

    if hasKeybind then
        connect(keyBtn.MouseButton1Click, enterListenMode)
        connect(keyBtn.TouchTap, enterListenMode)
    end

    connect(textLayout:GetPropertyChangedSignal("AbsoluteContentSize"), resizeContainer)

    if description ~= "" then
        createDescription(description)
    end

    resizeContainer()
    updateVisuals()
    if default then fireCallback(default) end

    function data:Set(value)
        if destroyed then return end
        value = value == true
        if data.state == value then return end
        data.state = value
        updateVisuals()
        fireCallback(value)
    end

    function data:Get()
        return data.state
    end

    function data:Toggle()
        toggle()
    end

    function data:SetDisabled(value)
        if destroyed then return end
        data.disabled = value == true
        if data.disabled and data.listening then
            stopListening()
        end
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

    function data:SetKeybind(newBind)
        if destroyed then return end
        if newBind ~= nil and not isValidBinding(newBind) then
            warnNotify(("Checkbox '%s': keybind invalido."):format(title))
            return
        end
        data.keybind = newBind
        if data.listening then
            stopListening()
        elseif keyLabel then
            keyLabel.Text = getKeyName(newBind)
        end
    end

    function data:GetKeybind()
        return data.keybind
    end

    function data:ClearKeybind()
        if destroyed then return end
        data.keybind = nil
        if data.listening then
            stopListening()
        elseif keyLabel then
            keyLabel.Text = "None"
        end
    end

    function data:Destroy()
        if destroyed then return end
        destroyed = true
        if listeningConnection then
            listeningConnection:Disconnect()
            listeningConnection = nil
        end
        for _, conn in ipairs(connections) do
            conn:Disconnect()
        end
        table.clear(connections)
        container:Destroy()
    end

    return data
end)