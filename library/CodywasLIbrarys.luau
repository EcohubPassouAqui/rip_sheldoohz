-- // Serviços
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- // Fontes
local FONT = Enum.Font.BuilderSans
local FONT_BOLD = Enum.Font.BuilderSansBold

-- // Tema
local Theme = {
    Panel = Color3.fromRGB(20, 20, 20),
    HoverFill = Color3.fromRGB(255, 255, 255),
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(105, 105, 115),
    TextHeader = Color3.fromRGB(130, 130, 140),
    TitleText = Color3.fromRGB(255, 255, 255),
    Line = Color3.fromRGB(32, 32, 32),
    Accent = Color3.fromRGB(255, 255, 255)
}

-- // Medidas
local Metrics = {
    MinWidth = 320,
    MinHeight = 240,
    ScreenMargin = 24,
    TopBarHeight = 55,
    ColumnGap = 8,
    PagePadding = 12,
    TabWidthPC = 150,
    TabWidthMobile = 110,
    NarrowBreakpoint = 460
}

-- // Ícones
local ICONS = { assets = {} }
pcall(function()
    local result = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/assets/fonts/Icons.luau"))()
    if type(result) == "table" then ICONS = result end
end)

-- // Notificações
local CodywasNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/library/notifications/CodywasNotif.luau"))()
local Notify = CodywasNotif.Notify

-- // Detectar Mobile
local function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

-- // Obter Ícone
local function icon(name, fallback)
    return ICONS.assets and ICONS.assets["lucide-" .. name] or fallback or "rbxassetid://11419472304"
end

-- // Obter Viewport
local function getViewport()
    local camera = workspace.CurrentCamera
    if camera then
        return camera.ViewportSize
    end
    return Vector2.new(1280, 720)
end

-- // Shield
local Shield = {}

