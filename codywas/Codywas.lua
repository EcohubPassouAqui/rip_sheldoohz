local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local FONT = Enum.Font.BuilderSans
local FONT_BOLD = Enum.Font.BuilderSansBold

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

local ICONS = {}
local iconsOk, iconsResult = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/src/Icons.lua"))()
end)
if iconsOk and type(iconsResult) == "table" then
    ICONS = iconsResult
end

local Window = {
    Title = "codywas",
    Subtitle = "by rip_sheldoohz",
    Width = 550,
    Height = 350
}
Window.__index = Window

function Window.new()
    local self = setmetatable({}, Window)
    self.tabs = {}
    self.sections = {}
    self.sectionCount = 0
    self.selectedTab = nil
    self.dragging = false
    self.dragOffset = Vector2.new(0, 0)
    self.connections = {}
    self.minimized = false

    self:_init()
    return self
end

function Window:_init()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    for _, child in ipairs(playerGui:GetChildren()) do
        if child.Name == self.Title or child.Name == self.Title .. "_ToggleButton" then
            child:Destroy()
        end
    end

    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = self.Title
    self.screenGui.ResetOnSpawn = false
    self.screenGui.DisplayOrder = 999
    self.screenGui.Parent = playerGui

    self.mainPanel = Instance.new("Frame")
    self.mainPanel.Name = "MainPanel"
    self.mainPanel.Size = UDim2.new(0, self.Width, 0, self.Height)
    self.mainPanel.Position = UDim2.new(0.5, -self.Width / 2, 0.5, -self.Height / 2)
    self.mainPanel.BackgroundColor3 = Theme.Panel
    self.mainPanel.BorderSizePixel = 0
    self.mainPanel.ClipsDescendants = true
    self.mainPanel.Parent = self.screenGui

    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 6)
    panelCorner.Parent = self.mainPanel

    local backgroundTexture = Instance.new("ImageLabel")
    backgroundTexture.Name = "BackgroundTexture"
    backgroundTexture.Size = UDim2.new(1, 0, 1, 0)
    backgroundTexture.BackgroundTransparency = 1
    backgroundTexture.Image = "rbxassetid://88779617285504"
    backgroundTexture.ScaleType = Enum.ScaleType.Tile
    backgroundTexture.TileSize = UDim2.new(0, 128, 0, 128)
    backgroundTexture.ImageTransparency = 0.95
    backgroundTexture.ZIndex = 0
    backgroundTexture.Parent = self.mainPanel

    self:_createTopBar()
    self:_createContent()
    self:_createToggleButton(playerGui)
    self:_setupDrag()
    self:_setupToggle()
end

function Window:_createTopBar()
    self.topBar = Instance.new("Frame")
    self.topBar.Name = "TopBar"
    self.topBar.Size = UDim2.new(1, 0, 0, 55)
    self.topBar.BackgroundTransparency = 1
    self.topBar.BorderSizePixel = 0
    self.topBar.ZIndex = 5
    self.topBar.Parent = self.mainPanel

    local topBarLine = Instance.new("Frame")
    topBarLine.Name = "Line"
    topBarLine.Size = UDim2.new(1, 0, 0, 1)
    topBarLine.Position = UDim2.new(0, 0, 1, -1)
    topBarLine.BackgroundColor3 = Theme.Line
    topBarLine.BorderSizePixel = 0
    topBarLine.Parent = self.topBar

    local textContainer = Instance.new("Frame")
    textContainer.Name = "TextContainer"
    textContainer.Size = UDim2.new(1, -220, 1, 0)
    textContainer.Position = UDim2.new(0, 18, 0, 0)
    textContainer.BackgroundTransparency = 1
    textContainer.BorderSizePixel = 0
    textContainer.Parent = self.topBar

    self.titleLabel = Instance.new("TextLabel")
    self.titleLabel.Name = "TitleLabel"
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
    self.subtitleLabel.Name = "SubtitleLabel"
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
    searchContainer.Name = "SearchContainer"
    searchContainer.Size = UDim2.new(0, 160, 0, 28)
    searchContainer.Position = UDim2.new(1, -18, 0.5, 0)
    searchContainer.AnchorPoint = Vector2.new(1, 0.5)
    searchContainer.BackgroundColor3 = Theme.HoverFill
    searchContainer.BackgroundTransparency = 0.96
    searchContainer.BorderSizePixel = 0
    searchContainer.Parent = self.topBar

    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 4)
    searchCorner.Parent = searchContainer

    local searchIcon = Instance.new("ImageLabel")
    searchIcon.Name = "SearchIcon"
    searchIcon.Size = UDim2.new(0, 12, 0, 12)
    searchIcon.Position = UDim2.new(0, 10, 0.5, 0)
    searchIcon.AnchorPoint = Vector2.new(0, 0.5)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Image = (ICONS.assets and ICONS.assets["lucide-search"]) or "rbxassetid://11419472304"
    searchIcon.ImageColor3 = Theme.TextSecondary
    searchIcon.Parent = searchContainer

    self.searchBox = Instance.new("TextBox")
    self.searchBox.Name = "SearchInput"
    self.searchBox.Size = UDim2.new(1, -34, 1, 0)
    self.searchBox.Position = UDim2.new(0, 26, 0.5, 0)
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
    self.contentFrame.Name = "ContentFrame"
    self.contentFrame.Size = UDim2.new(1, 0, 1, -55)
    self.contentFrame.Position = UDim2.new(0, 0, 0, 55)
    self.contentFrame.BackgroundTransparency = 1
    self.contentFrame.BorderSizePixel = 0
    self.contentFrame.ZIndex = 1
    self.contentFrame.Parent = self.mainPanel

    self.tabBar = Instance.new("ScrollingFrame")
    self.tabBar.Name = "TabBar"
    self.tabBar.Size = UDim2.new(0, 150, 1, 0)
    self.tabBar.BackgroundTransparency = 1
    self.tabBar.BorderSizePixel = 0
    self.tabBar.ScrollBarThickness = 0
    self.tabBar.ClipsDescendants = true
    self.tabBar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.tabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.tabBar.Parent = self.contentFrame

    local sectionLine = Instance.new("Frame")
    sectionLine.Name = "SectionLine"
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
    self.tabContent.Name = "TabContent"
    self.tabContent.Size = UDim2.new(1, -150, 1, 0)
    self.tabContent.Position = UDim2.new(0, 150, 0, 0)
    self.tabContent.BackgroundTransparency = 1
    self.tabContent.BorderSizePixel = 0
    self.tabContent.ClipsDescendants = true
    self.tabContent.Parent = self.contentFrame
