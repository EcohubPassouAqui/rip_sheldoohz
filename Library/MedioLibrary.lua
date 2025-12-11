local library = {
    flags = {}
}
library.Flags = library.flags

--// Serviços //--
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Mouse = game.Players.LocalPlayer:GetMouse()

local Utilities = {}

function Utilities:Create(Inst, Properties, Childs)
    local Instance = Instance.new(Inst)
    local Properties = Properties or {}
    local Childs = Childs or {}
    local BlacklistedProps = {
        BorderSizePixel = 0,
        Text = "",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    }
    for blprop, v in pairs(BlacklistedProps) do
        pcall(function() Instance[blprop] = v end)
    end
    for prop, v in pairs(Properties) do
        Instance[prop] = v
    end
    for _, child in pairs(Childs) do
        child.Parent = Instance
    end
    return Instance
end

function Utilities:Tween(Inst, Speed, Properties, Style, Direction)
    local Instance = Inst or error("#1 argument: instance expected.")
    local Speed = Speed or .125
    local Properties = typeof(Properties) == "table" and Properties or error("#3 argument: table expected")
    local Style = Style or Enum.EasingStyle.Linear
    local Direction = Direction or Enum.EasingDirection.Out
    local Tween = TweenService:Create(Instance, TweenInfo.new(Speed, Style, Direction), Properties)
    Tween:Play()
    return Tween
end

--// Cores //--
local Colors = {
    Primary = Color3.fromRGB(27, 25, 27),
    Secondary = Color3.fromRGB(42, 40, 42),
    Tertiary = Color3.fromRGB(74, 73, 74),
    Divider = Color3.fromRGB(46, 45, 46),
    AccentDivider = Color3.fromRGB(54, 54, 54),
    PrimaryText = Color3.fromRGB(211, 211, 211),
    SecondaryText = Color3.fromRGB(122, 122, 122),
    TertiaryText = Color3.fromRGB(158, 158, 158),
    Hovering = Color3.fromRGB(56, 53, 56),
    Accent = Color3.fromRGB(52, 152, 219),  -- Azul
    DarkerAccent = Color3.fromRGB(41, 128, 185),  -- Azul escuro
    AccentText = Color3.fromRGB(235, 235, 235)
}

local ResizeIcon = "rbxassetid://6034818375"

