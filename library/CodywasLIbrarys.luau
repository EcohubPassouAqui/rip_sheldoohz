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
    SectionGap = 10,
    ElementGap = 6,
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

function Elements.RegisterSearchEntry(labelText, frame, sectionFrame)
    table.insert(Elements._searchRegistry, {
        label = labelText:lower(),
        frame = frame,
        section = sectionFrame
    })
end


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

    self:_playIntro(width, height)
end

-- // Animação de Entrada
function Library:_playIntro(width, height)
    if not self.mainPanel then return end
    self.mainPanel.Size = UDim2.new(0, width, 0, height - 24)
    self.mainPanel.BackgroundTransparency = 1
    TweenService:Create(self.mainPanel, TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, width, 0, height),
        BackgroundTransparency = 0
    }):Play()
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
            if entry.frame then entry.frame.Visible = true end
            if entry.section then entry.section.Visible = true end
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

    local sectionHits = {}

    for _, entry in ipairs(Elements._searchRegistry) do
        local match = string.find(entry.label, query, 1, true) ~= nil
        if entry.frame then
            entry.frame.Visible = match
        end
        if entry.section then
            sectionHits[entry.section] = sectionHits[entry.section] or match
        end
    end

    for sectionFrame, hit in pairs(sectionHits) do
        sectionFrame.Visible = hit
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
        sectionPadding.PaddingLeft = UDim.new(0, 10)
        sectionPadding.PaddingRight = UDim.new(0, 10)
        sectionPadding.Parent = sectionFrame

        local sectionLayout = Instance.new("UIListLayout")
        sectionLayout.Padding = UDim.new(0, Metrics.ElementGap)
        sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        sectionLayout.Parent = sectionFrame

        local headerFrame = Instance.new("Frame")
        headerFrame.Size = UDim2.new(1, 0, 0, 18)
        headerFrame.BackgroundTransparency = 1
        headerFrame.BorderSizePixel = 0
        headerFrame.LayoutOrder = 0
        headerFrame.Parent = sectionFrame

        local headerAccent = Instance.new("Frame")
        headerAccent.Size = UDim2.new(0, 3, 0, 12)
        headerAccent.Position = UDim2.new(0, 0, 0.5, -6)
        headerAccent.BackgroundColor3 = Theme.Accent
        headerAccent.BackgroundTransparency = 0.35
        headerAccent.BorderSizePixel = 0
        headerAccent.Parent = headerFrame

        local headerAccentCorner = Instance.new("UICorner")
        headerAccentCorner.CornerRadius = UDim.new(1, 0)
        headerAccentCorner.Parent = headerAccent

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -10, 1, 0)
        titleLabel.Position = UDim2.new(0, 10, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = tostring(sectionTitle):upper()
        titleLabel.Font = FONT_BOLD
        titleLabel.TextSize = 11
        titleLabel.TextColor3 = Theme.TextHeader
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
        titleLabel.Parent = headerFrame

        local sectionData = {}
        sectionData.frame = sectionFrame
        sectionData.window = window
        sectionData.elementCount = 0

        -- // Alterar Título Section
        function sectionData:SetTitle(text)
            titleLabel.Text = tostring(text):upper()
        end

        -- // Frame Element (sem fundo)
        local function wrapElement(constructorName, opts)
            local constructor = Elements.List[constructorName]
            if not constructor then
                Notify({ Title = "Erro | Element", Description = constructorName .. " nao registrado", Duration = 5 })
                return nil
            end

            sectionData.elementCount = sectionData.elementCount + 1

            local holder = Instance.new("Frame")
            holder.Name = constructorName
            holder.Size = UDim2.new(1, 0, 0, 0)
            holder.AutomaticSize = Enum.AutomaticSize.Y
            holder.BackgroundTransparency = 1
            holder.BorderSizePixel = 0
            holder.ClipsDescendants = false
            holder.LayoutOrder = sectionData.elementCount + 1
            holder.Parent = sectionFrame

            local holderLayout = Instance.new("UIListLayout")
            holderLayout.SortOrder = Enum.SortOrder.LayoutOrder
            holderLayout.Parent = holder

            local holderSection = setmetatable({ frame = holder, window = window }, { __index = sectionData })
            local result = constructor(holderSection, opts)

            local label = (type(opts) == "table" and (opts.name or opts.title or opts.text or opts.label)) or (type(opts) == "string" and opts) or ""
            if label ~= "" then
                Elements.RegisterSearchEntry(label, holder, sectionFrame)
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