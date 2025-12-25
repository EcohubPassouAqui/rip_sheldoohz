local Components = {}

function Components:CreateButton(parent, config)
    local Button = Instance.new("TextButton")
    Button.Name = config.Name or "Button"
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.Text = config.Name or "Button"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.Gotham
    Button.AutoButtonColor = false
    Button.Parent = parent
    
    Utils:CreateCorner(Button, 6)
    
    Button.MouseEnter:Connect(function()
        Utils:Tween(Button, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)})
    end)
    
    Button.MouseLeave:Connect(function()
        Utils:Tween(Button, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)})
    end)
    
    Button.MouseButton1Click:Connect(function()
        Utils:Tween(Button, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)})
        task.wait(0.1)
        Utils:Tween(Button, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)})
        
        if config.Callback then
            config.Callback()
        end
    end)
    
    return Button
end

function Components:CreateToggle(parent, config)
    -- Frame principal do Toggle
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = config.Name or "Toggle"
    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleFrame.Parent = parent
    
    Utils:CreateCorner(ToggleFrame, 6)
    
    -- Label do Toggle
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = config.Title or config.Name or "Toggle"
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    -- Descrição (opcional)
    local DescLabel
    if config.Description then
        DescLabel = Instance.new("TextLabel")
        DescLabel.Size = UDim2.new(1, -60, 0, 14)
        DescLabel.Position = UDim2.new(0, 10, 0, 18)
        DescLabel.BackgroundTransparency = 1
        DescLabel.Text = config.Description
        DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        DescLabel.TextSize = 11
        DescLabel.Font = Enum.Font.Gotham
        DescLabel.TextXAlignment = Enum.TextXAlignment.Left
        DescLabel.Parent = ToggleFrame
        
        ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
    end
    
    -- Container do botão toggle (slider)
    local ToggleSlider = Instance.new("Frame")
    ToggleSlider.Size = UDim2.fromOffset(36, 18)
    ToggleSlider.AnchorPoint = Vector2.new(1, 0.5)
    ToggleSlider.Position = UDim2.new(1, -10, 0.5, 0)
    ToggleSlider.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ToggleSlider.BackgroundTransparency = 1
    ToggleSlider.Parent = ToggleFrame
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 9)
    SliderCorner.Parent = ToggleSlider
    
    -- Borda do slider
    local ToggleBorder = Instance.new("UIStroke")
    ToggleBorder.Color = Color3.fromRGB(150, 150, 150)
    ToggleBorder.Transparency = 0.5
    ToggleBorder.Parent = ToggleSlider
    
    -- Círculo indicador
    local ToggleCircle = Instance.new("ImageLabel")
    ToggleCircle.AnchorPoint = Vector2.new(0, 0.5)
    ToggleCircle.Size = UDim2.fromOffset(14, 14)
    ToggleCircle.Position = UDim2.new(0, 2, 0.5, 0)
    ToggleCircle.Image = "http://www.roblox.com/asset/?id=12266946128"
    ToggleCircle.ImageColor3 = Color3.fromRGB(150, 150, 150)
    ToggleCircle.ImageTransparency = 0.5
    ToggleCircle.BackgroundTransparency = 1
    ToggleCircle.Parent = ToggleSlider
    
    -- Botão invisível para clique
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(1, 0, 1, 0)
    ToggleButton.BackgroundTransparency = 1
    ToggleButton.Text = ""
    ToggleButton.AutoButtonColor = false
    ToggleButton.Parent = ToggleFrame
    
    -- Estado do Toggle
    local Toggled = config.Default or false
    local Callback = config.Callback or function() end
    
    -- Funções auxiliares
    local function UpdateToggle()
        if Toggled then
            -- Estado ATIVO
            TweenService:Create(
                ToggleSlider,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(0, 170, 255)}
            ):Play()
            
            TweenService:Create(
                ToggleCircle,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Position = UDim2.new(0, 19, 0.5, 0)}
            ):Play()
            
            TweenService:Create(
                ToggleBorder,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Color = Color3.fromRGB(0, 170, 255), Transparency = 0}
            ):Play()
            
            TweenService:Create(
                ToggleCircle,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {ImageColor3 = Color3.fromRGB(255, 255, 255), ImageTransparency = 0}
            ):Play()
        else
            -- Estado INATIVO
            TweenService:Create(
                ToggleSlider,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {BackgroundTransparency = 1}
            ):Play()
            
            TweenService:Create(
                ToggleCircle,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Position = UDim2.new(0, 2, 0.5, 0)}
            ):Play()
            
            TweenService:Create(
                ToggleBorder,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Color = Color3.fromRGB(150, 150, 150), Transparency = 0.5}
            ):Play()
            
            TweenService:Create(
                ToggleCircle,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {ImageColor3 = Color3.fromRGB(150, 150, 150), ImageTransparency = 0.5}
            ):Play()
        end
        
        -- Callback
        pcall(function()
            Callback(Toggled)
        end)
    end
    
    -- Evento de clique
    ToggleButton.MouseButton1Click:Connect(function()
        Toggled = not Toggled
        UpdateToggle()
    end)
    
    -- Métodos públicos do Toggle
    local Toggle = {}
    
    function Toggle:SetValue(Value)
        Toggled = not not Value
        UpdateToggle()
    end
    
    function Toggle:GetValue()
        return Toggled
    end
    
    function Toggle:SetTitle(Title)
        ToggleLabel.Text = Title
    end
    
    function Toggle:SetDesc(Description)
        if DescLabel then
            DescLabel.Text = Description
        end
    end
    
    function Toggle:OnChanged(Func)
        Callback = Func
    end
    
    function Toggle:Destroy()
        ToggleFrame:Destroy()
    end
    
    -- Inicializar estado
    UpdateToggle()
    
    Toggle.Frame = ToggleFrame
    Toggle.Value = Toggled
    Toggle.Callback = Callback
    
    return Toggle
