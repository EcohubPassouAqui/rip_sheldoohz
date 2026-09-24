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
    SectionGap = 8,
    PagePadding = 12,
    TabWidthPC = 150,
    TabWidthMobile = 110,
    NarrowBreakpoint = 460,
    ShortBreakpoint = 320,
    PagePaddingShort = 6
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

function Elements.Register(name, constructor)
    Elements.List[name] = constructor
end

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

-- // Dropdown
Elements.Register("Dropdown", function(section, options)
    options = type(options) == "table" and options or {}

    local COLORS = {
        TextActive = Color3.fromRGB(255, 255, 255),
        TextInactive = Color3.fromRGB(105, 105, 115),
        TextDisabled = Color3.fromRGB(60, 60, 68),
        FieldBg = Color3.fromRGB(22, 22, 22),
        FieldBorder = Color3.fromRGB(38, 38, 38),
        RowBg = Color3.fromRGB(20, 20, 20),
        RowHover = Color3.fromRGB(30, 30, 30),
        RowSelected = Color3.fromRGB(36, 36, 36),
        OverlayBg = Color3.fromRGB(20, 20, 20),
        OverlayBorder = Color3.fromRGB(38, 38, 38),
        DescText = Color3.fromRGB(100, 100, 110),
        TitleText = Color3.fromRGB(255, 255, 255),
        Icon = Color3.fromRGB(100, 100, 110),
    }

    local TITLE_SIZE = 12
    local DESC_SIZE = 10
    local LABEL_SIZE = 11
    local ROW_H = 40
    local FIELD_W = 150
    local FIELD_H = 24
    local OPT_H = 30
    local MAX_H = 180
    local ANIM_T = 0.12
    local WORD_BREAK = 20
    local Z = 900

    local tweenService = TweenService or game:GetService("TweenService")
    local userInputService = UserInputService or game:GetService("UserInputService")
    local runService = game:GetService("RunService")
    local fontRegular = FONT or Enum.Font.SourceSans
    local fontTitle = FONT or Enum.Font.SourceSansSemibold

    local TI_FAST = TweenInfo.new(0.1)
    local TI_ROW = TweenInfo.new(0.09)
    local TI_HOVER = TweenInfo.new(0.07)
    local TI_OPEN = TweenInfo.new(ANIM_T, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local TI_CLOSE = TweenInfo.new(ANIM_T, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local TI_ICON = TweenInfo.new(ANIM_T)

    local connections = {}
    local rowConnections = {}
    local destroyed = false
    local followConn
    local closeTween
    local closeTweenConn
    local openTween

    local function connect(signal, fn)
        local conn = signal:Connect(fn)
        table.insert(connections, conn)
        return conn
    end

    local function warnf(msg)
        pcall(function()
            Notify({ Title = "CodyWas | Dropdown", Description = msg, Duration = 5 })
        end)
    end

    local function breakWords(text, maxRun)
        text = tostring(text or "")
        local lines = {}
        for line in (text .. "\n"):gmatch("(.-)\n") do
            local r = {}
            for w in line:gmatch("%S+") do
                while #w > maxRun do
                    table.insert(r, w:sub(1, maxRun))
                    w = w:sub(maxRun + 1)
                end
                table.insert(r, w)
            end
            table.insert(lines, table.concat(r, " "))
        end
        return table.concat(lines, "\n")
    end

    local function tw(obj, info, props)
        if destroyed or not obj or not obj.Parent then return end
        pcall(function()
            tweenService:Create(obj, info, props):Play()
        end)
    end

    local function isPointerInput(input)
        return input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
    end

    local function isInside(guiObject, pos)
        local p = guiObject.AbsolutePosition
        local s = guiObject.AbsoluteSize
        return pos.X >= p.X and pos.X <= p.X + s.X and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
    end

    local title = tostring(options.title or options.Name or "Dropdown")
    local desc = tostring(options.description or "")
    local values = type(options.values or options.Options) == "table" and (options.values or options.Options) or {}
    local multi = options.multi == true
    local disabled = options.disabled == true
    local callback = options.callback or options.Callback
    local placeholder = tostring(options.placeholder or "Selecione...")
    local allowDeselect = options.allowDeselect ~= false

    if type(callback) ~= "function" then
        callback = function() end
    end

    local hasDesc = desc ~= ""

    local data = { disabled = disabled, expanded = false }

    local function hasValue(v)
        return table.find(values, v) ~= nil
    end

    if multi then
        data.value = {}
        if type(options.default) == "table" then
            for _, v in ipairs(options.default) do
                if hasValue(v) then data.value[v] = true end
            end
        end
    else
        data.value = nil
        if options.default ~= nil and hasValue(options.default) then
            data.value = options.default
        end
    end

    local screenGui = section.frame:FindFirstAncestorWhichIsA("ScreenGui")

    local container = Instance.new("Frame")
    container.Name = title .. "_Dropdown"
    container.Size = UDim2.new(1, 0, 0, ROW_H)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = false
    container.Parent = section.frame

    local headerRow = Instance.new("Frame")
    headerRow.Name = "Header"
    headerRow.Size = UDim2.new(1, 0, 0, ROW_H)
    headerRow.BackgroundTransparency = 1
    headerRow.Parent = container

    local textSide = Instance.new("Frame")
    textSide.Name = "TextSide"
    textSide.Size = UDim2.new(1, -(FIELD_W + 16), 1, 0)
    textSide.BackgroundTransparency = 1
    textSide.Parent = headerRow

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = disabled and COLORS.TextDisabled or COLORS.TitleText
    titleLabel.TextSize = TITLE_SIZE
    titleLabel.Font = fontTitle
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    titleLabel.Parent = textSide

    local descLabel

    local function layoutText()
        if descLabel then
            titleLabel.Size = UDim2.new(1, 0, 0, 16)
            titleLabel.Position = UDim2.new(0, 0, 0, 2)
        else
            titleLabel.Size = UDim2.new(1, 0, 1, 0)
            titleLabel.Position = UDim2.new(0, 0, 0, 0)
        end
    end

    local function createDescription(text)
        descLabel = Instance.new("TextLabel")
        descLabel.Name = "Desc"
        descLabel.Size = UDim2.new(1, 0, 0, 0)
        descLabel.Position = UDim2.new(0, 0, 0, 18)
        descLabel.AutomaticSize = Enum.AutomaticSize.Y
        descLabel.BackgroundTransparency = 1
        descLabel.Text = breakWords(text, WORD_BREAK)
        descLabel.TextColor3 = COLORS.DescText
        descLabel.TextSize = DESC_SIZE
        descLabel.Font = fontRegular
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.TextYAlignment = Enum.TextYAlignment.Top
        descLabel.TextWrapped = true
        descLabel.LineHeight = 1.1
        descLabel.Parent = textSide
    end

    if hasDesc then
        createDescription(desc)
    end

    layoutText()

    local field = Instance.new("TextButton")
    field.Name = "Field"
    field.Size = UDim2.new(0, FIELD_W, 0, FIELD_H)
    field.Position = UDim2.new(1, 0, 0.5, 0)
    field.AnchorPoint = Vector2.new(1, 0.5)
    field.BackgroundColor3 = COLORS.FieldBg
    field.BorderSizePixel = 0
    field.Text = ""
    field.AutoButtonColor = false
    field.Selectable = false
    field.Active = not disabled
    field.Parent = headerRow

    local fieldCorner = Instance.new("UICorner")
    fieldCorner.CornerRadius = UDim.new(0, 6)
    fieldCorner.Parent = field

    local fStroke = Instance.new("UIStroke")
    fStroke.Color = COLORS.FieldBorder
    fStroke.Thickness = 1
    fStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    fStroke.Parent = field

    local fieldText = Instance.new("TextLabel")
    fieldText.Name = "FieldText"
    fieldText.Size = UDim2.new(1, -24, 1, 0)
    fieldText.Position = UDim2.new(0, 8, 0, 0)
    fieldText.BackgroundTransparency = 1
    fieldText.Text = placeholder
    fieldText.TextColor3 = COLORS.TextInactive
    fieldText.TextSize = LABEL_SIZE
    fieldText.Font = fontRegular
    fieldText.TextXAlignment = Enum.TextXAlignment.Left
    fieldText.TextTruncate = Enum.TextTruncate.AtEnd
    fieldText.Parent = field

    local fieldIcon = Instance.new("ImageLabel")
    fieldIcon.Name = "Icon"
    fieldIcon.Size = UDim2.new(0, 11, 0, 11)
    fieldIcon.Position = UDim2.new(1, -7, 0.5, 0)
    fieldIcon.AnchorPoint = Vector2.new(1, 0.5)
    fieldIcon.BackgroundTransparency = 1
    fieldIcon.Image = "rbxassetid://10709790948"
    fieldIcon.ImageColor3 = COLORS.Icon
    fieldIcon.Parent = field

    local overlay = Instance.new("Frame")
    overlay.Name = title .. "_Overlay"
    overlay.BackgroundColor3 = COLORS.OverlayBg
    overlay.BorderSizePixel = 0
    overlay.Size = UDim2.fromOffset(0, 0)
    overlay.Visible = false
    overlay.ZIndex = Z
    overlay.ClipsDescendants = true
    overlay.Parent = screenGui or container

    local overlayCorner = Instance.new("UICorner")
    overlayCorner.CornerRadius = UDim.new(0, 6)
    overlayCorner.Parent = overlay

    local oStroke = Instance.new("UIStroke")
    oStroke.Color = COLORS.OverlayBorder
    oStroke.Thickness = 1
    oStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    oStroke.Parent = overlay

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "Scroll"
    scroll.Size = UDim2.new(1, -4, 1, -4)
    scroll.Position = UDim2.new(0, 2, 0, 2)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    scroll.ScrollBarImageTransparency = 0
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ZIndex = Z
    scroll.Parent = overlay

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 1)
    listLayout.Parent = scroll

    local listPad = Instance.new("UIPadding")
    listPad.PaddingTop = UDim.new(0, 3)
    listPad.PaddingBottom = UDim.new(0, 3)
    listPad.Parent = scroll

    local optRows = {}

    local function isSelected(value)
        if multi then
            return data.value[value] == true
        end
        return data.value == value
    end

    local function hasSelection()
        if multi then
            return next(data.value) ~= nil
        end
        return data.value ~= nil
    end

    local function getSelectedList()
        local sel = {}
        for _, v in ipairs(values) do
            if data.value[v] then
                table.insert(sel, v)
            end
        end
        return sel
    end

    local function getOutput()
        if multi then
            return getSelectedList()
        end
        return data.value
    end

    local function getDisplayText()
        if multi then
            local sel = getSelectedList()
            if #sel == 0 then return placeholder end
            local names = {}
            for i, v in ipairs(sel) do
                names[i] = tostring(v)
            end
            return table.concat(names, ", ")
        end
        if data.value == nil then return placeholder end
        return tostring(data.value)
    end

    local function updateField(animate)
        local col
        if data.disabled then
            col = COLORS.TextDisabled
        elseif hasSelection() then
            col = COLORS.TextActive
        else
            col = COLORS.TextInactive
        end
        fieldText.Text = getDisplayText()
        titleLabel.TextColor3 = data.disabled and COLORS.TextDisabled or COLORS.TitleText
        if animate then
            tw(fieldText, TI_FAST, { TextColor3 = col })
        else
            fieldText.TextColor3 = col
        end
    end

    local function updateRow(row, animate)
        local sel = isSelected(row.value)
        local bg = sel and COLORS.RowSelected or COLORS.RowBg
        local tc = sel and COLORS.TextActive or (data.disabled and COLORS.TextDisabled or COLORS.TextInactive)
        if animate then
            tw(row.frame, TI_ROW, { BackgroundColor3 = bg })
            tw(row.label, TI_ROW, { TextColor3 = tc })
        else
            row.frame.BackgroundColor3 = bg
            row.label.TextColor3 = tc
        end
    end

    local function fireCallback()
        local ok, err = pcall(callback, getOutput())
        if not ok then warnf("callback: " .. tostring(err)) end
    end

    local function getOverlayH()
        return math.min(listLayout.AbsoluteContentSize.Y + 6, MAX_H)
    end

    local function computePlacement()
        local cam = workspace.CurrentCamera
        local fPos = field.AbsolutePosition
        local fSize = field.AbsoluteSize
        local h = getOverlayH()
        local screenH = cam and cam.ViewportSize.Y or 600
        local goUp = (screenH - fPos.Y - fSize.Y) < h + 6
        local startY = goUp and (fPos.Y - 4) or (fPos.Y + fSize.Y + 4)
        local endY = goUp and (fPos.Y - h - 4) or (fPos.Y + fSize.Y + 4)
        return fPos, fSize, h, startY, endY
    end

    local function stopFollow()
        if followConn then
            followConn:Disconnect()
            followConn = nil
        end
    end

    local function cancelTweens()
        if openTween then
            openTween:Cancel()
            openTween = nil
        end
        if closeTweenConn then
            closeTweenConn:Disconnect()
            closeTweenConn = nil
        end
        if closeTween then
            closeTween:Cancel()
            closeTween = nil
        end
    end

    local closeOverlay

    local function reposition()
        if destroyed or not data.expanded then return end
        local cam = workspace.CurrentCamera
        local fPos, fSize, h, _, endY = computePlacement()
        if cam then
            local vp = cam.ViewportSize
            if fPos.Y + fSize.Y < 0 or fPos.Y > vp.Y or fPos.X + fSize.X < 0 or fPos.X > vp.X then
                closeOverlay(true)
                return
            end
        end
        overlay.Position = UDim2.fromOffset(fPos.X, endY)
        overlay.Size = UDim2.fromOffset(fSize.X, h)
    end

    local function startFollow()
        stopFollow()
        followConn = runService.RenderStepped:Connect(reposition)
    end

    closeOverlay = function(instant)
        if not data.expanded then return end
        data.expanded = false
        stopFollow()
        cancelTweens()
        tw(fieldIcon, TI_ICON, { Rotation = 0 })

        if instant then
            overlay.Visible = false
            overlay.Size = UDim2.fromOffset(0, 0)
            return
        end

        local fSize = field.AbsoluteSize
        closeTween = tweenService:Create(overlay, TI_CLOSE, { Size = UDim2.fromOffset(fSize.X, 0) })
        closeTweenConn = closeTween.Completed:Connect(function()
            if not data.expanded and not destroyed then
                overlay.Visible = false
            end
            if closeTweenConn then
                closeTweenConn:Disconnect()
                closeTweenConn = nil
            end
        end)
        closeTween:Play()
    end

    local function selectValue(value)
        if destroyed or data.disabled then return end
        if multi then
            if data.value[value] then
                data.value[value] = nil
            else
                data.value[value] = true
            end
        else
            if data.value == value then
                if not allowDeselect then
                    closeOverlay(false)
                    return
                end
                data.value = nil
            else
                data.value = value
            end
        end
        for _, row in ipairs(optRows) do updateRow(row, true) end
        updateField(true)
        fireCallback()
        if not multi then closeOverlay(false) end
    end

    local function clearRowConnections()
        for _, conn in ipairs(rowConnections) do
            conn:Disconnect()
        end
        table.clear(rowConnections)
    end

    local function buildOptions()
        clearRowConnections()
        for _, row in ipairs(optRows) do
            if row.frame then row.frame:Destroy() end
        end
        optRows = {}

        for i, value in ipairs(values) do
            local optFrame = Instance.new("Frame")
            optFrame.Name = "Opt_" .. i
            optFrame.Size = UDim2.new(1, 0, 0, OPT_H)
            optFrame.BackgroundColor3 = COLORS.RowBg
            optFrame.BorderSizePixel = 0
            optFrame.LayoutOrder = i
            optFrame.ZIndex = Z

            local optCorner = Instance.new("UICorner")
            optCorner.CornerRadius = UDim.new(0, 4)
            optCorner.Parent = optFrame

            optFrame.Parent = scroll

            local optLabel = Instance.new("TextLabel")
            optLabel.Name = "Label"
            optLabel.Size = UDim2.new(1, -16, 1, 0)
            optLabel.Position = UDim2.new(0, 10, 0, 0)
            optLabel.BackgroundTransparency = 1
            optLabel.Text = tostring(value)
            optLabel.TextColor3 = COLORS.TextInactive
            optLabel.TextSize = LABEL_SIZE
            optLabel.Font = fontRegular
            optLabel.TextXAlignment = Enum.TextXAlignment.Left
            optLabel.TextYAlignment = Enum.TextYAlignment.Center
            optLabel.TextTruncate = Enum.TextTruncate.AtEnd
            optLabel.ZIndex = Z + 1
            optLabel.Parent = optFrame

            local btn = Instance.new("TextButton")
            btn.Name = "Btn"
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.AutoButtonColor = false
            btn.Selectable = false
            btn.ZIndex = Z + 2
            btn.Parent = optFrame

            local row = { frame = optFrame, label = optLabel, value = value }
            table.insert(optRows, row)

            updateRow(row, false)

            table.insert(rowConnections, btn.MouseEnter:Connect(function()
                if not isSelected(value) and not data.disabled then
                    tw(optFrame, TI_HOVER, { BackgroundColor3 = COLORS.RowHover })
                end
            end))
            table.insert(rowConnections, btn.MouseLeave:Connect(function()
                if not isSelected(value) then
                    tw(optFrame, TI_HOVER, { BackgroundColor3 = COLORS.RowBg })
                end
            end))
            table.insert(rowConnections, btn.MouseButton1Click:Connect(function()
                selectValue(value)
            end))
        end
    end

    local openedAt = 0

    local function openOverlay()
        if destroyed or data.disabled or data.expanded or #values == 0 then return end
        data.expanded = true
        openedAt = os.clock()
        cancelTweens()

        task.defer(function()
            if destroyed or not data.expanded then return end
            local fPos, fSize, h, startY, endY = computePlacement()

            overlay.Size = UDim2.fromOffset(fSize.X, 0)
            overlay.Position = UDim2.fromOffset(fPos.X, startY)
            overlay.Visible = true

            tw(fieldIcon, TI_ICON, { Rotation = 180 })
            openTween = tweenService:Create(overlay, TI_OPEN, {
                Size = UDim2.fromOffset(fSize.X, h),
                Position = UDim2.fromOffset(fPos.X, endY),
            })
            openTween:Play()
            startFollow()
        end)
    end

    connect(field.MouseButton1Click, function()
        if data.expanded then
            closeOverlay(false)
        else
            openOverlay()
        end
    end)

    connect(userInputService.InputBegan, function(input)
        if destroyed or not data.expanded then return end
        if os.clock() - openedAt < 0.15 then return end
        if not isPointerInput(input) then return end
        local pos = Vector2.new(input.Position.X, input.Position.Y)
        if not isInside(field, pos) and not isInside(overlay, pos) then
            closeOverlay(false)
        end
    end)

    buildOptions()
    updateField(false)

    if hasSelection() then
        fireCallback()
    end

    local function sameSelection(a, b)
        if multi then
            for k in pairs(a) do
                if not b[k] then return false end
            end
            for k in pairs(b) do
                if not a[k] then return false end
            end
            return true
        end
        return a == b
    end

    function data:Set(value)
        if destroyed then return end
        local new
        if multi then
            new = {}
            if type(value) == "table" then
                for _, v in ipairs(value) do
                    if hasValue(v) then new[v] = true end
                end
            end
        else
            if value ~= nil and not hasValue(value) then
                warnf("valor '" .. tostring(value) .. "' nao existe.")
                return
            end
            new = value
        end
        if sameSelection(data.value, new) then return end
        data.value = new
        for _, row in ipairs(optRows) do updateRow(row, true) end
        updateField(true)
        fireCallback()
    end

    function data:Get()
        return getOutput()
    end

    function data:SetValues(newValues)
        if destroyed then return end
        values = type(newValues) == "table" and newValues or {}

        local changed = false
        if multi then
            local f = {}
            for v in pairs(data.value) do
                if hasValue(v) then
                    f[v] = true
                else
                    changed = true
                end
            end
            data.value = f
        elseif data.value ~= nil and not hasValue(data.value) then
            data.value = nil
            changed = true
        end

        buildOptions()
        updateField(false)

        if #values == 0 and data.expanded then
            closeOverlay(true)
        elseif data.expanded then
            task.defer(reposition)
        end

        if changed then
            fireCallback()
        end
    end

    function data:SetDisabled(value)
        if destroyed then return end
        data.disabled = value == true
        field.Active = not data.disabled
        if data.disabled then closeOverlay(true) end
        for _, row in ipairs(optRows) do updateRow(row, false) end
        updateField(true)
    end

    function data:SetTitle(newTitle)
        if destroyed then return end
        title = tostring(newTitle or "")
        titleLabel.Text = title
        container.Name = title .. "_Dropdown"
        overlay.Name = title .. "_Overlay"
    end

    function data:SetDescription(newDesc)
        if destroyed then return end
        newDesc = tostring(newDesc or "")
        if newDesc == "" then
            if descLabel then
                descLabel:Destroy()
                descLabel = nil
            end
            layoutText()
            return
        end
        if not descLabel then
            createDescription(newDesc)
        else
            descLabel.Text = breakWords(newDesc, WORD_BREAK)
        end
        layoutText()
    end

    function data:Open()
        openOverlay()
    end

    function data:Close()
        closeOverlay(false)
    end

    function data:Destroy()
        if destroyed then return end
        destroyed = true
        stopFollow()
        cancelTweens()
        clearRowConnections()
        for _, conn in ipairs(connections) do
            conn:Disconnect()
        end
        table.clear(connections)
        overlay:Destroy()
        container:Destroy()
    end

    return data
end)

-- // Colorpick
Elements.Register("ColorPicker", function(section, options)
    options = type(options) == "table" and options or {}

    local COLORS = {
        TextActive = Color3.fromRGB(255, 255, 255),
        TextInactive = Color3.fromRGB(105, 105, 115),
        TextDisabled = Color3.fromRGB(70, 70, 78),
        Line = Color3.fromRGB(32, 32, 32),
        Field = Color3.fromRGB(24, 24, 24),
        FieldAlt = Color3.fromRGB(30, 30, 30),
        MenuBackground = Color3.fromRGB(18, 18, 18),
        SectionBackground = Color3.fromRGB(22, 22, 22),
        DescriptionText = Color3.fromRGB(105, 105, 115),
        Accent = Color3.fromRGB(255, 255, 255),
    }

    local TITLE_TEXT_SIZE = 12
    local DESCRIPTION_TEXT_SIZE = 10
    local LABEL_TEXT_SIZE = 11
    local ROW_HEIGHT = 50
    local FIELD_WIDTH = 120
    local FIELD_HEIGHT = 28
    local OVERLAY_ZINDEX = 1000
    local WORD_MAX = 30
    local MAP_HEIGHT = 130
    local HUE_HEIGHT = 18
    local ALPHA_HEIGHT = 18
    local OVERLAY_PADDING = 14
    local OVERLAY_GAP = 14
    local OVERLAY_HEIGHT = (OVERLAY_PADDING * 2) + MAP_HEIGHT + HUE_HEIGHT + ALPHA_HEIGHT + (OVERLAY_GAP * 2)

    local tweenService = TweenService or game:GetService("TweenService")
    local userInputService = UserInputService or game:GetService("UserInputService")
    local fontBold = FONT_BOLD or Enum.Font.SourceSansBold
    local fontRegular = FONT or Enum.Font.SourceSans

    local TI_OPEN = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local TI_CLOSE = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

    local connections = {}
    local destroyed = false
    local closeTween
    local closeTweenConn

    local function connect(signal, fn)
        local conn = signal:Connect(fn)
        table.insert(connections, conn)
        return conn
    end

    local function warnf(msg)
        pcall(function()
            Notify({ Title = "CodyWas | ColorPicker", Description = msg, Duration = 5 })
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

    local function rgbToHex(color)
        local r = math.round(color.R * 255)
        local g = math.round(color.G * 255)
        local b = math.round(color.B * 255)
        return string.format("%02X%02X%02X", r, g, b)
    end

    local function getContrastColor(color, transparency)
        transparency = transparency or 0
        local bg = 0.12
        local r = color.R * (1 - transparency) + bg * transparency
        local g = color.G * (1 - transparency) + bg * transparency
        local b = color.B * (1 - transparency) + bg * transparency
        local luminance = (0.299 * r) + (0.587 * g) + (0.114 * b)
        if luminance > 0.55 then
            return Color3.fromRGB(20, 20, 20)
        end
        return Color3.fromRGB(255, 255, 255)
    end

    local function isInside(guiObject, pos)
        local p = guiObject.AbsolutePosition
        local s = guiObject.AbsoluteSize
        return pos.X >= p.X and pos.X <= p.X + s.X and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
    end

    local title = tostring(options.title or options.Name or "Color")
    local description = tostring(options.description or "")
    local defaultColor = options.default or options.Default
    local defaultTransparency = tonumber(options.transparency) or 0
    local disabled = options.disabled == true
    local callback = options.callback or options.Callback

    if typeof(defaultColor) ~= "Color3" then
        defaultColor = Color3.fromRGB(68, 120, 255)
    end

    defaultTransparency = math.clamp(defaultTransparency, 0, 1)

    if type(callback) ~= "function" then
        callback = function() end
    end

    local hasDescription = description ~= ""

    local data = {
        disabled = disabled,
        opened = false,
        value = defaultColor,
        transparency = defaultTransparency,
    }

    local hue, sat, vib = Color3.toHSV(data.value)

    local container = Instance.new("Frame")
    container.Name = title .. "_ColorPicker"
    container.Size = UDim2.new(1, 0, 0, ROW_HEIGHT)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = false
    container.Parent = section.frame

    local textContainer = Instance.new("Frame")
    textContainer.Name = "TextContainer"
    textContainer.Size = UDim2.new(1, -(FIELD_WIDTH + 16), 1, 0)
    textContainer.BackgroundTransparency = 1
    textContainer.Parent = container

    local label = Instance.new("TextLabel")
    label.Name = "Title"
    label.Size = UDim2.new(1, 0, 0, 16)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = disabled and COLORS.TextDisabled or COLORS.TextActive
    label.TextSize = TITLE_TEXT_SIZE
    label.Font = fontRegular
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.Parent = textContainer

    local descLabel

    local function layoutText()
        if descLabel then
            label.Position = UDim2.new(0, 0, 0, 2)
            label.AnchorPoint = Vector2.new(0, 0)
        else
            label.Position = UDim2.new(0, 0, 0.5, 0)
            label.AnchorPoint = Vector2.new(0, 0.5)
        end
    end

    local function createDescription(text)
        descLabel = Instance.new("TextLabel")
        descLabel.Name = "Desc"
        descLabel.Size = UDim2.new(1, 0, 0, 0)
        descLabel.Position = UDim2.new(0, 0, 0, 18)
        descLabel.AutomaticSize = Enum.AutomaticSize.Y
        descLabel.BackgroundTransparency = 1
        descLabel.Text = breakLongWords(text, WORD_MAX)
        descLabel.TextColor3 = COLORS.DescriptionText
        descLabel.TextSize = DESCRIPTION_TEXT_SIZE
        descLabel.Font = fontRegular
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.TextYAlignment = Enum.TextYAlignment.Top
        descLabel.TextWrapped = true
        descLabel.LineHeight = 1.1
        descLabel.Parent = textContainer
    end

    if hasDescription then
        createDescription(description)
    end

    layoutText()

    local field = Instance.new("TextButton")
    field.Name = "Field"
    field.Size = UDim2.new(0, FIELD_WIDTH, 0, FIELD_HEIGHT)
    field.Position = UDim2.new(1, 0, 0.5, 0)
    field.AnchorPoint = Vector2.new(1, 0.5)
    field.BackgroundColor3 = COLORS.Field
    field.BorderSizePixel = 0
    field.Text = ""
    field.AutoButtonColor = false
    field.Selectable = false
    field.Active = not disabled
    field.ZIndex = 10
    field.Parent = container

    local fieldCorner = Instance.new("UICorner")
    fieldCorner.CornerRadius = UDim.new(0, 6)
    fieldCorner.Parent = field

    local fieldStroke = Instance.new("UIStroke")
    fieldStroke.Color = COLORS.Line
    fieldStroke.Thickness = 1
    fieldStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    fieldStroke.Parent = field

    local checkerBoard = Instance.new("ImageLabel")
    checkerBoard.Name = "CheckerBoard"
    checkerBoard.Size = UDim2.new(1, 0, 1, 0)
    checkerBoard.BackgroundTransparency = 1
    checkerBoard.Image = "rbxasset://textures/Checkerboard.png"
    checkerBoard.ImageTransparency = 0.45
    checkerBoard.ScaleType = Enum.ScaleType.Tile
    checkerBoard.TileSize = UDim2.fromOffset(8, 8)
    checkerBoard.ZIndex = 9
    checkerBoard.Parent = field

    local checkerCorner = Instance.new("UICorner")
    checkerCorner.CornerRadius = UDim.new(0, 6)
    checkerCorner.Parent = checkerBoard

    local fieldColor = Instance.new("Frame")
    fieldColor.Name = "FieldColor"
    fieldColor.Size = UDim2.new(1, 0, 1, 0)
    fieldColor.BackgroundColor3 = data.value
    fieldColor.BackgroundTransparency = data.transparency
    fieldColor.BorderSizePixel = 0
    fieldColor.ZIndex = 10
    fieldColor.Parent = field

    local fieldColorCorner = Instance.new("UICorner")
    fieldColorCorner.CornerRadius = UDim.new(0, 6)
    fieldColorCorner.Parent = fieldColor

    local fieldLabel = Instance.new("TextLabel")
    fieldLabel.Name = "FieldLabel"
    fieldLabel.Size = UDim2.new(1, 0, 1, 0)
    fieldLabel.BackgroundTransparency = 1
    fieldLabel.Text = rgbToHex(data.value)
    fieldLabel.TextColor3 = getContrastColor(data.value, data.transparency)
    fieldLabel.TextSize = LABEL_TEXT_SIZE
    fieldLabel.Font = fontBold
    fieldLabel.ZIndex = 11
    fieldLabel.Parent = fieldColor

    local overlayCanvas = Instance.new("Frame")
    overlayCanvas.Name = title .. "_PickerOverlay"
    overlayCanvas.Size = UDim2.new(0, 0, 0, 0)
    overlayCanvas.BackgroundColor3 = COLORS.MenuBackground
    overlayCanvas.BorderSizePixel = 0
    overlayCanvas.ClipsDescendants = true
    overlayCanvas.Visible = false
    overlayCanvas.ZIndex = OVERLAY_ZINDEX
    overlayCanvas.Parent = container

    local overlayCorner = Instance.new("UICorner")
    overlayCorner.CornerRadius = UDim.new(0, 8)
    overlayCorner.Parent = overlayCanvas

    local overlayStroke = Instance.new("UIStroke")
    overlayStroke.Color = COLORS.Line
    overlayStroke.Thickness = 1
    overlayStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    overlayStroke.Parent = overlayCanvas

    local overlayPadding = Instance.new("UIPadding")
    overlayPadding.PaddingTop = UDim.new(0, OVERLAY_PADDING)
    overlayPadding.PaddingBottom = UDim.new(0, OVERLAY_PADDING)
    overlayPadding.PaddingLeft = UDim.new(0, OVERLAY_PADDING)
    overlayPadding.PaddingRight = UDim.new(0, OVERLAY_PADDING)
    overlayPadding.Parent = overlayCanvas

    local pickerLayout = Instance.new("UIListLayout")
    pickerLayout.Padding = UDim.new(0, OVERLAY_GAP)
    pickerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pickerLayout.Parent = overlayCanvas

    local satVibMap = Instance.new("ImageLabel")
    satVibMap.Name = "SatVibMap"
    satVibMap.Size = UDim2.new(1, 0, 0, MAP_HEIGHT)
    satVibMap.Image = "rbxassetid://4155801252"
    satVibMap.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
    satVibMap.BorderSizePixel = 0
    satVibMap.LayoutOrder = 1
    satVibMap.ZIndex = OVERLAY_ZINDEX + 1
    satVibMap.Parent = overlayCanvas

    local satVibCorner = Instance.new("UICorner")
    satVibCorner.CornerRadius = UDim.new(0, 6)
    satVibCorner.Parent = satVibMap

    local satVibStroke = Instance.new("UIStroke")
    satVibStroke.Color = COLORS.Line
    satVibStroke.Thickness = 1
    satVibStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    satVibStroke.Parent = satVibMap

    local satCursorOuter = Instance.new("Frame")
    satCursorOuter.Name = "SatCursorOuter"
    satCursorOuter.Size = UDim2.fromOffset(18, 18)
    satCursorOuter.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    satCursorOuter.BackgroundTransparency = 0.35
    satCursorOuter.BorderSizePixel = 0
    satCursorOuter.ZIndex = OVERLAY_ZINDEX + 2
    satCursorOuter.Parent = satVibMap

    local satCursorOuterCorner = Instance.new("UICorner")
    satCursorOuterCorner.CornerRadius = UDim.new(1, 0)
    satCursorOuterCorner.Parent = satCursorOuter

    local satCursor = Instance.new("Frame")
    satCursor.Name = "SatCursor"
    satCursor.Size = UDim2.fromOffset(14, 14)
    satCursor.Position = UDim2.new(0.5, 0, 0.5, 0)
    satCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    satCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    satCursor.BorderSizePixel = 0
    satCursor.ZIndex = OVERLAY_ZINDEX + 3
    satCursor.Parent = satCursorOuter

    local satCursorCorner = Instance.new("UICorner")
    satCursorCorner.CornerRadius = UDim.new(1, 0)
    satCursorCorner.Parent = satCursor

    local satCursorInnerStroke = Instance.new("UIStroke")
    satCursorInnerStroke.Color = Color3.fromRGB(0, 0, 0)
    satCursorInnerStroke.Thickness = 1
    satCursorInnerStroke.Transparency = 0.5
    satCursorInnerStroke.Parent = satCursor

    local hueSlider = Instance.new("Frame")
    hueSlider.Name = "HueSlider"
    hueSlider.Size = UDim2.new(1, 0, 0, HUE_HEIGHT)
    hueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueSlider.LayoutOrder = 2
    hueSlider.BorderSizePixel = 0
    hueSlider.ZIndex = OVERLAY_ZINDEX + 1
    hueSlider.Parent = overlayCanvas

    local hueCorner = Instance.new("UICorner")
    hueCorner.CornerRadius = UDim.new(0, 6)
    hueCorner.Parent = hueSlider

    local hueStroke = Instance.new("UIStroke")
    hueStroke.Color = COLORS.Line
    hueStroke.Thickness = 1
    hueStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    hueStroke.Parent = hueSlider

    local hueSequence = {}
    for i = 0, 10 do
        local t = i / 10
        table.insert(hueSequence, ColorSequenceKeypoint.new(t, Color3.fromHSV(math.min(t, 0.999), 1, 1)))
    end

    local hueGradient = Instance.new("UIGradient")
    hueGradient.Color = ColorSequence.new(hueSequence)
    hueGradient.Rotation = 0
    hueGradient.Parent = hueSlider

    local hueCursor = Instance.new("Frame")
    hueCursor.Name = "HueCursor"
    hueCursor.Size = UDim2.fromOffset(6, HUE_HEIGHT + 4)
    hueCursor.Position = UDim2.new(0, 0, 0.5, 0)
    hueCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    hueCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueCursor.BorderSizePixel = 0
    hueCursor.ZIndex = OVERLAY_ZINDEX + 2
    hueCursor.Parent = hueSlider

    local hueCursorCorner = Instance.new("UICorner")
    hueCursorCorner.CornerRadius = UDim.new(0, 3)
    hueCursorCorner.Parent = hueCursor

    local hueCursorStroke = Instance.new("UIStroke")
    hueCursorStroke.Color = Color3.fromRGB(0, 0, 0)
    hueCursorStroke.Thickness = 1.5
    hueCursorStroke.Transparency = 0.3
    hueCursorStroke.Parent = hueCursor

    local alphaSlider = Instance.new("Frame")
    alphaSlider.Name = "AlphaSlider"
    alphaSlider.Size = UDim2.new(1, 0, 0, ALPHA_HEIGHT)
    alphaSlider.BackgroundColor3 = COLORS.Field
    alphaSlider.LayoutOrder = 3
    alphaSlider.BorderSizePixel = 0
    alphaSlider.ZIndex = OVERLAY_ZINDEX + 1
    alphaSlider.Parent = overlayCanvas

    local alphaCorner = Instance.new("UICorner")
    alphaCorner.CornerRadius = UDim.new(0, 6)
    alphaCorner.Parent = alphaSlider

    local alphaStroke = Instance.new("UIStroke")
    alphaStroke.Color = COLORS.Line
    alphaStroke.Thickness = 1
    alphaStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    alphaStroke.Parent = alphaSlider

    local alphaChecker = Instance.new("ImageLabel")
    alphaChecker.Name = "AlphaChecker"
    alphaChecker.Size = UDim2.new(1, 0, 1, 0)
    alphaChecker.BackgroundTransparency = 1
    alphaChecker.Image = "rbxasset://textures/Checkerboard.png"
    alphaChecker.ImageTransparency = 0.45
    alphaChecker.ScaleType = Enum.ScaleType.Tile
    alphaChecker.TileSize = UDim2.fromOffset(8, 8)
    alphaChecker.ZIndex = OVERLAY_ZINDEX + 1
    alphaChecker.Parent = alphaSlider

    local alphaCheckerCorner = Instance.new("UICorner")
    alphaCheckerCorner.CornerRadius = UDim.new(0, 6)
    alphaCheckerCorner.Parent = alphaChecker

    local alphaFill = Instance.new("Frame")
    alphaFill.Name = "AlphaFill"
    alphaFill.Size = UDim2.new(1, 0, 1, 0)
    alphaFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    alphaFill.BorderSizePixel = 0
    alphaFill.ZIndex = OVERLAY_ZINDEX + 1
    alphaFill.Parent = alphaSlider

    local alphaFillCorner = Instance.new("UICorner")
    alphaFillCorner.CornerRadius = UDim.new(0, 6)
    alphaFillCorner.Parent = alphaFill

    local alphaGradient = Instance.new("UIGradient")
    alphaGradient.Rotation = 0
    alphaGradient.Color = ColorSequence.new(data.value)
    alphaGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1),
    })
    alphaGradient.Parent = alphaFill

    local alphaCursor = Instance.new("Frame")
    alphaCursor.Name = "AlphaCursor"
    alphaCursor.Size = UDim2.fromOffset(6, ALPHA_HEIGHT + 4)
    alphaCursor.Position = UDim2.new(0, 0, 0.5, 0)
    alphaCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    alphaCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    alphaCursor.BorderSizePixel = 0
    alphaCursor.ZIndex = OVERLAY_ZINDEX + 2
    alphaCursor.Parent = alphaSlider

    local alphaCursorCorner = Instance.new("UICorner")
    alphaCursorCorner.CornerRadius = UDim.new(0, 3)
    alphaCursorCorner.Parent = alphaCursor

    local alphaCursorStroke = Instance.new("UIStroke")
    alphaCursorStroke.Color = Color3.fromRGB(0, 0, 0)
    alphaCursorStroke.Thickness = 1.5
    alphaCursorStroke.Transparency = 0.3
    alphaCursorStroke.Parent = alphaCursor

    local function fireCallback()
        local ok, err = pcall(callback, data.value, data.transparency)
        if not ok then
            warnf("callback error: " .. tostring(err))
        end
    end

    local function updateFieldVisuals()
        fieldColor.BackgroundColor3 = data.value
        fieldColor.BackgroundTransparency = data.transparency
        fieldLabel.Text = rgbToHex(data.value)
        fieldLabel.TextColor3 = getContrastColor(data.value, data.transparency)
        alphaGradient.Color = ColorSequence.new(data.value)
        field.BackgroundTransparency = data.disabled and 0.5 or 0
    end

    local function display()
        if destroyed then return end
        satVibMap.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        satCursorOuter.Position = UDim2.new(sat, -9, 1 - vib, -9)
        hueCursor.Position = UDim2.new(hue, 0, 0.5, 0)
        alphaCursor.Position = UDim2.new(data.transparency, 0, 0.5, 0)

        data.value = Color3.fromHSV(hue, sat, vib)
        updateFieldVisuals()
    end

    display()

    local dragging = nil
    local openedAt = 0
    local dragEndedAt = 0

    local function updateFromInput(kind, inputPos)
        if kind == "satvib" then
            local minX = satVibMap.AbsolutePosition.X
            local maxX = minX + satVibMap.AbsoluteSize.X
            local minY = satVibMap.AbsolutePosition.Y
            local maxY = minY + satVibMap.AbsoluteSize.Y
            local mouseX = math.clamp(inputPos.X, minX, maxX)
            local mouseY = math.clamp(inputPos.Y, minY, maxY)
            if maxX > minX then sat = (mouseX - minX) / (maxX - minX) end
            if maxY > minY then vib = 1 - ((mouseY - minY) / (maxY - minY)) end
        elseif kind == "hue" then
            local minX = hueSlider.AbsolutePosition.X
            local maxX = minX + hueSlider.AbsoluteSize.X
            local mouseX = math.clamp(inputPos.X, minX, maxX)
            if maxX > minX then hue = (mouseX - minX) / (maxX - minX) end
        elseif kind == "alpha" then
            local minX = alphaSlider.AbsolutePosition.X
            local maxX = minX + alphaSlider.AbsoluteSize.X
            local mouseX = math.clamp(inputPos.X, minX, maxX)
            if maxX > minX then data.transparency = (mouseX - minX) / (maxX - minX) end
        end
        display()
        fireCallback()
    end

    local function isPointerInput(input)
        return input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
    end

    local function bindDrag(gui, kind)
        connect(gui.InputBegan, function(input)
            if destroyed or data.disabled then return end
            if isPointerInput(input) then
                dragging = kind
                updateFromInput(kind, input.Position)
            end
        end)
    end

    bindDrag(satVibMap, "satvib")
    bindDrag(hueSlider, "hue")
    bindDrag(alphaSlider, "alpha")

    connect(userInputService.InputChanged, function(input)
        if destroyed or not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            updateFromInput(dragging, input.Position)
        end
    end)

    connect(userInputService.InputEnded, function(input)
        if isPointerInput(input) and dragging then
            dragging = nil
            dragEndedAt = os.clock()
        end
    end)

    local function positionOverlay()
        overlayCanvas.Position = UDim2.new(1, -0, 0, ROW_HEIGHT + 6)
        overlayCanvas.AnchorPoint = Vector2.new(1, 0)
    end

    local function disconnectCloseTween()
        if closeTweenConn then
            closeTweenConn:Disconnect()
            closeTweenConn = nil
        end
        if closeTween then
            closeTween:Cancel()
            closeTween = nil
        end
    end

    local closeMenu

    local function openMenu()
        if destroyed or data.disabled or data.opened then return end
        data.opened = true
        openedAt = os.clock()

        disconnectCloseTween()
        positionOverlay()

        local width = math.max(container.AbsoluteSize.X, 200)
        overlayCanvas.Size = UDim2.new(0, width, 0, 0)
        overlayCanvas.Visible = true
        tweenService:Create(overlayCanvas, TI_OPEN, { Size = UDim2.new(0, width, 0, OVERLAY_HEIGHT) }):Play()
    end

    closeMenu = function()
        if not data.opened then return end
        data.opened = false
        dragging = nil

        disconnectCloseTween()
        closeTween = tweenService:Create(overlayCanvas, TI_CLOSE, { Size = UDim2.new(0, overlayCanvas.AbsoluteSize.X, 0, 0) })
        closeTweenConn = closeTween.Completed:Connect(function()
            if not data.opened and not destroyed then
                overlayCanvas.Visible = false
            end
            if closeTweenConn then
                closeTweenConn:Disconnect()
                closeTweenConn = nil
            end
        end)
        closeTween:Play()
    end

    connect(field.MouseButton1Click, function()
        if data.opened then
            closeMenu()
        else
            openMenu()
        end
    end)

    connect(userInputService.InputBegan, function(input)
        if destroyed or not data.opened or dragging then return end
        if os.clock() - openedAt < 0.1 then return end
        if os.clock() - dragEndedAt < 0.1 then return end
        if not isPointerInput(input) then return end

        local pos = Vector2.new(input.Position.X, input.Position.Y)
        if not isInside(overlayCanvas, pos) and not isInside(field, pos) then
            closeMenu()
        end
    end)

    local function applyDisabledVisual()
        field.Active = not data.disabled
        label.TextColor3 = data.disabled and COLORS.TextDisabled or COLORS.TextActive
        field.BackgroundTransparency = data.disabled and 0.5 or 0
        fieldColor.BackgroundTransparency = data.disabled and math.clamp(data.transparency + 0.4, 0, 1) or data.transparency
    end

    applyDisabledVisual()

    function data:Set(color, transparency)
        if destroyed then return end
        if typeof(color) ~= "Color3" then
            warnf("Set() esperava Color3, recebeu " .. typeof(color))
            return
        end
        transparency = math.clamp(tonumber(transparency) or 0, 0, 1)
        if data.value == color and data.transparency == transparency then return end
        data.transparency = transparency
        hue, sat, vib = Color3.toHSV(color)
        display()
        data.value = color
        updateFieldVisuals()
        fireCallback()
    end

    function data:Get()
        return data.value
    end

    function data:GetHex()
        return rgbToHex(data.value)
    end

    function data:GetTransparency()
        return data.transparency
    end

    function data:SetCallback(newCallback)
        if type(newCallback) ~= "function" then
            warnf("SetCallback() esperava function")
            return
        end
        callback = newCallback
    end

    function data:SetDisabled(value)
        if destroyed then return end
        data.disabled = value == true
        applyDisabledVisual()
        if data.disabled and data.opened then
            closeMenu()
        end
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
            layoutText()
            return
        end
        if not descLabel then
            createDescription(newDesc)
        else
            descLabel.Text = breakLongWords(newDesc, WORD_MAX)
        end
        layoutText()
    end

    function data:Open()
        openMenu()
    end

    function data:Close()
        closeMenu()
    end

    function data:Destroy()
        if destroyed then return end
        destroyed = true
        disconnectCloseTween()
        for _, conn in ipairs(connections) do
            conn:Disconnect()
        end
        table.clear(connections)
        overlayCanvas:Destroy()
        container:Destroy()
    end

    return data