-- // Shield Nome Aleatório
function Shield:RandomName()
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-"
    local name = ""
    for _ = 1, math.random(8, 14) do
        local i = math.random(1, #chars)
        name = name .. chars:sub(i, i)
    end
    return name
end

-- // Shield Container
function Shield:GetContainer()
    if gethui then return gethui() end
    return Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- // Shield Colocar Gui
function Shield:PlaceGui(gui)
    if not gui then return end
    pcall(function()
        if syn and syn.protect_gui then
            syn.protect_gui(gui)
            gui.Parent = game:GetService("CoreGui")
        elseif gethui then
            gui.Parent = gethui()
        else
            gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        end
    end)
end

-- // Shield Esconder Objeto
function Shield:HideObject(obj)
    if not obj then return end
    pcall(function()
        if sethiddenproperty then
            sethiddenproperty(obj, "Archivable", false)
        end
        if makereadonly then
            makereadonly(obj)
        elseif setreadonly then
            setreadonly(obj, true)
        end
    end)
end

-- // Shield Hook Detecções
function Shield:HookDetections()
    if setthreadidentity then
        pcall(function() setthreadidentity(8) end)
    end

    if setstackhidden and Shield.HookDetections then
        pcall(function() setstackhidden(Shield.HookDetections, true) end)
    end

    if getgc then
        pcall(function()
            local gc = getgc(true)
            for i = #gc, 1, -1 do
                if gc[i] == getfenv() then table.remove(gc, i) end
            end
        end)
    end

    local detections = {
        "getscripts", "getloadedmodules", "getrunningscripts",
        "getnilinstances", "filtergc", "getinstances"
    }
    for _, func_name in ipairs(detections) do
        pcall(function()
            local fn = getfenv()[func_name] or _G[func_name]
            if not fn then return end
            if iscclosure and iscclosure(fn) then
                if oth and oth.hook then
                    oth.hook(fn, function() return {} end)
                end
            elseif hookfunction then
                hookfunction(fn, function() return {} end)
            end
        end)
    end

    if hookfunction and debug and debug.getinfo then
        pcall(function()
            local _orig = hookfunction(debug.getinfo, newcclosure(function(level, ...)
                if isourthread and type(level) == "thread" and isourthread(level) then
                    return nil
                end
                return _orig(level, ...)
            end))
        end)
    end

    if debug and debug.getcallstack and hookfunction then
        pcall(function()
            local _orig = hookfunction(debug.getcallstack, newcclosure(function(...)
                local stack = _orig(...)
                if type(stack) == "table" then
                    local clean = {}
                    for _, entry in ipairs(stack) do
                        if entry.what ~= "executor" then
                            table.insert(clean, entry)
                        end
                    end
                    return clean
                end
                return stack
            end))
        end)
    end
end

-- // Shield Iniciar
function Shield:Init()
    local ok, err = pcall(function() Shield:HookDetections() end)
    if not ok then
        Notify({ Title = "CodyWas | Erro", Description = tostring(err), Duration = 6 })
    end
end

-- // Elements
local Elements = {}
Elements.List = {}
Elements._searchRegistry = {}

-- // Elements Registrar
function Elements.Register(name, constructor)
    Elements.List[name] = constructor
end

-- // Elements Registrar Pesquisa
function Elements.RegisterSearchEntry(labelText, frame)
    table.insert(Elements._searchRegistry, { label = labelText:lower(), frame = frame })
end

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
    local PILL_W = 46
    local PILL_H = 20
    local WORD_MAX = 20
    local BASE_H = 36

    local tweenService = TweenService or game:GetService("TweenService")
    local userInputService = UserInputService or game:GetService("UserInputService")
    local fontBold = FONT_BOLD or Enum.Font.SourceSansBold
    local fontRegular = FONT or Enum.Font.SourceSans

    local TI_FAST = TweenInfo.new(0.1)
    local TI_STD = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    local connections = {}
    local destroyed = false
    local hovering = false
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

    local clickArea = Instance.new("TextButton")
    clickArea.Name = "ClickArea"
    clickArea.Size = UDim2.new(1, -rightReserve, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.AutoButtonColor = false
    clickArea.Selectable = false
    clickArea.Parent = container

    local textFrame = Instance.new("Frame")
    textFrame.Name = "TextFrame"
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
        keyBtn.Position = UDim2.new(1, -(BOX + 4 + PILL_W), 0.5, -PILL_H / 2)
        keyBtn.AnchorPoint = Vector2.new(0, 0)
        keyBtn.BackgroundColor3 = COLORS.KeyBindBg
        keyBtn.BorderSizePixel = 0
        keyBtn.Text = ""
        keyBtn.AutoButtonColor = false
        keyBtn.Selectable = false
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

    local function updateVisuals(animate)
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

        if animate then
            tweenService:Create(box, TI_STD, { BackgroundColor3 = boxColor }):Play()
            tweenService:Create(boxStroke, TI_STD, { Color = strokeColor, Thickness = 1.2 }):Play()
            tweenService:Create(checkIcon, TI_STD, { ImageTransparency = checkT, ImageColor3 = COLORS.Icon }):Play()
            tweenService:Create(label, TI_STD, { TextColor3 = textColor }):Play()
        else
            box.BackgroundColor3 = boxColor
            boxStroke.Color = strokeColor
            boxStroke.Thickness = 1.2
            checkIcon.ImageTransparency = checkT
            checkIcon.ImageColor3 = COLORS.Icon
            label.TextColor3 = textColor
        end

        clickArea.Active = not data.disabled
    end

    local function applyHover(state)
        if destroyed or data.disabled then return end
        if state then
            tweenService:Create(boxStroke, TI_STD, { Color = COLORS.Active, Thickness = 1.4 }):Play()
            if not data.state then
                tweenService:Create(checkIcon, TI_STD, { ImageTransparency = 0.55, ImageColor3 = COLORS.Active }):Play()
            end
        else
            tweenService:Create(boxStroke, TI_STD, { Color = data.state and COLORS.Active or COLORS.Line, Thickness = 1.2 }):Play()
            if not data.state then
                tweenService:Create(checkIcon, TI_STD, { ImageTransparency = 1, ImageColor3 = COLORS.Icon }):Play()
            end
        end
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
        updateVisuals(true)
        if hovering then applyHover(true) end
        fireCallback(data.state)
    end

    local function resetKeyVisual()
        if not keyBtn then return end
        tweenService:Create(keyBtn, TI_FAST, { BackgroundColor3 = COLORS.KeyBindBg }):Play()
        tweenService:Create(keyStroke, TI_FAST, { Color = COLORS.KeyBindBorder }):Play()
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

        tweenService:Create(keyBtn, TI_FAST, { BackgroundColor3 = COLORS.KeyBindListening }):Play()
        tweenService:Create(keyStroke, TI_FAST, { Color = COLORS.KeyBindListenText }):Play()
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

    connect(clickArea.MouseButton1Click, toggle)

    connect(clickArea.MouseEnter, function()
        hovering = true
        applyHover(true)
    end)

    connect(clickArea.MouseLeave, function()
        hovering = false
        applyHover(false)
    end)

    if hasKeybind then
        connect(keyBtn.MouseButton1Click, enterListenMode)

        connect(keyBtn.MouseEnter, function()
            if data.disabled or data.listening then return end
            tweenService:Create(keyBtn, TI_FAST, { BackgroundColor3 = COLORS.KeyBindHover }):Play()
        end)

        connect(keyBtn.MouseLeave, function()
            if data.listening then return end
            tweenService:Create(keyBtn, TI_FAST, { BackgroundColor3 = COLORS.KeyBindBg }):Play()
        end)
    end

    connect(textLayout:GetPropertyChangedSignal("AbsoluteContentSize"), resizeContainer)

    if description ~= "" then
        createDescription(description)
    end

    resizeContainer()
    updateVisuals(false)
    if default then fireCallback(default) end

    function data:Set(value)
        if destroyed then return end
        value = value == true
        if data.state == value then return end
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
        if destroyed then return end
        data.disabled = value == true
        if data.disabled and data.listening then
            stopListening()
        end
        updateVisuals(true)
        if hovering then applyHover(true) end
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

-- // Library
local Library = {}
Library.__index = Library

-- // Criar Janela
function Library:CreateWindow(config)
    config = type(config) == "table" and config or {}

    local self = setmetatable({}, Library)
    self.Title = config.Title or "UILib"
    self.SubTitle = config.SubTitle or config.Subtitle or ""
    local size = config.Size or UDim2.fromOffset(580, 460)
    self.BaseWidth = size.X.Offset
    self.BaseHeight = size.Y.Offset
    self.MinimizeKey = config.MinimizeKey or Enum.KeyCode.LeftControl
    self.IsMobile = IsMobile()
    self.tabs = {}
    self.sections = {}
    self.sectionCount = 0
    self.selectedTab = nil
    self.dragging = false
    self.connections = {}
    self.minimized = false

    local ok, err = pcall(function()
        Shield:Init()
        self:_init()
    end)

    if not ok then
        Notify({ Title = "Erro | Window", Description = tostring(err), Duration = 6 })
    end

    return self
end

-- // Compatibilidade Library.new
function Library.new(title, subtitle)
    return Library:CreateWindow({ Title = title, SubTitle = subtitle })
end

-- // Calcular Tamanho
function Library:_computeSize()
    local viewport = getViewport()
    local maxWidth = math.max(Metrics.MinWidth, viewport.X - Metrics.ScreenMargin * 2)
    local maxHeight = math.max(Metrics.MinHeight, viewport.Y - Metrics.ScreenMargin * 2)
    local width = math.clamp(self.BaseWidth, Metrics.MinWidth, maxWidth)
    local height = math.clamp(self.BaseHeight, Metrics.MinHeight, maxHeight)
    return width, height
end

-- // Aplicar Tamanho
function Library:_applySize()
    if not self.mainPanel then return end
    local width, height = self:_computeSize()
    self.currentWidth = width
    self.mainPanel.Size = UDim2.new(0, width, 0, height)
    self:_applyLayoutMode()
end

-- // Modo Layout
function Library:_applyLayoutMode()
    local tabWidth = self.IsMobile and Metrics.TabWidthMobile or Metrics.TabWidthPC
    if self.currentWidth and self.currentWidth < Metrics.NarrowBreakpoint then
        tabWidth = Metrics.TabWidthMobile
    end
    self.tabWidth = tabWidth

    if self.tabBar then
        self.tabBar.Size = UDim2.new(0, tabWidth, 1, 0)
    end
    if self.tabDivider then
        self.tabDivider.Position = UDim2.new(0, tabWidth - 1, 0, 0)
    end
    if self.tabContent then
        self.tabContent.Size = UDim2.new(1, -tabWidth, 1, 0)
        self.tabContent.Position = UDim2.new(0, tabWidth, 0, 0)
    end

    for _, tab in ipairs(self.tabs) do
        if tab.relayout then
            tab.relayout()
        end
    end
end

-- // Iniciar Janela
function Library:_init()
    local player = Players.LocalPlayer
    if not player then return end

    local container = Shield:GetContainer()

    for _, child in ipairs(container:GetChildren()) do
        if child.Name == "codywas" or child.Name == "codywas_toggle" then
            child:Destroy()
        end
    end

    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = "codywas"
    self.screenGui.ResetOnSpawn = false
    self.screenGui.DisplayOrder = 999
    Shield:PlaceGui(self.screenGui)
    Shield:HideObject(self.screenGui)

    local width, height = self:_computeSize()
    self.currentWidth = width

    self.mainPanel = Instance.new("Frame")
    self.mainPanel.Name = Shield:RandomName()
    self.mainPanel.AnchorPoint = Vector2.new(0.5, 0.5)
    self.mainPanel.Size = UDim2.new(0, width, 0, height)
    self.mainPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.mainPanel.BackgroundColor3 = Theme.Panel
    self.mainPanel.BorderSizePixel = 0
    self.mainPanel.ClipsDescendants = true
    self.mainPanel.Parent = self.screenGui
    Shield:HideObject(self.mainPanel)

    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 8)
    panelCorner.Parent = self.mainPanel

    local panelStroke = Instance.new("UIStroke")
    panelStroke.Color = Theme.Line
    panelStroke.Thickness = 1
    panelStroke.Parent = self.mainPanel

    self:_createTopBar()
    self:_createContent()
    self:_setupDrag()
    self:_applyLayoutMode()

    local camera = workspace.CurrentCamera
    if camera then
        table.insert(self.connections, camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            self:_applySize()
        end))
    end

    if self.IsMobile then
        self:_createToggleButton()
    else
        self:_setupKeybind()
    end
