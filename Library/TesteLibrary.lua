-- Akiri UI Library v2.1 - FIXED
-- Corrigido: AddToggle, AddButton e outros métodos

local StartTime = tick()

-- Verificação de ambiente
if not Drawing then
    warn("Drawing API não encontrada! Use um executor compatível.")
    return
end

-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AkiriUI_" .. HttpService:GenerateGUID(false)
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Protection
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

-- Library
local Library = {
    Version = "2.1",
    Theme = {
        Accent = Color3.fromHex("#c37be5"),
        Outline = Color3.fromHex("#000005"),
        Inline = Color3.fromHex("#3c3c3c"),
        LightContrast = Color3.fromHex("#231946"),
        DarkContrast = Color3.fromHex("#191432"),
        Text = Color3.fromHex("#c8c8ff"),
        TextInactive = Color3.fromHex("#afafaf"),
        Font = Drawing.Fonts.Plex,
        TextSize = 13,
    },
    Flags = {},
    Items = {},
    Drawings = {},
    Connections = {},
    Windows = {},
    IsVisible = true,
}

-- Utility
local Utility = {}

function Utility.Create(class, properties)
    local success, obj = pcall(function()
        return Drawing.new(class)
    end)
    
    if not success then
        warn("Erro ao criar Drawing:", class)
        return nil
    end
    
    for prop, value in pairs(properties) do
        pcall(function()
            if class == "Text" and prop == "Font" then
                obj.Font = Library.Theme.Font
            elseif class == "Text" and prop == "Size" then
                obj.Size = Library.Theme.TextSize
            else
                obj[prop] = value
            end
        end)
    end
    
    obj.ZIndex = properties.ZIndex and properties.ZIndex + 20 or 20
    table.insert(Library.Drawings, obj)
    return obj
end

function Utility.Remove(drawing)
    for i, v in ipairs(Library.Drawings) do
        if v == drawing then
            pcall(function() v:Remove() end)
            table.remove(Library.Drawings, i)
            break
        end
    end
end

function Utility.Connect(signal, callback)
    local success, connection = pcall(function()
        return signal:Connect(callback)
    end)
    if success then
        table.insert(Library.Connections, connection)
        return connection
    end
end

function Utility.IsMouseOver(drawing)
    if not drawing or not drawing.Visible then return false end
    local success, result = pcall(function()
        local mousePos = UserInputService:GetMouseLocation()
        local pos = drawing.Position
        local size = drawing.Size
        return mousePos.X >= pos.X and mousePos.X <= pos.X + size.X and
               mousePos.Y >= pos.Y and mousePos.Y <= pos.Y + size.Y
    end)
    return success and result or false
end

function Utility.CenterPosition(size)
    return Vector2.new(
        (Camera.ViewportSize.X - size.X) / 2,
        (Camera.ViewportSize.Y - size.Y) / 2
    )
end