end

function Window:_createToggleButton(playerGui)
    local toggleGui = Instance.new("ScreenGui")
    toggleGui.Name = self.Title .. "_ToggleButton"
    toggleGui.ResetOnSpawn = false
    toggleGui.DisplayOrder = 1000
    toggleGui.Parent = playerGui

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "OpenButton"
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
    toggleTexture.Name = "Texture"
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

    local draggingButton = false
    local isActualDrag = false
    local dragStart = Vector3.new(0,0,0)
    local startPos = UDim2.new(0,0,0,0)
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
            self.dragOffset = self.mainPanel.AbsolutePosition - UserInputService:GetMouseLocation()
        end
    end))

    table.insert(self.connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then self.dragging = false end
    end))

    table.insert(self.connections, UserInputService.InputChanged:Connect(function(input)
        if self.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            self.mainPanel.Position = UDim2.new(0, mousePos.X + self.dragOffset.X, 0, mousePos.Y + self.dragOffset.Y)
        end
    end))
end

function Window:_setupToggle()
    table.insert(self.connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.F10 then
            self.mainPanel.Visible = not self.mainPanel.Visible
        end
    end))
end

function Window:addTab(options)
    local sectionName = type(options) == "table" and options.section or nil
    local tabName = type(options) == "table" and options.tab or options
    local iconName = type(options) == "table" and options.icon or nil

    if sectionName and not self.sections[sectionName] then
        self.sectionCount = self.sectionCount + 1
        
        local headerContainer = Instance.new("Frame")
        headerContainer.Name = sectionName .. "_Header"
        headerContainer.Size = UDim2.new(1, -12, 0, 26)
        headerContainer.BackgroundTransparency = 1
        headerContainer.LayoutOrder = self.sectionCount * 1000
        headerContainer.Parent = self.tabBar

        local header = Instance.new("TextLabel")
        header.Name = "Text"
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

    local tabData = {
        name = tabName,
        section = sectionName,
        selected = false
    }

    local button = Instance.new("TextButton")
    button.Name = tabName
    button.Size = UDim2.new(1, -12, 0, 30)
    button.BackgroundTransparency = 1
    button.AutoButtonColor = false
    button.Text = ""
    button.BorderSizePixel = 0
    button.LayoutOrder = (self.sectionCount * 1000) + #self.tabs + 1
    button.Parent = self.tabBar

    local highlight = Instance.new("Frame")
    highlight.Name = "Highlight"
    highlight.Size = UDim2.new(1, 0, 1, 0)
    highlight.BackgroundColor3 = Theme.HoverFill
    highlight.BackgroundTransparency = 1
    highlight.BorderSizePixel = 0
    highlight.Parent = button

    local highlightCorner = Instance.new("UICorner")
    highlightCorner.CornerRadius = UDim.new(0, 4)
    highlightCorner.Parent = highlight

    local indicatorBar = Instance.new("Frame")
    indicatorBar.Name = "IndicatorBar"
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
            iconLabel.Name = "Icon"
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
    tabLabel.Name = "Label"
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
    page.Name = tabName .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 2
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
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

    return page
