local EcoHub = {}

local Theme = {
	Name = "Darker Force",
	Accent = Color3.fromRGB(72, 138, 182),
	AcrylicMain = Color3.fromRGB(15, 15, 15),
	AcrylicBorder = Color3.fromRGB(40, 40, 40),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(10, 10, 10), Color3.fromRGB(5, 5, 5)),
	AcrylicNoise = 0.94,
	TitleBarLine = Color3.fromRGB(50, 50, 50),
	Tab = Color3.fromRGB(80, 80, 80),
	Element = Color3.fromRGB(45, 45, 45),
	ElementBorder = Color3.fromRGB(20, 20, 20),
	InElementBorder = Color3.fromRGB(35, 35, 35),
	ElementTransparency = 0.65,
	BoxHeader = Color3.fromRGB(30, 30, 30),
	BoxContent = Color3.fromRGB(25, 25, 25),
}

local Icons = {
	Close = "rbxassetid://9886659671",
	Min = "rbxassetid://9886659276",
	Max = "rbxassetid://9886659406",
	Restore = "rbxassetid://9886659001",
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EcoHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not ScreenGui.Parent then
	ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = ScreenGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
LoadingFrame.Size = UDim2.new(0, 300, 0, 150)
LoadingFrame.ZIndex = 100

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 10)
LoadingCorner.Parent = LoadingFrame

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Parent = LoadingFrame
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Position = UDim2.new(0, 0, 0, 20)
LoadingTitle.Size = UDim2.new(1, 0, 0, 30)
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.Text = "EcoHub"
LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingTitle.TextSize = 24
LoadingTitle.ZIndex = 101

local LoadingStatus = Instance.new("TextLabel")
LoadingStatus.Parent = LoadingFrame
LoadingStatus.BackgroundTransparency = 1
LoadingStatus.Position = UDim2.new(0, 0, 0, 60)
LoadingStatus.Size = UDim2.new(1, 0, 0, 20)
LoadingStatus.Font = Enum.Font.Gotham
LoadingStatus.Text = "Carregando..."
LoadingStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
LoadingStatus.TextSize = 14
LoadingStatus.ZIndex = 101

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = LoadingFrame
LoadingBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LoadingBar.BorderSizePixel = 0
LoadingBar.Position = UDim2.new(0.1, 0, 0, 100)
LoadingBar.Size = UDim2.new(0.8, 0, 0, 6)
LoadingBar.ZIndex = 101

local LoadingBarCorner = Instance.new("UICorner")
LoadingBarCorner.CornerRadius = UDim.new(1, 0)
LoadingBarCorner.Parent = LoadingBar

local LoadingProgress = Instance.new("Frame")
LoadingProgress.Parent = LoadingBar
LoadingProgress.BackgroundColor3 = Theme.Accent
LoadingProgress.BorderSizePixel = 0
LoadingProgress.Size = UDim2.new(0, 0, 1, 0)
LoadingProgress.ZIndex = 102

local LoadingProgressCorner = Instance.new("UICorner")
LoadingProgressCorner.CornerRadius = UDim.new(1, 0)
LoadingProgressCorner.Parent = LoadingProgress

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Theme.AcrylicMain
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Theme.AcrylicBorder
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Gradient = Instance.new("UIGradient")
Gradient.Color = Theme.AcrylicGradient
Gradient.Rotation = math.random(0, 360)
Gradient.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Theme.AcrylicBorder
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 32)

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Text = "EcoHub"
Title.TextColor3 = Color3.fromRGB(230, 230, 230)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Parent = TitleBar
ButtonHolder.AnchorPoint = Vector2.new(1, 0.5)
ButtonHolder.Position = UDim2.new(1, -8, 0.5, 0)
ButtonHolder.Size = UDim2.new(0, 90, 0, 24)
ButtonHolder.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout")
Layout.FillDirection = Enum.FillDirection.Horizontal
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
Layout.VerticalAlignment = Enum.VerticalAlignment.Center
Layout.Padding = UDim.new(0, 8)
Layout.Parent = ButtonHolder

local function MakeButton(iconId, color, hoverColor)
	local btn = Instance.new("ImageButton")
	btn.BackgroundTransparency = 0.5
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Image = iconId
	btn.ImageColor3 = color
	btn.Size = UDim2.new(0, 24, 0, 24)
	btn.Parent = ButtonHolder
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 4)
	btnCorner.Parent = btn
	
	btn.MouseEnter:Connect(function()
		btn.BackgroundTransparency = 0
		btn.BackgroundColor3 = hoverColor or Theme.Accent
		btn.ImageColor3 = Color3.fromRGB(255, 255, 255)
	end)
	
	btn.MouseLeave:Connect(function()
		btn.BackgroundTransparency = 0.5
		btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		btn.ImageColor3 = color
	end)
	
	return btn
end

local MinButton = MakeButton(Icons.Min, Color3.fromRGB(220, 220, 220), Color3.fromRGB(60, 120, 180))
local MaxButton = MakeButton(Icons.Max, Color3.fromRGB(220, 220, 220), Color3.fromRGB(60, 120, 180))
local CloseButton = MakeButton(Icons.Close, Color3.fromRGB(255, 100, 100), Color3.fromRGB(200, 50, 50))

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local dragStart, startPos, dragging = nil, nil, false
local minimized = false
local maximized = false
local originalSize = MainFrame.Size
local originalPos = MainFrame.Position

local function enableDrag(frame)
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not maximized then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
		end
	end)
	frame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end
enableDrag(TitleBar)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Theme.Element
ContentFrame.BorderSizePixel = 1
ContentFrame.BorderColor3 = Theme.ElementBorder
ContentFrame.Position = UDim2.new(0, 0, 0, 32)
ContentFrame.Size = UDim2.new(1, 0, 1, -32)
ContentFrame.ClipsDescendants = true

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentFrame

local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Parent = ContentFrame
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabBar.BorderSizePixel = 0
TabBar.Size = UDim2.new(0, 140, 1, 0)

local TabList = Instance.new("UIListLayout")
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 4)
TabList.Parent = TabBar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 8)
TabPadding.PaddingBottom = UDim.new(0, 8)
TabPadding.PaddingLeft = UDim.new(0, 6)
TabPadding.PaddingRight = UDim.new(0, 6)
TabPadding.Parent = TabBar

local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = ContentFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 140, 0, 0)
TabContainer.Size = UDim2.new(1, -140, 1, 0)

local Tabs = {}
local CurrentTab = nil