end

-- // Minimizar Janela
function Library:SetMinimized(state)
    self.minimized = state
    if self.mainPanel then
        self.mainPanel.Visible = not state
    end
end

-- // Alternar Janela
function Library:Toggle()
    self:SetMinimized(not self.minimized)
end

-- // Tecla Minimizar PC
function Library:_setupKeybind()
    table.insert(self.connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == self.MinimizeKey then
            self:Toggle()
        end
    end))
end

-- // Barra Título
function Library:_createTopBar()
    self.topBar = Instance.new("Frame")
    self.topBar.Name = Shield:RandomName()
    self.topBar.Size = UDim2.new(1, 0, 0, Metrics.TopBarHeight)
    self.topBar.BackgroundTransparency = 1
    self.topBar.BorderSizePixel = 0
    self.topBar.ZIndex = 5
    self.topBar.Parent = self.mainPanel

    local topBarLine = Instance.new("Frame")
    topBarLine.Size = UDim2.new(1, 0, 0, 1)
    topBarLine.Position = UDim2.new(0, 0, 1, -1)
    topBarLine.BackgroundColor3 = Theme.Line
    topBarLine.BorderSizePixel = 0
    topBarLine.Parent = self.topBar

    local searchWidth = self.IsMobile and 110 or 160
    local searchContainer = Instance.new("Frame")
    searchContainer.Size = UDim2.new(0, searchWidth, 0, 28)
    searchContainer.Position = UDim2.new(1, -18, 0.5, 0)
    searchContainer.AnchorPoint = Vector2.new(1, 0.5)
    searchContainer.BackgroundColor3 = Theme.HoverFill
    searchContainer.BackgroundTransparency = 0.96
    searchContainer.BorderSizePixel = 0
    searchContainer.ClipsDescendants = true
    searchContainer.Parent = self.topBar

    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 4)
    searchCorner.Parent = searchContainer

    local searchIcon = Instance.new("ImageLabel")
    searchIcon.Size = UDim2.new(0, 14, 0, 14)
    searchIcon.Position = UDim2.new(0, 8, 0.5, -7)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Image = icon("search")
    searchIcon.ImageColor3 = Theme.TextSecondary
    searchIcon.Parent = searchContainer

    self.searchBox = Instance.new("TextBox")
    self.searchBox.Size = UDim2.new(1, -32, 1, 0)
    self.searchBox.Position = UDim2.new(0, 28, 0.5, 0)
    self.searchBox.AnchorPoint = Vector2.new(0, 0.5)
    self.searchBox.BackgroundTransparency = 1
    self.searchBox.Text = ""
    self.searchBox.PlaceholderText = "Pesquisar..."
    self.searchBox.PlaceholderColor3 = Theme.TextSecondary
    self.searchBox.TextColor3 = Theme.TextPrimary
    self.searchBox.Font = FONT
    self.searchBox.TextSize = 13
    self.searchBox.TextXAlignment = Enum.TextXAlignment.Left
    self.searchBox.ClearTextOnFocus = false
    self.searchBox.ClipsDescendants = true
    self.searchBox.Parent = searchContainer

    local textContainer = Instance.new("Frame")
    textContainer.Size = UDim2.new(1, -(searchWidth + 18 + 24), 1, 0)
    textContainer.Position = UDim2.new(0, 18, 0, 0)
    textContainer.BackgroundTransparency = 1
    textContainer.BorderSizePixel = 0
    textContainer.Parent = self.topBar

    self.titleLabel = Instance.new("TextLabel")
    self.titleLabel.Size = UDim2.new(1, 0, 0, 22)
    self.titleLabel.Position = UDim2.new(0, 0, 0, 10)
    self.titleLabel.BackgroundTransparency = 1
    self.titleLabel.TextColor3 = Theme.TitleText
    self.titleLabel.TextSize = 18
    self.titleLabel.Font = FONT_BOLD
    self.titleLabel.Text = self.Title
    self.titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    self.titleLabel.Parent = textContainer

    self.subtitleLabel = Instance.new("TextLabel")
    self.subtitleLabel.Size = UDim2.new(1, 0, 0, 14)
    self.subtitleLabel.Position = UDim2.new(0, 0, 0, 29)
    self.subtitleLabel.BackgroundTransparency = 1
    self.subtitleLabel.TextColor3 = Theme.TextSecondary
    self.subtitleLabel.TextSize = 11
    self.subtitleLabel.Font = FONT
    self.subtitleLabel.Text = self.SubTitle
    self.subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.subtitleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    self.subtitleLabel.Parent = textContainer

    table.insert(self.connections, self.searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        self:_filterElements(self.searchBox.Text)
    end))