end

function Window:addSection(page, sectionName)
    local sectionFrame = Instance.new("Frame")
    sectionFrame.Name = sectionName .. "_Section"
    sectionFrame.Size = UDim2.new(1, 0, 0, 0)
    sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
    sectionFrame.BackgroundColor3 = Theme.HoverFill
    sectionFrame.BackgroundTransparency = 0.98
    sectionFrame.BorderSizePixel = 0
    sectionFrame.ClipsDescendants = false
    sectionFrame.Parent = page

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
    sectionTitle.Name = "SectionTitle"
    sectionTitle.Size = UDim2.new(1, 0, 0, 16)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = sectionName:upper()
    sectionTitle.Font = FONT_BOLD
    sectionTitle.TextSize = 11
    sectionTitle.TextColor3 = Theme.TextHeader
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.LayoutOrder = 0
    sectionTitle.Parent = sectionFrame

    return sectionFrame
end

function Window:addCheckbox(parent, options)
    local title = options.title or "Checkbox"
    local description = options.description or ""
    local callback = options.callback or function() end
    local default = options.default or false
    
    local hasKeybind = options.keybind ~= nil
    local hasColorPick = options.colorpick ~= nil

    local checkboxColor = hasColorPick and (options.colorpick.default or Theme.Accent) or Theme.Accent
    local currentBind = hasKeybind and (options.keybind.default or Enum.KeyCode.RightShift) or nil

    local checkboxData = { 
        state = default, 
        color = checkboxColor,
        key = currentBind,
        binding = false
    }

    local container = Instance.new("Frame")
    container.Name = title .. "_CheckboxContainer"
    container.Size = UDim2.new(1, 0, 0, 44)
    container.BackgroundTransparency = 1
    container.ZIndex = 2
    container.Parent = parent

    local clickArea = Instance.new("TextButton")
    clickArea.Name = "ClickArea"
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.AutoButtonColor = false
    clickArea.ZIndex = 2
    clickArea.Parent = container

    local textContainer = Instance.new("Frame")
    textContainer.Name = "TextContainer"
    textContainer.Size = UDim2.new(1, -110, 1, 0)
    textContainer.BackgroundTransparency = 1
    textContainer.ZIndex = 2
    textContainer.Parent = container

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, description ~= "" and 0.5 or 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.Font = FONT
    titleLabel.TextSize = 13
    titleLabel.TextColor3 = Theme.TextPrimary
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = description ~= "" and Enum.TextYAlignment.Bottom or Enum.TextYAlignment.Center
    titleLabel.ZIndex = 2
    titleLabel.Parent = textContainer

    if description ~= "" then
        local descLabel = Instance.new("TextLabel")
        descLabel.Name = "Description"
        descLabel.Size = UDim2.new(1, 0, 0.5, 0)
        descLabel.Position = UDim2.new(0, 0, 0.5, 0)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = description
        descLabel.Font = FONT
        descLabel.TextSize = 11
        descLabel.TextColor3 = Theme.TextSecondary
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.TextYAlignment = Enum.TextYAlignment.Top
        descLabel.ZIndex = 2
        descLabel.Parent = textContainer
    end

    local rightElements = Instance.new("Frame")
    rightElements.Name = "RightElements"
    rightElements.Size = UDim2.new(0, 130, 1, 0)
    rightElements.Position = UDim2.new(1, 0, 0, 0)
    rightElements.AnchorPoint = Vector2.new(1, 0)
    rightElements.BackgroundTransparency = 1
    rightElements.ZIndex = 3
    rightElements.Parent = container

    local elementsLayout = Instance.new("UIListLayout")
    elementsLayout.FillDirection = Enum.FillDirection.Horizontal
    elementsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    elementsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    elementsLayout.Padding = UDim.new(0, 8)
    elementsLayout.Parent = rightElements

    local box = Instance.new("Frame")
    box.Name = "Box"
    box.Size = UDim2.new(0, 18, 0, 18)
    box.BackgroundColor3 = default and checkboxData.color or Theme.Panel
    box.BorderSizePixel = 0
    box.ZIndex = 4
    box.LayoutOrder = 3
    box.Parent = rightElements

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = box

    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = default and checkboxData.color or Theme.Line
    boxStroke.Thickness = 1.2
    boxStroke.Parent = box

    local checkIcon = Instance.new("ImageLabel")
    checkIcon.Name = "CheckIcon"
    checkIcon.Size = UDim2.new(0, 12, 0, 12)
    checkIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    checkIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    checkIcon.BackgroundTransparency = 1
    checkIcon.Image = (ICONS.assets and ICONS.assets["lucide-check"]) or "rbxassetid://11419463440"
    checkIcon.ImageColor3 = Theme.Panel
    checkIcon.ImageTransparency = default and 0 or 1
    checkIcon.ZIndex = 5
    checkIcon.Parent = box

    local function updateVisuals(animate)
        local targetBg = checkboxData.state and checkboxData.color or Theme.Panel
        local targetStroke = checkboxData.state and checkboxData.color or Theme.Line
        local targetTrans = checkboxData.state and 0 or 1

        if animate then
            TweenService:Create(box, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = targetBg}):Play()
            TweenService:Create(boxStroke, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = targetStroke}):Play()
            TweenService:Create(checkIcon, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = targetTrans}):Play()
        else
            box.BackgroundColor3 = targetBg
            boxStroke.Color = targetStroke
            checkIcon.ImageTransparency = targetTrans
        end
    end

    table.insert(self.connections, clickArea.MouseButton1Click:Connect(function()
        checkboxData.state = not checkboxData.state
        updateVisuals(true)
        task.spawn(callback, checkboxData.state)
    end))

    if hasKeybind then
        local bindBtn = Instance.new("TextButton")
        bindBtn.Name = "BindButton"
        bindBtn.Size = UDim2.new(0, 44, 0, 18)
        bindBtn.BackgroundColor3 = Theme.HoverFill
        bindBtn.BackgroundTransparency = 0.96
        bindBtn.Text = currentBind.Name
        bindBtn.Font = FONT
        bindBtn.TextSize = 11
        bindBtn.TextColor3 = Theme.TextSecondary
        bindBtn.ZIndex = 4
        bindBtn.LayoutOrder = 1
        bindBtn.Parent = rightElements

        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 4)
        bCorner.Parent = bindBtn

        local bStroke = Instance.new("UIStroke")
        bStroke.Color = Theme.Line
        bStroke.Thickness = 1
        bStroke.Parent = bindBtn

        table.insert(self.connections, bindBtn.MouseButton1Click:Connect(function()
            checkboxData.binding = true
            bindBtn.Text = "..."
        end))

        table.insert(self.connections, UserInputService.InputBegan:Connect(function(input, processed)
            if processed then return end
            if checkboxData.binding and input.UserInputType == Enum.UserInputType.Keyboard then
                checkboxData.key = input.KeyCode
                bindBtn.Text = input.KeyCode.Name
                checkboxData.binding = false
                if options.keybind.callback then task.spawn(options.keybind.callback, input.KeyCode) end
            end
        end))
    end

    if hasColorPick then
        local cpBox = Instance.new("TextButton")
        cpBox.Name = "ColorButton"
        cpBox.Size = UDim2.new(0, 22, 0, 14)
        cpBox.BackgroundColor3 = checkboxData.color
        cpBox.Text = ""
        cpBox.ZIndex = 4
        cpBox.LayoutOrder = 2
        cpBox.Parent = rightElements

        local cpCorner = Instance.new("UICorner")
        cpCorner.CornerRadius = UDim.new(0, 3)
        cpCorner.Parent = cpBox

        local cpStroke = Instance.new("UIStroke")
        cpStroke.Color = Theme.Line
        cpStroke.Thickness = 1
        cpStroke.Parent = cpBox

        local palette = Instance.new("Frame")
        palette.Name = "Palette"
        palette.Size = UDim2.new(0, 162, 0, 0)
        palette.Position = UDim2.new(1, 0, 1, 4)
        palette.AnchorPoint = Vector2.new(1, 0)
        palette.BackgroundColor3 = Theme.Panel
        palette.Visible = false
        palette.ZIndex = 50
        palette.Parent = cpBox

        local pCorner = Instance.new("UICorner")
        pCorner.CornerRadius = UDim.new(0, 6)
        pCorner.Parent = palette

        local pStroke = Instance.new("UIStroke")
        pStroke.Color = Theme.Line
        pStroke.Thickness = 1
        pStroke.Parent = palette

        local H, S, V = Color3.toHSV(checkboxData.color)
        
        local satMap = Instance.new("ImageLabel")
        satMap.Name = "SatMap"
        satMap.Size = UDim2.new(0, 130, 0, 90)
        satMap.Position = UDim2.new(0, 6, 0, 6)
        satMap.Image = "rbxassetid://4155801252"
        satMap.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
        satMap.ZIndex = 51
        satMap.Parent = palette

        local smCorner = Instance.new("UICorner")
        smCorner.CornerRadius = UDim.new(0, 4)
        smCorner.Parent = satMap

        local cursor = Instance.new("ImageLabel")
        cursor.Name = "Cursor"
        cursor.Size = UDim2.new(0, 8, 0, 8)
        cursor.AnchorPoint = Vector2.new(0.5, 0.5)
        cursor.BackgroundTransparency = 1
        cursor.Image = "http://www.roblox.com/asset/?id=4805639000"
        cursor.Position = UDim2.new(S, 0, 1 - V, 0)
        cursor.ZIndex = 52
        cursor.Parent = satMap

        local hueBar = Instance.new("Frame")
        hueBar.Name = "HueBar"
        hueBar.Size = UDim2.new(0, 14, 0, 90)
        hueBar.Position = UDim2.new(0, 142, 0, 6)
        hueBar.ZIndex = 51
        hueBar.Parent = palette

        local hbCorner = Instance.new("UICorner")
        hbCorner.CornerRadius = UDim.new(0, 4)
        hbCorner.Parent = hueBar

        local hueGrad = Instance.new("UIGradient")
        hueGrad.Rotation = 90
        local pts = {}
        for i = 0, 1, 0.1 do table.insert(pts, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1))) end
        hueGrad.Color = ColorSequence.new(pts)
        hueGrad.Parent = hueBar

        local hueDrag = Instance.new("Frame")
        hueDrag.Name = "Drag"
        hueDrag.Size = UDim2.new(1, 4, 0, 3)
        hueDrag.Position = UDim2.new(0, -2, H, 0)
        hueDrag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        hueDrag.BorderSizePixel = 0
        hueDrag.ZIndex = 52
        hueDrag.Parent = hueBar

        local function updateColor()
            local cColor = Color3.fromHSV(H, S, V)
            checkboxData.color = cColor
            if cpBox and cpBox:IsA("GuiObject") then
                cpBox.BackgroundColor3 = cColor
            end
            satMap.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
            cursor.Position = UDim2.new(S, 0, 1 - V, 0)
            hueDrag.Position = UDim2.new(0, -2, H, 0)
            
            updateVisuals(false)
            if options.colorpick.callback then task.spawn(options.colorpick.callback, cColor) end
        end

        table.insert(self.connections, satMap.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                local conn
                conn = RunService.RenderStepped:Connect(function()
                    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                        local mLoc = UserInputService:GetMouseLocation()
                        S = math.clamp((mLoc.X - satMap.AbsolutePosition.X) / satMap.AbsoluteSize.X, 0, 1)
                        V = math.clamp(1 - ((mLoc.Y - 36 - satMap.AbsolutePosition.Y) / satMap.AbsoluteSize.Y), 0, 1)
                        updateColor()
                    else
                        conn:Disconnect()
                    end
                end)
            end
        end))

        table.insert(self.connections, hueBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                local conn
                conn = RunService.RenderStepped:Connect(function()
                    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                        local mLoc = UserInputService:GetMouseLocation()
                        H = math.clamp((mLoc.Y - 36 - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
                        updateColor()
                    else
                        conn:Disconnect()
                    end
                end)
            end
        end))

        local cpOpen = false
        table.insert(self.connections, cpBox.MouseButton1Click:Connect(function()
            cpOpen = not cpOpen
            if cpOpen then
                container.ZIndex = 20
                palette.Visible = true
                TweenService:Create(palette, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 162, 0, 102)}):Play()
            else
                TweenService:Create(palette, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 162, 0, 0)}):Play()
                task.delay(0.15, function()
                    if not cpOpen then 
                        container.ZIndex = 2 
                        palette.Visible = false 
                    end
                end)
            end
        end))

        checkboxData.colorButtonInstance = cpBox
    end

    function checkboxData:Set(value)
        checkboxData.state = value
        updateVisuals(true)
        task.spawn(callback, checkboxData.state)
    end

    function checkboxData:SetColor(newColor)
        checkboxData.color = newColor
        if checkboxData.colorButtonInstance and checkboxData.colorButtonInstance:IsA("GuiObject") then
            checkboxData.colorButtonInstance.BackgroundColor3 = newColor
        end
        updateVisuals(true)
    end

    return checkboxData