local function AnimateLoading()
	local steps = {
		{progress = 0.2, text = "Iniciando componentes..."},
		{progress = 0.4, text = "Carregando interface..."},
		{progress = 0.6, text = "Preparando sistema..."},
		{progress = 0.8, text = "Finalizando..."},
		{progress = 1.0, text = "Completo!"}
	}
	
	for _, step in ipairs(steps) do
		LoadingStatus.Text = step.text
		TweenService:Create(LoadingProgress, TweenInfo.new(0.3), {
			Size = UDim2.new(step.progress, 0, 1, 0)
		}):Play()
		task.wait(0.4)
	end
	
	task.wait(0.3)
	
	TweenService:Create(LoadingFrame, TweenInfo.new(0.3), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0)
	}):Play()
	
	task.wait(0.3)
	LoadingFrame:Destroy()
	MainFrame.Visible = true
end

task.spawn(AnimateLoading)

function EcoHub:CreateWindow(config)
	config = config or {}
	Title.Text = config.Title or "EcoHub Library"
	return self
end

function EcoHub:AddTab(config)
	config = config or {}
	local tabName = config.Title or "Tab"
	
	local TabButton = Instance.new("TextButton")
	TabButton.Name = tabName
	TabButton.Parent = TabBar
	TabButton.BackgroundColor3 = Theme.Tab
	TabButton.BorderSizePixel = 0
	TabButton.Size = UDim2.new(1, 0, 0, 36)
	TabButton.Font = Enum.Font.GothamSemibold
	TabButton.Text = tabName
	TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
	TabButton.TextSize = 14
	TabButton.TextXAlignment = Enum.TextXAlignment.Left
	TabButton.ClipsDescendants = true
	
	local TabBtnCorner = Instance.new("UICorner")
	TabBtnCorner.CornerRadius = UDim.new(0, 6)
	TabBtnCorner.Parent = TabButton
	
	local TabBtnPadding = Instance.new("UIPadding")
	TabBtnPadding.PaddingLeft = UDim.new(0, 12)
	TabBtnPadding.Parent = TabButton
	
	local TabContent = Instance.new("ScrollingFrame")
	TabContent.Name = tabName .. "Content"
	TabContent.Parent = TabContainer
	TabContent.BackgroundTransparency = 1
	TabContent.BorderSizePixel = 0
	TabContent.Size = UDim2.new(1, 0, 1, 0)
	TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabContent.ScrollBarThickness = 4
	TabContent.ScrollBarImageColor3 = Theme.Accent
	TabContent.Visible = false
	
	local TabContentList = Instance.new("UIListLayout")
	TabContentList.SortOrder = Enum.SortOrder.LayoutOrder
	TabContentList.Padding = UDim.new(0, 8)
	TabContentList.Parent = TabContent
	
	local TabContentPadding = Instance.new("UIPadding")
	TabContentPadding.PaddingTop = UDim.new(0, 10)
	TabContentPadding.PaddingBottom = UDim.new(0, 10)
	TabContentPadding.PaddingLeft = UDim.new(0, 10)
	TabContentPadding.PaddingRight = UDim.new(0, 10)
	TabContentPadding.Parent = TabContent
	
	TabContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentList.AbsoluteContentSize.Y + 20)
	end)
	
	TabButton.MouseButton1Click:Connect(function()
		for _, tab in pairs(Tabs) do
			tab.Button.BackgroundColor3 = Theme.Tab
			tab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
			tab.Content.Visible = false
		end
		TabButton.BackgroundColor3 = Theme.Accent
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabContent.Visible = true
		CurrentTab = tabName
	end)
	
	TabButton.MouseEnter:Connect(function()
		if CurrentTab ~= tabName then
			TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		end
	end)
	
	TabButton.MouseLeave:Connect(function()
		if CurrentTab ~= tabName then
			TabButton.BackgroundColor3 = Theme.Tab
		end
	end)
	
	Tabs[tabName] = {
		Button = TabButton,
		Content = TabContent
	}
	
	if not CurrentTab then
		TabButton.BackgroundColor3 = Theme.Accent
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabContent.Visible = true
		CurrentTab = tabName
	end
	
	local Tab = {}
	
	function Tab:AddBox(name)
		local Box = {}
		
		local BoxFrame = Instance.new("Frame")
		BoxFrame.Name = name
		BoxFrame.Parent = TabContent
		BoxFrame.BackgroundColor3 = Theme.BoxHeader
		BoxFrame.BorderSizePixel = 1
		BoxFrame.BorderColor3 = Theme.ElementBorder
		BoxFrame.Size = UDim2.new(1, -10, 0, 40)
		BoxFrame.ClipsDescendants = true
		
		local BoxCorner = Instance.new("UICorner")
		BoxCorner.CornerRadius = UDim.new(0, 6)
		BoxCorner.Parent = BoxFrame
		
		-- Barra azul vertical à esquerda (4 pixels de largura)
		local AccentBar = Instance.new("Frame")
		AccentBar.Name = "AccentBar"
		AccentBar.Parent = BoxFrame
		AccentBar.BackgroundColor3 = Theme.Accent
		AccentBar.Size = UDim2.new(0, 4, 1, 0)
		AccentBar.Position = UDim2.new(0, 0, 0, 0)
		
		local BoxHeader = Instance.new("TextButton")
		BoxHeader.Name = "Header"
		BoxHeader.Parent = BoxFrame
		BoxHeader.BackgroundTransparency = 1
		-- deslocar para direita para não sobrepor a barra azul
		BoxHeader.Position = UDim2.new(0, 8, 0, 0)
		BoxHeader.Size = UDim2.new(1, -8, 0, 40)
		BoxHeader.Font = Enum.Font.GothamBold
		BoxHeader.Text = "  " .. name
		BoxHeader.TextColor3 = Color3.fromRGB(230, 230, 230)
		BoxHeader.TextSize = 14
		BoxHeader.TextXAlignment = Enum.TextXAlignment.Left
		BoxHeader.AutoButtonColor = false
		
		local Arrow = Instance.new("TextLabel")
		Arrow.Parent = BoxHeader
		Arrow.BackgroundTransparency = 1
		Arrow.Position = UDim2.new(1, -30, 0.5, -10)
		Arrow.Size = UDim2.new(0, 20, 0, 20)
		Arrow.Font = Enum.Font.GothamBold
		Arrow.Text = "▼"
		Arrow.TextColor3 = Theme.Accent
		Arrow.TextSize = 12
		
		local BoxContent = Instance.new("Frame")
		BoxContent.Name = "BoxContent"
		BoxContent.Parent = BoxFrame
		BoxContent.BackgroundTransparency = 1
		BoxContent.Position = UDim2.new(0, 0, 0, 40)
		BoxContent.Size = UDim2.new(1, 0, 0, 0)
		BoxContent.Visible = false
		BoxContent.ClipsDescendants = false
		
		local BoxLayout = Instance.new("UIListLayout")
		BoxLayout.Parent = BoxContent
		BoxLayout.SortOrder = Enum.SortOrder.LayoutOrder
		BoxLayout.Padding = UDim.new(0, 6)
		
		local BoxPadding = Instance.new("UIPadding")
		BoxPadding.Parent = BoxContent
		BoxPadding.PaddingTop = UDim.new(0, 8)
		BoxPadding.PaddingBottom = UDim.new(0, 8)
		BoxPadding.PaddingLeft = UDim.new(0, 8)
		BoxPadding.PaddingRight = UDim.new(0, 8)
	
		local boxOpen = false
		local animating = false
		
		BoxHeader.MouseButton1Click:Connect(function()
			if animating then return end
			animating = true
			
			boxOpen = not boxOpen
			
			if boxOpen then
				BoxContent.Visible = true
				
				local contentHeight = BoxLayout.AbsoluteContentSize.Y + 16
				
				TweenService:Create(BoxFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
					Size = UDim2.new(1, -10, 0, 40 + contentHeight)
				}):Play()
				
				TweenService:Create(Arrow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
					Rotation = 180
				}):Play()
				
				BoxContent.Size = UDim2.new(1, 0, 0, contentHeight)
				
				task.wait(0.3)
				animating = false
			else
				TweenService:Create(BoxFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
					Size = UDim2.new(1, -10, 0, 40)
				}):Play()
				
				TweenService:Create(Arrow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
					Rotation = 0
				}):Play()
				
				task.wait(0.3)
				BoxContent.Visible = false
				animating = false
			end
		end)
		
		BoxHeader.MouseEnter:Connect(function()
			TweenService:Create(BoxFrame, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			}):Play()
		end)
		
		BoxHeader.MouseLeave:Connect(function()
			TweenService:Create(BoxFrame, TweenInfo.new(0.2), {
				BackgroundColor3 = Theme.BoxHeader
			}):Play()
		end)
		
		BoxLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if boxOpen and not animating then
				local contentHeight = BoxLayout.AbsoluteContentSize.Y + 16
				BoxContent.Size = UDim2.new(1, 0, 0, contentHeight)
				BoxFrame.Size = UDim2.new(1, -10, 0, 40 + contentHeight)
			end
		end)
		
		function Box:AddButton(config)
			config = config or {}
			local Container = Instance.new("Frame")
			Container.Parent = BoxContent
			Container.BackgroundColor3 = Theme.BoxContent
			Container.BorderSizePixel = 0
			Container.Size = UDim2.new(1, 0, 0, 45)
			
			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 4)
			Corner.Parent = Container
			
			local Button = Instance.new("TextButton")
			Button.Parent = Container
			Button.BackgroundColor3 = Theme.Accent
			Button.BorderSizePixel = 0
			Button.Position = UDim2.new(1, -70, 0.5, -14)
			Button.Size = UDim2.new(0, 60, 0, 28)
			Button.Font = Enum.Font.GothamBold
			Button.Text = "Click"
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.TextSize = 11
			
			local BtnCorner = Instance.new("UICorner")
			BtnCorner.CornerRadius = UDim.new(0, 4)
			BtnCorner.Parent = Button
			
			local TitleLabel = Instance.new("TextLabel")
			TitleLabel.Parent = Container
			TitleLabel.BackgroundTransparency = 1
			TitleLabel.Position = UDim2.new(0, 10, 0, 5)
			TitleLabel.Size = UDim2.new(1, -85, 0, 16)
			TitleLabel.Font = Enum.Font.GothamSemibold
			TitleLabel.Text = config.Title or "Button"
			TitleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
			TitleLabel.TextSize = 12
			TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			local DescLabel = Instance.new("TextLabel")
			DescLabel.Parent = Container
			DescLabel.BackgroundTransparency = 1
			DescLabel.Position = UDim2.new(0, 10, 0, 22)
			DescLabel.Size = UDim2.new(1, -85, 0, 18)
			DescLabel.Font = Enum.Font.Gotham
			DescLabel.Text = config.Description or ""
			DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
			DescLabel.TextSize = 10
			DescLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			Button.MouseButton1Click:Connect(function()
				if config.Callback then
					config.Callback()
				end
			end)
			
			Button.MouseEnter:Connect(function()
				Button.BackgroundColor3 = Color3.fromRGB(90, 160, 200)
			end)
			
			Button.MouseLeave:Connect(function()
				Button.BackgroundColor3 = Theme.Accent
			end)
		end
		
		function Box:AddToggle(id, config)
			config = config or {}
			local toggled = config.Default or false
			
			local Container = Instance.new("Frame")
			Container.Parent = BoxContent
			Container.BackgroundColor3 = Theme.BoxContent
			Container.BorderSizePixel = 0
			Container.Size = UDim2.new(1, 0, 0, 38)
			
			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 4)
			Corner.Parent = Container
			
			local TitleLabel = Instance.new("TextLabel")
			TitleLabel.Parent = Container
			TitleLabel.BackgroundTransparency = 1
			TitleLabel.Position = UDim2.new(0, 10, 0, 0)
			TitleLabel.Size = UDim2.new(1, -60, 1, 0)
			TitleLabel.Font = Enum.Font.GothamSemibold
			TitleLabel.Text = config.Title or "Toggle"
			TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
			TitleLabel.TextSize = 12
			TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			local ToggleButton = Instance.new("TextButton")
			ToggleButton.Parent = Container
			ToggleButton.BackgroundColor3 = toggled and Theme.Accent or Color3.fromRGB(50, 50, 50)
			ToggleButton.BorderSizePixel = 0
			ToggleButton.Position = UDim2.new(1, -48, 0.5, -10)
			ToggleButton.Size = UDim2.new(0, 40, 0, 20)
			ToggleButton.Text = ""
			
			local ToggleCorner = Instance.new("UICorner")
			ToggleCorner.CornerRadius = UDim.new(1, 0)
			ToggleCorner.Parent = ToggleButton
			
			local ToggleCircle = Instance.new("Frame")
			ToggleCircle.Parent = ToggleButton
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleCircle.BorderSizePixel = 0
			ToggleCircle.Position = toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
			ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
			
			local CircleCorner = Instance.new("UICorner")
			CircleCorner.CornerRadius = UDim.new(1, 0)
			CircleCorner.Parent = ToggleCircle
			
			local Toggle = {}
			Toggle.Value = toggled
			
			function Toggle:SetValue(value)
				toggled = value
				Toggle.Value = value
				
				TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
					BackgroundColor3 = toggled and Theme.Accent or Color3.fromRGB(50, 50, 50)
				}):Play()
				
				TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {
					Position = toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
				}):Play()
				
				if config.Callback then
					config.Callback(toggled)
				end
			end
			
			ToggleButton.MouseButton1Click:Connect(function()
				Toggle:SetValue(not toggled)
			end)
			
			return Toggle
		end
		
		function Box:AddLabel(text)
			local Label = Instance.new("TextLabel")
			Label.Parent = BoxContent
			Label.BackgroundColor3 = Theme.BoxContent
			Label.BorderSizePixel = 0
			Label.Size = UDim2.new(1, 0, 0, 28)
			Label.Font = Enum.Font.Gotham
			Label.Text = "  " .. text
			Label.TextColor3 = Color3.fromRGB(180, 180, 180)
			Label.TextSize = 11
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.TextWrapped = true
			Label.AutomaticSize = Enum.AutomaticSize.Y
			
			local LabelCorner = Instance.new("UICorner")
			LabelCorner.CornerRadius = UDim.new(0, 4)
			LabelCorner.Parent = Label
			
			local LabelPadding = Instance.new("UIPadding")
			LabelPadding.PaddingLeft = UDim.new(0, 8)
			LabelPadding.PaddingRight = UDim.new(0, 8)
			LabelPadding.PaddingTop = UDim.new(0, 6)
			LabelPadding.PaddingBottom = UDim.new(0, 6)
			LabelPadding.Parent = Label
			
			return Label
		end
		
		function Box:AddSlider(id, config)
			config = config or {}
			local min = config.Min or 0
			local max = config.Max or 100
			local default = config.Default or min
			local rounding = config.Rounding or 1
			local currentValue = default
			
			local Container = Instance.new("Frame")
			Container.Parent = BoxContent
			Container.BackgroundColor3 = Theme.BoxContent
			Container.BorderSizePixel = 0
			Container.Size = UDim2.new(1, 0, 0, 58)
			
			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 4)
			Corner.Parent = Container
			
			local TitleLabel = Instance.new("TextLabel")
			TitleLabel.Parent = Container
			TitleLabel.BackgroundTransparency = 1
			TitleLabel.Position = UDim2.new(0, 10, 0, 6)
			TitleLabel.Size = UDim2.new(0.6, 0, 0, 16)
			TitleLabel.Font = Enum.Font.GothamSemibold
			TitleLabel.Text = config.Title or "Slider"
			TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
			TitleLabel.TextSize = 12
			TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			local ValueLabel = Instance.new("TextLabel")
			ValueLabel.Parent = Container
			ValueLabel.BackgroundTransparency = 1
			ValueLabel.Position = UDim2.new(0.6, 0, 0, 6)
			ValueLabel.Size = UDim2.new(0.4, -10, 0, 16)
			ValueLabel.Font = Enum.Font.GothamBold
			ValueLabel.Text = tostring(default)
			ValueLabel.TextColor3 = Theme.Accent
			ValueLabel.TextSize = 12
			ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
			
			local SliderBack = Instance.new("Frame")
			SliderBack.Parent = Container
			SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			SliderBack.BorderSizePixel = 0
			SliderBack.Position = UDim2.new(0, 10, 0, 30)
			SliderBack.Size = UDim2.new(1, -20, 0, 16)
			
			local SliderBackCorner = Instance.new("UICorner")
			SliderBackCorner.CornerRadius = UDim.new(1, 0)
			SliderBackCorner.Parent = SliderBack
			
			local SliderFill = Instance.new("Frame")
			SliderFill.Parent = SliderBack
			SliderFill.BackgroundColor3 = Theme.Accent
			SliderFill.BorderSizePixel = 0
			SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			
			local SliderFillCorner = Instance.new("UICorner")
			SliderFillCorner.CornerRadius = UDim.new(1, 0)
			SliderFillCorner.Parent = SliderFill
			
			local SliderButton = Instance.new("TextButton")
			SliderButton.Parent = SliderBack
			SliderButton.BackgroundTransparency = 1
			SliderButton.Size = UDim2.new(1, 0, 1, 0)
			SliderButton.Text = ""
			
			local draggingSlider = false
			
			local function updateSlider(input)
				local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
				currentValue = math.floor((min + (max - min) * pos) / rounding + 0.5) * rounding
				
				SliderFill.Size = UDim2.new(pos, 0, 1, 0)
				ValueLabel.Text = tostring(currentValue)
				
				if config.Callback then
					config.Callback(currentValue)
				end
			end
			
			SliderButton.MouseButton1Down:Connect(function()
				draggingSlider = true
			end)
			
			SliderButton.MouseButton1Up:Connect(function()
				draggingSlider = false
			end)
			
			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					draggingSlider = false
				end
			end)
			
			UserInputService.InputChanged:Connect(function(input)
				if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateSlider(input)
				end
			end)
			
			local Slider = {}
			Slider.Value = currentValue
			
			function Slider:SetValue(value)
				currentValue = math.clamp(value, min, max)
				local pos = (currentValue - min) / (max - min)
				SliderFill.Size = UDim2.new(pos, 0, 1, 0)
				ValueLabel.Text = tostring(currentValue)
				Slider.Value = currentValue
			end
			
			return Slider
		end
		
		function Box:AddDropdown(id, config)
			config = config or {}
			local values = config.Values or {}
			local selected = config.Default or values[1] or ""
			local isOpen = false
			
			local Container = Instance.new("Frame")
			Container.Parent = BoxContent
			Container.BackgroundColor3 = Theme.BoxContent
			Container.BorderSizePixel = 0
			Container.Size = UDim2.new(1, 0, 0, 45)
			Container.ClipsDescendants = false
			
			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 4)
			Corner.Parent = Container
			
			local TitleLabel = Instance.new("TextLabel")
			TitleLabel.Parent = Container
			TitleLabel.BackgroundTransparency = 1
			TitleLabel.Position = UDim2.new(0, 10, 0, 6)
			TitleLabel.Size = UDim2.new(1, -20, 0, 14)
			TitleLabel.Font = Enum.Font.GothamSemibold
			TitleLabel.Text = config.Title or "Dropdown"
			TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
			TitleLabel.TextSize = 12
			TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			local DropdownButton = Instance.new("TextButton")
			DropdownButton.Parent = Container
			DropdownButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			DropdownButton.BorderSizePixel = 0
			DropdownButton.Position = UDim2.new(0, 10, 0, 22)
			DropdownButton.Size = UDim2.new(1, -20, 0, 18)
			DropdownButton.Font = Enum.Font.Gotham
			DropdownButton.Text = "  " .. selected
			DropdownButton.TextColor3 = Color3.fromRGB(200, 200, 200)
			DropdownButton.TextSize = 11
			DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
			
			local DropCorner = Instance.new("UICorner")
			DropCorner.CornerRadius = UDim.new(0, 3)
			DropCorner.Parent = DropdownButton
			
			local Arrow = Instance.new("TextLabel")
			Arrow.Parent = DropdownButton
			Arrow.BackgroundTransparency = 1
			Arrow.Position = UDim2.new(1, -18, 0, 0)
			Arrow.Size = UDim2.new(0, 18, 1, 0)
			Arrow.Font = Enum.Font.GothamBold
			Arrow.Text = "▼"
			Arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
			Arrow.TextSize = 9
			
			local OptionsFrame = Instance.new("Frame")
			OptionsFrame.Parent = Container
			OptionsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			OptionsFrame.BorderSizePixel = 1
			OptionsFrame.BorderColor3 = Theme.Accent
			OptionsFrame.Position = UDim2.new(0, 10, 0, 42)
			OptionsFrame.Size = UDim2.new(1, -20, 0, 0)
			OptionsFrame.ClipsDescendants = true
			OptionsFrame.Visible = false
			OptionsFrame.ZIndex = 10
			
			local OptionsCorner = Instance.new("UICorner")
			OptionsCorner.CornerRadius = UDim.new(0, 3)
			OptionsCorner.Parent = OptionsFrame
			
			local OptionsList = Instance.new("UIListLayout")
			OptionsList.SortOrder = Enum.SortOrder.LayoutOrder
			OptionsList.Parent = OptionsFrame
			
			for _, value in ipairs(values) do
				local OptionButton = Instance.new("TextButton")
				OptionButton.Parent = OptionsFrame
				OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				OptionButton.BorderSizePixel = 0
				OptionButton.Size = UDim2.new(1, 0, 0, 22)
				OptionButton.Font = Enum.Font.Gotham
				OptionButton.Text = "  " .. value
				OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
				OptionButton.TextSize = 10
				OptionButton.TextXAlignment = Enum.TextXAlignment.Left
				
				OptionButton.MouseEnter:Connect(function()
					OptionButton.BackgroundColor3 = Theme.Accent
				end)
				
				OptionButton.MouseLeave:Connect(function()
					OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				end)
				
				OptionButton.MouseButton1Click:Connect(function()
					selected = value
					DropdownButton.Text = "  " .. selected
					
					TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
						Size = UDim2.new(1, -20, 0, 0)
					}):Play()
					
					task.wait(0.2)
					OptionsFrame.Visible = false
					Container.Size = UDim2.new(1, 0, 0, 45)
					isOpen = false
					
					if config.Callback then
						config.Callback(selected)
					end
				end)
			end
			
			DropdownButton.MouseButton1Click:Connect(function()
				isOpen = not isOpen
				
				if isOpen then
					OptionsFrame.Visible = true
					local optionsHeight = #values * 22
					Container.Size = UDim2.new(1, 0, 0, 45 + optionsHeight + 2)
					
					TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
						Size = UDim2.new(1, -20, 0, optionsHeight)
					}):Play()
				else
					TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
						Size = UDim2.new(1, -20, 0, 0)
					}):Play()
					
					task.wait(0.2)
					OptionsFrame.Visible = false
					Container.Size = UDim2.new(1, 0, 0, 45)
				end
			end)
			
			local Dropdown = {}
			Dropdown.Value = selected
			
			function Dropdown:SetValue(value)
				selected = value
				DropdownButton.Text = "  " .. selected
				Dropdown.Value = selected
			end
			
			return Dropdown
		end
		
		function Box:AddInput(id, config)
			config = config or {}
			
			local Container = Instance.new("Frame")
			Container.Parent = BoxContent
			Container.BackgroundColor3 = Theme.BoxContent
			Container.BorderSizePixel = 0
			Container.Size = UDim2.new(1, 0, 0, 48)
			
			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 4)
			Corner.Parent = Container
			
			local TitleLabel = Instance.new("TextLabel")
			TitleLabel.Parent = Container
			TitleLabel.BackgroundTransparency = 1
			TitleLabel.Position = UDim2.new(0, 10, 0, 6)
			TitleLabel.Size = UDim2.new(1, -20, 0, 14)
			TitleLabel.Font = Enum.Font.GothamSemibold
			TitleLabel.Text = config.Title or "Input"
			TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
			TitleLabel.TextSize = 12
			TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			local InputBox = Instance.new("TextBox")
			InputBox.Parent = Container
			InputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			InputBox.BorderSizePixel = 0
			InputBox.Position = UDim2.new(0, 10, 0, 24)
			InputBox.Size = UDim2.new(1, -20, 0, 20)
			InputBox.Font = Enum.Font.Gotham
			InputBox.PlaceholderText = config.Placeholder or "Enter text..."
			InputBox.Text = config.Default or ""
			InputBox.TextColor3 = Color3.fromRGB(220, 220, 220)
			InputBox.TextSize = 11
			InputBox.TextXAlignment = Enum.TextXAlignment.Left
			InputBox.ClearTextOnFocus = false
			
			local InputCorner = Instance.new("UICorner")
			InputCorner.CornerRadius = UDim.new(0, 3)
			InputCorner.Parent = InputBox
			
			local InputPadding = Instance.new("UIPadding")
			InputPadding.PaddingLeft = UDim.new(0, 8)
			InputPadding.PaddingRight = UDim.new(0, 8)
			InputPadding.Parent = InputBox
			
			InputBox.FocusLost:Connect(function(enterPressed)
				if config.Finished and not enterPressed then
					return
				end
				
				if config.Callback then
					config.Callback(InputBox.Text)
				end
			end)
			
			local Input = {}
			Input.Value = InputBox.Text
			
			InputBox:GetPropertyChangedSignal("Text"):Connect(function()
				Input.Value = InputBox.Text
			end)
			
			return Input
		end
		
		function Box:AddParagraph(config)
			config = config or {}
			local Container = Instance.new("Frame")
			Container.Parent = BoxContent
			Container.BackgroundColor3 = Theme.BoxContent
			Container.BorderSizePixel = 0
			Container.Size = UDim2.new(1, 0, 0, 60)
			Container.AutomaticSize = Enum.AutomaticSize.Y
			
			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 4)
			Corner.Parent = Container
			
			local Padding = Instance.new("UIPadding")
			Padding.PaddingTop = UDim.new(0, 8)
			Padding.PaddingBottom = UDim.new(0, 8)
			Padding.PaddingLeft = UDim.new(0, 10)
			Padding.PaddingRight = UDim.new(0, 10)
			Padding.Parent = Container
			
			local TitleLabel = Instance.new("TextLabel")
			TitleLabel.Parent = Container
			TitleLabel.BackgroundTransparency = 1
			TitleLabel.Size = UDim2.new(1, 0, 0, 16)
			TitleLabel.Font = Enum.Font.GothamBold
			TitleLabel.Text = config.Title or "Paragraph"
			TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
			TitleLabel.TextSize = 13
			TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			local ContentLabel = Instance.new("TextLabel")
			ContentLabel.Parent = Container
			ContentLabel.BackgroundTransparency = 1
			ContentLabel.Position = UDim2.new(0, 0, 0, 20)
			ContentLabel.Size = UDim2.new(1, 0, 0, 32)
			ContentLabel.Font = Enum.Font.Gotham
			ContentLabel.Text = config.Content or ""
			ContentLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
			ContentLabel.TextSize = 11
			ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
			ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
			ContentLabel.TextWrapped = true
			ContentLabel.AutomaticSize = Enum.AutomaticSize.Y
		end
		
		return Box
	end
	
	function Tab:AddParagraph(config)
		config = config or {}
		local Container = Instance.new("Frame")
		Container.Parent = TabContent
		Container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Container.BorderSizePixel = 0
		Container.Size = UDim2.new(1, -10, 0, 70)
		Container.AutomaticSize = Enum.AutomaticSize.Y
		
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = Container
		
		local Padding = Instance.new("UIPadding")
		Padding.PaddingTop = UDim.new(0, 10)
		Padding.PaddingBottom = UDim.new(0, 10)
		Padding.PaddingLeft = UDim.new(0, 12)
		Padding.PaddingRight = UDim.new(0, 12)
		Padding.Parent = Container
		
		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Parent = Container
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Size = UDim2.new(1, 0, 0, 20)
		TitleLabel.Font = Enum.Font.GothamBold
		TitleLabel.Text = config.Title or "Paragraph"
		TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TitleLabel.TextSize = 14
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		local ContentLabel = Instance.new("TextLabel")
		ContentLabel.Parent = Container
		ContentLabel.BackgroundTransparency = 1
		ContentLabel.Position = UDim2.new(0, 0, 0, 24)
		ContentLabel.Size = UDim2.new(1, 0, 0, 40)
		ContentLabel.Font = Enum.Font.Gotham
		ContentLabel.Text = config.Content or ""
		ContentLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		ContentLabel.TextSize = 12
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
		ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
		ContentLabel.TextWrapped = true
		ContentLabel.AutomaticSize = Enum.AutomaticSize.Y
	end
	
	function Tab:AddButton(config)
		config = config or {}
		local Container = Instance.new("Frame")
		Container.Parent = TabContent
		Container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Container.BorderSizePixel = 0
		Container.Size = UDim2.new(1, -10, 0, 50)
		
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = Container
		
		local Button = Instance.new("TextButton")
		Button.Parent = Container
		Button.BackgroundColor3 = Theme.Accent
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(1, -80, 0.5, -15)
		Button.Size = UDim2.new(0, 70, 0, 30)
		Button.Font = Enum.Font.GothamBold
		Button.Text = "Click"
		Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		Button.TextSize = 12
		
		local BtnCorner = Instance.new("UICorner")
		BtnCorner.CornerRadius = UDim.new(0, 6)
		BtnCorner.Parent = Button
		
		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Parent = Container
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Position = UDim2.new(0, 12, 0, 8)
		TitleLabel.Size = UDim2.new(1, -100, 0, 18)
		TitleLabel.Font = Enum.Font.GothamBold
		TitleLabel.Text = config.Title or "Button"
		TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TitleLabel.TextSize = 14
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		local DescLabel = Instance.new("TextLabel")
		DescLabel.Parent = Container
		DescLabel.BackgroundTransparency = 1
		DescLabel.Position = UDim2.new(0, 12, 0, 26)
		DescLabel.Size = UDim2.new(1, -100, 0, 16)
		DescLabel.Font = Enum.Font.Gotham
		DescLabel.Text = config.Description or ""
		DescLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
		DescLabel.TextSize = 11
		DescLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		Button.MouseButton1Click:Connect(function()
			if config.Callback then
				config.Callback()
			end
		end)
		
		Button.MouseEnter:Connect(function()
			Button.BackgroundColor3 = Color3.fromRGB(90, 160, 200)
		end)
		
		Button.MouseLeave:Connect(function()
			Button.BackgroundColor3 = Theme.Accent
		end)
	end
	
	function Tab:AddToggle(id, config)
		config = config or {}
		local toggled = config.Default or false
		
		local Container = Instance.new("Frame")
		Container.Parent = TabContent
		Container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Container.BorderSizePixel = 0
		Container.Size = UDim2.new(1, -10, 0, 45)
		
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = Container
		
		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Parent = Container
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Position = UDim2.new(0, 12, 0, 0)
		TitleLabel.Size = UDim2.new(1, -70, 1, 0)
		TitleLabel.Font = Enum.Font.GothamSemibold
		TitleLabel.Text = config.Title or "Toggle"
		TitleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
		TitleLabel.TextSize = 13
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		local ToggleButton = Instance.new("TextButton")
		ToggleButton.Parent = Container
		ToggleButton.BackgroundColor3 = toggled and Theme.Accent or Color3.fromRGB(50, 50, 50)
		ToggleButton.BorderSizePixel = 0
		ToggleButton.Position = UDim2.new(1, -55, 0.5, -12)
		ToggleButton.Size = UDim2.new(0, 45, 0, 24)
		ToggleButton.Text = ""
		
		local ToggleCorner = Instance.new("UICorner")
		ToggleCorner.CornerRadius = UDim.new(1, 0)
		ToggleCorner.Parent = ToggleButton
		
		local ToggleCircle = Instance.new("Frame")
		ToggleCircle.Parent = ToggleButton
		ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleCircle.BorderSizePixel = 0
		ToggleCircle.Position = toggled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
		ToggleCircle.Size = UDim2.new(0, 20, 0, 20)
		
		local CircleCorner = Instance.new("UICorner")
		CircleCorner.CornerRadius = UDim.new(1, 0)
		CircleCorner.Parent = ToggleCircle
		
		local Toggle = {}
		Toggle.Value = toggled
		
		function Toggle:SetValue(value)
			toggled = value
			Toggle.Value = value
			
			TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
				BackgroundColor3 = toggled and Theme.Accent or Color3.fromRGB(50, 50, 50)
			}):Play()
			
			TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {
				Position = toggled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
			}):Play()
			
			if config.Callback then
				config.Callback(toggled)
			end
		end
		
		ToggleButton.MouseButton1Click:Connect(function()
			Toggle:SetValue(not toggled)
		end)
		
		return Toggle
	end
	
	function Tab:AddSlider(id, config)
		config = config or {}
		local min = config.Min or 0
		local max = config.Max or 100
		local default = config.Default or min
		local rounding = config.Rounding or 1
		local currentValue = default
		
		local Container = Instance.new("Frame")
		Container.Parent = TabContent
		Container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Container.BorderSizePixel = 0
		Container.Size = UDim2.new(1, -10, 0, 65)
		
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = Container
		
		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Parent = Container
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Position = UDim2.new(0, 12, 0, 8)
		TitleLabel.Size = UDim2.new(0.7, 0, 0, 18)
		TitleLabel.Font = Enum.Font.GothamSemibold
		TitleLabel.Text = config.Title or "Slider"
		TitleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
		TitleLabel.TextSize = 13
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		local ValueLabel = Instance.new("TextLabel")
		ValueLabel.Parent = Container
		ValueLabel.BackgroundTransparency = 1
		ValueLabel.Position = UDim2.new(0.7, 0, 0, 8)
		ValueLabel.Size = UDim2.new(0.3, -12, 0, 18)
		ValueLabel.Font = Enum.Font.GothamBold
		ValueLabel.Text = tostring(default)
		ValueLabel.TextColor3 = Theme.Accent
		ValueLabel.TextSize = 13
		ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
		
		local SliderBack = Instance.new("Frame")
		SliderBack.Parent = Container
		SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		SliderBack.BorderSizePixel = 0
		SliderBack.Position = UDim2.new(0, 12, 0, 35)
		SliderBack.Size = UDim2.new(1, -24, 0, 18)
		
		local SliderBackCorner = Instance.new("UICorner")
		SliderBackCorner.CornerRadius = UDim.new(1, 0)
		SliderBackCorner.Parent = SliderBack
		
		local SliderFill = Instance.new("Frame")
		SliderFill.Parent = SliderBack
		SliderFill.BackgroundColor3 = Theme.Accent
		SliderFill.BorderSizePixel = 0
		SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
		
		local SliderFillCorner = Instance.new("UICorner")
		SliderFillCorner.CornerRadius = UDim.new(1, 0)
		SliderFillCorner.Parent = SliderFill
		
		local SliderButton = Instance.new("TextButton")
		SliderButton.Parent = SliderBack
		SliderButton.BackgroundTransparency = 1
		SliderButton.Size = UDim2.new(1, 0, 1, 0)
		SliderButton.Text = ""
		
		local draggingSlider = false
		
		local function updateSlider(input)
			local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
			currentValue = math.floor((min + (max - min) * pos) / rounding + 0.5) * rounding
			
			SliderFill.Size = UDim2.new(pos, 0, 1, 0)
			ValueLabel.Text = tostring(currentValue)
			
			if config.Callback then
				config.Callback(currentValue)
			end
		end
		
		SliderButton.MouseButton1Down:Connect(function()
			draggingSlider = true
		end)
		
		SliderButton.MouseButton1Up:Connect(function()
			draggingSlider = false
		end)
		
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				draggingSlider = false
			end
		end)
		
		UserInputService.InputChanged:Connect(function(input)
			if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
				updateSlider(input)
			end
		end)
		
		local Slider = {}
		Slider.Value = currentValue
		
		function Slider:SetValue(value)
			currentValue = math.clamp(value, min, max)
			local pos = (currentValue - min) / (max - min)
			SliderFill.Size = UDim2.new(pos, 0, 1, 0)
			ValueLabel.Text = tostring(currentValue)
			Slider.Value = currentValue
		end
		
		return Slider
	end
	
	function Tab:AddDropdown(id, config)
		config = config or {}
		local values = config.Values or {}
		local selected = config.Default or values[1] or ""
		local isOpen = false
		
		local Container = Instance.new("Frame")
		Container.Parent = TabContent
		Container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Container.BorderSizePixel = 0
		Container.Size = UDim2.new(1, -10, 0, 50)
		Container.ClipsDescendants = false
		
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = Container
		
		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Parent = Container
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Position = UDim2.new(0, 12, 0, 8)
		TitleLabel.Size = UDim2.new(1, -24, 0, 16)
		TitleLabel.Font = Enum.Font.GothamSemibold
		TitleLabel.Text = config.Title or "Dropdown"
		TitleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
		TitleLabel.TextSize = 13
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		local DropdownButton = Instance.new("TextButton")
		DropdownButton.Parent = Container
		DropdownButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		DropdownButton.BorderSizePixel = 0
		DropdownButton.Position = UDim2.new(0, 12, 0, 26)
		DropdownButton.Size = UDim2.new(1, -24, 0, 20)
		DropdownButton.Font = Enum.Font.Gotham
		DropdownButton.Text = "  " .. selected
		DropdownButton.TextColor3 = Color3.fromRGB(200, 200, 200)
		DropdownButton.TextSize = 12
		DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
		
		local DropCorner = Instance.new("UICorner")
		DropCorner.CornerRadius = UDim.new(0, 4)
		DropCorner.Parent = DropdownButton
		
		local Arrow = Instance.new("TextLabel")
		Arrow.Parent = DropdownButton
		Arrow.BackgroundTransparency = 1
		Arrow.Position = UDim2.new(1, -20, 0, 0)
		Arrow.Size = UDim2.new(0, 20, 1, 0)
		Arrow.Font = Enum.Font.GothamBold
		Arrow.Text = "▼"
		Arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
		Arrow.TextSize = 10
		
		local OptionsFrame = Instance.new("Frame")
		OptionsFrame.Parent = Container
		OptionsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		OptionsFrame.BorderSizePixel = 1
		OptionsFrame.BorderColor3 = Theme.Accent
		OptionsFrame.Position = UDim2.new(0, 12, 0, 48)
		OptionsFrame.Size = UDim2.new(1, -24, 0, 0)
		OptionsFrame.ClipsDescendants = true
		OptionsFrame.Visible = false
		OptionsFrame.ZIndex = 10
		
		local OptionsCorner = Instance.new("UICorner")
		OptionsCorner.CornerRadius = UDim.new(0, 4)
		OptionsCorner.Parent = OptionsFrame
		
		local OptionsList = Instance.new("UIListLayout")
		OptionsList.SortOrder = Enum.SortOrder.LayoutOrder
		OptionsList.Parent = OptionsFrame
		
		for _, value in ipairs(values) do
			local OptionButton = Instance.new("TextButton")
			OptionButton.Parent = OptionsFrame
			OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			OptionButton.BorderSizePixel = 0
			OptionButton.Size = UDim2.new(1, 0, 0, 24)
			OptionButton.Font = Enum.Font.Gotham
			OptionButton.Text = "  " .. value
			OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
			OptionButton.TextSize = 11
			OptionButton.TextXAlignment = Enum.TextXAlignment.Left
			
			OptionButton.MouseEnter:Connect(function()
				OptionButton.BackgroundColor3 = Theme.Accent
			end)
			
			OptionButton.MouseLeave:Connect(function()
				OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			end)
			
			OptionButton.MouseButton1Click:Connect(function()
				selected = value
				DropdownButton.Text = "  " .. selected
				
				TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
					Size = UDim2.new(1, -24, 0, 0)
				}):Play()
				
				task.wait(0.2)
				OptionsFrame.Visible = false
				Container.Size = UDim2.new(1, -10, 0, 50)
				isOpen = false
				
				if config.Callback then
					config.Callback(selected)
				end
			end)
		end
		
		DropdownButton.MouseButton1Click:Connect(function()
			isOpen = not isOpen
			
			if isOpen then
				OptionsFrame.Visible = true
				local optionsHeight = #values * 24
				Container.Size = UDim2.new(1, -10, 0, 50 + optionsHeight + 4)
				
				TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
					Size = UDim2.new(1, -24, 0, optionsHeight)
				}):Play()
			else
				TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
					Size = UDim2.new(1, -24, 0, 0)
				}):Play()
				
				task.wait(0.2)
				OptionsFrame.Visible = false
				Container.Size = UDim2.new(1, -10, 0, 50)
			end
		end)
		
		local Dropdown = {}
		Dropdown.Value = selected
		
		function Dropdown:SetValue(value)
			selected = value
			DropdownButton.Text = "  " .. selected
			Dropdown.Value = selected
		end
		
		return Dropdown
	end
	
	function Tab:AddInput(id, config)
		config = config or {}
		
		local Container = Instance.new("Frame")
		Container.Parent = TabContent
		Container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Container.BorderSizePixel = 0
		Container.Size = UDim2.new(1, -10, 0, 55)
		
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = Container
		
		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Parent = Container
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Position = UDim2.new(0, 12, 0, 8)
		TitleLabel.Size = UDim2.new(1, -24, 0, 16)
		TitleLabel.Font = Enum.Font.GothamSemibold
		TitleLabel.Text = config.Title or "Input"
		TitleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
		TitleLabel.TextSize = 13
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		local InputBox = Instance.new("TextBox")
		InputBox.Parent = Container
		InputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		InputBox.BorderSizePixel = 0
		InputBox.Position = UDim2.new(0, 12, 0, 28)
		InputBox.Size = UDim2.new(1, -24, 0, 22)
		InputBox.Font = Enum.Font.Gotham
		InputBox.PlaceholderText = config.Placeholder or "Enter text..."
		InputBox.Text = config.Default or ""
		InputBox.TextColor3 = Color3.fromRGB(220, 220, 220)
		InputBox.TextSize = 12
		InputBox.TextXAlignment = Enum.TextXAlignment.Left
		InputBox.ClearTextOnFocus = false
		
		local InputCorner = Instance.new("UICorner")
		InputCorner.CornerRadius = UDim.new(0, 4)
		InputCorner.Parent = InputBox
		
		local InputPadding = Instance.new("UIPadding")
		InputPadding.PaddingLeft = UDim.new(0, 8)
		InputPadding.PaddingRight = UDim.new(0, 8)
		InputPadding.Parent = InputBox
		
		InputBox.FocusLost:Connect(function(enterPressed)
			if config.Finished and not enterPressed then
				return
			end
			
			if config.Callback then
				config.Callback(InputBox.Text)
			end
		end)
		
		local Input = {}
		Input.Value = InputBox.Text
		
		InputBox:GetPropertyChangedSignal("Text"):Connect(function()
			Input.Value = InputBox.Text
		end)
		
		return Input
	end
	
	return Tab