end

-- // Filtro Pesquisa
function Library:_filterElements(query)
    query = query:lower():gsub("^%s+", ""):gsub("%s+$", "")

    if query == "" then
        for _, entry in ipairs(Elements._searchRegistry) do
            if entry.frame then
                entry.frame.Visible = true
            end
        end
        if self.selectedTab then
            for _, tab in ipairs(self.tabs) do
                tab.page.Visible = (tab == self.selectedTab)
            end
        end
        return
    end

    for _, tab in ipairs(self.tabs) do
        tab.page.Visible = true
    end

    for _, entry in ipairs(Elements._searchRegistry) do
        if entry.frame then
            entry.frame.Visible = string.find(entry.label, query, 1, true) ~= nil
        end
    end
end

-- // Conteúdo Janela
function Library:_createContent()
    local tabWidth = self.IsMobile and Metrics.TabWidthMobile or Metrics.TabWidthPC

    self.contentFrame = Instance.new("Frame")
    self.contentFrame.Size = UDim2.new(1, 0, 1, -Metrics.TopBarHeight)
    self.contentFrame.Position = UDim2.new(0, 0, 0, Metrics.TopBarHeight)
    self.contentFrame.BackgroundTransparency = 1
    self.contentFrame.BorderSizePixel = 0
    self.contentFrame.ZIndex = 1
    self.contentFrame.ClipsDescendants = true
    self.contentFrame.Parent = self.mainPanel

    self.tabBar = Instance.new("ScrollingFrame")
    self.tabBar.Size = UDim2.new(0, tabWidth, 1, 0)
    self.tabBar.BackgroundTransparency = 1
    self.tabBar.BorderSizePixel = 0
    self.tabBar.ScrollBarThickness = 0
    self.tabBar.ClipsDescendants = true
    self.tabBar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.tabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.tabBar.Parent = self.contentFrame

    self.tabDivider = Instance.new("Frame")
    self.tabDivider.Size = UDim2.new(0, 1, 1, 0)
    self.tabDivider.Position = UDim2.new(0, tabWidth - 1, 0, 0)
    self.tabDivider.BackgroundColor3 = Theme.Line
    self.tabDivider.BorderSizePixel = 0
    self.tabDivider.ZIndex = 2
    self.tabDivider.Parent = self.contentFrame

    local tabList = Instance.new("UIListLayout")
    tabList.Padding = UDim.new(0, 2)
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Parent = self.tabBar

    local tabListPadding = Instance.new("UIPadding")
    tabListPadding.PaddingTop = UDim.new(0, 8)
    tabListPadding.PaddingBottom = UDim.new(0, 8)
    tabListPadding.PaddingLeft = UDim.new(0, 6)
    tabListPadding.PaddingRight = UDim.new(0, 6)
    tabListPadding.Parent = self.tabBar

    self.tabContent = Instance.new("Frame")
    self.tabContent.Size = UDim2.new(1, -tabWidth, 1, 0)
    self.tabContent.Position = UDim2.new(0, tabWidth, 0, 0)
    self.tabContent.BackgroundTransparency = 1
    self.tabContent.BorderSizePixel = 0
    self.tabContent.ClipsDescendants = true
    self.tabContent.Parent = self.contentFrame