end

function Window:addSlider(parent, options)
    local title = options.title or "Slider"
    local description = options.description or ""
    local min = options.min or 0
    local max = options.max or 100
    local default = options.default or min
    local callback = options.callback or function() end

    local sliderData = { value = default }
    local dragging = false

    local container = Instance.new("Frame")
    container.Name = title .. "_Slider"
    container.Size = UDim2.new(1, 0, 0, description ~= "" and 58 or 50)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local textContainer = Instance.new("Frame")
    textContainer.Name = "TextContainer"
    textContainer.Size = UDim2.new(1, 0, 0, description ~= "" and 32 or 22)
    textContainer.Position = UDim2.new(0, 0, 0, 2)
    textContainer.BackgroundTransparency = 1
    textContainer.Parent = container

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -60, description ~= "" and 0.5 or 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.Font = FONT
    titleLabel.TextSize = 13
    titleLabel.TextColor3 = Theme.TextPrimary
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = textContainer

    if description ~= "" then
        local descLabel = Instance.new("TextLabel")
        descLabel.Name = "Description"
        descLabel.Size = UDim2.new(1, -60, 0.5, 0)
        descLabel.Position = UDim2.new(0, 0, 0.5, 0)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = description
        descLabel.Font = FONT
        descLabel.TextSize = 11
        descLabel.TextColor3 = Theme.TextSecondary
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Parent = textContainer
    end

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(0, 50, 1, 0)
    valueLabel.Position = UDim2.new(1, 0, 0, 0)
    valueLabel.AnchorPoint = Vector2.new(1, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.Font = FONT_BOLD
    valueLabel.TextSize = 13
    valueLabel.TextColor3 = Theme.TextPrimary
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.TextYAlignment = Enum.TextYAlignment.Center
    valueLabel.Parent = textContainer

    local sliderBar = Instance.new("TextButton")
    sliderBar.Name = "SliderBar"
    sliderBar.Size = UDim2.new(1, 0, 0, 10)
    sliderBar.Position = UDim2.new(0, 0, 1, -12)
    sliderBar.BackgroundColor3 = Theme.Line
    sliderBar.BorderSizePixel = 0
    sliderBar.Text = ""
    sliderBar.AutoButtonColor = false
    sliderBar.Parent = container

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = sliderBar

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = sliderBar

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.BackgroundColor3 = Theme.Accent
    knob.BorderSizePixel = 0
    knob.Parent = sliderBar

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local function updateSlider(inputPosition)
        local percentage = math.clamp((inputPosition.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local finalValue = math.round(min + percentage * (max - min))
        
        sliderData.value = finalValue
        valueLabel.Text = tostring(finalValue)
        
        local visualPercent = (finalValue - min) / (max - min)
        TweenService:Create(fill, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(visualPercent, 0, 1, 0)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(visualPercent, 0, 0.5, 0)}):Play()
        
        task.spawn(callback, finalValue)
    end

    table.insert(self.connections, sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input.Position)
        end
    end))

    table.insert(self.connections, UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input.Position)
        end
    end))

    table.insert(self.connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end))

    function sliderData:Set(value)
        local finalValue = math.clamp(value, min, max)
        sliderData.value = finalValue
        valueLabel.Text = tostring(finalValue)
        local visualPercent = (finalValue - min) / (max - min)
        TweenService:Create(fill, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(visualPercent, 0, 1, 0)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(visualPercent, 0, 0.5, 0)}):Play()
        task.spawn(callback, finalValue)
    end

    return sliderData