end

function Components:CreateSlider(parent, config)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = config.Name or "Slider"
    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SliderFrame.Parent = parent
    
    Utils:CreateCorner(SliderFrame, 6)
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Size = UDim2.new(1, -110, 0, 20)
    SliderLabel.Position = UDim2.new(0, 10, 0, 5)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = config.Name or "Slider"
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 14
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Parent = SliderFrame
    
    local SliderValue = Instance.new("TextLabel")
    SliderValue.Size = UDim2.fromOffset(100, 20)
    SliderValue.Position = UDim2.new(1, -105, 0, 5)
    SliderValue.BackgroundTransparency = 1
    SliderValue.Text = tostring(config.Default or config.Min or 0)
    SliderValue.TextColor3 = Color3.fromRGB(150, 150, 150)
    SliderValue.TextSize = 12
    SliderValue.Font = Enum.Font.Gotham
    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
    SliderValue.Parent = SliderFrame
    
    local SliderRail = Instance.new("Frame")
    SliderRail.Size = UDim2.new(1, -20, 0, 4)
    SliderRail.Position = UDim2.new(0, 10, 1, -15)
    SliderRail.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderRail.BackgroundTransparency = 0.4
    SliderRail.BorderSizePixel = 0
    SliderRail.Parent = SliderFrame
    
    Utils:CreateCorner(SliderRail, 2)
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(0, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderRail
    
    Utils:CreateCorner(SliderFill, 2)
    
    -- Área de clique expandida para facilitar interação
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(1, 0, 1, 20) -- Aumentado para facilitar clique
    SliderButton.Position = UDim2.new(0, 0, 0, -10)
    SliderButton.BackgroundTransparency = 1
    SliderButton.Text = ""
    SliderButton.AutoButtonColor = false
    SliderButton.Parent = SliderRail
    
    local SliderDot = Instance.new("ImageLabel")
    SliderDot.Name = "SliderDot"
    SliderDot.AnchorPoint = Vector2.new(0.5, 0.5)
    SliderDot.Position = UDim2.new(0, 0, 0.5, 0)
    SliderDot.Size = UDim2.fromOffset(14, 14)
    SliderDot.BackgroundTransparency = 1
    SliderDot.Image = "rbxassetid://12266946128"
    SliderDot.ImageColor3 = Color3.fromRGB(0, 170, 255)
    SliderDot.Parent = SliderRail
    
    local Min = config.Min or 0
    local Max = config.Max or 100
    local Rounding = config.Rounding or 1
    local Default = config.Default or Min
    local CurrentValue = Default
    local Dragging = false
    
    local function Round(value, rounding)
        return math.floor(value / rounding + 0.5) * rounding
    end
    
    local function UpdateSlider(value, animate)
        CurrentValue = Round(math.clamp(value, Min, Max), Rounding)
        local percent = (CurrentValue - Min) / (Max - Min)
        
        if animate then
            TweenService:Create(
                SliderFill,
                TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(percent, 0, 1, 0)}
            ):Play()
            
            TweenService:Create(
                SliderDot,
                TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(percent, 0, 0.5, 0)}
            ):Play()
        else
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            SliderDot.Position = UDim2.new(percent, 0, 0.5, 0)
        end
        
        SliderValue.Text = tostring(CurrentValue)
        
        if config.Callback then
            pcall(function()
                config.Callback(CurrentValue)
            end)
        end
    end
    
    local function GetPercent(mouseX)
        local railPos = SliderRail.AbsolutePosition.X
        local railSize = SliderRail.AbsoluteSize.X
        return math.clamp((mouseX - railPos) / railSize, 0, 1)
    end
    
    -- Mouse Down - Inicia arraste
    SliderButton.MouseButton1Down:Connect(function()
        Dragging = true
        local mousePos = UserInputService:GetMouseLocation()
        local percent = GetPercent(mousePos.X)
        UpdateSlider(Min + (Max - Min) * percent, false)
    end)
    
    -- Mouse Up - Para arraste
    SliderButton.MouseButton1Up:Connect(function()
        Dragging = false
    end)
    
    -- Input Changed - Arraste suave
    local InputConnection = UserInputService.InputChanged:Connect(function(input)
        if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local percent = GetPercent(mousePos.X)
            UpdateSlider(Min + (Max - Min) * percent, false)
        end
    end)
    
    -- Input Ended - Garante que para o arraste
    local InputEndedConnection = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)
    
    -- Métodos públicos
    local Slider = {}
    
    function Slider:SetValue(value)
        UpdateSlider(value, true)
    end
    
    function Slider:GetValue()
        return CurrentValue
    end
    
    function Slider:SetMin(min)
        Min = min
        UpdateSlider(CurrentValue, true)
    end
    
    function Slider:SetMax(max)
        Max = max
        UpdateSlider(CurrentValue, true)
    end
    
    function Slider:Destroy()
        InputConnection:Disconnect()
        InputEndedConnection:Disconnect()
        SliderFrame:Destroy()
    end
    
    -- Inicializar com valor padrão
    UpdateSlider(Default, false)
    
    Slider.Frame = SliderFrame
    Slider.Value = CurrentValue
    
    return Slider
