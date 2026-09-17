-- // Serviço
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- // Fontes
local FONT = Enum.Font.BuilderSans
local FONT_BOLD = Enum.Font.BuilderSansBold

-- // Theme
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

-- // Icons
local ICONS = { assets = {} }
pcall(function()
    local result = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/assets/fonts/Icons.luau"))()
    if type(result) == "table" then ICONS = result end
end)

-- // Notify
local CodywasNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/library/notifications/CodywasNotif.luau"))()
local Notify = CodywasNotif.Notify

-- // Shield
local Shield = {}

function Shield:RandomName()
    local chars = "abcdefghijklmnopqrstuvwxyz"
    local name = ""
    for _ = 1, math.random(8, 14) do
        local i = math.random(1, #chars)
        name = name .. chars:sub(i, i)
    end
    return name
end

function Shield:GetContainer()
    if gethui then return gethui() end
    return Players.LocalPlayer:WaitForChild("PlayerGui")
end

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

function Shield:Init()
    local ok, err = pcall(function() Shield:HookDetections() end)
    if not ok then
        Notify({ Title = "CodyWas | Erro", Description = tostring(err), Duration = 6 })
        return
    end
end

-- // Elements
local Elements = {}
Elements.List = {}

function Elements.Register(name, constructor)
    Elements.List[name] = constructor
end

-- // Window
local Window = {}
Window.__index = Window

function Window.new(title, subtitle)
    local self = setmetatable({}, Window)
    self.Title = title or "UILib"
    self.Subtitle = subtitle or "by rip_sheldoohz"
    self.Width = 550
    self.Height = 350
    self.tabs = {}
    self.sections = {}
    self.sectionCount = 0
    self.selectedTab = nil
    self.dragging = false
    self.dragOffset = Vector2.new(0, 0)
    self.connections = {}

    local ok, err = pcall(function()
        Shield:Init()
        self:_init()
    end)

    if not ok then
        Notify({ Title = "Erro | Window", Description = tostring(err), Duration = 6 })
    end

    return self
end

function Window:_init()
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

    self.mainPanel = Instance.new("Frame")
    self.mainPanel.Name = Shield:RandomName()
    self.mainPanel.AnchorPoint = Vector2.new(0.5, 0.5)
    self.mainPanel.Size = UDim2.new(0, self.Width, 0, self.Height)
    self.mainPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.mainPanel.BackgroundColor3 = Theme.Panel
    self.mainPanel.BorderSizePixel = 0
    self.mainPanel.ClipsDescendants = true
    self.mainPanel.Parent = self.screenGui
    Shield:HideObject(self.mainPanel)

    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 6)
    panelCorner.Parent = self.mainPanel

    self:_createTopBar()
    self:_createContent()
    self:_createToggleButton()
    self:_setupDrag()
end

function Window:_createTopBar()
    self.topBar = Instance.new("Frame")
    self.topBar.Name = Shield:RandomName()
    self.topBar.Size = UDim2.new(1, 0, 0, 55)
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

    local textContainer = Instance.new("Frame")
    textContainer.Size = UDim2.new(1, -220, 1, 0)
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
    self.titleLabel.Parent = textContainer

    self.subtitleLabel = Instance.new("TextLabel")
    self.subtitleLabel.Size = UDim2.new(1, 0, 0, 14)
    self.subtitleLabel.Position = UDim2.new(0, 0, 0, 29)
    self.subtitleLabel.BackgroundTransparency = 1
    self.subtitleLabel.TextColor3 = Theme.TextSecondary
    self.subtitleLabel.TextSize = 11
    self.subtitleLabel.Font = FONT
    self.subtitleLabel.Text = self.Subtitle
    self.subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.subtitleLabel.Parent = textContainer

    local searchContainer = Instance.new("Frame")
    searchContainer.Size = UDim2.new(0, 160, 0, 28)
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
    searchIcon.Image = ICONS.assets and ICONS.assets["lucide-search"] or "rbxassetid://11419472304"
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

    table.insert(self.connections, self.searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        self:_filterTabs(self.searchBox.Text)
    end))