end

function Window:addDropdown(parent, options)
    local title = options.title or "Dropdown"
    local list = options.list or {}
    local default = options.default or ""
    local callback = options.callback or function() end

    local dropdownData = { value = default, open = false, options = list }

    local container = Instance.new("Frame")
    container.Name = title .. "_Dropdown"
    container.Size = UDim2.new(1, 0, 0, 44)
    container.BackgroundTransparency = 1
    container.ZIndex = 1
    container.Parent = parent

    local header = Instance.new("TextButton")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 44)
    header.BackgroundTransparency = 1
    header.Text = ""
    header.AutoButtonColor = false
    header.Parent = container

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.Font = FONT
    titleLabel.TextSize = 13
    titleLabel.TextColor3 = Theme.TextPrimary
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header

    local selectedBox = Instance.new("Frame")
    selectedBox.Name = "SelectedBox"
    selectedBox.Size = UDim2.new(0.5, 0, 0, 28)
    selectedBox.Position = UDim2.new(1, 0, 0.5, 0)
    selectedBox.AnchorPoint = Vector2.new(1, 0.5)
    selectedBox.BackgroundColor3 = Theme.HoverFill
    selectedBox.BackgroundTransparency = 0.96
    selectedBox.BorderSizePixel = 0
    selectedBox.Parent = header

    local selectedCorner = Instance.new("UICorner")
    selectedCorner.CornerRadius = UDim.new(0, 4)
    selectedCorner.Parent = selectedBox

    local selectedStroke = Instance.new("UIStroke")
    selectedStroke.Color = Theme.Line
    selectedStroke.Thickness = 1
    selectedStroke.Parent = selectedBox

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(1, -26, 1, 0)
    valueLabel.Position = UDim2.new(0, 8, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = default ~= "" and default or "Selecionar..."
    valueLabel.Font = FONT
    valueLabel.TextSize = 12
    valueLabel.TextColor3 = default ~= "" and Theme.TextPrimary or Theme.TextSecondary
    valueLabel.TextXAlignment = Enum.TextXAlignment.Left
    valueLabel.Parent = selectedBox

    local arrowIcon = Instance.new("ImageLabel")
    arrowIcon.Name = "Arrow"
    arrowIcon.Size = UDim2.new(0, 12, 0, 12)
    arrowIcon.Position = UDim2.new(1, -8, 0.5, 0)
    arrowIcon.AnchorPoint = Vector2.new(1, 0.5)
    arrowIcon.BackgroundTransparency = 1
    arrowIcon.Image = (ICONS.assets and ICONS.assets["lucide-chevron-down"]) or "rbxassetid://11419461271"
    arrowIcon.ImageColor3 = Theme.TextSecondary
    arrowIcon.Parent = selectedBox

    local optionListFrame = Instance.new("ScrollingFrame")
    optionListFrame.Name = "OptionsList"
    optionListFrame.Size = UDim2.new(0.5, 0, 0, 0)
    optionListFrame.Position = UDim2.new(1, 0, 0, 40)
    optionListFrame.AnchorPoint = Vector2.new(1, 0)
    optionListFrame.BackgroundColor3 = Theme.Panel
    optionListFrame.BorderSizePixel = 0
    optionListFrame.ScrollBarThickness = 2
    optionListFrame.Visible = false
    optionListFrame.ZIndex = 100
    optionListFrame.Parent = container

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 4)
    listCorner.Parent = optionListFrame

    local listStroke = Instance.new("UIStroke")
    listStroke.Color = Theme.Line
    listStroke.Thickness = 1
    listStroke.Parent = optionListFrame

    local optionListLayout = Instance.new("UIListLayout")
    optionListLayout.Padding = UDim.new(0, 2)
    optionListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    optionListLayout.Parent = optionListFrame

    local optionListPadding = Instance.new("UIPadding")
    optionListPadding.PaddingTop = UDim.new(0, 4)
    optionListPadding.PaddingBottom = UDim.new(0, 4)
    optionListPadding.PaddingLeft = UDim.new(0, 4)
    optionListPadding.PaddingRight = UDim.new(0, 4)
    optionListPadding.Parent = optionListFrame

    local function refreshOptions()
        for _, child in ipairs(optionListFrame:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        for i, optionName in ipairs(dropdownData.options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Name = optionName
            optBtn.Size = UDim2.new(1, 0, 0, 26)
            optBtn.BackgroundColor3 = Theme.HoverFill
            optBtn.BackgroundTransparency = 1
            optBtn.BorderSizePixel = 0
            optBtn.Text = ""
            optBtn.ZIndex = 101
            optBtn.AutoButtonColor = false
            optBtn.Parent = optionListFrame

            local optCorner = Instance.new("UICorner")
            optCorner.CornerRadius = UDim.new(0, 4)
            optCorner.Parent = optBtn

            local optLabel = Instance.new("TextLabel")
            optLabel.Name = "Label"
            optLabel.Size = UDim2.new(1, -16, 1, 0)
            optLabel.Position = UDim2.new(0, 8, 0, 0)
            optLabel.BackgroundTransparency = 1
            optLabel.Text = optionName
            optLabel.Font = FONT
            optLabel.TextSize = 12
            optLabel.ZIndex = 102
            optLabel.TextColor3 = optionName == dropdownData.value and Theme.TextPrimary or Theme.TextSecondary
            optLabel.TextXAlignment = Enum.TextXAlignment.Left
            optLabel.Parent = optBtn

            table.insert(self.connections, optBtn.MouseEnter:Connect(function()
                TweenService:Create(optBtn, TweenInfo.new(0.1), {BackgroundTransparency = 0.96}):Play()
            end))

            table.insert(self.connections, optBtn.MouseLeave:Connect(function()
                TweenService:Create(optBtn, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
            end))

            table.insert(self.connections, optBtn.MouseButton1Click:Connect(function()
                dropdownData.value = optionName
                valueLabel.Text = optionName
                valueLabel.TextColor3 = Theme.TextPrimary
                
                dropdownData.open = false
                container.ZIndex = 1
                
                TweenService:Create(optionListFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0.5, 0, 0, 0)}):Play()
                TweenService:Create(arrowIcon, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                
                task.delay(0.15, function()
                    if not dropdownData.open then optionListFrame.Visible = false end
                end)
                
                refreshOptions()
                task.spawn(callback, optionName)
            end))
        end
    end

    table.insert(self.connections, header.MouseButton1Click:Connect(function()
        dropdownData.open = not dropdownData.open
        
        if dropdownData.open then
            container.ZIndex = 30
            optionListFrame.Visible = true
            local listSize = optionListLayout.AbsoluteContentSize.Y + 8
            
            TweenService:Create(optionListFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0.5, 0, 0, math.min(listSize, 130))}):Play()
            TweenService:Create(arrowIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 180}):Play()
        else
            TweenService:Create(optionListFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0.5, 0, 0, 0)}):Play()
            TweenService:Create(arrowIcon, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
            
            task.delay(0.15, function()
                if not dropdownData.open then 
                    container.ZIndex = 1 
                    optionListFrame.Visible = false 
                end
            end)
        end
    end))

    refreshOptions()

    function dropdownData:Set(value)
        dropdownData.value = value
        valueLabel.Text = value ~= "" and value or "Selecionar..."
        valueLabel.TextColor3 = value ~= "" and Theme.TextPrimary or Theme.TextSecondary
        refreshOptions()
        task.spawn(callback, value)
    end

    return dropdownData