end

function Components:CreateLabel(parent, config)
    local Label = Instance.new("TextLabel")
    Label.Name = config.Name or "Label"
    Label.Size = UDim2.new(1, 0, 0, 25)
    Label.BackgroundTransparency = 1
    Label.Text = config.Text or "Label"
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = parent
    
    return Label
end

function Components:CreateDropdown(parent, config)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = config.Name or "Dropdown"
    DropdownFrame.Size = UDim2.new(1, 0, 0, 35)
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    DropdownFrame.Parent = parent
    DropdownFrame.ClipsDescendants = false
    DropdownFrame.ZIndex = 5
    
    Utils:CreateCorner(DropdownFrame, 6)
    
    local DropdownLabel = Instance.new("TextLabel")
    DropdownLabel.Size = UDim2.new(1, -45, 1, 0)
    DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
    DropdownLabel.BackgroundTransparency = 1
    DropdownLabel.Text = config.Name or "Select"
    DropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownLabel.TextSize = 14
    DropdownLabel.Font = Enum.Font.Gotham
    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    DropdownLabel.ZIndex = 5
    DropdownLabel.Parent = DropdownFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.5, -35, 1, 0)
    ValueLabel.Position = UDim2.new(0.5, 0, 0, 0)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = config.Default or "..."
    ValueLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    ValueLabel.TextSize = 13
    ValueLabel.Font = Enum.Font.Gotham
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.ZIndex = 5
    ValueLabel.Parent = DropdownFrame
    
    local Arrow = Instance.new("ImageLabel")
    Arrow.Size = UDim2.fromOffset(16, 16)
    Arrow.Position = UDim2.new(1, -25, 0.5, -8)
    Arrow.BackgroundTransparency = 1
    Arrow.Image = LucideIcons.ChevronDown
    Arrow.ImageColor3 = Color3.fromRGB(200, 200, 200)
    Arrow.ZIndex = 5
    Arrow.Parent = DropdownFrame
    
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    DropdownButton.BackgroundTransparency = 1
    DropdownButton.Text = ""
    DropdownButton.ZIndex = 6
    DropdownButton.Parent = DropdownFrame
    
    local OptionsList = Instance.new("ScrollingFrame")
    OptionsList.Name = "OptionsList"
    OptionsList.Size = UDim2.new(1, 0, 0, 0)
    OptionsList.Position = UDim2.new(0, 0, 1, 5)
    OptionsList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    OptionsList.BorderSizePixel = 0
    OptionsList.Visible = false
    OptionsList.ScrollBarThickness = 4
    OptionsList.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    OptionsList.CanvasSize = UDim2.new(0, 0, 0, 0)
    OptionsList.ZIndex = 10
    OptionsList.ClipsDescendants = true
    OptionsList.Parent = DropdownFrame
    
    Utils:CreateCorner(OptionsList, 6)
    
    local OptionsStroke = Instance.new("UIStroke")
    OptionsStroke.Color = Color3.fromRGB(40, 40, 40)
    OptionsStroke.Thickness = 1
    OptionsStroke.Parent = OptionsList
    
    local OptionsLayout = Instance.new("UIListLayout")
    OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    OptionsLayout.Padding = UDim.new(0, 2)
    OptionsLayout.Parent = OptionsList
    
    local OptionsPadding = Instance.new("UIPadding")
    OptionsPadding.PaddingTop = UDim.new(0, 5)
    OptionsPadding.PaddingBottom = UDim.new(0, 5)
    OptionsPadding.PaddingLeft = UDim.new(0, 5)
    OptionsPadding.PaddingRight = UDim.new(0, 5)
    OptionsPadding.Parent = OptionsList
    
    local IsOpen = false
    local SelectedValue = config.Default
    
    for _, option in ipairs(config.Options or {}) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Size = UDim2.new(1, -10, 0, 28)
        OptionButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        OptionButton.Text = option
        OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        OptionButton.TextSize = 13
        OptionButton.Font = Enum.Font.Gotham
        OptionButton.ZIndex = 11
        OptionButton.AutoButtonColor = false
        OptionButton.Parent = OptionsList
        
        Utils:CreateCorner(OptionButton, 4)
        
        OptionButton.MouseEnter:Connect(function()
            Utils:Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(45, 45, 45)})
        end)
        
        OptionButton.MouseLeave:Connect(function()
            if SelectedValue == option then
                Utils:Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(0, 170, 255)})
            else
                Utils:Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)})
            end
        end)
        
        if SelectedValue == option then
            OptionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        
        OptionButton.MouseButton1Click:Connect(function()
            for _, btn in ipairs(OptionsList:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
            end
            
            OptionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            
            ValueLabel.Text = option
            SelectedValue = option
            IsOpen = false
            
            Utils:Tween(OptionsList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
            Utils:Tween(Arrow, {Rotation = 0}, 0.2)
            
            task.wait(0.2)
            OptionsList.Visible = false
            
            if config.Callback then
                config.Callback(option)
            end
        end)
    end
    
    OptionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentHeight = OptionsLayout.AbsoluteContentSize.Y + 10
        OptionsList.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
    end)
    
    DropdownButton.MouseButton1Click:Connect(function()
        IsOpen = not IsOpen
        if IsOpen then
            local contentHeight = OptionsLayout.AbsoluteContentSize.Y + 10
            local maxHeight = 150
            local displayHeight = math.min(maxHeight, contentHeight)
            
            OptionsList.Size = UDim2.new(1, 0, 0, 0)
            OptionsList.Visible = true
            Utils:Tween(OptionsList, {Size = UDim2.new(1, 0, 0, displayHeight)}, 0.2)
            Utils:Tween(Arrow, {Rotation = 180}, 0.2)
        else
            Utils:Tween(OptionsList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
            Utils:Tween(Arrow, {Rotation = 0}, 0.2)
            task.wait(0.2)
            OptionsList.Visible = false
        end
    end)
    
    return DropdownFrame
end

function Components:CreateSection(parent, config)
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Name = config.Name or "Section"
    SectionFrame.Size = UDim2.new(1, 0, 0, 30)
    SectionFrame.BackgroundTransparency = 1
    SectionFrame.Parent = parent
    
    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Size = UDim2.new(1, -10, 1, 0)
    SectionLabel.Position = UDim2.new(0, 5, 0, 0)
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.Text = config.Name or "Section"
    SectionLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
    SectionLabel.TextSize = 16
    SectionLabel.Font = Enum.Font.GothamBold
    SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    SectionLabel.Parent = SectionFrame
    
    local Divider = Instance.new("Frame")
    Divider.Size = UDim2.new(1, -10, 0, 2)
    Divider.Position = UDim2.new(0, 5, 1, -5)
    Divider.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    Divider.BorderSizePixel = 0
    Divider.Parent = SectionFrame
    
    Utils:CreateCorner(Divider, 1)
    
    return SectionFrame
end

function Components:CreateParagraph(parent, config)
    local ParagraphFrame = Instance.new("Frame")
    ParagraphFrame.Name = config.Title or "Paragraph"
    ParagraphFrame.Size = UDim2.new(1, 0, 0, 0)
    ParagraphFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ParagraphFrame.AutomaticSize = Enum.AutomaticSize.Y
    ParagraphFrame.Parent = parent
    Utils:CreateCorner(ParagraphFrame, 6)
    
    local ParagraphTitle = Instance.new("TextLabel")
    ParagraphTitle.Size = UDim2.new(1, -20, 0, 20)
    ParagraphTitle.Position = UDim2.new(0, 10, 0, 8)
    ParagraphTitle.BackgroundTransparency = 1
    ParagraphTitle.Text = config.Title or "Title"
    ParagraphTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ParagraphTitle.TextSize = 14
    ParagraphTitle.Font = Enum.Font.GothamBold
    ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left
    ParagraphTitle.TextYAlignment = Enum.TextYAlignment.Top
    ParagraphTitle.Parent = ParagraphFrame
    
    local ParagraphContent = Instance.new("TextLabel")
    ParagraphContent.Size = UDim2.new(1, -20, 0, 0)
    ParagraphContent.Position = UDim2.new(0, 10, 0, 30)
    ParagraphContent.BackgroundTransparency = 1
    ParagraphContent.Text = config.Content or "Content"
    ParagraphContent.TextColor3 = Color3.fromRGB(200, 200, 200)
    ParagraphContent.TextSize = 13
    ParagraphContent.Font = Enum.Font.Gotham
    ParagraphContent.TextXAlignment = Enum.TextXAlignment.Left
    ParagraphContent.TextYAlignment = Enum.TextYAlignment.Top
    ParagraphContent.TextWrapped = true
    ParagraphContent.AutomaticSize = Enum.AutomaticSize.Y
    ParagraphContent.Parent = ParagraphFrame
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingBottom = UDim.new(0, 10)
    Padding.Parent = ParagraphFrame
    
    local ParagraphObject = {}
    
    function ParagraphObject:Set(newConfig)
        if newConfig.Title then
            ParagraphTitle.Text = newConfig.Title
            ParagraphFrame.Name = newConfig.Title
        end
        if newConfig.Content then
            ParagraphContent.Text = newConfig.Content
        end
    end
    
    return ParagraphObject
end

function Components:CreateColorPicker(parent, config)
    local ColorFrame = Instance.new("Frame")
    ColorFrame.Name = config.Name or "ColorPicker"
    ColorFrame.Size = UDim2.new(1, 0, 0, 35)
    ColorFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ColorFrame.Parent = parent
    
    Utils:CreateCorner(ColorFrame, 6)
    
    local ColorLabel = Instance.new("TextLabel")
    ColorLabel.Size = UDim2.new(1, -50, 1, 0)
    ColorLabel.Position = UDim2.new(0, 10, 0, 0)
    ColorLabel.BackgroundTransparency = 1
    ColorLabel.Text = config.Name or "Color"
    ColorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ColorLabel.TextSize = 14
    ColorLabel.Font = Enum.Font.Gotham
    ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
    ColorLabel.Parent = ColorFrame
    
    local ColorDisplayBG = Instance.new("ImageLabel")
    ColorDisplayBG.Size = UDim2.fromOffset(30, 25)
    ColorDisplayBG.Position = UDim2.new(1, -40, 0.5, -12.5)
    ColorDisplayBG.Image = "http://www.roblox.com/asset/?id=14204231522"
    ColorDisplayBG.ImageTransparency = 0.45
    ColorDisplayBG.ScaleType = Enum.ScaleType.Tile
    ColorDisplayBG.TileSize = UDim2.fromOffset(40, 40)
    ColorDisplayBG.BackgroundTransparency = 1
    ColorDisplayBG.Parent = ColorFrame
    
    Utils:CreateCorner(ColorDisplayBG, 4)
    
    local ColorDisplay = Instance.new("Frame")
    ColorDisplay.Size = UDim2.fromScale(1, 1)
    ColorDisplay.BackgroundColor3 = config.Default or Color3.fromRGB(255, 255, 255)
    ColorDisplay.BackgroundTransparency = config.Transparency or 0
    ColorDisplay.Parent = ColorDisplayBG
    
    Utils:CreateCorner(ColorDisplay, 4)
    
    local ColorButton = Instance.new("TextButton")
    ColorButton.Size = UDim2.fromOffset(30, 25)
    ColorButton.Position = UDim2.new(1, -40, 0.5, -12.5)
    ColorButton.BackgroundTransparency = 1
    ColorButton.Text = ""
    ColorButton.ZIndex = 10
    ColorButton.Parent = ColorFrame
    
    local CurrentHue = 0
    local CurrentSat = 1
    local CurrentVib = 1
    local CurrentTransparency = config.Transparency or 0
    
    local function SetHSVFromRGB(color)
        CurrentHue, CurrentSat, CurrentVib = Color3.toHSV(color)
    end
    
    SetHSVFromRGB(config.Default or Color3.fromRGB(255, 255, 255))
    
    local function CreateColorDialog()
        local DialogFrame = Instance.new("Frame")
        DialogFrame.Name = "ColorDialog"
        DialogFrame.Size = UDim2.fromOffset(430, 330)
        DialogFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        DialogFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        DialogFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        DialogFrame.BorderSizePixel = 0
        DialogFrame.ZIndex = 100
        DialogFrame.Parent = ScreenGui
        
        Utils:CreateCorner(DialogFrame, 8)
        
        local DialogStroke = Instance.new("UIStroke")
        DialogStroke.Color = Color3.fromRGB(40, 40, 40)
        DialogStroke.Thickness = 2
        DialogStroke.Parent = DialogFrame
        
        local DialogTitle = Instance.new("TextLabel")
        DialogTitle.Size = UDim2.new(1, -40, 0, 30)
        DialogTitle.Position = UDim2.new(0, 20, 0, 15)
        DialogTitle.BackgroundTransparency = 1
        DialogTitle.Text = config.Name or "Color Picker"
        DialogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        DialogTitle.TextSize = 16
        DialogTitle.Font = Enum.Font.GothamBold
        DialogTitle.TextXAlignment = Enum.TextXAlignment.Left
        DialogTitle.ZIndex = 101
        DialogTitle.Parent = DialogFrame
        
        local CloseButton = Instance.new("TextButton")
        CloseButton.Size = UDim2.fromOffset(30, 30)
        CloseButton.Position = UDim2.new(1, -45, 0, 10)
        CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        CloseButton.Text = "X"
        CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseButton.TextSize = 14
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.ZIndex = 101
        CloseButton.Parent = DialogFrame
        
        Utils:CreateCorner(CloseButton, 6)
        
        local SatVibMap = Instance.new("ImageLabel")
        SatVibMap.Size = UDim2.fromOffset(180, 160)
        SatVibMap.Position = UDim2.fromOffset(20, 55)
        SatVibMap.Image = "rbxassetid://4155801252"
        SatVibMap.BackgroundColor3 = Color3.fromHSV(CurrentHue, 1, 1)
        SatVibMap.ZIndex = 101
        SatVibMap.Parent = DialogFrame
        
        Utils:CreateCorner(SatVibMap, 4)
        
        local SatCursor = Instance.new("ImageLabel")
        SatCursor.Size = UDim2.fromOffset(18, 18)
        SatCursor.Position = UDim2.new(CurrentSat, 0, 1 - CurrentVib, 0)
        SatCursor.AnchorPoint = Vector2.new(0.5, 0.5)
        SatCursor.BackgroundTransparency = 1
        SatCursor.Image = "http://www.roblox.com/asset/?id=4805639000"
        SatCursor.ZIndex = 102
        SatCursor.Parent = SatVibMap
        
        local HueGradient = Instance.new("UIGradient")
        HueGradient.Rotation = 90
        local hueColors = {}
        for i = 0, 1, 0.1 do
            table.insert(hueColors, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1)))
        end
        HueGradient.Color = ColorSequence.new(hueColors)
        
        local HueSlider = Instance.new("Frame")
        HueSlider.Size = UDim2.fromOffset(12, 190)
        HueSlider.Position = UDim2.fromOffset(210, 55)
        HueSlider.ZIndex = 101
        HueSlider.Parent = DialogFrame
        
        Utils:CreateCorner(HueSlider, 6)
        HueGradient.Parent = HueSlider
        
        local HueCursor = Instance.new("ImageLabel")
        HueCursor.Size = UDim2.fromOffset(14, 14)
        HueCursor.Position = UDim2.new(0, -1, CurrentHue, -7)
        HueCursor.BackgroundTransparency = 1
        HueCursor.Image = "http://www.roblox.com/asset/?id=12266946128"
        HueCursor.ImageColor3 = Color3.fromRGB(255, 255, 255)
        HueCursor.ZIndex = 102
        HueCursor.Parent = HueSlider
        
        local OldColorBG = Instance.new("ImageLabel")
        OldColorBG.Size = UDim2.fromOffset(88, 24)
        OldColorBG.Position = UDim2.fromOffset(112, 220)
        OldColorBG.Image = "http://www.roblox.com/asset/?id=14204231522"
        OldColorBG.ImageTransparency = 0.45
        OldColorBG.ScaleType = Enum.ScaleType.Tile
        OldColorBG.TileSize = UDim2.fromOffset(40, 40)
        OldColorBG.BackgroundTransparency = 1
        OldColorBG.ZIndex = 101
        OldColorBG.Parent = DialogFrame
        
        Utils:CreateCorner(OldColorBG, 4)
        
        local OldColor = Instance.new("Frame")
        OldColor.Size = UDim2.fromScale(1, 1)
        OldColor.BackgroundColor3 = ColorDisplay.BackgroundColor3
        OldColor.BackgroundTransparency = CurrentTransparency
        OldColor.ZIndex = 101
        OldColor.Parent = OldColorBG
        
        Utils:CreateCorner(OldColor, 4)
        
        local NewColorBG = Instance.new("ImageLabel")
        NewColorBG.Size = UDim2.fromOffset(88, 24)
        NewColorBG.Position = UDim2.fromOffset(20, 220)
        NewColorBG.Image = "http://www.roblox.com/asset/?id=14204231522"
        NewColorBG.ImageTransparency = 0.45
        NewColorBG.ScaleType = Enum.ScaleType.Tile
        NewColorBG.TileSize = UDim2.fromOffset(40, 40)
        NewColorBG.BackgroundTransparency = 1
        NewColorBG.ZIndex = 101
        NewColorBG.Parent = DialogFrame
        
        Utils:CreateCorner(NewColorBG, 4)
        
        local NewColor = Instance.new("Frame")
        NewColor.Size = UDim2.fromScale(1, 1)
        NewColor.BackgroundColor3 = Color3.fromHSV(CurrentHue, CurrentSat, CurrentVib)
        NewColor.BackgroundTransparency = CurrentTransparency
        NewColor.ZIndex = 101
        NewColor.Parent = NewColorBG
        
        Utils:CreateCorner(NewColor, 4)
        
        local TransparencySlider, TransparencyCursor
        if config.Transparency then
            local TransparencyBG = Instance.new("ImageLabel")
            TransparencyBG.Size = UDim2.fromOffset(12, 190)
            TransparencyBG.Position = UDim2.fromOffset(230, 55)
            TransparencyBG.Image = "http://www.roblox.com/asset/?id=14204231522"
            TransparencyBG.ImageTransparency = 0.45
            TransparencyBG.ScaleType = Enum.ScaleType.Tile
            TransparencyBG.TileSize = UDim2.fromOffset(40, 40)
            TransparencyBG.BackgroundTransparency = 1
            TransparencyBG.ZIndex = 101
            TransparencyBG.Parent = DialogFrame
            
            Utils:CreateCorner(TransparencyBG, 6)
            
            TransparencySlider = Instance.new("Frame")
            TransparencySlider.Size = UDim2.fromScale(1, 1)
            TransparencySlider.BackgroundColor3 = Color3.fromHSV(CurrentHue, CurrentSat, CurrentVib)
            TransparencySlider.ZIndex = 101
            TransparencySlider.Parent = TransparencyBG
            
            Utils:CreateCorner(TransparencySlider, 6)
            
            local TransGradient = Instance.new("UIGradient")
            TransGradient.Rotation = 270
            TransGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 1)
            })
            TransGradient.Parent = TransparencySlider
            
            TransparencyCursor = Instance.new("ImageLabel")
            TransparencyCursor.Size = UDim2.fromOffset(14, 14)
            TransparencyCursor.Position = UDim2.new(0, -1, 1 - CurrentTransparency, -7)
            TransparencyCursor.BackgroundTransparency = 1
            TransparencyCursor.Image = "http://www.roblox.com/asset/?id=12266946128"
            TransparencyCursor.ImageColor3 = Color3.fromRGB(255, 255, 255)
            TransparencyCursor.ZIndex = 102
            TransparencyCursor.Parent = TransparencyBG
        end
        
        local DoneButton = Instance.new("TextButton")
        DoneButton.Size = UDim2.fromOffset(90, 32)
        DoneButton.Position = UDim2.fromOffset(210, 270)
        DoneButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        DoneButton.Text = "Done"
        DoneButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        DoneButton.TextSize = 14
        DoneButton.Font = Enum.Font.GothamBold
        DoneButton.ZIndex = 101
        DoneButton.Parent = DialogFrame
        
        Utils:CreateCorner(DoneButton, 6)
        
        local CancelButton = Instance.new("TextButton")
        CancelButton.Size = UDim2.fromOffset(90, 32)
        CancelButton.Position = UDim2.fromOffset(310, 270)
        CancelButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        CancelButton.Text = "Cancel"
        CancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CancelButton.TextSize = 14
        CancelButton.Font = Enum.Font.GothamBold
        CancelButton.ZIndex = 101
        CancelButton.Parent = DialogFrame
        
        Utils:CreateCorner(CancelButton, 6)
        
        local function UpdateDisplay()
            SatVibMap.BackgroundColor3 = Color3.fromHSV(CurrentHue, 1, 1)
            HueCursor.Position = UDim2.new(0, -1, CurrentHue, -7)
            SatCursor.Position = UDim2.new(CurrentSat, 0, 1 - CurrentVib, 0)
            NewColor.BackgroundColor3 = Color3.fromHSV(CurrentHue, CurrentSat, CurrentVib)
            NewColor.BackgroundTransparency = CurrentTransparency
            
            if config.Transparency and TransparencySlider then
                TransparencySlider.BackgroundColor3 = Color3.fromHSV(CurrentHue, CurrentSat, CurrentVib)
                TransparencyCursor.Position = UDim2.new(0, -1, 1 - CurrentTransparency, -7)
            end
        end
        
        local SatVibDragging = false
        SatVibMap.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                SatVibDragging = true
            end
        end)
        
        SatVibMap.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                SatVibDragging = false
            end
        end)
        
        local HueDragging = false
        HueSlider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                HueDragging = true
            end
        end)
        
        HueSlider.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                HueDragging = false
            end
        end)
        
        local TransDragging = false
        if config.Transparency and TransparencySlider then
            TransparencySlider.Parent.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    TransDragging = true
                end
            end)
            
            TransparencySlider.Parent.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    TransDragging = false
                end
            end)
        end
        
        RunService.RenderStepped:Connect(function()
            if SatVibDragging then
                local mousePos = UserInputService:GetMouseLocation()
                local relativeX = math.clamp(mousePos.X - SatVibMap.AbsolutePosition.X, 0, SatVibMap.AbsoluteSize.X)
                local relativeY = math.clamp(mousePos.Y - SatVibMap.AbsolutePosition.Y, 0, SatVibMap.AbsoluteSize.Y)
                
                CurrentSat = relativeX / SatVibMap.AbsoluteSize.X
                CurrentVib = 1 - (relativeY / SatVibMap.AbsoluteSize.Y)
                UpdateDisplay()
            end
            
            if HueDragging then
                local mousePos = UserInputService:GetMouseLocation()
                local relativeY = math.clamp(mousePos.Y - HueSlider.AbsolutePosition.Y, 0, HueSlider.AbsoluteSize.Y)
                
                CurrentHue = relativeY / HueSlider.AbsoluteSize.Y
                UpdateDisplay()
            end
            
            if TransDragging and config.Transparency and TransparencySlider then
                local mousePos = UserInputService:GetMouseLocation()
                local relativeY = math.clamp(mousePos.Y - TransparencySlider.Parent.AbsolutePosition.Y, 0, TransparencySlider.Parent.AbsoluteSize.Y)
                
                CurrentTransparency = 1 - (relativeY / TransparencySlider.Parent.AbsoluteSize.Y)
                UpdateDisplay()
            end
        end)
        
        DoneButton.MouseButton1Click:Connect(function()
            ColorDisplay.BackgroundColor3 = Color3.fromHSV(CurrentHue, CurrentSat, CurrentVib)
            ColorDisplay.BackgroundTransparency = CurrentTransparency
            
            if config.Callback then
                config.Callback(Color3.fromHSV(CurrentHue, CurrentSat, CurrentVib), CurrentTransparency)
            end
            
            DialogFrame:Destroy()
        end)
        
        CancelButton.MouseButton1Click:Connect(function()
            DialogFrame:Destroy()
        end)
        
        CloseButton.MouseButton1Click:Connect(function()
            DialogFrame:Destroy()
        end)
        
        UpdateDisplay()
    end
    
    ColorButton.MouseButton1Click:Connect(function()
        CreateColorDialog()
    end)
    
    return ColorFrame