end

function Window:_filterTabs(query)
    query = query:lower()
    local sectionHasVisible = {}
    local firstVisibleTab = nil

    for _, tab in ipairs(self.tabs) do
        local visible = query == "" or string.find(tab.name:lower(), query, 1, true) ~= nil
        tab.button.Visible = visible
        if visible then
            if not firstVisibleTab then firstVisibleTab = tab end
            if tab.section then sectionHasVisible[tab.section] = true end
        else
            tab.page.Visible = false
        end
    end

    for sectionName, header in pairs(self.sections) do
        header.Visible = sectionHasVisible[sectionName] == true
    end

    if firstVisibleTab then
        if self.selectedTab and not firstVisibleTab.button.Visible then
            self.selectedTab.updateVisuals(false)
            self.selectedTab = firstVisibleTab
            self.selectedTab.updateVisuals(true)
        elseif self.selectedTab and self.selectedTab.button.Visible then
            self.selectedTab.page.Visible = true
        end
    end
end

function Window:_createContent()
    self.contentFrame = Instance.new("Frame")
    self.contentFrame.Size = UDim2.new(1, 0, 1, -55)
    self.contentFrame.Position = UDim2.new(0, 0, 0, 55)
    self.contentFrame.BackgroundTransparency = 1
    self.contentFrame.BorderSizePixel = 0
    self.contentFrame.ZIndex = 1
    self.contentFrame.Parent = self.mainPanel

    self.tabBar = Instance.new("ScrollingFrame")
    self.tabBar.Size = UDim2.new(0, 150, 1, 0)
    self.tabBar.BackgroundTransparency = 1
    self.tabBar.BorderSizePixel = 0
    self.tabBar.ScrollBarThickness = 0
    self.tabBar.ClipsDescendants = true
    self.tabBar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.tabBar.Parent = self.contentFrame

    local sectionLine = Instance.new("Frame")
    sectionLine.Size = UDim2.new(0, 1, 1, 0)
    sectionLine.Position = UDim2.new(0, 149, 0, 0)
    sectionLine.BackgroundColor3 = Theme.Line
    sectionLine.BorderSizePixel = 0
    sectionLine.ZIndex = 2
    sectionLine.Parent = self.contentFrame

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
    self.tabContent.Size = UDim2.new(1, -150, 1, 0)
    self.tabContent.Position = UDim2.new(0, 150, 0, 0)
    self.tabContent.BackgroundTransparency = 1
    self.tabContent.BorderSizePixel = 0
    self.tabContent.ClipsDescendants = true
    self.tabContent.Parent = self.contentFrame
end

function Window:_createToggleButton()
    local toggleGui = Instance.new("ScreenGui")
    toggleGui.Name = "codywas_toggle"
    toggleGui.ResetOnSpawn = false
    toggleGui.DisplayOrder = 1000
    Shield:PlaceGui(toggleGui)
    Shield:HideObject(toggleGui)

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
    toggleIcon.Image = ICONS.assets and ICONS.assets["lucide-panel-left"] or "rbxassetid://11419472304"
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
                self.mainPanel.Visible = not self.mainPanel.Visible
            end
            draggingButton = false
            isActualDrag = false
        end
    end))
end

function Window:_setupDrag()
    table.insert(self.connections, self.topBar.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.dragging = true
            local center = self.mainPanel.AbsolutePosition + self.mainPanel.AbsoluteSize / 2
            self.dragOffset = center - UserInputService:GetMouseLocation()
        end
    end))

    table.insert(self.connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.dragging = false
        end
    end))

    table.insert(self.connections, UserInputService.InputChanged:Connect(function(input)
        if self.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            self.mainPanel.Position = UDim2.new(0, mousePos.X + self.dragOffset.X, 0, mousePos.Y + self.dragOffset.Y)
        end
    end))
end