end

-- // Círculo Mobile
function Library:_createToggleButton()
    local toggleGui = Instance.new("ScreenGui")
    toggleGui.Name = "codywas_toggle"
    toggleGui.ResetOnSpawn = false
    toggleGui.DisplayOrder = 1000
    Shield:PlaceGui(toggleGui)
    Shield:HideObject(toggleGui)
    self.toggleGui = toggleGui

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 46, 0, 46)
    toggleButton.Position = UDim2.new(0, 20, 0.5, -23)
    toggleButton.BackgroundColor3 = Theme.Panel
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = ""
    toggleButton.ClipsDescendants = true
    toggleButton.Parent = toggleGui

    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Line
    stroke.Thickness = 1.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = toggleButton

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = toggleButton

    local toggleTexture = Instance.new("ImageLabel")
    toggleTexture.Size = UDim2.new(1, 0, 1, 0)
    toggleTexture.Position = UDim2.new(0.5, 0, 0.5, 0)
    toggleTexture.AnchorPoint = Vector2.new(0.5, 0.5)
    toggleTexture.BackgroundTransparency = 1
    toggleTexture.Image = "rbxassetid://88779617285504"
    toggleTexture.ScaleType = Enum.ScaleType.Crop
    toggleTexture.ImageTransparency = 0.90
    toggleTexture.ZIndex = 1
    toggleTexture.Parent = toggleButton

    local textureCorner = Instance.new("UICorner")
    textureCorner.CornerRadius = UDim.new(1, 0)
    textureCorner.Parent = toggleTexture

    local toggleIcon = Instance.new("ImageLabel")
    toggleIcon.Size = UDim2.new(0, 20, 0, 20)
    toggleIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    toggleIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    toggleIcon.BackgroundTransparency = 1
    toggleIcon.Image = icon("panel-left")
    toggleIcon.ImageColor3 = Theme.TextPrimary
    toggleIcon.ZIndex = 2
    toggleIcon.Parent = toggleButton

    local draggingButton = false
    local isActualDrag = false
    local dragStart = Vector3.new(0, 0, 0)
    local startPos = UDim2.new(0, 0, 0, 0)
    local DRAG_THRESHOLD = 7

    table.insert(self.connections, toggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingButton = true
            isActualDrag = false
            dragStart = input.Position
            startPos = toggleButton.Position
        end
    end))

    table.insert(self.connections, UserInputService.InputChanged:Connect(function(input)
        if draggingButton and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            if delta.Magnitude > DRAG_THRESHOLD then isActualDrag = true end
            if isActualDrag then
                toggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end))

    table.insert(self.connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if draggingButton and not isActualDrag then
                self:Toggle()
            end
            draggingButton = false
            isActualDrag = false
        end
    end))
end