end

function Components:CreateDivider(parent, config)
    local DividerFrame = Instance.new("Frame")
    DividerFrame.Name = "Divider"
    DividerFrame.Size = UDim2.new(1, 0, 0, 15)
    DividerFrame.BackgroundTransparency = 1
    DividerFrame.Parent = parent
    
    local DividerLine = Instance.new("Frame")
    DividerLine.Size = UDim2.new(1, -20, 0, 1)
    DividerLine.Position = UDim2.new(0, 10, 0.5, 0)
    DividerLine.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    DividerLine.BorderSizePixel = 0
    DividerLine.Parent = DividerFrame
    
    if config and config.Text then
        local DividerLabel = Instance.new("TextLabel")
        DividerLabel.Size = UDim2.new(0, 0, 1, 0)
        DividerLabel.Position = UDim2.new(0.5, 0, 0, 0)
        DividerLabel.AnchorPoint = Vector2.new(0.5, 0)
        DividerLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        DividerLabel.Text = " " .. config.Text .. " "
        DividerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        DividerLabel.TextSize = 12
        DividerLabel.Font = Enum.Font.Gotham
        DividerLabel.AutomaticSize = Enum.AutomaticSize.X
        DividerLabel.Parent = DividerFrame
    end
    
    return DividerFrame
end