function library:Window(WindowArgs)
    WindowArgs = WindowArgs or {}
    WindowArgs.Text = WindowArgs.Text or "Window"
    
    local WindowTable = {}
    local Tabs = 0
    local SelectedTab = nil

    local Window = Utilities:Create("ScreenGui", {
        Name = "PPHUD",
        ZIndexBehavior = Enum.ZIndexBehavior.Global
    }, {
        Utilities:Create("Frame", {
            Name = "Main",
            Size = UDim2.new(0, 600, 0, 400),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            ClipsDescendants = true,
            Position = UDim2.new(0, 600, 0, 270)
        }, {
            Utilities:Create("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 25, 27)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 10, 12)),
                }),
                Offset = Vector2.new(0, 0.65),
                Rotation = 90
            }),
            Utilities:Create("Frame", {
                Name = "Containers",
                Size = UDim2.new(1, 0, 1, -50),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 26)
            }),
            Utilities:Create("Frame", {
                Name = "Bottom",
                Size = UDim2.new(1, 0, 0, 24),
                AnchorPoint = Vector2.new(.5, 1),
                Position = UDim2.new(.5, 0, 1, 0),
                BackgroundColor3 = Colors.Secondary,
                ZIndex = 100
            }, {
                Utilities:Create("Frame", {
                    Name = "Divider",
                    Size = UDim2.new(1, 0, 0, 1),
                    AnchorPoint = Vector2.new(.5, 0),
                    BackgroundColor3 = Colors.Divider,
                    Position = UDim2.new(.5, 0, 0, 0),
                    ZIndex = 100
                }),
                Utilities:Create("ImageLabel", {
                    Name = "ResizeIcon",
                    Size = UDim2.new(0, 10, 0, 10),
                    BackgroundTransparency = 1,
                    Image = ResizeIcon,
                    AnchorPoint = Vector2.new(1, 1),
                    Position = UDim2.new(1, 0, 1, 0),
                    ZIndex = 100
                }, {
                    Utilities:Create("TextButton", {
                        Name = "ResizeButton",
                        Size = UDim2.new(0, 10, 0, 10),
                        BackgroundTransparency = 1,
                        ZIndex = 100
                    })
                }),
                Utilities:Create("TextLabel", {
                    Name = "BottomText",
                    Text = WindowArgs.Text,
                    Size = UDim2.new(1, -10, 0, 24),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, 0),
                    RichText = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextSize = 13,
                    Font = Enum.Font.SourceSansBold,
                    TextColor3 = Colors.PrimaryText,
                    ZIndex = 100
                })
            }),
            Utilities:Create("Frame", {
                Name = "Topbar",
                AnchorPoint = Vector2.new(.5, 0),
                Position = UDim2.new(.5, 0, 0, 0),
                BackgroundColor3 = Colors.Secondary,
                Size = UDim2.new(1, 0, 0, 26)
            }, {
                Utilities:Create("Frame", {
                    Name = "Divider",
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundColor3 = Colors.Divider,
                    AnchorPoint = Vector2.new(0.5, 1),
                    ZIndex = 2,
                    Position = UDim2.new(.5, 0, 1, 0)
                }),
                Utilities:Create("Frame", {
                    Name = "TabContainer",
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true
                }, {
                    Utilities:Create("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal
                    })
                })
            })
        })
    })

    -- TOGGLE COM LEFT ALT
    UserInputService.InputBegan:Connect(function(Input, GameProcessed)
        if Input.KeyCode == Enum.KeyCode.LeftAlt and not GameProcessed then
            Window.Main.Visible = not Window.Main.Visible
        end
    end)

    -- Efeito hover no nome da window
    local bottomText = Window.Main.Bottom.BottomText
    bottomText.MouseEnter:Connect(function() 
        Utilities:Tween(bottomText, .125, {TextColor3 = Colors.Accent}) 
    end)
    bottomText.MouseLeave:Connect(function() 
        Utilities:Tween(bottomText, .125, {TextColor3 = Colors.PrimaryText}) 
    end)

    -- PROTEÇÃO DA GUI
    local function SafeParent()
        if syn and syn.protect_gui then
            syn.protect_gui(Window)
            Window.Parent = CoreGui
        elseif gethui then
            Window.Parent = gethui()
        elseif not RunService:IsStudio() then
            Window.Parent = CoreGui
        else
            Window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        end
    end
    pcall(SafeParent)

    local ResizeButton = Window.Main.Bottom.ResizeIcon.ResizeButton
    local TabContainer = Window.Main.Topbar.TabContainer
    local Containers = Window.Main.Containers

    local SizeX = Instance.new("NumberValue", Window.Main)
    SizeX.Name = "X"
    SizeX.Value = 600

    local SizeY = Instance.new("NumberValue", Window.Main)
    SizeY.Name = "Y"
    SizeY.Value = 400

    local function ResizeTabs()
        local TabSize = 1 / math.max(Tabs, 1)
        task.spawn(function()
            for _, v in pairs(TabContainer:GetChildren()) do
                if v.ClassName == "Frame" then 
                    v.Size = UDim2.new(TabSize, 0, 0, 26) 
                end
            end
        end)
    end

    local function GetMouse()
        return Vector2.new(UserInputService:GetMouseLocation().X + 1, UserInputService:GetMouseLocation().Y - 35)
    end

    local function Resize()
        local MouseLocation = GetMouse()
        local X = math.clamp(MouseLocation.X - Window.Main.AbsolutePosition.X, 300, 1300)
        local Y = math.clamp(MouseLocation.Y - Window.Main.AbsolutePosition.Y, 165, 730)
        SizeX.Value = X
        SizeY.Value = Y
        Utilities:Tween(Window.Main, .05, {Size = UDim2.new(0, X, 0, Y)})
        ResizeTabs()
    end

    ResizeButton.MouseButton1Down:Connect(function()
        local ResizeMove, ResizeKill
        Utilities:Tween(Window.Main.Bottom.ResizeIcon, .125, {ImageColor3 = Colors.Accent})
        ResizeMove = Mouse.Move:Connect(function() Resize() end)
        ResizeKill = UserInputService.InputEnded:Connect(function(UserInput)
            if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                ResizeMove:Disconnect()
                ResizeKill:Disconnect()
                Utilities:Tween(Window.Main.Bottom.ResizeIcon, .125, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
            end
        end)
    end)

    TabContainer.ChildAdded:Connect(function()
        Tabs = Tabs + 1
        ResizeTabs()
    end)

    -- SISTEMA DE DRAG
    local dragging = false
    local dragInput, mousePos, framePos

    Window.Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = Window.Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then 
                    dragging = false 
                end
            end)
        end
    end)

    Window.Main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then 
            dragInput = input 
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            Window.Main.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

    -- Funções da Window
    function WindowTable:Exit() 
        Window:Destroy() 
    end
    
    function WindowTable:Toggle()
        Window.Main.Visible = not Window.Main.Visible
    end

    function WindowTable:Tab(TabArgs)
        TabArgs = TabArgs or {}
        TabArgs.Text = TabArgs.Text or "Tab"
        
        local TabTable = {}

        local Tab = Utilities:Create("Frame", {
            Name = "Tab",
            Parent = TabContainer,
            Size = UDim2.new(0, 200, 0, 26),
            BackgroundTransparency = 1,
        }, {
            Utilities:Create("Frame", {
                Name = "Divider",
                AnchorPoint = Vector2.new(.5, 1),
                Position = UDim2.new(.5, 0, 1, 0),
                Size = UDim2.new(1, 0, 0, 1),
                ZIndex = 3,
                BackgroundColor3 = Colors.Divider
            }),
            Utilities:Create("TextLabel", {
                Name = "TabText",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = TabArgs.Text,
                RichText = true,
                Font = Enum.Font.SourceSansBold,
                TextColor3 = Colors.SecondaryText,
                TextSize = 14,
                ZIndex = 2
            }),
            Utilities:Create("TextButton", {
                Name = "TabButton",
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            })
        })

        ResizeTabs()

        local ContainerHolder = Utilities:Create("Frame", {
            Name = "ContainerHolder",
            Size = UDim2.new(1, 0, 1, 0),
            Parent = Containers,
            BackgroundTransparency = 1
        }, { 
            Utilities:Create("UIListLayout", { 
                FillDirection = Enum.FillDirection.Horizontal 
            })
        })

        local Left = Utilities:Create("ScrollingFrame", {
            Name = "Left",
            BackgroundTransparency = 1,
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ClipsDescendants = false,
            ScrollBarThickness = 0,
            Parent = ContainerHolder,
            Size = UDim2.new(.5, 0, 0, 350)
        }, { 
            Utilities:Create("UIListLayout", {
                Padding = UDim.new(0, 8)
            }), 
            Utilities:Create("UIPadding", { 
                PaddingLeft = UDim.new(0, 8),
                PaddingTop = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 4)
            }) 
        })

        local Right = Utilities:Create("ScrollingFrame", {
            Name = "Right",
            BackgroundTransparency = 1,
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ClipsDescendants = false,
            ScrollBarThickness = 0,
            Parent = ContainerHolder,
            Size = UDim2.new(.5, 0, 0, 350),
            Position = UDim2.new(0, 300, 0, 0)
        }, { 
            Utilities:Create("UIListLayout", {
                Padding = UDim.new(0, 8)
            }), 
            Utilities:Create("UIPadding", { 
                PaddingLeft = UDim.new(0, 4),
                PaddingTop = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 8)
            }) 
        })

        Tab.MouseEnter:Connect(function()
            if SelectedTab == nil or SelectedTab ~= Tab then
                Utilities:Tween(Tab.Divider, .125, {BackgroundColor3 = Colors.Tertiary})
                Utilities:Tween(Tab.TabText, .125, {TextColor3 = Colors.PrimaryText})
            end
        end)

        Tab.MouseLeave:Connect(function()
            if SelectedTab == nil or Tab ~= SelectedTab then
                Utilities:Tween(Tab.Divider, .125, {BackgroundColor3 = Colors.Divider})
                Utilities:Tween(Tab.TabText, .125, {TextColor3 = Colors.SecondaryText})
            end
        end)

        -- Funções da Tab
        function TabTable:Select()
            SelectedTab = Tab
            task.spawn(function()
                for _, v in pairs(Containers:GetChildren()) do
                    if v.Name == "ContainerHolder" then
                        if v.Left ~= Left then 
                            v.Left.Visible = false
                            v.Right.Visible = false 
                        end
                    end
                end
                for _, v in pairs(TabContainer:GetChildren()) do
                    if v.ClassName == "Frame" and v ~= Tab then
                        Utilities:Tween(v.Divider, .125, {BackgroundColor3 = Colors.Divider})
                        Utilities:Tween(v.TabText, .125, {TextColor3 = Colors.SecondaryText})
                    end
                end
            end)
            Left.Visible = true
            Right.Visible = true
            Utilities:Tween(Tab.Divider, .125, {BackgroundColor3 = Colors.DarkerAccent})
            Utilities:Tween(Tab.TabText, .125, {TextColor3 = Colors.AccentText})
        end

        Tab.TabButton.MouseButton1Click:Connect(function() 
            TabTable:Select() 
        end)

        function TabTable:Section(SectionArgs)
            SectionArgs = SectionArgs or {}
            SectionArgs.Text = SectionArgs.Text or "Section"
            SectionArgs.Side = SectionArgs.Side or "Left"
            
            local SectionTable = {}

            local Section = Utilities:Create("Frame", {
                Name = "Section",
                Parent = SectionArgs.Side == "Left" and Left or Right,
                BackgroundColor3 = Colors.Primary,  -- Mesma cor do fundo do painel
                BorderSizePixel = 0,
                Size = UDim2.new(1, -8, 0, 100)
            }, {
                Utilities:Create("UICorner", {
                    CornerRadius = UDim.new(0, 4)
                }),
                Utilities:Create("Frame", {
                    Name = "Header",
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundColor3 = Colors.Primary,  -- Mesma cor do fundo
                    BorderSizePixel = 0
                }, {
                    Utilities:Create("UICorner", {
                        CornerRadius = UDim.new(0, 4)
                    }),
                    Utilities:Create("TextLabel", {
                        Name = "SectionText",
                        Size = UDim2.new(1, -10, 1, 0),
                        Position = UDim2.new(0, 10, 0, 0),
                        Text = SectionArgs.Text,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextSize = 13,
                        BackgroundTransparency = 1,
                        TextColor3 = Colors.Accent,
                        RichText = true,
                        Font = Enum.Font.SourceSansBold,
                        ZIndex = 2
                    }),
                    Utilities:Create("Frame", {
                        Name = "HeaderDivider",
                        Position = UDim2.new(0, 0, 1, -1),
                        Size = UDim2.new(1, 0, 0, 1),
                        BackgroundColor3 = Colors.Accent,
                        BorderSizePixel = 0
                    })
                }),
                Utilities:Create("Frame", {
                    Name = "Container",
                    Size = UDim2.new(1, -16, 1, -32),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, 28)
                }, { 
                    Utilities:Create("UIListLayout", { 
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 4)
                    }) 
                })
            })

            local SectionY = 100
            SizeX:GetPropertyChangedSignal("Value"):Connect(function()
                -- A section agora se adapta automaticamente ao tamanho
                task.wait()
            end)

            local SectionContainer = Section.Container
            SectionContainer.ChildAdded:Connect(function()
                SectionY = SectionY + 24
                Section.Size = UDim2.new(1, -8, 0, SectionY)
            end)

            -- Funções da Section
            function SectionTable:Button(Info)
                Info = Info or {}
                Info.Text = Info.Text or "Button"
                Info.Callback = Info.Callback or function() end

                local Button = Utilities:Create("Frame", {
                    Name = "Button", 
                    Parent = SectionContainer,
                    Size = UDim2.new(1, 0, 0, 22), 
                    BackgroundTransparency = 1
                }, {
                    Utilities:Create("Frame", { 
                        Name = "ButtonFrame", 
                        BackgroundColor3 = Colors.Secondary, 
                        Size = UDim2.new(1, 0, 0, 22)
                    }, {
                        Utilities:Create("UICorner", {
                            CornerRadius = UDim.new(0, 3)
                        }),
                        Utilities:Create("TextLabel", {
                            Name = "ButtonText", 
                            Size = UDim2.new(1, 0, 1, 0), 
                            Text = Info.Text,
                            RichText = true, 
                            Font = Enum.Font.SourceSans, 
                            BackgroundTransparency = 1,
                            TextSize = 13, 
                            TextColor3 = Colors.PrimaryText
                        }),
                        Utilities:Create("TextButton", { 
                            Name = "ButtonButton", 
                            Size = UDim2.new(1, 0, 1, 0), 
                            BackgroundTransparency = 1 
                        })
                    })
                })

                local Hovering = false
                Button.ButtonFrame.MouseEnter:Connect(function()
                    Hovering = true
                    Utilities:Tween(Button.ButtonFrame, .125, {BackgroundColor3 = Color3.fromRGB(40, 38, 40)})
                    Utilities:Tween(Button.ButtonFrame.UIStroke, .125, {Color = Colors.Accent})
                end)
                Button.ButtonFrame.MouseLeave:Connect(function()
                    Hovering = false
                    Utilities:Tween(Button.ButtonFrame, .125, {BackgroundColor3 = Color3.fromRGB(30, 28, 30)})
                    Utilities:Tween(Button.ButtonFrame.UIStroke, .125, {Color = Color3.fromRGB(50, 48, 50)})
                end)
                
                Button.ButtonFrame.ButtonButton.MouseButton1Down:Connect(function()
                    Utilities:Tween(Button.ButtonFrame.UIStroke, .1, {Color = Colors.Accent})
                    Utilities:Tween(Button.ButtonFrame.ButtonText, .1, {TextColor3 = Colors.Accent})
                end)
                Button.ButtonFrame.ButtonButton.MouseButton1Up:Connect(function()
                    Utilities:Tween(Button.ButtonFrame.ButtonText, .1, {TextColor3 = Colors.PrimaryText})
                    if Hovering then 
                        Utilities:Tween(Button.ButtonFrame.UIStroke, .125, {Color = Colors.Accent})
                    else 
                        Utilities:Tween(Button.ButtonFrame.UIStroke, .125, {Color = Color3.fromRGB(50, 48, 50)}) 
                    end
                end)
                Button.ButtonFrame.ButtonButton.MouseButton1Click:Connect(function() 
                    task.spawn(Info.Callback) 
                end)
            end

            function SectionTable:Label(Info)
                Info = Info or {}
                Info.Text = Info.Text or "Label"
                Info.Color = Info.Color or Colors.PrimaryText
                
                local LabelTable = {}
                
                local Label = Utilities:Create("Frame", {
                    Name = "Label", 
                    Parent = SectionContainer,
                    Size = UDim2.new(1, 0, 0, 16), 
                    BackgroundTransparency = 1
                }, {
                    Utilities:Create("TextLabel", {
                        Name = "LabelText", 
                        Text = Info.Text, 
                        TextColor3 = Info.Color, 
                        RichText = true,
                        BackgroundTransparency = 1, 
                        Size = UDim2.new(1, 0, 1, 0),
                        TextXAlignment = Enum.TextXAlignment.Left, 
                        TextSize = 13, 
                        Font = Enum.Font.SourceSans
                    })
                })
                
                function LabelTable:Set(str, color)
                    Label.LabelText.Text = str or Label.LabelText.Text
                    Label.LabelText.TextColor3 = color or Info.Color
                end
                
                return LabelTable
            end

            return SectionTable
        end
        return TabTable
    end
    return WindowTable
end

-- TESTE LOCAL (remova ao usar no GitHub)
local Window = library:Window({
    Text = "Meu Script"
})

local Tab1 = Window:Tab({
    Text = "Principal"
})

Tab1:Select()

local Section1 = Tab1:Section({
    Text = "Controles",
    Side = "Left"
})

Section1:Button({
    Text = "Testar Botão",
    Callback = function()
        print("Botão funcionando!")
    end
})

local Label1 = Section1:Label({
    Text = "Status: Ativo"
})

return library
