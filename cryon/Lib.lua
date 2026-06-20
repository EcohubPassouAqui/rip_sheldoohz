-- // EcoHub UI Library
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game.CoreGui

local EcoHub = {}
EcoHub.__index = EcoHub

-- Cores da UI
local Colors = {
	bg = Color3.fromRGB(13, 13, 13),
	topbar = Color3.fromRGB(20, 20, 20),
	tabbar = Color3.fromRGB(13, 13, 13),
	card = Color3.fromRGB(22, 22, 22),
	elBg = Color3.fromRGB(24, 24, 24),
	elBgHov = Color3.fromRGB(34, 34, 34),
	elBgPress = Color3.fromRGB(16, 16, 16),
	border = Color3.fromRGB(45, 45, 45),
	divider = Color3.fromRGB(35, 35, 35),
	textPri = Color3.fromRGB(255, 255, 255),
	textSec = Color3.fromRGB(185, 185, 185),
	textDim = Color3.fromRGB(100, 100, 100),
	muted = Color3.fromRGB(100, 100, 100),
	dim = Color3.fromRGB(50, 50, 50),
	accentDark = Color3.fromRGB(38, 38, 42),
	white = Color3.fromRGB(255, 255, 255),
	secText = Color3.fromRGB(210, 210, 210),
	togOn = Color3.fromRGB(225, 225, 230),
	togOff = Color3.fromRGB(26, 26, 30),
	togKnobOn = Color3.fromRGB(20, 20, 24),
	togKnobOff = Color3.fromRGB(80, 80, 86),
	chkOn = Color3.fromRGB(225, 225, 230),
	chkOff = Color3.fromRGB(22, 22, 26),
	disabled = Color3.fromRGB(28, 28, 30),
	disabledTxt = Color3.fromRGB(60, 60, 64),
	labelVal = Color3.fromRGB(180, 180, 188),
}

local function CreateElement(class, props)
	local elem = Instance.new(class)
	for k, v in pairs(props or {}) do
		if k ~= "Parent" then elem[k] = v end
	end
	if props and props.Parent then elem.Parent = props.Parent end
	return elem
end

local function CreateCorner(obj, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 6)
	corner.Parent = obj
	return corner
end