end

function Window:addButton(parent, options)
    local title = options.title or "Button"
    local callback = options.callback or function() end

    local btnData = {}

    local button = Instance.new("TextButton")
    button.Name = title .. "_Button"
    button.Size = UDim2.new(1, 0, 0, 34)
    button.BackgroundColor3 = Theme.HoverFill
    button.BackgroundTransparency = 0.96
    button.AutoButtonColor = false
    button.Text = ""
    button.Parent = parent

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 4)
    bCorner.Parent = button

    local bStroke = Instance.new("UIStroke")
    bStroke.Color = Theme.Line
    bStroke.Thickness = 1
    bStroke.Parent = button

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.Font = FONT
    label.TextSize = 13
    label.TextColor3 = Theme.TextPrimary
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Parent = button

    table.insert(self.connections, button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundTransparency = 0.92}):Play()
    end))

    table.insert(self.connections, button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundTransparency = 0.96}):Play()
    end))

    table.insert(self.connections, button.MouseButton1Click:Connect(function()
        button.BackgroundTransparency = 0.88
        task.delay(0.05, function() button.BackgroundTransparency = 0.92 end)
        task.spawn(callback)
    end))

    function btnData:SetText(text)
        label.Text = text
    end

    return btnData
end

function Window:addLabel(parent, text)
    local labelData = {}

    local label = Instance.new("TextLabel")
    label.Name = "LabelElement"
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = FONT
    label.TextSize = 13
    label.TextColor3 = Theme.TextPrimary
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    function labelData:SetText(newText)
        label.Text = newText
    end

    function labelData:SetColor(color)
        label.TextColor3 = color
    end

    return labelData