end)

-- // Paragraph
Elements.Register("Paragraph", function(section, options)
    options = type(options) == "table" and options or {}

    local COLORS = {
        TextActive = Color3.fromRGB(255, 255, 255),
        TextDisabled = Color3.fromRGB(70, 70, 78),
        DescText = Color3.fromRGB(105, 105, 115),
        DescDisabled = Color3.fromRGB(60, 60, 68),
        Line = Color3.fromRGB(32, 32, 32),
        ThumbBg = Color3.fromRGB(24, 24, 24),
    }

    local TITLE_SIZE = 12
    local DESC_SIZE = 10
    local THUMB_SIZE = 36
    local PADDING_X = 0
    local PADDING_Y = 10
    local THUMB_GAP = 10
    local MIN_HEIGHT = 40
    local UPDATE_INTERVAL = 3
    local WORD_MAX = 30

    local players = Players or game:GetService("Players")
    local fontBold = FONT_BOLD or Enum.Font.SourceSansBold
    local fontRegular = FONT or Enum.Font.SourceSans

    local destroyed = false
    local liveToken = 0
    local thumbWarned = false

    local function warnf(msg)
        pcall(function()
            Notify({ Title = "CodyWas | Paragraph", Description = msg, Duration = 5 })
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

    local title = tostring(options.title or options.Name or "")
    local description = tostring(options.description or options.Description or "")
    local thumbnail = options.thumbnail or options.Thumbnail
    local disabled = options.disabled == true
    local richText = options.richText ~= false

    if thumbnail ~= nil and type(thumbnail) ~= "string" and type(thumbnail) ~= "number" then
        warnf("thumbnail deve ser string ou number (userId)")
        thumbnail = nil
    end

    local function formatText(text)
        if richText then
            return text
        end
        return breakLongWords(text, WORD_MAX)
    end

    local data = {
        disabled = disabled,
        title = title,
        description = description,
        thumbnail = thumbnail,
    }

    local container = Instance.new("Frame")
    container.Name = (title ~= "" and title or "Paragraph") .. "_Paragraph"
    container.Size = UDim2.new(1, 0, 0, MIN_HEIGHT)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = false
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.Parent = section.frame

    local sizeConstraint = Instance.new("UISizeConstraint")
    sizeConstraint.MinSize = Vector2.new(0, MIN_HEIGHT)
    sizeConstraint.Parent = container

    local innerPad = Instance.new("UIPadding")
    innerPad.PaddingTop = UDim.new(0, PADDING_Y)
    innerPad.PaddingBottom = UDim.new(0, PADDING_Y)
    innerPad.PaddingLeft = UDim.new(0, PADDING_X)
    innerPad.PaddingRight = UDim.new(0, PADDING_X)
    innerPad.Parent = container

    local rowFrame = Instance.new("Frame")
    rowFrame.Name = "Row"
    rowFrame.BackgroundTransparency = 1
    rowFrame.Size = UDim2.new(1, 0, 0, 0)
    rowFrame.AutomaticSize = Enum.AutomaticSize.Y
    rowFrame.Parent = container

    local thumbFrame = Instance.new("Frame")
    thumbFrame.Name = "Thumbnail"
    thumbFrame.Size = UDim2.fromOffset(THUMB_SIZE, THUMB_SIZE)
    thumbFrame.Position = UDim2.new(0, 0, 0, 0)
    thumbFrame.BackgroundColor3 = COLORS.ThumbBg
    thumbFrame.BorderSizePixel = 0
    thumbFrame.Visible = thumbnail ~= nil
    thumbFrame.Parent = rowFrame

    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(0, 6)
    thumbCorner.Parent = thumbFrame

    local thumbStroke = Instance.new("UIStroke")
    thumbStroke.Color = COLORS.Line
    thumbStroke.Thickness = 1
    thumbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    thumbStroke.Parent = thumbFrame

    local thumbImage = Instance.new("ImageLabel")
    thumbImage.Name = "Image"
    thumbImage.Size = UDim2.new(1, 0, 1, 0)
    thumbImage.BackgroundTransparency = 1
    thumbImage.Image = type(thumbnail) == "string" and thumbnail or ""
    thumbImage.ScaleType = Enum.ScaleType.Crop
    thumbImage.ZIndex = 2
    thumbImage.Parent = thumbFrame

    local thumbImageCorner = Instance.new("UICorner")
    thumbImageCorner.CornerRadius = UDim.new(0, 6)
    thumbImageCorner.Parent = thumbImage

    local textFrame = Instance.new("Frame")
    textFrame.Name = "TextBlock"
    textFrame.BackgroundTransparency = 1
    textFrame.Position = UDim2.new(0, 0, 0, 0)
    textFrame.Size = UDim2.new(1, 0, 0, 0)
    textFrame.AutomaticSize = Enum.AutomaticSize.Y
    textFrame.Parent = rowFrame

    local textLayout = Instance.new("UIListLayout")
    textLayout.SortOrder = Enum.SortOrder.LayoutOrder
    textLayout.Padding = UDim.new(0, 4)
    textLayout.Parent = textFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 0)
    titleLabel.AutomaticSize = Enum.AutomaticSize.Y
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = formatText(title)
    titleLabel.TextColor3 = COLORS.TextActive
    titleLabel.TextSize = TITLE_SIZE
    titleLabel.Font = fontBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Top
    titleLabel.TextWrapped = true
    titleLabel.RichText = richText
    titleLabel.LayoutOrder = 1
    titleLabel.Visible = title ~= ""
    titleLabel.Parent = textFrame

    local descLabel = Instance.new("TextLabel")
    descLabel.Name = "Description"
    descLabel.Size = UDim2.new(1, 0, 0, 0)
    descLabel.AutomaticSize = Enum.AutomaticSize.Y
    descLabel.BackgroundTransparency = 1
    descLabel.Text = formatText(description)
    descLabel.TextColor3 = COLORS.DescText
    descLabel.TextSize = DESC_SIZE
    descLabel.Font = fontRegular
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextYAlignment = Enum.TextYAlignment.Top
    descLabel.TextWrapped = true
    descLabel.LineHeight = 1.2
    descLabel.RichText = richText
    descLabel.LayoutOrder = 2
    descLabel.Visible = description ~= ""
    descLabel.Parent = textFrame

    local function layoutThumbnail(hasThumb)
        if hasThumb then
            local offset = THUMB_SIZE + THUMB_GAP
            thumbFrame.Visible = true
            textFrame.Position = UDim2.new(0, offset, 0, 0)
            textFrame.Size = UDim2.new(1, -offset, 0, 0)
        else
            thumbFrame.Visible = false
            thumbImage.Image = ""
            textFrame.Position = UDim2.new(0, 0, 0, 0)
            textFrame.Size = UDim2.new(1, 0, 0, 0)
        end
    end

    local function applyDisabled()
        titleLabel.TextColor3 = data.disabled and COLORS.TextDisabled or COLORS.TextActive
        descLabel.TextColor3 = data.disabled and COLORS.DescDisabled or COLORS.DescText
        thumbImage.ImageTransparency = data.disabled and 0.5 or 0
    end

    local function fetchUserThumb(userId)
        local ok, result = pcall(function()
            return players:GetUserThumbnailAsync(
                userId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size100x100
            )
        end)
        if ok and result then
            thumbWarned = false
            return result
        end
        if not thumbWarned then
            thumbWarned = true
            warnf("Falha ao buscar thumbnail do userId " .. tostring(userId))
        end
        return nil
    end

    local function stopLive()
        liveToken = liveToken + 1
    end

    local function startLive(userId)
        liveToken = liveToken + 1
        local myToken = liveToken
        thumbWarned = false

        task.spawn(function()
            while not destroyed and liveToken == myToken do
                local img = fetchUserThumb(userId)
                if destroyed or liveToken ~= myToken then return end
                if img and thumbImage.Image ~= img then
                    thumbImage.Image = img
                end
                task.wait(UPDATE_INTERVAL)
            end
        end)
    end

    local function setThumbnailInternal(value)
        stopLive()
        data.thumbnail = value

        if value == nil or value == "" then
            layoutThumbnail(false)
            return
        end

        layoutThumbnail(true)

        if type(value) == "number" then
            thumbImage.Image = ""
            startLive(value)
        elseif type(value) == "string" then
            thumbImage.Image = value
        else
            warnf("thumbnail deve ser string ou number (userId)")
            layoutThumbnail(false)
        end
    end

    setThumbnailInternal(thumbnail)
    applyDisabled()

    function data:SetTitle(newTitle)
        if destroyed then return end
        newTitle = tostring(newTitle or "")
        data.title = newTitle
        titleLabel.Text = formatText(newTitle)
        titleLabel.Visible = newTitle ~= ""
        container.Name = (newTitle ~= "" and newTitle or "Paragraph") .. "_Paragraph"
    end

    function data:SetDescription(newDesc)
        if destroyed then return end
        newDesc = tostring(newDesc or "")
        data.description = newDesc
        descLabel.Text = formatText(newDesc)
        descLabel.Visible = newDesc ~= ""
    end

    function data:SetThumbnail(value)
        if destroyed then return end
        setThumbnailInternal(value)
    end

    function data:SetDisabled(value)
        if destroyed then return end
        data.disabled = value == true
        applyDisabled()
    end

    function data:GetTitle()
        return data.title
    end

    function data:GetDescription()
        return data.description
    end

    function data:Destroy()
        if destroyed then return end
        destroyed = true
        stopLive()
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
    self.mainPanel.Size = UDim2.new(0, width, 0, height)
    self:_applyLayoutMode()
end

-- // Modo Layout
function Library:_applyLayoutMode()
    if not self.mainPanel then return end

    local panelSize = self.mainPanel.AbsoluteSize
    local width = panelSize.X > 0 and panelSize.X or (self.currentWidth or self.BaseWidth)
    local height = panelSize.Y > 0 and panelSize.Y or (self.currentHeight or self.BaseHeight)
    self.currentWidth = width
    self.currentHeight = height

    local tabWidth = self.IsMobile and Metrics.TabWidthMobile or Metrics.TabWidthPC
    if width < Metrics.NarrowBreakpoint then
        tabWidth = Metrics.TabWidthMobile
    end
    self.tabWidth = tabWidth
    self.compact = height < Metrics.ShortBreakpoint

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
    self.currentHeight = height

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

    table.insert(self.connections, self.mainPanel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        self:_applyLayoutMode()
    end))

    local camera = workspace.CurrentCamera
    if camera then
        table.insert(self.connections, camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            self:_applySize()
        end))
    end

    task.defer(function()
        if self.mainPanel then
            self:_applyLayoutMode()
        end
    end)

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
    tabData.sectionCount = 0
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
    page.ScrollBarThickness = 0
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ClipsDescendants = true
    page.Visible = false
    page.Parent = self.tabContent

    local pagePadding = Instance.new("UIPadding")
    pagePadding.PaddingTop = UDim.new(0, Metrics.PagePadding)
    pagePadding.PaddingLeft = UDim.new(0, Metrics.PagePadding)
    pagePadding.PaddingRight = UDim.new(0, Metrics.PagePadding)
    pagePadding.PaddingBottom = UDim.new(0, Metrics.PagePadding)
    pagePadding.Parent = page

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, Metrics.SectionGap)
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Parent = page

    -- // Ajustar Página
    local function relayout()
        local padding = window.compact and Metrics.PagePaddingShort or Metrics.PagePadding
        pagePadding.PaddingTop = UDim.new(0, padding)
        pagePadding.PaddingLeft = UDim.new(0, padding)
        pagePadding.PaddingRight = UDim.new(0, padding)
        pagePadding.PaddingBottom = UDim.new(0, padding)
    end

    tabData.relayout = relayout
    tabData.button = button
    tabData.page = page

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
    function tabData:CreateSection(sectionTitle)
        tabData.sectionCount = tabData.sectionCount + 1

        local sectionFrame = Instance.new("Frame")
        sectionFrame.Size = UDim2.new(1, 0, 0, 0)
        sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
        sectionFrame.BackgroundColor3 = Theme.HoverFill
        sectionFrame.BackgroundTransparency = 0.98
        sectionFrame.BorderSizePixel = 0
        sectionFrame.ClipsDescendants = true
        sectionFrame.LayoutOrder = tabData.sectionCount
        sectionFrame.Parent = page

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
        sectionPadding.PaddingLeft = UDim.new(0, 8)
        sectionPadding.PaddingRight = UDim.new(0, 8)
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
            holder.ClipsDescendants = true
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