-- // Arrastar Janela
function Library:_setupDrag()
    local dragInput
    local dragStart
    local startPos

    table.insert(self.connections, self.topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.dragging = true
            dragStart = input.Position
            startPos = self.mainPanel.Position
            dragInput = input
        end
    end))

    table.insert(self.connections, UserInputService.InputEnded:Connect(function(input)
        if input == dragInput then
            self.dragging = false
            dragInput = nil
        end
    end))

    table.insert(self.connections, UserInputService.InputChanged:Connect(function(input)
        if not self.dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            self.mainPanel.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end))
end

-- // Criar Tab
function Library:CreateTab(options)
    local sectionName = type(options) == "table" and options.section or nil
    local tabName = type(options) == "table" and options.tab or options
    local iconName = type(options) == "table" and options.icon or nil

    if sectionName and not self.sections[sectionName] then
        self.sectionCount = self.sectionCount + 1

        local headerContainer = Instance.new("Frame")
        headerContainer.Size = UDim2.new(1, -12, 0, 26)
        headerContainer.BackgroundTransparency = 1
        headerContainer.LayoutOrder = self.sectionCount * 1000
        headerContainer.Parent = self.tabBar

        local header = Instance.new("TextLabel")
        header.Size = UDim2.new(1, 0, 1, 0)
        header.Position = UDim2.new(0, 8, 0, 4)
        header.BackgroundTransparency = 1
        header.Text = sectionName
        header.Font = FONT
        header.TextSize = 12
        header.TextColor3 = Theme.TextHeader
        header.TextXAlignment = Enum.TextXAlignment.Left
        header.TextYAlignment = Enum.TextYAlignment.Center
        header.TextTruncate = Enum.TextTruncate.AtEnd
        header.Parent = headerContainer

        self.sections[sectionName] = headerContainer
    end

    local window = self
    local tabData = {}
    tabData.name = tabName
    tabData.section = sectionName
    tabData.selected = false
    tabData.window = window

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -12, 0, 30)
    button.BackgroundTransparency = 1
    button.AutoButtonColor = false
    button.Text = ""
    button.BorderSizePixel = 0
    button.LayoutOrder = (self.sectionCount * 1000) + #self.tabs + 1
    button.Parent = self.tabBar

    local highlight = Instance.new("Frame")
    highlight.Size = UDim2.new(1, 0, 1, 0)
    highlight.BackgroundColor3 = Theme.HoverFill
    highlight.BackgroundTransparency = 1
    highlight.BorderSizePixel = 0
    highlight.Parent = button

    local highlightCorner = Instance.new("UICorner")
    highlightCorner.CornerRadius = UDim.new(0, 4)
    highlightCorner.Parent = highlight

    local indicatorBar = Instance.new("Frame")
    indicatorBar.Size = UDim2.new(0, 2, 0, 0)
    indicatorBar.Position = UDim2.new(0, 2, 0.5, 0)
    indicatorBar.BackgroundColor3 = Theme.Accent
    indicatorBar.BorderSizePixel = 0
    indicatorBar.BackgroundTransparency = 1
    indicatorBar.Parent = button

    local iconLabel
    if iconName and ICONS.assets then
        local foundIcon = ICONS.assets["lucide-" .. iconName]
        if foundIcon then
            iconLabel = Instance.new("ImageLabel")
            iconLabel.Size = UDim2.new(0, 14, 0, 14)
            iconLabel.Position = UDim2.new(0, 14, 0.5, -7)
            iconLabel.BackgroundTransparency = 1
            iconLabel.Image = foundIcon
            iconLabel.ImageColor3 = Theme.TextSecondary
            iconLabel.Parent = button
        end
    end

    local textOffset = iconLabel and 34 or 14
    local tabLabel = Instance.new("TextLabel")
    tabLabel.Size = UDim2.new(1, -textOffset, 1, 0)
    tabLabel.Position = UDim2.new(0, textOffset, 0, 0)
    tabLabel.BackgroundTransparency = 1
    tabLabel.Text = tabName
    tabLabel.Font = FONT
    tabLabel.TextSize = 13
    tabLabel.TextColor3 = Theme.TextSecondary
    tabLabel.TextXAlignment = Enum.TextXAlignment.Left
    tabLabel.TextTruncate = Enum.TextTruncate.AtEnd
    tabLabel.Parent = button

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 2
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ClipsDescendants = true
    page.Visible = false
    page.Parent = self.tabContent

    local pagePadding = Instance.new("UIPadding")
    pagePadding.PaddingTop = UDim.new(0, Metrics.PagePadding)
    pagePadding.PaddingLeft = UDim.new(0, Metrics.PagePadding)
    pagePadding.PaddingRight = UDim.new(0, Metrics.PagePadding + 4)
    pagePadding.PaddingBottom = UDim.new(0, Metrics.PagePadding)
    pagePadding.Parent = page

    local columns = Instance.new("Frame")
    columns.Size = UDim2.new(1, 0, 0, 0)
    columns.BackgroundTransparency = 1
    columns.BorderSizePixel = 0
    columns.Parent = page

    local leftColumn = Instance.new("Frame")
    leftColumn.Name = "Left"
    leftColumn.BackgroundTransparency = 1
    leftColumn.BorderSizePixel = 0
    leftColumn.AutomaticSize = Enum.AutomaticSize.Y
    leftColumn.Parent = columns

    local leftLayout = Instance.new("UIListLayout")
    leftLayout.Padding = UDim.new(0, Metrics.ColumnGap)
    leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
    leftLayout.Parent = leftColumn

    local rightColumn = Instance.new("Frame")
    rightColumn.Name = "Right"
    rightColumn.BackgroundTransparency = 1
    rightColumn.BorderSizePixel = 0
    rightColumn.AutomaticSize = Enum.AutomaticSize.Y
    rightColumn.Parent = columns

    local rightLayout = Instance.new("UIListLayout")
    rightLayout.Padding = UDim.new(0, Metrics.ColumnGap)
    rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
    rightLayout.Parent = rightColumn

    -- // Reorganizar Colunas
    local function relayout()
        local totalWidth = columns.AbsoluteSize.X
        if totalWidth <= 0 then
            totalWidth = math.max(0, (window.currentWidth or Metrics.MinWidth) - (window.tabWidth or Metrics.TabWidthPC) - Metrics.PagePadding * 2 - 4)
        end

        local stacked = window.IsMobile or totalWidth < 300
        tabData.stacked = stacked

        local leftH = leftLayout.AbsoluteContentSize.Y
        local rightH = rightLayout.AbsoluteContentSize.Y

        if stacked then
            leftColumn.Size = UDim2.new(1, 0, 0, leftH)
            leftColumn.Position = UDim2.new(0, 0, 0, 0)
            local offset = leftH + ((leftH > 0 and rightH > 0) and Metrics.ColumnGap or 0)
            rightColumn.Size = UDim2.new(1, 0, 0, rightH)
            rightColumn.Position = UDim2.new(0, 0, 0, offset)
            columns.Size = UDim2.new(1, 0, 0, offset + rightH)
        else
            local colWidth = math.floor((totalWidth - Metrics.ColumnGap) / 2)
            leftColumn.Size = UDim2.new(0, colWidth, 0, leftH)
            leftColumn.Position = UDim2.new(0, 0, 0, 0)
            rightColumn.Size = UDim2.new(0, colWidth, 0, rightH)
            rightColumn.Position = UDim2.new(0, colWidth + Metrics.ColumnGap, 0, 0)
            columns.Size = UDim2.new(1, 0, 0, math.max(leftH, rightH))
        end
    end

    table.insert(self.connections, columns:GetPropertyChangedSignal("AbsoluteSize"):Connect(relayout))
    table.insert(self.connections, leftLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(relayout))
    table.insert(self.connections, rightLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(relayout))

    tabData.relayout = relayout
    tabData.button = button
    tabData.page = page
    tabData.leftColumn = leftColumn
    tabData.rightColumn = rightColumn

    relayout()

    -- // Visual Tab
    local function updateTabVisuals(isSelected)
        tabData.selected = isSelected
        local searchActive = window.searchBox and window.searchBox.Text ~= ""
        if not searchActive then
            page.Visible = isSelected
        end
        tabLabel.TextColor3 = isSelected and Theme.TextPrimary or Theme.TextSecondary
        tabLabel.Font = isSelected and FONT_BOLD or FONT
        if iconLabel then
            iconLabel.ImageColor3 = isSelected and Theme.TextPrimary or Theme.TextSecondary
        end
        TweenService:Create(highlight, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = isSelected and 0.94 or 1
        }):Play()
        TweenService:Create(indicatorBar, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = isSelected and UDim2.new(0, 2, 0, 14) or UDim2.new(0, 2, 0, 0),
            Position = isSelected and UDim2.new(0, 2, 0.5, -7) or UDim2.new(0, 2, 0.5, 0),
            BackgroundTransparency = isSelected and 0 or 1
        }):Play()
        if isSelected then
            task.defer(relayout)
        end
    end

    table.insert(self.connections, button.MouseEnter:Connect(function()
        if not tabData.selected then
            TweenService:Create(highlight, TweenInfo.new(0.1), { BackgroundTransparency = 0.97 }):Play()
        end
    end))

    table.insert(self.connections, button.MouseLeave:Connect(function()
        if not tabData.selected then
            TweenService:Create(highlight, TweenInfo.new(0.1), { BackgroundTransparency = 1 }):Play()
        end
    end))

    table.insert(self.connections, button.MouseButton1Click:Connect(function()
        if window.searchBox then
            window.searchBox.Text = ""
        end
        if self.selectedTab and self.selectedTab ~= tabData then
            self.selectedTab.updateVisuals(false)
        end
        self.selectedTab = tabData
        updateTabVisuals(true)
    end))

    tabData.updateVisuals = updateTabVisuals
    table.insert(self.tabs, tabData)

    if #self.tabs == 1 then
        self.selectedTab = tabData
        updateTabVisuals(true)
    end

    -- // Criar Section
    function tabData:CreateSection(sectionTitle, side)
        local column = (type(side) == "string" and side:lower() == "right") and tabData.rightColumn or tabData.leftColumn

        local sectionFrame = Instance.new("Frame")
        sectionFrame.Size = UDim2.new(1, 0, 0, 0)
        sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
        sectionFrame.BackgroundColor3 = Theme.HoverFill
        sectionFrame.BackgroundTransparency = 0.98
        sectionFrame.BorderSizePixel = 0
        sectionFrame.ClipsDescendants = false
        sectionFrame.Parent = column

        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 6)
        sectionCorner.Parent = sectionFrame

        local sectionStroke = Instance.new("UIStroke")
        sectionStroke.Color = Theme.Line
        sectionStroke.Thickness = 1
        sectionStroke.Parent = sectionFrame

        local sectionPadding = Instance.new("UIPadding")
        sectionPadding.PaddingTop = UDim.new(0, 10)
        sectionPadding.PaddingBottom = UDim.new(0, 10)
        sectionPadding.PaddingLeft = UDim.new(0, 10)
        sectionPadding.PaddingRight = UDim.new(0, 10)
        sectionPadding.Parent = sectionFrame

        local sectionLayout = Instance.new("UIListLayout")
        sectionLayout.Padding = UDim.new(0, 6)
        sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        sectionLayout.Parent = sectionFrame

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 0, 16)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = tostring(sectionTitle):upper()
        titleLabel.Font = FONT_BOLD
        titleLabel.TextSize = 11
        titleLabel.TextColor3 = Theme.TextHeader
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
        titleLabel.LayoutOrder = 0
        titleLabel.Parent = sectionFrame

        local titleLine = Instance.new("Frame")
        titleLine.Size = UDim2.new(1, 0, 0, 1)
        titleLine.BackgroundColor3 = Theme.Line
        titleLine.BorderSizePixel = 0
        titleLine.LayoutOrder = 1
        titleLine.Parent = sectionFrame

        local sectionData = {}
        sectionData.frame = sectionFrame
        sectionData.window = window
        sectionData.elementCount = 0

        -- // Frame Element
        local function wrapElement(constructorName, opts)
            local constructor = Elements.List[constructorName]
            if not constructor then
                Notify({ Title = "Erro | Element", Description = constructorName .. " nao registrado", Duration = 5 })
                return nil
            end

            sectionData.elementCount = sectionData.elementCount + 1

            local holder = Instance.new("Frame")
            holder.Size = UDim2.new(1, 0, 0, 0)
            holder.AutomaticSize = Enum.AutomaticSize.Y
            holder.BackgroundColor3 = Theme.HoverFill
            holder.BackgroundTransparency = 0.97
            holder.BorderSizePixel = 0
            holder.LayoutOrder = sectionData.elementCount + 1
            holder.Parent = sectionFrame

            local holderCorner = Instance.new("UICorner")
            holderCorner.CornerRadius = UDim.new(0, 5)
            holderCorner.Parent = holder

            local holderStroke = Instance.new("UIStroke")
            holderStroke.Color = Theme.Line
            holderStroke.Thickness = 1
            holderStroke.Parent = holder

            local holderPadding = Instance.new("UIPadding")
            holderPadding.PaddingTop = UDim.new(0, 6)
            holderPadding.PaddingBottom = UDim.new(0, 6)
            holderPadding.PaddingLeft = UDim.new(0, 8)
            holderPadding.PaddingRight = UDim.new(0, 8)
            holderPadding.Parent = holder

            local holderLayout = Instance.new("UIListLayout")
            holderLayout.SortOrder = Enum.SortOrder.LayoutOrder
            holderLayout.Parent = holder

            local holderSection = setmetatable({ frame = holder, window = window }, { __index = sectionData })
            local result = constructor(holderSection, opts)

            local label = (type(opts) == "table" and (opts.name or opts.title or opts.text or opts.label)) or (type(opts) == "string" and opts) or ""
            if label ~= "" then
                Elements.RegisterSearchEntry(label, holder)
            end

            return result or holder
        end

        -- // Criar Toggle
        function sectionData:CreateToggle(opts)
            return wrapElement("Checkbox", opts)
        end

        -- // Criar Button
        function sectionData:CreateButton(opts)
            return wrapElement("Button", opts)
        end

        -- // Criar Slider
        function sectionData:CreateSlider(opts)
            return wrapElement("Slider", opts)
        end

        -- // Criar Dropdown
        function sectionData:CreateDropdown(opts)
            return wrapElement("Dropdown", opts)
        end

        -- // Criar ColorPicker
        function sectionData:CreateColorPicker(opts)
            return wrapElement("ColorPicker", opts)
        end

        -- // Criar Paragraph
        function sectionData:CreateParagraph(opts)
            return wrapElement("Paragraph", opts)
        end

        return sectionData
    end

    return tabData
end

-- // Destruir Janela
function Library:Destroy()
    for _, connection in ipairs(self.connections) do
        pcall(function() connection:Disconnect() end)
    end
    if self.screenGui then self.screenGui:Destroy() end
    if self.toggleGui then self.toggleGui:Destroy() end
end

-- // Exportar Library
Library.Shield = Shield
Library.Notify = Notify
Library.ICONS = ICONS
Library.Elements = Elements
Library.Theme = Theme
Library.Metrics = Metrics

return Library