end

function Window:addParagraph(parent, options)
    local title = options.title or "Informação"
    local content = options.content or ""
    local paraData = {}

    local container = Instance.new("Frame")
    container.Name = "ParagraphElement"
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.Parent = parent

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 2)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = container

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 16)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.Font = FONT_BOLD
    titleLabel.TextSize = 12
    titleLabel.TextColor3 = Theme.TextHeader
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.LayoutOrder = 1
    titleLabel.Parent = container

    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "Content"
    contentLabel.Size = UDim2.new(1, 0, 0, 0)
    contentLabel.AutomaticSize = Enum.AutomaticSize.Y
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = content
    contentLabel.Font = FONT
    contentLabel.TextSize = 12
    contentLabel.TextColor3 = Theme.TextSecondary
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextWrapped = true
    contentLabel.LayoutOrder = 2
    contentLabel.Parent = container

    function paraData:SetTitle(newTitle)
        titleLabel.Text = newTitle
    end

    function paraData:SetContent(newContent)
        contentLabel.Text = newContent
    end

    return paraData
end

function Window:addKeybind(parent, options)
    local title = options.title or "Keybind"
    local default = options.default or Enum.KeyCode.RightShift
    local callback = options.callback or function() end

    local bindData = { key = default, binding = false }

    local container = Instance.new("Frame")
    container.Name = title .. "_Keybind"
    container.Size = UDim2.new(1, 0, 0, 36)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -60, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.Font = FONT
    label.TextSize = 13
    label.TextColor3 = Theme.TextPrimary
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local bindBtn = Instance.new("TextButton")
    bindBtn.Name = "Button"
    bindBtn.Size = UDim2.new(0, 60, 0, 24)
    bindBtn.Position = UDim2.new(1, 0, 0.5, 0)
    bindBtn.AnchorPoint = Vector2.new(1, 0.5)
    bindBtn.BackgroundColor3 = Theme.HoverFill
    bindBtn.BackgroundTransparency = 0.96
    bindBtn.Text = default.Name
    bindBtn.Font = FONT
    bindBtn.TextSize = 11
    bindBtn.TextColor3 = Theme.TextSecondary
    bindBtn.Parent = container

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 4)
    bCorner.Parent = bindBtn

    local bStroke = Instance.new("UIStroke")
    bStroke.Color = Theme.Line
    bStroke.Thickness = 1
    bStroke.Parent = bindBtn

    table.insert(self.connections, bindBtn.MouseButton1Click:Connect(function()
        bindData.binding = true
        bindBtn.Text = "..."
    end))

    table.insert(self.connections, UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if bindData.binding and input.UserInputType == Enum.UserInputType.Keyboard then
            bindData.key = input.KeyCode
            bindBtn.Text = input.KeyCode.Name
            bindData.binding = false
            task.spawn(callback, input.KeyCode)
        end
    end))

    function bindData:Set(newKey)
        bindData.key = newKey
        bindBtn.Text = newKey.Name
        task.spawn(callback, newKey)
    end

    return bindData
end

function Window:Destroy()
    for _, connection in ipairs(self.connections) do connection:Disconnect() end
    if self.screenGui then self.screenGui:Destroy() end
end

return Window