local function CreateStroke(obj, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0
	stroke.Parent = obj
	return stroke
end

local function Tween(obj, props, time, style)
	if not obj or not obj.Parent then return end
	local tweenInfo = TweenInfo.new(time or 0.15, style or Enum.EasingStyle.Quad)
	TweenService:Create(obj, tweenInfo, props):Play()
end

function EcoHub:CreateWindow(config)
	config = config or {}
	local title = config.Title or "EcoHub"
	local subtitle = config.SubTitle or "v1"

	if CoreGui:FindFirstChild("EcoHub") then
		CoreGui:FindFirstChild("EcoHub"):Destroy()
	end

	local screenGui = CreateElement("ScreenGui", {
		Name = "EcoHub",
		Parent = CoreGui,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
	})

	local mainFrame = CreateElement("Frame", {
		Name = "MainFrame",
		Parent = screenGui,
		BackgroundColor3 = Colors.bg,
		Position = UDim2.new(0.5, -290, 0.5, -230),
		Size = UDim2.new(0, 580, 0, 460),
		Active = true,
		Draggable = true,
	})
	CreateCorner(mainFrame, 10)
	CreateStroke(mainFrame, Color3.fromRGB(52, 52, 58), 1.2)

	-- Top Bar
	local topBar = CreateElement("Frame", {
		Name = "TopBar",
		Parent = mainFrame,
		BackgroundColor3 = Colors.topbar,
		Size = UDim2.new(1, 0, 0, 58),
		BorderSizePixel = 0,
	})
	CreateCorner(topBar, 10)

	CreateElement("TextLabel", {
		Parent = topBar,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 18, 0, 8),
		Size = UDim2.new(0, 300, 0, 22),
		Font = Enum.Font.Code,
		Text = title,
		TextColor3 = Colors.textPri,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	CreateElement("TextLabel", {
		Parent = topBar,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 18, 0, 32),
		Size = UDim2.new(0, 300, 0, 16),
		Font = Enum.Font.Code,
		Text = subtitle,
		TextColor3 = Colors.muted,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	-- Page Area
	local pageArea = CreateElement("Frame", {
		Name = "PageArea",
		Parent = mainFrame,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 58),
		Size = UDim2.new(1, 0, 1, -116),
		ClipsDescendants = false,
	})

	-- Tab Bar
	local tabBar = CreateElement("Frame", {
		Name = "TabBar",
		Parent = mainFrame,
		BackgroundColor3 = Colors.tabbar,
		Position = UDim2.new(0, 0, 1, -58),
		Size = UDim2.new(1, 0, 0, 58),
		BorderSizePixel = 0,
		ClipsDescendants = true,
	})
	CreateCorner(tabBar, 10)

	local tabs = {}
	local tabFrames = {}
	local activeTab = nil

	local tabsAPI = {}

	function tabsAPI:AddTab(cfg)
		cfg = cfg or {}
		local tabName = cfg.Name or ("Tab" .. tostring(#tabs + 1))
		local tabSub = cfg.Sub or ""
		
		if #tabs >= 10 then return nil end

		-- Page Frame
		local pageFrame = CreateElement("Frame", {
			Name = tabName,
			Parent = pageArea,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Visible = false,
		})

		-- Left & Right Sections
		local leftScroll = CreateElement("ScrollingFrame", {
			Parent = pageFrame,
			Position = UDim2.new(0, 8, 0, 5),
			Size = UDim2.new(0.5, -12, 1, -10),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 2,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
		})

		local rightScroll = CreateElement("ScrollingFrame", {
			Parent = pageFrame,
			Position = UDim2.new(0.5, 4, 0, 5),
			Size = UDim2.new(0.5, -12, 1, -10),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 2,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
		})

		for _, scroll in ipairs({leftScroll, rightScroll}) do
			CreateElement("UIListLayout", {
				Parent = scroll,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 2),
			})
		end

		-- Tab Button
		local tabBtn = CreateElement("TextButton", {
			Parent = tabBar,
			BackgroundColor3 = Colors.card,
			Size = UDim2.new(0, 48, 1, 0),
			Text = "",
			BorderSizePixel = 0,
		})
		CreateCorner(tabBtn, 8)

		local tabLabel = CreateElement("TextLabel", {
			Parent = tabBtn,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Font = Enum.Font.GothamBold,
			Text = tabName,
			TextColor3 = Colors.dim,
			TextSize = 9,
		})

		table.insert(tabs, {name = tabName, sub = tabSub})
		table.insert(tabFrames, {btn = tabBtn, label = tabLabel, frame = pageFrame, left = leftScroll, right = rightScroll})

		tabBtn.MouseButton1Click:Connect(function()
			if activeTab then activeTab.frame.Visible = false end
			pageFrame.Visible = true
			activeTab = tabFrames[#tabFrames]
			
			for _, tf in ipairs(tabFrames) do
				Tween(tf.btn, {BackgroundColor3 = Colors.card}, 0.15)
				Tween(tf.label, {TextColor3 = Colors.dim}, 0.15)
			end
			Tween(tabBtn, {BackgroundColor3 = Colors.accentDark}, 0.15)
			Tween(tabLabel, {TextColor3 = Colors.white}, 0.15)
		end)

		tabBtn.MouseEnter:Connect(function()
			if activeTab ~= tabFrames[#tabFrames] then
				Tween(tabBtn, {BackgroundColor3 = Colors.elBgHov}, 0.1)
			end
		end)

		tabBtn.MouseLeave:Connect(function()
			if activeTab ~= tabFrames[#tabFrames] then
				Tween(tabBtn, {BackgroundColor3 = Colors.card}, 0.1)
			end
		end)

		if #tabs == 1 then
			pageFrame.Visible = true
			activeTab = tabFrames[1]
			Tween(tabBtn, {BackgroundColor3 = Colors.accentDark}, 0)
			Tween(tabLabel, {TextColor3 = Colors.white}, 0)
		end

		-- Section API
		local sectionAPI = {}
		local leftIdx = 0
		local rightIdx = 0

		function sectionAPI:AddSection(cfg)
			cfg = cfg or {}
			if type(cfg) == "string" then cfg = {Name = cfg} end
			
			local boxType = (cfg.Box == "right") and "right" or "left"
			local secName = cfg.Name or "Section"
			local scroll = (boxType == "left") and leftScroll or rightScroll
			
			if boxType == "left" then
				leftIdx = leftIdx + 1
			else
				rightIdx = rightIdx + 1
			end

			local secFrame = CreateElement("Frame", {
				Size = UDim2.new(1, 0, 0, 38),
				BackgroundColor3 = Colors.bg,
				BorderSizePixel = 0,
				LayoutOrder = (boxType == "left") and leftIdx or rightIdx,
				Parent = scroll,
			})
			CreateCorner(secFrame, 6)
			CreateStroke(secFrame, Color3.fromRGB(30, 30, 30), 1, 0.5)

			CreateElement("TextLabel", {
				Parent = secFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 12, 0.5, -5),
				Size = UDim2.new(1, -24, 0, 10),
				Font = Enum.Font.GothamBold,
				Text = string.upper(secName),
				TextColor3 = Colors.secText,
				TextSize = 10,
				TextXAlignment = Enum.TextXAlignment.Left,
			})

			-- Elements API
			local elemAPI = {}
			local elemOrder = (boxType == "left") and leftIdx or rightIdx

			function elemAPI:AddLabel(cfg)
				if type(cfg) == "string" then cfg = {Title = cfg} end
				cfg = cfg or {}
				
				elemOrder = elemOrder + 1
				local frame = CreateElement("Frame", {
					Size = UDim2.new(1, 0, 0, 40),
					BackgroundColor3 = Colors.elBg,
					BorderSizePixel = 0,
					LayoutOrder = elemOrder,
					Parent = scroll,
				})
				CreateCorner(frame, 7)

				CreateElement("TextLabel", {
					Parent = frame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 12, 0.5, -7),
					Size = UDim2.new(0.55, -12, 0, 14),
					Font = Enum.Font.Gotham,
					Text = cfg.Title or "Label",
					TextColor3 = Colors.textPri,
					TextSize = 11,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local valueLabel = CreateElement("TextLabel", {
					Parent = frame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.55, 0, 0.5, -7),
					Size = UDim2.new(0.45, -14, 0, 14),
					Font = Enum.Font.GothamSemibold,
					Text = tostring(cfg.Value or ""),
					TextColor3 = Colors.labelVal,
					TextSize = 10,
					TextXAlignment = Enum.TextXAlignment.Right,
				})

				return {
					Set = function(_, v) valueLabel.Text = tostring(v) end,
					Get = function(_) return valueLabel.Text end,
				}
			end

			function elemAPI:AddToggle(cfg)
				if type(cfg) == "string" then cfg = {Title = cfg} end
				cfg = cfg or {}
				
				elemOrder = elemOrder + 1
				local frame = CreateElement("Frame", {
					Size = UDim2.new(1, 0, 0, 40),
					BackgroundColor3 = Colors.elBg,
					BorderSizePixel = 0,
					LayoutOrder = elemOrder,
					Parent = scroll,
				})
				CreateCorner(frame, 7)

				local state = cfg.Default == true

				CreateElement("TextLabel", {
					Parent = frame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 12, 0.5, -7),
					Size = UDim2.new(1, -70, 0, 14),
					Font = Enum.Font.Gotham,
					Text = cfg.Title or "Toggle",
					TextColor3 = Colors.textPri,
					TextSize = 11,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local track = CreateElement("Frame", {
					Size = UDim2.new(0, 34, 0, 18),
					Position = UDim2.new(1, -45, 0.5, -9),
					BackgroundColor3 = state and Colors.togOn or Colors.togOff,
					BorderSizePixel = 0,
					Parent = frame,
				})
				CreateCorner(track, 18)

				local knob = CreateElement("Frame", {
					Size = UDim2.new(0, 12, 0, 12),
					Position = state and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
					BackgroundColor3 = state and Colors.togKnobOn or Colors.togKnobOff,
					BorderSizePixel = 0,
					Parent = track,
				})
				CreateCorner(knob, 12)

				local btn = CreateElement("TextButton", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Text = "",
					Parent = frame,
				})

				btn.MouseButton1Click:Connect(function()
					state = not state
					Tween(track, {BackgroundColor3 = state and Colors.togOn or Colors.togOff}, 0.15)
					Tween(knob, {
						Position = state and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
						BackgroundColor3 = state and Colors.togKnobOn or Colors.togKnobOff,
					}, 0.15)
					if cfg.Callback then cfg.Callback(state) end
				end)

				btn.MouseEnter:Connect(function() Tween(frame, {BackgroundColor3 = Colors.elBgHov}, 0.1) end)
				btn.MouseLeave:Connect(function() Tween(frame, {BackgroundColor3 = Colors.elBg}, 0.1) end)

				return {
					Set = function(_, v) state = v == true end,
					Get = function(_) return state end,
				}
			end

			function elemAPI:AddCheckbox(cfg)
				if type(cfg) == "string" then cfg = {Title = cfg} end
				cfg = cfg or {}
				
				elemOrder = elemOrder + 1
				local frame = CreateElement("Frame", {
					Size = UDim2.new(1, 0, 0, 40),
					BackgroundColor3 = Colors.elBg,
					BorderSizePixel = 0,
					LayoutOrder = elemOrder,
					Parent = scroll,
				})
				CreateCorner(frame, 7)

				local state = cfg.Default == true

				local box = CreateElement("Frame", {
					Size = UDim2.new(0, 16, 0, 16),
					Position = UDim2.new(0, 12, 0.5, -8),
					BackgroundColor3 = state and Colors.chkOn or Colors.chkOff,
					BorderSizePixel = 0,
					Parent = frame,
				})
				CreateCorner(box, 4)

				CreateElement("TextLabel", {
					Parent = frame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 36, 0.5, -7),
					Size = UDim2.new(1, -48, 0, 14),
					Font = Enum.Font.Gotham,
					Text = cfg.Title or "Checkbox",
					TextColor3 = Colors.textPri,
					TextSize = 11,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local btn = CreateElement("TextButton", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Text = "",
					Parent = frame,
				})

				btn.MouseButton1Click:Connect(function()
					state = not state
					Tween(box, {BackgroundColor3 = state and Colors.chkOn or Colors.chkOff}, 0.14)
					if cfg.Callback then cfg.Callback(state) end
				end)

				btn.MouseEnter:Connect(function() Tween(frame, {BackgroundColor3 = Colors.elBgHov}, 0.1) end)
				btn.MouseLeave:Connect(function() Tween(frame, {BackgroundColor3 = Colors.elBg}, 0.1) end)

				return {
					Set = function(_, v) state = v == true end,
					Get = function(_) return state end,
				}
			end

			function elemAPI:AddButton(cfg)
				if type(cfg) == "string" then cfg = {Title = cfg} end
				cfg = cfg or {}
				
				elemOrder = elemOrder + 1
				local frame = CreateElement("Frame", {
					Size = UDim2.new(1, 0, 0, 40),
					BackgroundColor3 = Colors.elBg,
					BorderSizePixel = 0,
					LayoutOrder = elemOrder,
					Parent = scroll,
				})
				CreateCorner(frame, 7)

				CreateElement("TextLabel", {
					Parent = frame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 12, 0.5, -7),
					Size = UDim2.new(1, -40, 0, 14),
					Font = Enum.Font.GothamSemibold,
					Text = cfg.Title or "Button",
					TextColor3 = Colors.textPri,
					TextSize = 11,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local btn = CreateElement("TextButton", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Text = "",
					Parent = frame,
				})

				btn.MouseButton1Click:Connect(function()
					if cfg.Callback then cfg.Callback() end
				end)

				btn.MouseEnter:Connect(function() Tween(frame, {BackgroundColor3 = Colors.elBgHov}, 0.1) end)
				btn.MouseLeave:Connect(function() Tween(frame, {BackgroundColor3 = Colors.elBg}, 0.1) end)

				return {Fire = function(_) if cfg.Callback then cfg.Callback() end end}
			end

			function elemAPI:AddSlider(cfg)
				if type(cfg) == "string" then cfg = {Title = cfg} end
				cfg = cfg or {}
				
				elemOrder = elemOrder + 1
				local frame = CreateElement("Frame", {
					Size = UDim2.new(1, 0, 0, 44),
					BackgroundColor3 = Colors.elBg,
					BorderSizePixel = 0,
					LayoutOrder = elemOrder,
					Parent = scroll,
				})
				CreateCorner(frame, 7)

				CreateElement("TextLabel", {
					Parent = frame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 12, 0, 6),
					Size = UDim2.new(1, -24, 0, 12),
					Font = Enum.Font.Gotham,
					Text = cfg.Title or "Slider",
					TextColor3 = Colors.textPri,
					TextSize = 10,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local minV = cfg.Min or 0
				local maxV = cfg.Max or 100
				local val = cfg.Default or minV

				local rail = CreateElement("Frame", {
					Size = UDim2.new(1, -24, 0, 18),
					Position = UDim2.new(0, 12, 0, 22),
					BackgroundColor3 = Color3.fromRGB(38, 38, 42),
					BorderSizePixel = 0,
					Parent = frame,
				})
				CreateCorner(rail, 5)

				local fill = CreateElement("Frame", {
					Size = UDim2.new((val - minV) / (maxV - minV), 0, 1, 0),
					BackgroundColor3 = Colors.white,
					BorderSizePixel = 0,
					Parent = rail,
				})
				CreateCorner(fill, 5)

				local function updateFill(v)
					val = math.clamp(v, minV, maxV)
					local pct = (val - minV) / math.max(maxV - minV, 0.001)
					fill.Size = UDim2.new(pct, 0, 1, 0)
					if cfg.Callback then cfg.Callback(val) end
				end

				local dragging = false
				rail.InputBegan:Connect(function(inp)
					if inp.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
						local ab, sz = rail.AbsolutePosition, rail.AbsoluteSize
						updateFill(minV + (maxV - minV) * ((inp.Position.X - ab.X) / sz.X))
					end
				end)

				UserInputService.InputChanged:Connect(function(inp)
					if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
						local ab, sz = rail.AbsolutePosition, rail.AbsoluteSize
						updateFill(minV + (maxV - minV) * ((inp.Position.X - ab.X) / sz.X))
					end
				end)

				UserInputService.InputEnded:Connect(function(inp)
					if inp.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)

				return {
					Set = function(_, v) updateFill(v) end,
					Get = function(_) return val end,
				}
			end

			function elemAPI:AddDropdown(cfg)
				if type(cfg) == "string" then cfg = {Title = cfg} end
				cfg = cfg or {}
				
				elemOrder = elemOrder + 1
				local frame = CreateElement("Frame", {
					Size = UDim2.new(1, 0, 0, 40),
					BackgroundColor3 = Colors.elBg,
					BorderSizePixel = 0,
					LayoutOrder = elemOrder,
					Parent = scroll,
				})
				CreateCorner(frame, 7)

				local selected = cfg.Default or (cfg.Options and cfg.Options[1]) or ""

				CreateElement("TextLabel", {
					Parent = frame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 12, 0.5, -7),
					Size = UDim2.new(0.55, -12, 0, 14),
					Font = Enum.Font.Gotham,
					Text = cfg.Title or "Dropdown",
					TextColor3 = Colors.textPri,
					TextSize = 11,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local selLabel = CreateElement("TextLabel", {
					Parent = frame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.55, 0, 0.5, -7),
					Size = UDim2.new(0.45, -14, 0, 14),
					Font = Enum.Font.Gotham,
					Text = selected,
					TextColor3 = Colors.textSec,
					TextSize = 10,
					TextXAlignment = Enum.TextXAlignment.Right,
				})

				local btn = CreateElement("TextButton", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Text = "",
					Parent = frame,
				})

				btn.MouseButton1Click:Connect(function()
					if cfg.Callback then cfg.Callback(selected) end
				end)

				btn.MouseEnter:Connect(function() Tween(frame, {BackgroundColor3 = Colors.elBgHov}, 0.1) end)
				btn.MouseLeave:Connect(function() Tween(frame, {BackgroundColor3 = Colors.elBg}, 0.1) end)

				return {
					Set = function(_, v) selected = v if selLabel then selLabel.Text = v end end,
					Get = function(_) return selected end,
				}
			end

			function elemAPI:AddColorPicker(cfg)
				if type(cfg) == "string" then cfg = {Title = cfg} end
				cfg = cfg or {}
				
				elemOrder = elemOrder + 1
				local frame = CreateElement("Frame", {
					Size = UDim2.new(1, 0, 0, 40),
					BackgroundColor3 = Colors.elBg,
					BorderSizePixel = 0,
					LayoutOrder = elemOrder,
					Parent = scroll,
				})
				CreateCorner(frame, 7)

				local color = cfg.Default or Color3.fromRGB(255, 100, 50)

				CreateElement("TextLabel", {
					Parent = frame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 12, 0.5, -7),
					Size = UDim2.new(0.55, -12, 0, 14),
					Font = Enum.Font.Gotham,
					Text = cfg.Title or "Color",
					TextColor3 = Colors.textPri,
					TextSize = 11,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local colorBox = CreateElement("Frame", {
					Size = UDim2.new(0, 28, 0, 28),
					Position = UDim2.new(1, -40, 0.5, -14),
					BackgroundColor3 = color,
					BorderSizePixel = 0,
					Parent = frame,
				})
				CreateCorner(colorBox, 6)
				CreateStroke(colorBox, Colors.border, 1.5)

				local btn = CreateElement("TextButton", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Text = "",
					Parent = frame,
				})

				btn.MouseButton1Click:Connect(function()
					if cfg.Callback then cfg.Callback(color) end
				end)

				btn.MouseEnter:Connect(function() Tween(frame, {BackgroundColor3 = Colors.elBgHov}, 0.1) end)
				btn.MouseLeave:Connect(function() Tween(frame, {BackgroundColor3 = Colors.elBg}, 0.1) end)

				return {
					Set = function(_, c) color = c if colorBox then colorBox.BackgroundColor3 = c end end,
					Get = function(_) return color end,
				}
			end

			return elemAPI
		end

		return sectionAPI
	end

	return tabsAPI
end

return EcoHub
