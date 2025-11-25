-- Akiri UI Library - Versão Otimizada
-- Biblioteca de interface gráfica para Roblox

local Start = tick()
local LoadTime = tick()

-- Inicialização de Serviços
local Services = setmetatable({}, {
    __index = function(self, key)
        return game:GetService(key)
    end
})

local UserInput = Services.UserInputService
local RunService = Services.RunService
local CoreGui = Services.CoreGui
local Players = Services.Players
local Workspace = Services.Workspace
local HttpService = Services.HttpService

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- GUI Container
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "AkiriUI_" .. HttpService:GenerateGUID(false)
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Library Principal
local Library = {
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
    WindowVisible = true,
    Communication = Instance.new("BindableEvent")
}

-- Utility Functions
local Utility = {}

function Utility.AddDrawing(Type, Properties)
    local drawing = Drawing.new(Type)
    
    for prop, value in pairs(Properties) do
        if Type == "Text" then
            if prop == "Font" then
                drawing.Font = Library.Theme.Font
            elseif prop == "Size" then
                drawing.Size = Library.Theme.TextSize
            else
                drawing[prop] = value
            end
        else
            drawing[prop] = value
        end
    end
    
    drawing.ZIndex = Properties.ZIndex and Properties.ZIndex + 20 or 20
    table.insert(Library.Drawings, {drawing})
    
    return drawing
end

function Utility.RemoveDrawing(drawing)
    for i, v in pairs(Library.Drawings) do
        if v[1] == drawing then
            v[1]:Remove()
            table.remove(Library.Drawings, i)
            break
        end
    end
end

