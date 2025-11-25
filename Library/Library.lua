-- Modern UI Library v3.0
-- Design moderno com glassmorphism e animações suaves

local library = {
    flags = {},
    Flags = {}
}

--// Services
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local ViewportSize = workspace.CurrentCamera.ViewportSize
local Mouse = Players.LocalPlayer:GetMouse()

--// Utilities
local Utilities = {}

function Utilities:Create(instance, properties, children)
    local obj = Instance.new(instance)
    properties = properties or {}
    children = children or {}
    
    -- Defaults
    pcall(function() obj.BorderSizePixel = 0 end)
    pcall(function() obj.Text = "" end)
    pcall(function() obj.BackgroundColor3 = Color3.fromRGB(255, 255, 255) end)
    
    for prop, val in pairs(properties) do
        pcall(function() obj[prop] = val end)
    end
    
    for _, child in pairs(children) do
        child.Parent = obj
    end
    
    return obj
end

function Utilities:Tween(obj, speed, props, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    local tween = TweenService:Create(obj, TweenInfo.new(speed, style, direction), props)
    tween:Play()
    return tween
end

function Utilities:Round(num, increment)
    increment = 1 / increment
    return math.round(num * increment) / increment
end

function Utilities:GetXY(gui)
    local maxX, maxY = gui.AbsoluteSize.X, gui.AbsoluteSize.Y
    local mouseX = math.clamp(Mouse.X - gui.AbsolutePosition.X, 0, maxX)
    local mouseY = math.clamp(Mouse.Y - gui.AbsolutePosition.Y, 0, maxY)
    return mouseX / maxX, mouseY / maxY
end

function Utilities:GetMouse()
    return UserInputService:GetMouseLocation()
end

--// Modern Color Scheme (Glassmorphism)
local Colors = {
    -- Background com transparência
    Primary = Color3.fromRGB(20, 20, 25),
    Secondary = Color3.fromRGB(25, 25, 30),
    Tertiary = Color3.fromRGB(30, 30, 35),
    
    -- Containers modernos
    Container = Color3.fromRGB(35, 35, 40),
    ContainerHover = Color3.fromRGB(40, 40, 45),
    
    -- Divisores sutis
    Divider = Color3.fromRGB(45, 45, 50),
    DividerLight = Color3.fromRGB(55, 55, 60),
    
    -- Texto
    PrimaryText = Color3.fromRGB(240, 240, 245),
    SecondaryText = Color3.fromRGB(180, 180, 190),
    TertiaryText = Color3.fromRGB(140, 140, 150),
    
    -- Accent moderno
    Accent = Color3.fromRGB(88, 166, 255),
    AccentHover = Color3.fromRGB(108, 186, 255),
    AccentDark = Color3.fromRGB(68, 146, 235),
    
    -- Estados
    Success = Color3.fromRGB(56, 189, 117),
    Warning = Color3.fromRGB(255, 170, 66),
    Error = Color3.fromRGB(255, 92, 92),
    
    -- Hover
    Hover = Color3.fromRGB(45, 45, 50),
}

--// Icons Base64
local Icons = {
    Arrow = "rbxassetid://6034818372",
    Resize = "rbxassetid://6034818375",
    Check = "rbxassetid://6031094678",
    Close = "rbxassetid://6031094667"
}

--// Main Window Function
function library:Window(config)
    config = config or {}
    config.Text = config.Text or "Modern UI"
    config.Size = config.Size or UDim2.new(0, 650, 0, 450)
    
    local WindowTable = {}
    local isMinimized = false
    local currentTab = nil
    local tabCount = 0
    
    --// Create ScreenGui
    local ScreenGui = Utilities:Create("ScreenGui", {
        Name = "ModernUI_" .. HttpService:GenerateGUID(false),
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })
    
    -- Protection
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    elseif gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = CoreGui
    end
    
    --// Main Window
    local Main = Utilities:Create("Frame", {
        Name = "Main",
        Parent = ScreenGui,
        Size = config.Size,
        Position = UDim2.new(0.5, -325, 0.5, -225),
        BackgroundColor3 = Colors.Primary,
        ClipsDescendants = true
    }, {
        Utilities:Create("UICorner", { CornerRadius = UDim.new(0, 12) }),
        Utilities:Create("UIStroke", {
            Color = Colors.Divider,
            Thickness = 1,
            Transparency = 0.5
        }),
        -- Gradiente sutil
        Utilities:Create("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 30)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
            }),
            Rotation = 90
        })
    })
    
    --// Topbar moderna
    local Topbar = Utilities:Create("Frame", {
        Name = "Topbar",
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = Colors.Secondary,
        BackgroundTransparency = 0.3
    }, {
        Utilities:Create("UICorner", { CornerRadius = UDim.new(0, 12) }),
        Utilities:Create("Frame", {
            Name = "BottomFix",
            Size = UDim2.new(1, 0, 0, 12),
            Position = UDim2.new(0, 0, 1, -12),
            BackgroundColor3 = Colors.Secondary,
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0
        }),
        Utilities:Create("TextLabel", {
            Name = "Title",
            Size = UDim2.new(1, -20, 1, 0),
            Position = UDim2.new(0, 20, 0, 0),
            BackgroundTransparency = 1,
            Text = config.Text,
            TextColor3 = Colors.PrimaryText,
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left
        }),
        Utilities:Create("Frame", {
            Name = "Divider",
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            BackgroundColor3 = Colors.Divider,
            BorderSizePixel = 0
        })
    })
    
    --// Tab Container
    local TabContainer = Utilities:Create("Frame", {
        Name = "TabContainer",
        Parent = Main,
        Size = UDim2.new(1, -30, 0, 40),
        Position = UDim2.new(0, 15, 0, 55),
        BackgroundTransparency = 1
    }, {
        Utilities:Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    })
    
    --// Content Container
    local ContentContainer = Utilities:Create("Frame", {
        Name = "ContentContainer",
        Parent = Main,
        Size = UDim2.new(1, -30, 1, -115),
        Position = UDim2.new(0, 15, 0, 105),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    })
    
    --// Dragging
    local dragging = false
    local dragInput, dragStart, startPos
    
    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    Topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    --// Toggle with LEFT ALT
    UserInputService.InputBegan:Connect(function(input, processed)
        if input.KeyCode == Enum.KeyCode.LeftAlt and not processed then
            Main.Visible = not Main.Visible
        end
    end)
    
    --// Add Tab Function
    function WindowTable:Tab(config)
        config = config or {}
        config.Text = config.Text or "Tab"
        
        tabCount = tabCount + 1
        local TabTable = {}
        local isSelected = false
        
        --// Tab Button
        local TabButton = Utilities:Create("Frame", {
            Name = "Tab_" .. tabCount,
            Parent = TabContainer,
            Size = UDim2.new(0, 120, 0, 35),
            BackgroundColor3 = Colors.Container,
            BackgroundTransparency = 0.5
        }, {
            Utilities:Create("UICorner", { CornerRadius = UDim.new(0, 8) }),
            Utilities:Create("UIStroke", {
                Color = Colors.Divider,
                Thickness = 1,
                Transparency = 0.7
            }),
            Utilities:Create("TextLabel", {
                Name = "Label",
                Size = UDim2.new(1, -10, 1, 0),
                Position = UDim2.new(0, 5, 0, 0),
                BackgroundTransparency = 1,
                Text = config.Text,
                TextColor3 = Colors.SecondaryText,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Center
            }),
            Utilities:Create("TextButton", {
                Name = "Button",
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = ""
            })
        })
        
        --// Tab Content Holder
        local TabContent = Utilities:Create("Frame", {
            Name = "Content_" .. tabCount,
            Parent = ContentContainer,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible = false
        }, {
            Utilities:Create("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 15)
            })
        })
        
        --// Left Side
        local LeftSide = Utilities:Create("ScrollingFrame", {
            Name = "Left",
            Parent = TabContent,
            Size = UDim2.new(0.5, -7.5, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Colors.Accent,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        }, {
            Utilities:Create("UIListLayout", {
                Padding = UDim.new(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        })
        
        --// Right Side
        local RightSide = Utilities:Create("ScrollingFrame", {
            Name = "Right",
            Parent = TabContent,
            Size = UDim2.new(0.5, -7.5, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Colors.Accent,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        }, {
            Utilities:Create("UIListLayout", {
                Padding = UDim.new(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        })
        
        --// Select Function
        function TabTable:Select()
            -- Hide all tabs
            for _, child in pairs(ContentContainer:GetChildren()) do
                child.Visible = false
            end
            
            -- Reset all tab buttons
            for _, tab in pairs(TabContainer:GetChildren()) do
                if tab:IsA("Frame") then
                    Utilities:Tween(tab, 0.2, {
                        BackgroundColor3 = Colors.Container,
                        BackgroundTransparency = 0.5
                    })
                    Utilities:Tween(tab.UIStroke, 0.2, {
                        Transparency = 0.7
                    })
                    Utilities:Tween(tab.Label, 0.2, {
                        TextColor3 = Colors.SecondaryText
                    })
                end
            end
            
            -- Show this tab
            TabContent.Visible = true
            isSelected = true
            currentTab = TabTable
            
            -- Highlight button
            Utilities:Tween(TabButton, 0.2, {
                BackgroundColor3 = Colors.Accent,
                BackgroundTransparency = 0.1
            })
            Utilities:Tween(TabButton.UIStroke, 0.2, {
                Color = Colors.AccentHover,
                Transparency = 0.3
            })
            Utilities:Tween(TabButton.Label, 0.2, {
                TextColor3 = Colors.PrimaryText
            })
        end
        
        --// Button Click
        TabButton.Button.MouseButton1Click:Connect(function()
            TabTable:Select()
        end)
        
        --// Hover Effects
        TabButton.Button.MouseEnter:Connect(function()
            if not isSelected then
                Utilities:Tween(TabButton, 0.15, {
                    BackgroundTransparency = 0.3
                })
                Utilities:Tween(TabButton.Label, 0.15, {
                    TextColor3 = Colors.PrimaryText
                })
            end
        end)
        
        TabButton.Button.MouseLeave:Connect(function()
            if not isSelected then
                Utilities:Tween(TabButton, 0.15, {
                    BackgroundTransparency = 0.5
                })
                Utilities:Tween(TabButton.Label, 0.15, {
                    TextColor3 = Colors.SecondaryText
                })
            end
        end)
        
        --// Section Function
        function TabTable:Section(config)
            config = config or {}
            config.Text = config.Text or "Section"
            config.Side = config.Side or "Left"
            
            local SectionTable = {}
            local sectionHeight = 40
            
            local parent = config.Side == "Left" and LeftSide or RightSide
            
            --// Section Container (MELHORADO)
            local Section = Utilities:Create("Frame", {
                Name = "Section",
                Parent = parent,
                Size = UDim2.new(1, 0, 0, sectionHeight),
                BackgroundColor3 = Colors.Container,
                BackgroundTransparency = 0.3
            }, {
                Utilities:Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
                Utilities:Create("UIStroke", {
                    Color = Colors.DividerLight,
                    Thickness = 1,
                    Transparency = 0.5
                }),
                -- Gradiente sutil no container
                Utilities:Create("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 45)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 35))
                    }),
                    Rotation = 45,
                    Transparency = NumberSequence.new(0.7)
                }),
                Utilities:Create("TextLabel", {
                    Name = "Title",
                    Size = UDim2.new(1, -20, 0, 30),
                    Position = UDim2.new(0, 10, 0, 5),
                    BackgroundTransparency = 1,
                    Text = config.Text,
                    TextColor3 = Colors.PrimaryText,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left
                }),
                Utilities:Create("Frame", {
                    Name = "Divider",
                    Size = UDim2.new(1, -20, 0, 1),
                    Position = UDim2.new(0, 10, 0, 35),
                    BackgroundColor3 = Colors.Divider,
                    BorderSizePixel = 0
                }),
                Utilities:Create("Frame", {
                    Name = "Container",
                    Size = UDim2.new(1, -20, 1, -45),
                    Position = UDim2.new(0, 10, 0, 40),
                    BackgroundTransparency = 1
                }, {
                    Utilities:Create("UIListLayout", {
                        Padding = UDim.new(0, 8),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                })
            })
            
            local Container = Section.Container
            
            --// Update Height
            Container:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                sectionHeight = Container.AbsoluteContentSize.Y + 50
                Section.Size = UDim2.new(1, 0, 0, sectionHeight)
            end)
            
            --// Toggle (Check)
            function SectionTable:Check(config)
                config = config or {}
                config.Text = config.Text or "Toggle"
                config.Default = config.Default or false
                config.Callback = config.Callback or function() end
                config.Flag = config.Flag
                
                local state = config.Default
                local CheckTable = {}
                
                local Check = Utilities:Create("Frame", {
                    Name = "Check",
                    Parent = Container,
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundColor3 = Colors.Secondary,
                    BackgroundTransparency = 0.5
                }, {
                    Utilities:Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    Utilities:Create("Frame", {
                        Name = "CheckBox",
                        Size = UDim2.new(0, 18, 0, 18),
                        Position = UDim2.new(0, 8, 0.5, -9),
                        BackgroundColor3 = state and Colors.Accent or Colors.Tertiary
                    }, {
                        Utilities:Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
                        Utilities:Create("UIStroke", {
                            Color = state and Colors.AccentHover or Colors.Divider,
                            Thickness = 1
                        }),
                        Utilities:Create("ImageLabel", {
                            Name = "Check",
                            Size = UDim2.new(0, 12, 0, 12),
                            Position = UDim2.new(0.5, -6, 0.5, -6),
                            BackgroundTransparency = 1,
                            Image = Icons.Check,
                            ImageColor3 = Colors.PrimaryText,
                            Visible = state
                        })
                    }),
                    Utilities:Create("TextLabel", {
                        Name = "Label",
                        Size = UDim2.new(1, -40, 1, 0),
                        Position = UDim2.new(0, 35, 0, 0),
                        BackgroundTransparency = 1,
                        Text = config.Text,
                        TextColor3 = Colors.PrimaryText,
                        TextSize = 13,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }),
                    Utilities:Create("TextButton", {
                        Name = "Button",
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Text = ""
                    })
                })
                
                function CheckTable:Set(value)
                    state = value
                    if config.Flag then
                        library.flags[config.Flag] = value
                    end
                    
                    Check.CheckBox.Check.Visible = state
                    Utilities:Tween(Check.CheckBox, 0.2, {
                        BackgroundColor3 = state and Colors.Accent or Colors.Tertiary
                    })
                    Utilities:Tween(Check.CheckBox.UIStroke, 0.2, {
                        Color = state and Colors.AccentHover or Colors.Divider
                    })
                    
                    pcall(config.Callback, value)
                end
                
                Check.Button.MouseButton1Click:Connect(function()
                    CheckTable:Set(not state)
                end)
                
                Check.Button.MouseEnter:Connect(function()
                    Utilities:Tween(Check, 0.15, {
                        BackgroundTransparency = 0.3
                    })
                end)
                
                Check.Button.MouseLeave:Connect(function()
                    Utilities:Tween(Check, 0.15, {
                        BackgroundTransparency = 0.5
                    })
                end)
                
                if config.Default then
                    CheckTable:Set(true)
                end
                
                return CheckTable
            end
            
            --// Button
            function SectionTable:Button(config)
                config = config or {}
                config.Text = config.Text or "Button"
                config.Callback = config.Callback or function() end
                
                local Button = Utilities:Create("Frame", {
                    Name = "Button",
                    Parent = Container,
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundColor3 = Colors.Accent,
                    BackgroundTransparency = 0.2
                }, {
                    Utilities:Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    Utilities:Create("UIStroke", {
                        Color = Colors.AccentHover,
                        Thickness = 1,
                        Transparency = 0.5
                    }),
                    Utilities:Create("TextLabel", {
                        Name = "Label",
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Text = config.Text,
                        TextColor3 = Colors.PrimaryText,
                        TextSize = 13,
                        Font = Enum.Font.GothamBold
                    }),
                    Utilities:Create("TextButton", {
                        Name = "Btn",
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Text = ""
                    })
                })
                
                Button.Btn.MouseButton1Click:Connect(function()
                    Utilities:Tween(Button, 0.1, {
                        BackgroundColor3 = Colors.AccentDark
                    })
                    task.wait(0.1)
                    Utilities:Tween(Button, 0.1, {
                        BackgroundColor3 = Colors.Accent
                    })
                    pcall(config.Callback)
                end)
                
                Button.Btn.MouseEnter:Connect(function()
                    Utilities:Tween(Button, 0.15, {
                        BackgroundTransparency = 0.1
                    })
                end)
                
                Button.Btn.MouseLeave:Connect(function()
                    Utilities:Tween(Button, 0.15, {
                        BackgroundTransparency = 0.2
                    })
                end)
            end
            
            return SectionTable
        end
        
        -- Auto select first tab
        if tabCount == 1 then
            task.wait()
            TabTable:Select()
        end
        
        return TabTable
    end
    
    return WindowTable
end

print("✅ Modern UI Library carregada!")
return library