function Utility.MakeDraggable(trigger, objects)
    local dragging = false
    local dragStart, startPositions = nil, {}
    
    Utility.Connect(UserInputService.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and Utility.IsMouseOver(trigger) then
            dragging = true
            dragStart = UserInputService:GetMouseLocation()
            startPositions = {}
            for i, obj in ipairs(objects) do
                startPositions[i] = obj.Position
            end
        end
    end)
    
    Utility.Connect(UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    Utility.Connect(UserInputService.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local currentPos = UserInputService:GetMouseLocation()
            local delta = currentPos - dragStart
            for i, obj in ipairs(objects) do
                if startPositions[i] then
                    obj.Position = startPositions[i] + delta
                end
            end
        end
    end)
end

-- Window
function Library:CreateWindow(title, size)
    local window = {
        Title = title,
        Size = size,
        Tabs = {},
        CurrentTab = nil,
        Elements = {},
        ToggleKey = Enum.KeyCode.RightShift
    }
    
    -- Main Frame
    local mainOutline = Utility.Create("Square", {
        Size = size,
        Position = Utility.CenterPosition(size),
        Color = Library.Theme.Outline,
        Thickness = 0,
        Filled = true,
        Visible = true
    })
    
    if not mainOutline then
        warn("Erro ao criar janela!")
        return nil
    end
    
    local mainBorder = Utility.Create("Square", {
        Size = Vector2.new(size.X - 2, size.Y - 2),
        Position = mainOutline.Position + Vector2.new(1, 1),
        Color = Library.Theme.Accent,
        Thickness = 0,
        Filled = true,
        Visible = true
    })
    
    local mainBackground = Utility.Create("Square", {
        Size = Vector2.new(size.X - 4, size.Y - 4),
        Position = mainOutline.Position + Vector2.new(2, 2),
        Color = Library.Theme.DarkContrast,
        Thickness = 0,
        Filled = true,
        Visible = true,
        Transparency = 1
    })
    
    -- Title Bar
    local titleBar = Utility.Create("Square", {
        Size = Vector2.new(size.X - 4, 30),
        Position = mainBackground.Position,
        Color = Library.Theme.LightContrast,
        Thickness = 0,
        Filled = true,
        Visible = true,
        Transparency = 0.8
    })
    
    local titleText = Utility.Create("Text", {
        Text = title,
        Position = titleBar.Position + Vector2.new(10, 8),
        Color = Library.Theme.Text,
        Center = false,
        Outline = true,
        Visible = true
    })
    
    -- Tab Container
    local tabContainer = Utility.Create("Square", {
        Size = Vector2.new(size.X - 4, 35),
        Position = mainBackground.Position + Vector2.new(0, 35),
        Color = Library.Theme.Inline,
        Thickness = 0,
        Filled = true,
        Visible = true,
        Transparency = 0.5
    })
    
    table.insert(window.Elements, mainOutline)
    table.insert(window.Elements, mainBorder)
    table.insert(window.Elements, mainBackground)
    table.insert(window.Elements, titleBar)
    table.insert(window.Elements, titleText)
    table.insert(window.Elements, tabContainer)
    
    -- Make Draggable
    Utility.MakeDraggable(titleBar, window.Elements)
    
    -- Add Tab Method
    function window:AddTab(name)
        local tab = {
            Name = name,
            Window = window,
            Sections = {},
            Elements = {},
            Visible = false
        }
        
        local tabIndex = #window.Tabs
        local tabButton = Utility.Create("Square", {
            Size = Vector2.new(100, 25),
            Position = tabContainer.Position + Vector2.new(5 + (tabIndex * 105), 5),
            Color = Library.Theme.DarkContrast,
            Thickness = 0,
            Filled = true,
            Visible = true,
            Transparency = 0.7
        })
        
        local tabText = Utility.Create("Text", {
            Text = name,
            Position = tabButton.Position + Vector2.new(50, 6),
            Color = Library.Theme.TextInactive,
            Center = true,
            Outline = true,
            Visible = true
        })
        
        table.insert(tab.Elements, tabButton)
        table.insert(tab.Elements, tabText)
        
        -- Tab Click
        Utility.Connect(UserInputService.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                if Utility.IsMouseOver(tabButton) then
                    window:SwitchTab(tab)
                end
            end
        end)
        
        -- Hover Effect
        Utility.Connect(UserInputService.InputChanged, function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if Utility.IsMouseOver(tabButton) then
                    tabButton.Color = Library.Theme.Accent
                else
                    tabButton.Color = tab.Visible and Library.Theme.LightContrast or Library.Theme.DarkContrast
                end
            end
        end)
        
        -- Add Section Method - CORRIGIDO
        function tab:AddSection(name, side)
            local section = {
                Name = name,
                Side = side or "Left",
                Tab = tab,
                Elements = {},
                ContentY = 0
            }
            
            local sectionX = side == "Left" and 
                mainBackground.Position.X + 10 or 
                mainBackground.Position.X + (size.X / 2) + 5
            
            local sectionY = mainBackground.Position.Y + 75
            
            -- Count existing sections
            for _, s in ipairs(tab.Sections) do
                if s.Side == side then
                    sectionY = sectionY + s.Height + 10
                end
            end
            
            local sectionOutline = Utility.Create("Square", {
                Size = Vector2.new((size.X / 2) - 20, 150),
                Position = Vector2.new(sectionX, sectionY),
                Color = Library.Theme.Inline,
                Thickness = 0,
                Filled = true,
                Visible = false
            })
            
            local sectionBg = Utility.Create("Square", {
                Size = Vector2.new(sectionOutline.Size.X - 2, 148),
                Position = sectionOutline.Position + Vector2.new(1, 1),
                Color = Library.Theme.LightContrast,
                Thickness = 0,
                Filled = true,
                Visible = false,
                Transparency = 0.9
            })
            
            local sectionTitle = Utility.Create("Text", {
                Text = name,
                Position = sectionBg.Position + Vector2.new(8, 6),
                Color = Library.Theme.Text,
                Center = false,
                Outline = true,
                Visible = false
            })
            
            section.Outline = sectionOutline
            section.Background = sectionBg
            section.TitleText = sectionTitle
            section.Height = 150
            
            table.insert(section.Elements, sectionOutline)
            table.insert(section.Elements, sectionBg)
            table.insert(section.Elements, sectionTitle)
            
            -- Update Height Method
            function section:UpdateHeight()
                local newHeight = math.max(150, self.ContentY + 30)
                self.Height = newHeight
                self.Outline.Size = Vector2.new(self.Outline.Size.X, newHeight)
                self.Background.Size = Vector2.new(self.Background.Size.X, newHeight - 2)
            end
            
            -- AddToggle Method - CORRIGIDO
            function section:AddToggle(config)
                config = config or {}
                local toggle = {
                    Name = config.Name or "Toggle",
                    Flag = config.Flag or HttpService:GenerateGUID(false),
                    Default = config.Default or false,
                    Callback = config.Callback or function() end,
                    Value = config.Default or false
                }
                
                local toggleY = sectionBg.Position.Y + 25 + self.ContentY
                
                local toggleBox = Utility.Create("Square", {
                    Size = Vector2.new(12, 12),
                    Position = Vector2.new(sectionBg.Position.X + 8, toggleY),
                    Color = Library.Theme.Inline,
                    Thickness = 1,
                    Filled = true,
                    Visible = false
                })
                
                local toggleCheck = Utility.Create("Square", {
                    Size = Vector2.new(8, 8),
                    Position = toggleBox.Position + Vector2.new(2, 2),
                    Color = Library.Theme.Accent,
                    Thickness = 0,
                    Filled = true,
                    Visible = false,
                    Transparency = toggle.Default and 1 or 0
                })
                
                local toggleText = Utility.Create("Text", {
                    Text = toggle.Name,
                    Position = Vector2.new(toggleBox.Position.X + 20, toggleY - 2),
                    Color = Library.Theme.Text,
                    Center = false,
                    Outline = true,
                    Visible = false
                })
                
                table.insert(section.Elements, toggleBox)
                table.insert(section.Elements, toggleCheck)
                table.insert(section.Elements, toggleText)
                
                function toggle:Set(value)
                    self.Value = value
                    toggleCheck.Transparency = value and 1 or 0
                    Library.Flags[self.Flag] = value
                    pcall(self.Callback, value)
                end
                
                Utility.Connect(UserInputService.InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if Utility.IsMouseOver(toggleBox) then
                            toggle:Set(not toggle.Value)
                        end
                    end
                end)
                
                self.ContentY = self.ContentY + 20
                self:UpdateHeight()
                
                Library.Items[toggle.Flag] = toggle
                Library.Flags[toggle.Flag] = toggle.Value
                
                return toggle
            end
            
            -- AddButton Method - CORRIGIDO
            function section:AddButton(config)
                config = config or {}
                local button = {
                    Name = config.Name or "Button",
                    Callback = config.Callback or function() end
                }
                
                local buttonY = sectionBg.Position.Y + 25 + self.ContentY
                
                local buttonBg = Utility.Create("Square", {
                    Size = Vector2.new(sectionBg.Size.X - 16, 20),
                    Position = Vector2.new(sectionBg.Position.X + 8, buttonY),
                    Color = Library.Theme.DarkContrast,
                    Thickness = 0,
                    Filled = true,
                    Visible = false,
                    Transparency = 0.8
                })
                
                local buttonText = Utility.Create("Text", {
                    Text = button.Name,
                    Position = Vector2.new(buttonBg.Position.X + buttonBg.Size.X / 2, buttonY + 4),
                    Color = Library.Theme.Text,
                    Center = true,
                    Outline = true,
                    Visible = false
                })
                
                table.insert(section.Elements, buttonBg)
                table.insert(section.Elements, buttonText)
                
                Utility.Connect(UserInputService.InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if Utility.IsMouseOver(buttonBg) then
                            buttonBg.Color = Library.Theme.Accent
                            task.spawn(function()
                                task.wait(0.1)
                                buttonBg.Color = Library.Theme.DarkContrast
                            end)
                            pcall(button.Callback)
                        end
                    end
                end)
                
                Utility.Connect(UserInputService.InputChanged, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        if Utility.IsMouseOver(buttonBg) then
                            buttonBg.Color = Library.Theme.LightContrast
                        else
                            buttonBg.Color = Library.Theme.DarkContrast
                        end
                    end
                end)
                
                self.ContentY = self.ContentY + 25
                self:UpdateHeight()
                
                return button
            end
            
            table.insert(tab.Sections, section)
            return section
        end
        
        table.insert(window.Tabs, tab)
        if #window.Tabs == 1 then
            window:SwitchTab(tab)
        end
        
        return tab
    end
    
    -- Switch Tab Method
    function window:SwitchTab(targetTab)
        for _, tab in ipairs(self.Tabs) do
            tab.Visible = false
            for _, elem in ipairs(tab.Elements) do
                elem.Visible = false
            end
            for _, section in ipairs(tab.Sections) do
                for _, elem in ipairs(section.Elements) do
                    elem.Visible = false
                end
            end
        end
        
        targetTab.Visible = true
        for _, elem in ipairs(targetTab.Elements) do
            elem.Visible = true
        end
        for _, section in ipairs(targetTab.Sections) do
            for _, elem in ipairs(section.Elements) do
                elem.Visible = true
            end
        end
        
        self.CurrentTab = targetTab
    end
    
    -- Toggle Visibility Method
    function window:SetVisible(visible)
        Library.IsVisible = visible
        UserInputService.MouseIconEnabled = not visible
        for _, elem in ipairs(self.Elements) do
            elem.Visible = visible
        end
        if self.CurrentTab then
            for _, elem in ipairs(self.CurrentTab.Elements) do
                elem.Visible = visible
            end
            for _, section in ipairs(self.CurrentTab.Sections) do
                for _, elem in ipairs(section.Elements) do
                    elem.Visible = visible
                end
            end
        end
    end
    
    -- Toggle Key Handler
    Utility.Connect(UserInputService.InputBegan, function(input)
        if input.KeyCode == window.ToggleKey then
            window:SetVisible(not Library.IsVisible)
        end
    end)
    
    table.insert(Library.Windows, window)
    return window
end

-- Destroy Method
function Library:Destroy()
    UserInputService.MouseIconEnabled = true
    for _, conn in ipairs(self.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    for _, drawing in ipairs(self.Drawings) do
        pcall(function() drawing:Remove() end)
    end
    if ScreenGui then
        ScreenGui:Destroy()
    end
end

print("✅ Akiri UI Library v2.1 carregada em " .. math.floor((tick() - StartTime) * 1000) .. "ms")

return Library