function Utility.AddConnection(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(Library.Connections, connection)
    return connection
end

function Utility.OnMouse(drawing)
    if not drawing.Visible then return false end
    
    local mousePos = UserInput:GetMouseLocation()
    local drawPos = drawing.Position
    local drawSize = drawing.Size
    
    return mousePos.X >= drawPos.X and 
           mousePos.X <= drawPos.X + drawSize.X and
           mousePos.Y >= drawPos.Y and 
           mousePos.Y <= drawPos.Y + drawSize.Y
end

function Utility.MiddlePos(drawing)
    return Vector2.new(
        (Camera.ViewportSize.X / 2) - (drawing.Size.X / 2),
        (Camera.ViewportSize.Y / 2) - (drawing.Size.Y / 2)
    )
end

function Utility.AddDrag(sensor, drawingsList)
    local dragging = false
    local dragStart = Vector2.new()
    local startPos = {}
    
    Utility.AddConnection(UserInput.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if Utility.OnMouse(sensor) then
                dragging = true
                dragStart = UserInput:GetMouseLocation()
                
                for i, v in pairs(drawingsList) do
                    startPos[i] = v[1].Position
                end
            end
        end
    end)
    
    Utility.AddConnection(UserInput.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    Utility.AddConnection(UserInput.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local currentMouse = UserInput:GetMouseLocation()
            local delta = currentMouse - dragStart
            
            for i, v in pairs(drawingsList) do
                if startPos[i] then
                    v[1].Position = startPos[i] + delta
                end
            end
        end
    end)
end

-- Window Creation
function Library:CreateWindow(title, size)
    local window = {
        Tabs = {},
        CurrentTab = nil,
        Title = title
    }
    
    -- Window Outline
    local windowOutline = Utility.AddDrawing("Square", {
        Size = size,
        Position = Utility.MiddlePos({Size = size}),
        Thickness = 0,
        Color = Library.Theme.Outline,
        Filled = true,
        Visible = true
    })
    
    -- Window Border
    local windowBorder = Utility.AddDrawing("Square", {
        Size = Vector2.new(size.X - 2, size.Y - 2),
        Position = windowOutline.Position + Vector2.new(1, 1),
        Thickness = 0,
        Color = Library.Theme.Accent,
        Filled = true,
        Visible = true
    })
    
    -- Window Background
    local windowBg = Utility.AddDrawing("Square", {
        Size = Vector2.new(size.X - 4, size.Y - 4),
        Position = windowOutline.Position + Vector2.new(2, 2),
        Thickness = 0,
        Color = Library.Theme.DarkContrast,
        Filled = true,
        Visible = true,
        Transparency = 1
    })
    
    -- Title Bar
    local titleBar = Utility.AddDrawing("Square", {
        Size = Vector2.new(size.X - 4, 25),
        Position = windowBg.Position,
        Thickness = 0,
        Color = Library.Theme.LightContrast,
        Filled = true,
        Visible = true,
        Transparency = 0.5
    })
    
    -- Title Text
    local titleText = Utility.AddDrawing("Text", {
        Text = title,
        Position = titleBar.Position + Vector2.new(8, 5),
        Color = Library.Theme.Text,
        Center = false,
        Outline = true,
        Visible = true
    })
    
    -- Make draggable
    Utility.AddDrag(titleBar, Library.Drawings)
    
    -- Tab Creation
    function window:AddTab(name)
        local tab = {
            Name = name,
            Sections = {},
            Visible = false
        }
        
        local tabButton = Utility.AddDrawing("Square", {
            Size = Vector2.new(100, 20),
            Position = Vector2.new(
                windowBg.Position.X + (#self.Tabs * 105),
                windowBg.Position.Y + 30
            ),
            Color = Library.Theme.Inline,
            Filled = true,
            Visible = true
        })
        
        local tabText = Utility.AddDrawing("Text", {
            Text = name,
            Position = tabButton.Position + Vector2.new(50, 3),
            Color = Library.Theme.Text,
            Center = true,
            Visible = true
        })
        
        -- Tab Click
        Utility.AddConnection(UserInput.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                if Utility.OnMouse(tabButton) then
                    window:SwitchTab(tab)
                end
            end
        end)
        
        -- Section Creation
        function tab:AddSection(name, side)
            local section = {
                Name = name,
                Elements = {},
                ContentHeight = 0
            }
            
            local xPos = side == "Left" and windowBg.Position.X + 10 or windowBg.Position.X + (size.X / 2) + 5
            
            local sectionBg = Utility.AddDrawing("Square", {
                Size = Vector2.new((size.X / 2) - 15, 200),
                Position = Vector2.new(xPos, windowBg.Position.Y + 60),
                Color = Library.Theme.LightContrast,
                Filled = true,
                Visible = false
            })
            
            local sectionTitle = Utility.AddDrawing("Text", {
                Text = name,
                Position = sectionBg.Position + Vector2.new(5, 5),
                Color = Library.Theme.Text,
                Visible = false
            })
            
            table.insert(tab.Sections, section)
            return section
        end
        
        table.insert(self.Tabs, tab)
        return tab
    end
    
    -- Switch Tab
    function window:SwitchTab(tab)
        for _, t in pairs(self.Tabs) do
            t.Visible = false
            -- Hide all tab elements
        end
        
        tab.Visible = true
        self.CurrentTab = tab
        -- Show tab elements
    end
    
    return window
end

-- Toggle Visibility
function Library:ToggleVisibility()
    self.WindowVisible = not self.WindowVisible
    UserInput.MouseIconEnabled = not self.WindowVisible
    
    for _, drawing in pairs(self.Drawings) do
        if drawing[1].Transparency then
            drawing[1].Transparency = self.WindowVisible and 1 or 0
        end
    end
end

-- Cleanup
function Library:Destroy()
    UserInput.MouseIconEnabled = true
    
    for _, connection in pairs(self.Connections) do
        connection:Disconnect()
    end
    
    for _, drawing in pairs(self.Drawings) do
        if drawing[1] then
            drawing[1]:Remove()
        end
    end
    
    if ScreenGui then
        ScreenGui:Destroy()
    end
end

-- Keybind Handler
Utility.AddConnection(UserInput.InputBegan, function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Library:ToggleVisibility()
    end
end)

-- Protect GUI
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end

print("Akiri UI Library carregada em " .. math.floor((tick() - Start) * 1000) .. "ms")

return Library