end

function EcoHub:Notify(config)
	config = config or {}
	
	local NotificationFrame = Instance.new("Frame")
	NotificationFrame.Parent = ScreenGui
	NotificationFrame.AnchorPoint = Vector2.new(1, 1)
	NotificationFrame.Position = UDim2.new(1, -20, 1, 120)
	NotificationFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	NotificationFrame.BackgroundTransparency = 0.1
	NotificationFrame.Size = UDim2.new(0, 300, 0, 80)
	NotificationFrame.BorderSizePixel = 1
	NotificationFrame.BorderColor3 = Theme.Accent
	
	local NotifCorner = Instance.new("UICorner")
	NotifCorner.CornerRadius = UDim.new(0, 8)
	NotifCorner.Parent = NotificationFrame
	
	local NotifTitle = Instance.new("TextLabel")
	NotifTitle.Parent = NotificationFrame
	NotifTitle.BackgroundTransparency = 1
	NotifTitle.Position = UDim2.new(0, 12, 0, 10)
	NotifTitle.Size = UDim2.new(1, -24, 0, 20)
	NotifTitle.Text = config.Title or "Notification"
	NotifTitle.Font = Enum.Font.GothamBold
	NotifTitle.TextSize = 14
	NotifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
	
	local NotifDesc = Instance.new("TextLabel")
	NotifDesc.Parent = NotificationFrame
	NotifDesc.BackgroundTransparency = 1
	NotifDesc.Position = UDim2.new(0, 12, 0, 32)
	NotifDesc.Size = UDim2.new(1, -24, 0, 40)
	NotifDesc.Text = config.Content or ""
	NotifDesc.Font = Enum.Font.Gotham
	NotifDesc.TextSize = 12
	NotifDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
	NotifDesc.TextXAlignment = Enum.TextXAlignment.Left
	NotifDesc.TextYAlignment = Enum.TextYAlignment.Top
	NotifDesc.TextWrapped = true
	
	NotificationFrame:TweenPosition(
		UDim2.new(1, -20, 1, -20),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.4,
		true
	)
	
	local duration = config.Duration or 5
	task.wait(duration)
	
	NotificationFrame:TweenPosition(
		UDim2.new(1, -20, 1, 120),
		Enum.EasingDirection.In,
		Enum.EasingStyle.Quad,
		0.4,
		true
	)
	
	task.wait(0.4)
	NotificationFrame:Destroy()