function Window:CreateTab(options)
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
    tabLabel.Parent = button

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 2
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ClipsDescendants = true
    page.Visible = false
    page.Parent = self.tabContent

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Parent = page

    local pagePadding = Instance.new("UIPadding")
    pagePadding.PaddingTop = UDim.new(0, 12)
    pagePadding.PaddingLeft = UDim.new(0, 12)
    pagePadding.PaddingRight = UDim.new(0, 12)
    pagePadding.PaddingBottom = UDim.new(0, 12)
    pagePadding.Parent = page

    tabData.button = button
    tabData.page = page
    tabData.pageLayout = pageLayout

    local function updateTabVisuals(isSelected)
        tabData.selected = isSelected
        page.Visible = isSelected and button.Visible
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
    end

    table.insert(self.connections, button.MouseEnter:Connect(function()
        if not tabData.selected then
            TweenService:Create(highlight, TweenInfo.new(0.1), {BackgroundTransparency = 0.97}):Play()
        end
    end))

    table.insert(self.connections, button.MouseLeave:Connect(function()
        if not tabData.selected then
            TweenService:Create(highlight, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
        end
    end))

    table.insert(self.connections, button.MouseButton1Click:Connect(function()
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

    function tabData:CreateSection(sectionName)
        local sectionFrame = Instance.new("Frame")
        sectionFrame.Size = UDim2.new(1, 0, 0, 0)
        sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
        sectionFrame.BackgroundColor3 = Theme.HoverFill
        sectionFrame.BackgroundTransparency = 0.98
        sectionFrame.BorderSizePixel = 0
        sectionFrame.ClipsDescendants = false
        sectionFrame.Parent = tabData.page

        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 6)
        sectionCorner.Parent = sectionFrame

        local sectionStroke = Instance.new("UIStroke")
        sectionStroke.Color = Theme.Line
        sectionStroke.Thickness = 1
        sectionStroke.Parent = sectionFrame

        local sectionLayout = Instance.new("UIListLayout")
        sectionLayout.Padding = UDim.new(0, 6)
        sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        sectionLayout.Parent = sectionFrame

        local sectionPadding = Instance.new("UIPadding")
        sectionPadding.PaddingTop = UDim.new(0, 10)
        sectionPadding.PaddingBottom = UDim.new(0, 10)
        sectionPadding.PaddingLeft = UDim.new(0, 12)
        sectionPadding.PaddingRight = UDim.new(0, 12)
        sectionPadding.Parent = sectionFrame

        local sectionTitle = Instance.new("TextLabel")
        sectionTitle.Size = UDim2.new(1, 0, 0, 16)
        sectionTitle.BackgroundTransparency = 1
        sectionTitle.Text = sectionName:upper()
        sectionTitle.Font = FONT_BOLD
        sectionTitle.TextSize = 11
        sectionTitle.TextColor3 = Theme.TextHeader
        sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionTitle.LayoutOrder = 0
        sectionTitle.Parent = sectionFrame

        local sectionData = {}
        sectionData.frame = sectionFrame
        sectionData.window = window

        function sectionData:CreateToggle(opts)
            return Elements.List["Checkbox"](self, opts)
        end
        function sectionData:CreateButton(opts)
            return Elements.List["Button"](self, opts)
        end
        function sectionData:CreateSlider(opts)
            return Elements.List["Slider"](self, opts)
        end
        function sectionData:CreateDropdown(opts)
            return Elements.List["Dropdown"](self, opts)
        end
        function sectionData:CreateColorPicker(opts)
            return Elements.List["ColorPicker"](self, opts)
        end

        return sectionData
    end

    return tabData
end

function Window:Destroy()
    for _, connection in ipairs(self.connections) do
        pcall(function() connection:Disconnect() end)
    end
    if self.screenGui then self.screenGui:Destroy() end
end

Window.Shield = Shield
Window.Notify = Notify
Window.ICONS = ICONS
Window.Elements = Elements
Window.Theme = Theme

return Window