end

MinButton.MouseButton1Click:Connect(function()
	if maximized then
		return
	end
	
	if minimized then
		MainFrame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
		ContentFrame.Visible = true
	else
		originalSize = MainFrame.Size
		originalPos = MainFrame.Position
		MainFrame:TweenSize(UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
		task.wait(0.25)
		ContentFrame.Visible = false
	end
	minimized = not minimized
end)

MaxButton.MouseButton1Click:Connect(function()
	if minimized then
		MainFrame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
		ContentFrame.Visible = true
		minimized = false
		task.wait(0.25)
	end
	
	if maximized then
		MaxButton.Image = Icons.Max
		MainFrame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
		MainFrame:TweenPosition(originalPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
	else
		MaxButton.Image = Icons.Restore
		originalSize = MainFrame.Size
		originalPos = MainFrame.Position
		MainFrame:TweenSize(UDim2.new(1, -20, 1, -20), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
		MainFrame:TweenPosition(UDim2.new(0, 10, 0, 10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
	end
	maximized = not maximized
end)

CloseButton.MouseButton1Click:Connect(function()
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(MainFrame, tweenInfo, {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0)
	})
	tween:Play()
	
	tween.Completed:Connect(function()
		MainFrame.Visible = false
		MainFrame.Size = originalSize
		MainFrame.Position = originalPos
	end)
end)

return EcoHub
