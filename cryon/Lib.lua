-- // EcoHub UI Library
local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game.CoreGui
local v_u_6 = Instance.new
local v_u_7 = UDim2.new
local v_u_8 = UDim2.fromScale
local v_u_9 = UDim.new
local v_u_10 = Color3.fromRGB
local v_u_11 = Color3.fromHSV
local v_u_12 = Color3.toHSV
local v_u_13 = TweenInfo.new
local v_u_14 = Enum.EasingStyle
local v_u_15 = Enum.Font
local v_u_16 = math.clamp
local v_u_17 = math.round
local v_u_18 = string.format
local v_u_19 = v_u_4.LocalPlayer
local v_u_20 = workspace
local v_u_21 = game.Teams
local v_u_22 = v_u_4:GetPlayers()

local EcoHub = {}
EcoHub.__index = EcoHub

local v_u_23 = {}
local v_u_24 = {}

local v_u_25, v_u_26 = pcall(function()
	return loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/src/Icons.lua"))()
end)
if v_u_25 and v_u_26 then v_u_23 = v_u_26 end

local v_u_27, v_u_28 = pcall(function()
	return loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/core/Notifications.lua"))()
end)
if v_u_27 and v_u_28 then v_u_24 = v_u_28 end

local function v_u_47(id)
	return nil
end

local function v_u_48(id, val)
end

local function v_u_49(obj, props, t, style)
	if not obj or not obj.Parent then return end
	v_u_1:Create(obj, v_u_13(t or 0.15, style or v_u_14.Quad), props):Play()
end

local function v_u_50(obj, r)
	local v_u_51 = v_u_6("UICorner")
	v_u_51.CornerRadius = v_u_9(0, r or 6)
	v_u_51.Parent = obj
	return v_u_51
end

local function v_u_52(obj, color, thickness, transparency)
	local v_u_53 = v_u_6("UIStroke")
	v_u_53.Color = color
	v_u_53.Thickness = thickness or 1
	v_u_53.Transparency = transparency or 0
	v_u_53.Parent = obj
	return v_u_53
end

local function v_u_54(class, props)
	local v_u_55 = v_u_6(class)
	for k, v in pairs(props or {}) do
		if k ~= "Parent" then v_u_55[k] = v end
	end
	if props and props.Parent then v_u_55.Parent = props.Parent end
	return v_u_55
end

local function v_u_56(name)
	if not name or name == "" then return "" end
	if not v_u_23 or not v_u_23.assets then return "" end
	local v_u_57 = v_u_23.assets["lucide-" .. name]
	if not v_u_57 then v_u_57 = v_u_23.assets[name] or "" end
	return v_u_57
end

local function v_u_58(title, desc)
	pcall(function()
		if v_u_24 and v_u_24.Notify then
			v_u_24.Notify({ Title = "[ERRO] " .. tostring(title), Description = tostring(desc), Duration = 5 })
		end
	end)
end

local function v_u_59(c)
	return v_u_18("%02X%02X%02X", v_u_17(c.R*255), v_u_17(c.G*255), v_u_17(c.B*255))
end

local function v_u_60(hex)
	hex = hex:gsub("[^%x]", ""):upper()
	if #hex == 6 then
		local r = tonumber(hex:sub(1,2), 16)
		local g = tonumber(hex:sub(3,4), 16)
		local b = tonumber(hex:sub(5,6), 16)
		if r and g and b then return v_u_10(r, g, b) end
	end
	return nil
end

local function v_u_61()
	local v_u_62 = {}
	for _, v_u_63 in ipairs(v_u_4:GetPlayers()) do
		table.insert(v_u_62, v_u_63.Name)
	end
	return v_u_62
end

local v_u_64 = {
	bg = v_u_10(13, 13, 13),
	topbar = v_u_10(20, 20, 20),
	tabbar = v_u_10(13, 13, 13),
	card = v_u_10(22, 22, 22),
	elBg = v_u_10(24, 24, 24),
	elBgHov = v_u_10(34, 34, 34),
	elBgPress = v_u_10(16, 16, 16),
	elemHover = v_u_10(34, 34, 34),
	border = v_u_10(45, 45, 45),
	divider = v_u_10(35, 35, 35),
	textPri = v_u_10(255, 255, 255),
	textSec = v_u_10(185, 185, 185),
	textDim = v_u_10(100, 100, 100),
	muted = v_u_10(100, 100, 100),
	dim = v_u_10(50, 50, 50),
	accentDark = v_u_10(38, 38, 42),
	white = v_u_10(255, 255, 255),
	secBg = v_u_10(13, 13, 13),
	secBord = v_u_10(30, 30, 30),
	secText = v_u_10(210, 210, 210),
	togOn = v_u_10(225, 225, 230),
	togOff = v_u_10(26, 26, 30),
	togKnobOn = v_u_10(20, 20, 24),
	togKnobOff = v_u_10(80, 80, 86),
	togBordOn = v_u_10(210, 210, 215),
	togBordOff = v_u_10(48, 48, 54),
	chkOn = v_u_10(225, 225, 230),
	chkOff = v_u_10(22, 22, 26),
	chkBordOn = v_u_10(210, 210, 215),
	chkBordOff = v_u_10(48, 48, 54),
	chkKnobOn = v_u_10(20, 20, 24),
	chkKnobOff = v_u_10(255, 255, 255),
	dropBg = v_u_10(16, 16, 19),
	dropBorder = v_u_10(42, 42, 50),
	dropSel = v_u_10(38, 38, 46),
	dropItem = v_u_10(30, 30, 36),
	elBorder = v_u_10(38, 38, 44),
	disabled = v_u_10(28, 28, 30),
	disabledTxt = v_u_10(60, 60, 64),
	labelVal = v_u_10(180, 180, 188),
	secIconBg = v_u_10(30, 30, 36),
	secIconClr = v_u_10(160, 160, 170),
	searchBg = v_u_10(18, 18, 18),
	searchBord = v_u_10(38, 38, 44),
}

local v_u_65 = 40
local v_u_66 = 58
local v_u_67 = 580
local v_u_68 = 460

function EcoHub:CreateWindow(config)
	config = config or {}
	local v_u_72 = config.Title or "EcoHub"
	local v_u_73 = config.SubTitle or "v1"

	if v_u_5:FindFirstChild("EcoHub") then
		v_u_5:FindFirstChild("EcoHub"):Destroy()
	end

	local v_u_74 = v_u_54("ScreenGui", {
		Name = "EcoHub", Parent = v_u_5,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ResetOnSpawn = false,
	})

	local v_u_75 = v_u_54("Frame", {
		Name = "MainFrame", Parent = v_u_74,
		BackgroundColor3 = v_u_64.bg,
		Position = v_u_7(0.5, -v_u_67/2, 0.5, -v_u_68/2),
		Size = v_u_7(0, v_u_67, 0, v_u_68),
		Active = true, Draggable = true, ClipsDescendants = false,
	})
	v_u_50(v_u_75, 10)
	v_u_52(v_u_75, v_u_10(52, 52, 58), 1.2)

	local v_u_76 = v_u_54("Frame", {
		Name = "ClipFrame", Parent = v_u_75,
		BackgroundTransparency = 1, Size = v_u_8(1, 1),
		ClipsDescendants = true, BorderSizePixel = 0, ZIndex = 1,
	})

	local v_u_77 = v_u_54("Frame", {
		Name = "TopBar", Parent = v_u_76,
		BackgroundColor3 = v_u_64.topbar, Size = v_u_7(1, 0, 0, 58),
		BorderSizePixel = 0, ZIndex = 2,
	})
	v_u_50(v_u_77, 10)
	v_u_54("Frame", {
		Parent = v_u_77, BackgroundColor3 = v_u_64.topbar,
		Position = v_u_7(0, 0, 1, -10), Size = v_u_7(1, 0, 0, 10), BorderSizePixel = 0,
	})
	v_u_54("Frame", {
		Parent = v_u_77, BackgroundColor3 = v_u_64.divider,
		Position = v_u_7(0, 0, 1, -1), Size = v_u_7(1, 0, 0, 1), BorderSizePixel = 0, ZIndex = 3,
	})
	v_u_54("TextLabel", {
		Parent = v_u_77, BackgroundTransparency = 1,
		Position = v_u_7(0, 18, 0, 8), Size = v_u_7(0, 300, 0, 22),
		Font = v_u_15.Code, Text = v_u_72,
		TextColor3 = v_u_64.textPri, TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
	})
	v_u_54("TextLabel", {
		Parent = v_u_77, BackgroundTransparency = 1,
		Position = v_u_7(0, 18, 0, 32), Size = v_u_7(0, 300, 0, 16),
		Font = v_u_15.Code, Text = v_u_73,
		TextColor3 = v_u_64.muted, TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
	})

	local v_u_81 = v_u_54("TextButton", {
		Parent = v_u_77, BackgroundTransparency = 1,
		Position = v_u_7(1, -40, 0.5, -12), Size = v_u_7(0, 24, 0, 24),
		Text = "", ZIndex = 3,
	})
	v_u_54("ImageLabel", {
		Parent = v_u_81, BackgroundTransparency = 1, Size = v_u_8(1, 1),
		Image = v_u_56("move"), ImageColor3 = v_u_10(95, 95, 100), ZIndex = 4,
	})

	local v_u_82 = v_u_54("Frame", {
		Name = "PageArea", Parent = v_u_76, BackgroundTransparency = 1,
		Position = v_u_7(0, 0, 0, 58),
		Size = v_u_7(1, 0, 1, -116),
		ClipsDescendants = false,
	})

	local v_u_83 = v_u_54("Frame", {
		Name = "TabBar", Parent = v_u_76,
		BackgroundColor3 = v_u_64.tabbar,
		Position = v_u_7(0, 0, 1, -58), Size = v_u_7(1, 0, 0, 58),
		BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 5,
	})
	v_u_50(v_u_83, 10)
	v_u_54("Frame", {
		Parent = v_u_83, BackgroundColor3 = v_u_64.tabbar,
		Position = v_u_7(0, 0, 0, 0), Size = v_u_7(1, 0, 0, 10), BorderSizePixel = 0,
	})
	v_u_54("Frame", {
		Parent = v_u_83, BackgroundColor3 = v_u_64.divider,
		Position = v_u_7(0, 0, 0, 0), Size = v_u_7(1, 0, 0, 1), BorderSizePixel = 0, ZIndex = 6,
	})

	local v_u_84 = 48
	local v_u_85 = 112
	local v_u_86 = 16
	local v_u_87 = {}
	local v_u_88 = {}
	local v_u_89 = {}
	local v_u_90 = nil

	local function v_u_91(ai)
		local n = math.max(1, #v_u_87)
		local expW = v_u_85
		if expW + (n-1)*v_u_84 > v_u_67 - 18 then
			expW = math.max(v_u_84 + 14, v_u_67 - 18 - (n-1)*v_u_84)
		end
		local off = math.max(2, math.floor((v_u_67 - (expW + (n-1)*v_u_84)) / 2))
		local pos, x = {}, off
		for i = 1, n do
			local w = (i == ai) and expW or v_u_84
			pos[i] = { x = x, w = w }
			x = x + w
		end
		return pos
	end

	local function v_u_92(ai, animate)
		local pos = v_u_91(ai)
		for i, tb in ipairs(v_u_88) do
			local p = pos[i]
			if animate then
				v_u_1:Create(tb.bg, v_u_13(0.26, v_u_14.Quint), {
					Position = v_u_7(0, p.x, 0, 0),
					Size = v_u_7(0, p.w, 1, 0),
				}):Play()
			else
				tb.bg.Position = v_u_7(0, p.x, 0, 0)
				tb.bg.Size = v_u_7(0, p.w, 1, 0)
			end
		end
	end

	local function v_u_93(name)
		if v_u_90 == name then return end
		if v_u_90 and v_u_89[v_u_90] then v_u_89[v_u_90].pg.Visible = false end
		v_u_90 = name
		v_u_89[name].pg.Visible = true
		local ai = 1
		for i, t in ipairs(v_u_87) do
			if t.name == name then ai = i; break end
		end
		v_u_92(ai, true)
		for i, tb in ipairs(v_u_88) do
			local on = v_u_87[i].name == name
			if on then
				v_u_49(tb.sq, { BackgroundColor3 = v_u_64.accentDark }, 0.2)
				v_u_49(tb.str, { Color = v_u_64.white, Thickness = 1.5 }, 0.2)
				v_u_49(tb.img, { ImageColor3 = v_u_64.white }, 0.2)
				v_u_49(tb.lbl, { TextColor3 = v_u_64.textPri, TextTransparency = 0 }, 0.2)
				v_u_49(tb.sub, { TextColor3 = v_u_64.muted, TextTransparency = 0 }, 0.2)
			else
				v_u_49(tb.sq, { BackgroundColor3 = v_u_64.card }, 0.2)
				v_u_49(tb.str, { Color = v_u_64.border, Thickness = 1 }, 0.2)
				v_u_49(tb.img, { ImageColor3 = v_u_64.dim }, 0.2)
				v_u_49(tb.lbl, { TextTransparency = 1 }, 0.15)
				v_u_49(tb.sub, { TextTransparency = 1 }, 0.15)
			end
		end
	end

	local v_u_94 = {}

	function v_u_94:AddTab(cfg)
		cfg = cfg or {}
		local name = cfg.Name or ("Tab" .. tostring(#v_u_87 + 1))
		local subText = cfg.Sub or ""
		local iconKey = cfg.Icon or "home"

		if #v_u_87 >= 10 then
			v_u_58("AddTab", "Limite de 10 tabs atingido.")
			return nil
		end

		local v_u_95 = v_u_54("Frame", {
			Name = name, Parent = v_u_82, BackgroundTransparency = 1,
			Size = v_u_7(1, 0, 1, 0), Visible = false, ClipsDescendants = false,
		})

		local function v_u_96(posX, sizeW)
			local v_u_97 = v_u_54("ScrollingFrame", {
				Parent = v_u_95,
				Position = v_u_7(posX, posX == 0 and 8 or 4, 0, 5),
				Size = v_u_7(sizeW, -12, 1, -10),
				BackgroundTransparency = 1, BorderSizePixel = 0,
				ScrollBarThickness = 2, ScrollBarImageColor3 = v_u_10(70, 70, 76),
				CanvasSize = v_u_7(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollingDirection = Enum.ScrollingDirection.Y, ScrollingEnabled = true,
				ElasticBehavior = Enum.ElasticBehavior.Never,
			})
			local v_u_98 = v_u_54("UIListLayout", {
				Parent = v_u_97, SortOrder = Enum.SortOrder.LayoutOrder, Padding = v_u_9(0, 2),
			})
			v_u_54("UIPadding", {
				Parent = v_u_97,
				PaddingTop = v_u_9(0, 3),
				PaddingBottom = v_u_9(0, 16),
				PaddingLeft = v_u_9(0, 3),
				PaddingRight = v_u_9(0, 6),
			})
			v_u_98:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				v_u_97.CanvasSize = v_u_7(0, 0, 0, v_u_98.AbsoluteContentSize.Y + 32)
			end)
			return v_u_97
		end

		local v_u_99 = v_u_96(0, 0.5)
		local v_u_100 = v_u_96(0.5, 0.5)

		v_u_54("Frame", {
			Parent = v_u_95, Position = v_u_7(0.5, -1, 0, 5), Size = v_u_7(0, 1, 1, -10),
			BackgroundColor3 = v_u_64.divider, BorderSizePixel = 0,
		})

		v_u_89[name] = { pg = v_u_95, left = v_u_99, right = v_u_100 }
		table.insert(v_u_87, { name = name, sub = subText })
		local idx = #v_u_87

		local v_u_101 = v_u_54("Frame", {
			Parent = v_u_83, BackgroundTransparency = 1, BorderSizePixel = 0,
			ClipsDescendants = true, ZIndex = 6,
			Size = v_u_7(0, v_u_84, 1, 0),
		})
		local v_u_102 = v_u_54("Frame", {
			Parent = v_u_101,
			Size = v_u_7(0, 36, 0, 36),
			Position = v_u_7(0, 6, 0.5, -18),
			BackgroundColor3 = v_u_64.card, BorderSizePixel = 0, ZIndex = 7,
		})
		v_u_50(v_u_102, 8)
		local v_u_103 = v_u_52(v_u_102, v_u_64.border, 1)
		local v_u_104 = v_u_54("ImageLabel", {
			Parent = v_u_102, BackgroundTransparency = 1,
			Size = v_u_7(0, v_u_86, 0, v_u_86),
			Position = v_u_7(0.5, -v_u_86/2, 0.5, -v_u_86/2),
			Image = v_u_56(iconKey), ImageColor3 = v_u_64.dim, ZIndex = 9,
		})
		local v_u_105 = v_u_54("TextLabel", {
			Parent = v_u_101, BackgroundTransparency = 1,
			Size = v_u_7(1, -50, 0, 13), Position = v_u_7(0, 48, 0.5, -11),
			Font = v_u_15.GothamBold, Text = name,
			TextColor3 = v_u_64.textPri, TextSize = 9,
			TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1, ZIndex = 7,
		})
		local v_u_106 = v_u_54("TextLabel", {
			Parent = v_u_101, BackgroundTransparency = 1,
			Size = v_u_7(1, -50, 0, 10), Position = v_u_7(0, 48, 0.5, 3),
			Font = v_u_15.Gotham, Text = subText,
			TextColor3 = v_u_64.muted, TextSize = 7,
			TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1, ZIndex = 7,
		})
		local v_u_107 = v_u_54("TextButton", {
			Parent = v_u_101, Size = v_u_8(1, 1),
			BackgroundTransparency = 1, Text = "", ZIndex = 12,
		})

		v_u_88[idx] = { name = name, bg = v_u_101, sq = v_u_102, str = v_u_103, img = v_u_104, lbl = v_u_105, sub = v_u_106 }

		local function v_u_108()
			for i, t in ipairs(v_u_87) do
				if t.name == v_u_90 then return i end
			end
			return idx
		end
		v_u_92(v_u_90 and v_u_108() or idx, false)

		v_u_107.MouseButton1Click:Connect(function() v_u_93(name) end)
		v_u_107.MouseEnter:Connect(function()
			if v_u_90 ~= name then
				v_u_49(v_u_102, { BackgroundColor3 = v_u_64.elemHover }, 0.1)
				v_u_49(v_u_104, { ImageColor3 = v_u_64.muted }, 0.1)
			end
		end)
		v_u_107.MouseLeave:Connect(function()
			if v_u_90 ~= name then
				v_u_49(v_u_102, { BackgroundColor3 = v_u_64.card }, 0.1)
				v_u_49(v_u_104, { ImageColor3 = v_u_64.dim }, 0.1)
			end
		end)

		if #v_u_87 == 1 then
			v_u_90 = name
			v_u_95.Visible = true
			v_u_92(1, false)
			local tb = v_u_88[1]
			tb.sq.BackgroundColor3 = v_u_64.accentDark
			tb.str.Color = v_u_64.white
			tb.str.Thickness = 1.5
			tb.img.ImageColor3 = v_u_64.white
			tb.lbl.TextTransparency = 0
			tb.lbl.TextColor3 = v_u_64.textPri
			tb.sub.TextTransparency = 0
			tb.sub.TextColor3 = v_u_64.muted
		end

		local v_u_109 = {}
		local v_u_110 = { left = 0, right = 0 }

		function v_u_109:AddSection(cfg)
			cfg = cfg or {}
			if type(cfg) == "string" then
				cfg = { Name = cfg }
			end
			local v_u_111 = (cfg.Box == "right") and "right" or "left"
			local v_u_112 = cfg.Name or cfg[1] or "Secao"
			local v_u_113 = cfg.Icon or ""
			local v_u_114 = (v_u_111 == "left") and v_u_99 or v_u_100
			v_u_110[v_u_111] = v_u_110[v_u_111] + 1

			local SEC_H = 38

			local v_u_115 = v_u_54("Frame", {
				Size = v_u_7(1, 0, 0, SEC_H),
				BackgroundColor3 = v_u_64.bg,
				BorderSizePixel = 0, LayoutOrder = v_u_110[v_u_111],
				ZIndex = 2, ClipsDescendants = true, Parent = v_u_114,
			})
			v_u_50(v_u_115, 6)
			v_u_52(v_u_115, v_u_64.secBord, 1, 0.5)

			local v_u_116 = v_u_54("Frame", {
				Size = v_u_7(0, 80, 1, 0), Position = v_u_7(-0.5, 0, 0, 0),
				BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 5, Parent = v_u_115,
			})
			v_u_54("UIGradient", {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, v_u_10(13, 13, 13)),
					ColorSequenceKeypoint.new(0.5, v_u_10(140, 140, 160)),
					ColorSequenceKeypoint.new(1, v_u_10(13, 13, 13)),
				}),
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.45, 0.75),
					NumberSequenceKeypoint.new(0.5, 0.65),
					NumberSequenceKeypoint.new(0.55, 0.75),
					NumberSequenceKeypoint.new(1, 1),
				}),
				Parent = v_u_116,
			})

			local textOffsetX = 10
			if v_u_113 ~= "" then
				local iconImg
				if v_u_113:match("^rbxassetid://") or v_u_113:match("^%d+$") then
					iconImg = v_u_113:match("^%d+$") and ("rbxassetid://" .. v_u_113) or v_u_113
				else
					iconImg = v_u_56(v_u_113)
				end
				v_u_54("ImageLabel", {
					Parent = v_u_115, BackgroundTransparency = 1,
					Size = v_u_7(0, 16, 0, 16),
					Position = v_u_7(0, 9, 0.5, -8),
					Image = iconImg,
					ImageColor3 = v_u_64.secIconClr, ZIndex = 6,
				})
				textOffsetX = 30
			end

			local v_u_119 = v_u_54("TextLabel", {
				Size = v_u_7(1, -(textOffsetX + 6), 1, 0),
				Position = v_u_7(0, textOffsetX, 0, 0),
				BackgroundTransparency = 1, Text = string.upper(tostring(v_u_112 or "")),
				TextColor3 = v_u_64.secText, TextSize = 10, Font = v_u_15.GothamBold,
				TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6, Parent = v_u_115,
			})

			task.spawn(function()
				while v_u_115 and v_u_115.Parent do
					pcall(function() v_u_116.Position = v_u_7(-0.5, 0, 0, 0) end)
					task.wait(0.1)
					v_u_49(v_u_116, { Position = v_u_7(1.5, 0, 0, 0) }, 1.8, v_u_14.Linear)
					task.wait(5)
				end
			end)

			local v_u_120 = {}
			local v_u_121 = v_u_110

			local function v_u_122(h)
				v_u_121[v_u_111] = v_u_121[v_u_111] + 1
				local f = v_u_54("Frame", {
					Size = v_u_7(1, 0, 0, h), BackgroundColor3 = v_u_64.elBg,
					BorderSizePixel = 0, LayoutOrder = v_u_121[v_u_111], ZIndex = 3, Parent = v_u_114,
				})
				v_u_50(f, 7)
				return f
			end

			local function v_u_123(f, isDisabled)
				if not f then return end
				v_u_49(f, { BackgroundColor3 = isDisabled and v_u_64.disabled or v_u_64.elBg }, 0.15)
			end

			local function v_u_124(parent, xOffset, hasDesc, descText)
				local lbl = v_u_54("TextLabel", {
					Size = v_u_7(1, -(xOffset + 8), 0, 13),
					Position = v_u_7(0, xOffset, 0, 24),
					BackgroundTransparency = 1,
					Text = tostring(descText or ""),
					TextColor3 = v_u_64.muted,
					TextSize = 9, Font = v_u_15.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd,
					Visible = hasDesc, ZIndex = 4, Parent = parent,
				})
				return lbl
			end

			function v_u_120:AddLabel(cfg)
				if type(cfg) == "string" then
					cfg = { Title = cfg }
				end
				cfg = cfg or {}
				local titulo = cfg.Title or "Label"
				local value = cfg.Value or ""
				local desc = cfg.Description or ""
				local saveId = cfg.SaveId or ""
				local callback = cfg.Callback

				local hasDesc = desc and desc ~= ""
				local h = hasDesc and v_u_66 or v_u_65
				local f = v_u_122(h)

				local titleLbl = v_u_54("TextLabel", {
					Size = v_u_7(0.55, -12, 0, 14),
					Position = hasDesc and v_u_7(0, 12, 0, 8) or v_u_7(0, 12, 0.5, -7),
					BackgroundTransparency = 1,
					Text = titulo,
					TextColor3 = v_u_64.textPri, TextSize = 11, Font = v_u_15.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 4, Parent = f,
				})

				local valueLbl = v_u_54("TextLabel", {
					Size = v_u_7(0.45, -14, 0, 14),
					Position = hasDesc and v_u_7(0.55, 0, 0, 8) or v_u_7(0.55, 0, 0.5, -7),
					BackgroundTransparency = 1,
					Text = tostring(value),
					TextColor3 = v_u_64.labelVal, TextSize = 10, Font = v_u_15.GothamSemibold,
					TextXAlignment = Enum.TextXAlignment.Right,
					TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 4, Parent = f,
				})

				local descLbl = v_u_124(f, 12, hasDesc, desc)

				return {
					Set = function(_, v)
						if valueLbl then valueLbl.Text = tostring(v) end
						pcall(function() if callback then callback(tostring(v)) end end)
					end,
					Get = function(_) return valueLbl and valueLbl.Text or "" end,
					SetTitle = function(_, v) if titleLbl then titleLbl.Text = tostring(v) end end,
					SetValue = function(_, v)
						if valueLbl then valueLbl.Text = tostring(v) end
						pcall(function() if callback then callback(tostring(v)) end end)
					end,
					SetDescription = function(_, v)
						if descLbl then
							local nd = v and v ~= ""
							descLbl.Text = tostring(v or "")
							descLbl.Visible = nd
							f.Size = v_u_7(1, 0, 0, nd and v_u_66 or v_u_65)
						end
					end,
					SetColor = function(_, c) if valueLbl then valueLbl.TextColor3 = c end end,
					SetTitleColor = function(_, c) if titleLbl then titleLbl.TextColor3 = c end end,
					SetColorTween = function(_, c, t)
						if valueLbl then v_u_49(valueLbl, { TextColor3 = c }, t or 0.2) end
					end,
					SetVisible = function(_, v) if f then f.Visible = v ~= false end end,
					Destroy = function(_) pcall(function() f:Destroy() end) end,
				}
			end

			function v_u_120:AddToggle(cfg)
				if type(cfg) == "string" then
					cfg = { Title = cfg }
				end
				cfg = cfg or {}
				local titulo = cfg.Title or "Toggle"
				local desc = cfg.Description or ""
				local saveId = cfg.SaveId or ""
				local callback = cfg.Callback
				local state = cfg.Default == true
				local enabled = true

				local hasDesc = desc and desc ~= ""
				local h = hasDesc and v_u_66 or v_u_65
				local f = v_u_122(h)

				local titleLbl = v_u_54("TextLabel", {
					Size = v_u_7(1, -70, 0, 14),
					Position = hasDesc and v_u_7(0, 12, 0, 8) or v_u_7(0, 12, 0.5, -7),
					BackgroundTransparency = 1, Text = titulo,
					TextColor3 = v_u_64.textPri, TextSize = 11, Font = v_u_15.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 4, Parent = f,
				})
				local descLbl = v_u_124(f, 12, hasDesc, desc)

				local TW, TH = 34, 18
				local track = v_u_54("Frame", {
					Size = v_u_7(0, TW, 0, TH),
					Position = v_u_7(1, -(TW+11), 0.5, -TH/2),
					BackgroundColor3 = state and v_u_64.togOn or v_u_64.togOff,
					BorderSizePixel = 0, ZIndex = 5, Parent = f,
				})
				v_u_50(track, TH)
				local tStr = v_u_52(track, state and v_u_64.togBordOn or v_u_64.togBordOff, 1, 0.05)
				local KSZ = 12
				local knob = v_u_54("Frame", {
					Size = v_u_7(0, KSZ, 0, KSZ),
					Position = state and v_u_7(1, -(KSZ+3), 0.5, -KSZ/2) or v_u_7(0, 3, 0.5, -KSZ/2),
					BackgroundColor3 = state and v_u_64.togKnobOn or v_u_64.togKnobOff,
					BorderSizePixel = 0, ZIndex = 6, Parent = track,
				})
				v_u_50(knob, KSZ)

				local function refresh(s)
					v_u_49(track, { BackgroundColor3 = s and v_u_64.togOn or v_u_64.togOff }, 0.15)
					v_u_49(knob, {
						Position = s and v_u_7(1, -(KSZ+3), 0.5, -KSZ/2) or v_u_7(0, 3, 0.5, -KSZ/2),
						BackgroundColor3 = s and v_u_64.togKnobOn or v_u_64.togKnobOff,
					}, 0.15, v_u_14.Back)
					v_u_49(tStr, { Color = s and v_u_64.togBordOn or v_u_64.togBordOff }, 0.13)
				end

				local btn2 = v_u_54("TextButton", {
					Size = v_u_8(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 7, Parent = f,
				})
				btn2.MouseButton1Click:Connect(function()
					if not enabled then return end
					state = not state
					refresh(state)
					local ok, err = pcall(function() if callback then callback(state) end end)
					if not ok then v_u_58("Toggle", err) end
				end)
				btn2.MouseEnter:Connect(function() if enabled then v_u_49(f, { BackgroundColor3 = v_u_64.elBgHov }, 0.1) end end)
				btn2.MouseLeave:Connect(function() if enabled then v_u_49(f, { BackgroundColor3 = v_u_64.elBg }, 0.1) end end)

				return {
					Set = function(_, v)
						state = v == true
						refresh(state)
					end,
					Get = function(_) return state end,
					SetEnabled = function(_, v)
						enabled = v ~= false
						v_u_123(f, not enabled)
						v_u_49(titleLbl, { TextColor3 = enabled and v_u_64.textPri or v_u_64.disabledTxt }, 0.15)
						v_u_49(track, { BackgroundTransparency = enabled and 0 or 0.6 }, 0.15)
						v_u_49(knob, { BackgroundTransparency = enabled and 0 or 0.6 }, 0.15)
					end,
					SetVisible = function(_, v) if f then f.Visible = v ~= false end end,
					SetTitle = function(_, v) if titleLbl then titleLbl.Text = tostring(v) end end,
					SetDescription = function(_, v)
						if descLbl then
							local nd = v and v ~= ""
							descLbl.Text = tostring(v or "")
							descLbl.Visible = nd
							f.Size = v_u_7(1, 0, 0, nd and v_u_66 or v_u_65)
						end
					end,
					SetCallback = function(_, fn) callback = fn end,
					Toggle = function(_)
						state = not state
						refresh(state)
						pcall(function() if callback then callback(state) end end)
					end,
					Destroy = function(_) pcall(function() f:Destroy() end) end,
				}
			end

			function v_u_120:AddCheckbox(cfg)
				if type(cfg) == "string" then
					cfg = { Title = cfg }
				end
				cfg = cfg or {}
				local titulo = cfg.Title or "Checkbox"
				local desc = cfg.Description or ""
				local saveId = cfg.SaveId or ""
				local callback = cfg.Callback
				local state = cfg.Default == true
				local enabled = true

				local hasDesc = desc and desc ~= ""
				local h = hasDesc and v_u_66 or v_u_65
				local f = v_u_122(h)

				local BSZ = 16
				local box = v_u_54("Frame", {
					Size = v_u_7(0, BSZ, 0, BSZ),
					Position = v_u_7(0, 12, 0.5, -BSZ/2),
					BackgroundColor3 = state and v_u_64.chkOn or v_u_64.chkOff,
					BorderSizePixel = 0, ZIndex = 5, Parent = f,
				})
				v_u_50(box, 4)
				local bStr = v_u_52(box, state and v_u_64.chkBordOn or v_u_64.chkBordOff, 1.5)
				local chk = v_u_54("ImageLabel", {
					Size = v_u_7(0, BSZ-6, 0, BSZ-6),
					Position = v_u_7(0.5, -(BSZ-6)/2, 0.5, -(BSZ-6)/2),
					BackgroundTransparency = 1, Image = v_u_56("check"),
					ImageColor3 = state and v_u_64.chkKnobOn or v_u_64.chkKnobOff,
					ImageTransparency = state and 0 or 1, ZIndex = 6, Parent = box,
				})
				local titleLbl = v_u_54("TextLabel", {
					Size = v_u_7(1, -(BSZ+26), 0, 14),
					Position = hasDesc and v_u_7(0, BSZ+20, 0, 8) or v_u_7(0, BSZ+20, 0.5, -7),
					BackgroundTransparency = 1, Text = titulo,
					TextColor3 = v_u_64.textPri, TextSize = 11, Font = v_u_15.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 4, Parent = f,
				})
				local descLbl = v_u_124(f, BSZ + 20, hasDesc, desc)

				local function refresh(s)
					v_u_49(box, { BackgroundColor3 = s and v_u_64.chkOn or v_u_64.chkOff }, 0.14)
					v_u_49(bStr, { Color = s and v_u_64.chkBordOn or v_u_64.chkBordOff }, 0.13)
					v_u_49(chk, { ImageTransparency = s and 0 or 1, ImageColor3 = s and v_u_64.chkKnobOn or v_u_64.chkKnobOff }, 0.11)
				end

				local btn2 = v_u_54("TextButton", {
					Size = v_u_8(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 7, Parent = f,
				})
				btn2.MouseButton1Click:Connect(function()
					if not enabled then return end
					state = not state
					refresh(state)
					local ok, err = pcall(function() if callback then callback(state) end end)
					if not ok then v_u_58("Checkbox", err) end
				end)
				btn2.MouseEnter:Connect(function() if enabled then v_u_49(f, { BackgroundColor3 = v_u_64.elBgHov }, 0.1) end end)
				btn2.MouseLeave:Connect(function() if enabled then v_u_49(f, { BackgroundColor3 = v_u_64.elBg }, 0.1) end end)

				return {
					Set = function(_, v)
						state = v == true
						refresh(state)
					end,
					Get = function(_) return state end,
					SetEnabled = function(_, v)
						enabled = v ~= false
						v_u_123(f, not enabled)
						v_u_49(titleLbl, { TextColor3 = enabled and v_u_64.textPri or v_u_64.disabledTxt }, 0.15)
						v_u_49(bStr, { Color = enabled and (state and v_u_64.chkBordOn or v_u_64.chkBordOff) or v_u_64.disabled }, 0.15)
						v_u_49(box, { BackgroundTransparency = enabled and 0 or 0.5 }, 0.15)
					end,
					SetVisible = function(_, v) if f then f.Visible = v ~= false end end,
					SetTitle = function(_, v) if titleLbl then titleLbl.Text = tostring(v) end end,
					SetDescription = function(_, v)
						if descLbl then
							local nd = v and v ~= ""
							descLbl.Text = tostring(v or "")
							descLbl.Visible = nd
							f.Size = v_u_7(1, 0, 0, nd and v_u_66 or v_u_65)
						end
					end,
					SetCallback = function(_, fn) callback = fn end,
					Toggle = function(_)
						state = not state
						refresh(state)
						pcall(function() if callback then callback(state) end end)
					end,
					Destroy = function(_) pcall(function() f:Destroy() end) end,
				}
			end

			function v_u_120:AddButton(cfg)
				if type(cfg) == "string" then
					cfg = { Title = cfg }
				end
				cfg = cfg or {}
				local titulo = cfg.Title or "Button"
				local desc = cfg.Description or ""
				local saveId = cfg.SaveId or ""
				local callback = cfg.Callback
				local enabled = true
				local loading = false

				local hasDesc = desc and desc ~= ""
				local h = hasDesc and v_u_66 or v_u_65
				local f = v_u_122(h)

				local titleLbl = v_u_54("TextLabel", {
					Size = v_u_7(1, -40, 0, 14),
					Position = hasDesc and v_u_7(0, 12, 0, 8) or v_u_7(0, 12, 0.5, -7),
					BackgroundTransparency = 1, Text = titulo,
					TextColor3 = v_u_64.textPri, TextSize = 11, Font = v_u_15.GothamSemibold,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 5, Parent = f,
				})
				local descLbl = v_u_124(f, 12, hasDesc, desc)

				local arrow = v_u_54("ImageLabel", {
					Size = v_u_7(0, 10, 0, 10), Position = v_u_7(1, -20, 0.5, -5),
					BackgroundTransparency = 1, Image = v_u_56("chevron-right"),
					ImageColor3 = v_u_64.textDim, ZIndex = 5, Parent = f,
				})

				local spinnerLbl = v_u_54("TextLabel", {
					Size = v_u_7(0, 13, 0, 13), Position = v_u_7(1, -20, 0.5, -6.5),
					BackgroundTransparency = 1, Text = "○",
					TextColor3 = v_u_64.muted, TextSize = 12, Font = v_u_15.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Center,
					Visible = false, ZIndex = 5, Parent = f,
				})

				local spinConn = nil
				local spinChars = {"◜","◝","◞","◟"}
				local spinIdx = 1

				local function startSpin()
					spinnerLbl.Visible = true
					arrow.Visible = false
					spinConn = v_u_3.Heartbeat:Connect(function()
						spinIdx = (spinIdx % #spinChars) + 1
						spinnerLbl.Text = spinChars[spinIdx]
					end)
				end

				local function stopSpin()
					if spinConn then spinConn:Disconnect(); spinConn = nil end
					spinnerLbl.Visible = false
					arrow.Visible = enabled
				end

				local btn2 = v_u_54("TextButton", {
					Size = v_u_8(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 7, Parent = f,
				})
				btn2.MouseEnter:Connect(function()
					if not enabled or loading then return end
					v_u_49(f, { BackgroundColor3 = v_u_64.elBgHov }, 0.1)
					v_u_49(arrow, { ImageColor3 = v_u_64.white }, 0.1)
				end)
				btn2.MouseLeave:Connect(function()
					if not enabled or loading then return end
					v_u_49(f, { BackgroundColor3 = v_u_64.elBg }, 0.1)
					v_u_49(arrow, { ImageColor3 = v_u_64.textDim }, 0.1)
				end)
				btn2.MouseButton1Down:Connect(function()
					if enabled and not loading then v_u_49(f, { BackgroundColor3 = v_u_64.elBgPress }, 0.06) end
				end)
				btn2.MouseButton1Up:Connect(function()
					if enabled and not loading then v_u_49(f, { BackgroundColor3 = v_u_64.elBgHov }, 0.06) end
				end)
				btn2.MouseButton1Click:Connect(function()
					if not enabled or loading then return end
					local ok, err = pcall(function() if callback then callback() end end)
					if not ok then v_u_58("Button", err) end
				end)

				return {
					SetTitle = function(_, v) if titleLbl then titleLbl.Text = tostring(v) end end,
					SetDescription = function(_, v)
						if descLbl then
							local nd = v and v ~= ""
							descLbl.Text = tostring(v or "")
							descLbl.Visible = nd
							f.Size = v_u_7(1, 0, 0, nd and v_u_66 or v_u_65)
						end
					end,
					SetCallback = function(_, fn) callback = fn end,
					SetEnabled = function(_, v)
						enabled = v ~= false
						v_u_123(f, not enabled)
						v_u_49(titleLbl, { TextColor3 = enabled and v_u_64.textPri or v_u_64.disabledTxt }, 0.15)
						v_u_49(arrow, { ImageColor3 = enabled and v_u_64.textDim or v_u_64.dim }, 0.15)
					end,
					SetVisible = function(_, v) if f then f.Visible = v ~= false end end,
					SetLoading = function(_, v)
						loading = v == true
						if loading then
							startSpin()
							v_u_49(titleLbl, { TextColor3 = v_u_64.muted }, 0.15)
						else
							stopSpin()
							v_u_49(titleLbl, { TextColor3 = enabled and v_u_64.textPri or v_u_64.disabledTxt }, 0.15)
						end
					end,
					SetIcon = function(_, iconName)
						if arrow then arrow.Image = v_u_56(iconName) end
					end,
					Fire = function(_)
						if enabled and not loading then
							pcall(function() if callback then callback() end end)
						end
					end,
					Destroy = function(_)
						if spinConn then spinConn:Disconnect() end
						pcall(function() f:Destroy() end)
					end,
				}
			end

			function v_u_120:AddSlider(cfg)
				if type(cfg) == "string" then
					cfg = { Title = cfg }
				end
				cfg = cfg or {}
				local titulo = cfg.Title or "Slider"
				local desc = cfg.Description or ""
				local saveId = cfg.SaveId or ""
				local callback = cfg.Callback
				local minV = cfg.Min or 0
				local maxV = cfg.Max or 100
				local step = cfg.Rounding or 1
				local suffix = cfg.Suffix or ""

				local val = v_u_16(cfg.Default or minV, minV, maxV)
				local enabled = true
				local drag = false

				local hasDesc = desc and desc ~= ""
				local RAIL_H = 18
				local PAD = 12
				local sliderH = hasDesc and 60 or 44
				local f = v_u_122(sliderH)

				local function fmtVal(vv)
					local base = (step < 1) and v_u_18("%.2f", vv) or tostring(v_u_17(vv))
					return base .. suffix
				end

				local titleLbl = v_u_54("TextLabel", {
					Size = v_u_7(1, -(PAD * 2), 0, 12),
					Position = v_u_7(0, PAD, 0, hasDesc and 4 or 6),
					BackgroundTransparency = 1, Text = titulo,
					TextColor3 = v_u_64.textPri, TextSize = 10, Font = v_u_15.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4, Parent = f,
				})

				local descLbl = nil
				if hasDesc then
					descLbl = v_u_54("TextLabel", {
						Size = v_u_7(1, -(PAD * 2), 0, 11),
						Position = v_u_7(0, PAD, 0, 18),
						BackgroundTransparency = 1, Text = desc,
						TextColor3 = v_u_64.muted, TextSize = 9, Font = v_u_15.Gotham,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextTruncate = Enum.TextTruncate.AtEnd,
						ZIndex = 4, Parent = f,
					})
				end

				local railY = hasDesc and 32 or 22
				local pct = (val - minV) / math.max(maxV - minV, 0.001)

				local rail = v_u_54("Frame", {
					Size = v_u_7(1, -(PAD * 2), 0, RAIL_H),
					Position = v_u_7(0, PAD, 0, railY),
					BackgroundColor3 = v_u_10(38, 38, 42),
					BorderSizePixel = 0, ZIndex = 4, Parent = f,
				})
				v_u_50(rail, 5)
				v_u_52(rail, v_u_10(50, 50, 56), 1, 0.5)

				local fill = v_u_54("Frame", {
					Size = v_u_7(pct, 0, 1, 0),
					BackgroundColor3 = v_u_10(255, 255, 255),
					BorderSizePixel = 0, ZIndex = 5, Parent = rail,
				})
				v_u_50(fill, 5)

				local valLbl = v_u_54("TextLabel", {
					Size = v_u_8(1, 1),
					BackgroundTransparency = 1,
					Text = fmtVal(val) .. " / " .. fmtVal(maxV),
					TextColor3 = v_u_10(110, 110, 116),
					TextSize = 9, Font = v_u_15.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
					ZIndex = 7, Parent = rail,
				})

				local function updateLabel()
					if valLbl then
						valLbl.Text = fmtVal(val) .. " / " .. fmtVal(maxV)
					end
				end

				local function setVal(vv, silent)
					if not enabled then return end
					if step > 0 then vv = v_u_17(vv / step) * step end
					val = v_u_16(v_u_17(vv * 1000) / 1000, minV, maxV)
					local p = (val - minV) / math.max(maxV - minV, 0.001)
					fill.Size = v_u_7(p, 0, 1, 0)
					updateLabel()
					if not silent then
						local ok, err = pcall(function() if callback then callback(val) end end)
						if not ok then v_u_58("Slider", err) end
					end
				end

				local hit = v_u_54("TextButton", {
					Size = v_u_7(1, 0, 0, RAIL_H + 14),
					Position = v_u_7(0, 0, 0.5, -(RAIL_H + 14) / 2),
					BackgroundTransparency = 1, Text = "", ZIndex = 8, Parent = rail,
				})

				hit.InputBegan:Connect(function(inp)
					if not enabled then return end
					if inp.UserInputType ~= Enum.UserInputType.MouseButton1
						and inp.UserInputType ~= Enum.UserInputType.Touch then return end
					drag = true
					if not rail or not rail.Parent then return end
					local ab, sz = rail.AbsolutePosition, rail.AbsoluteSize
					setVal(minV + (maxV - minV) * v_u_16((inp.Position.X - ab.X) / sz.X, 0, 1))
				end)
				hit.MouseEnter:Connect(function()
					if enabled then v_u_49(f, { BackgroundColor3 = v_u_64.elBgHov }, 0.1) end
				end)
				hit.MouseLeave:Connect(function()
					if enabled then v_u_49(f, { BackgroundColor3 = v_u_64.elBg }, 0.1) end
				end)

				local slMoveConn = v_u_2.InputChanged:Connect(function(inp)
					if not drag or not enabled then return end
					if inp.UserInputType ~= Enum.UserInputType.MouseMovement
						and inp.UserInputType ~= Enum.UserInputType.Touch then return end
					if not rail or not rail.Parent then return end
					local ab, sz = rail.AbsolutePosition, rail.AbsoluteSize
					setVal(minV + (maxV - minV) * v_u_16((inp.Position.X - ab.X) / sz.X, 0, 1))
				end)

				local slEndConn = v_u_2.InputEnded:Connect(function(inp)
					if inp.UserInputType == Enum.UserInputType.MouseButton1
						or inp.UserInputType == Enum.UserInputType.Touch then
						drag = false
					end
				end)

				return {
					Set = function(_, vv) setVal(vv) end,
					Get = function(_) return val end,
					SetMin = function(_, vv)
						minV = vv
						setVal(math.max(val, minV), true)
						updateLabel()
					end,
					SetMax = function(_, vv)
						maxV = vv
						setVal(math.min(val, maxV), true)
						updateLabel()
					end,
					SetStep = function(_, vv)
						step = vv or 1
						setVal(val, true)
					end,
					SetSuffix = function(_, s)
						suffix = tostring(s or "")
						updateLabel()
					end,
					SetDescription = function(_, v)
						if descLbl then
							local nd = v and v ~= ""
							descLbl.Text = tostring(v or "")
							descLbl.Visible = nd
							local newH = nd and 60 or 44
							f.Size = v_u_7(1, 0, 0, newH)
							rail.Position = v_u_7(0, PAD, 0, nd and 32 or 22)
						end
					end,
					SetEnabled = function(_, vv)
						enabled = vv ~= false
						drag = false
						v_u_123(f, not enabled)
						v_u_49(titleLbl, { TextColor3 = enabled and v_u_64.textPri or v_u_64.disabledTxt }, 0.15)
						v_u_49(fill, { BackgroundColor3 = enabled and v_u_10(255, 255, 255) or v_u_64.dim }, 0.15)
						v_u_49(valLbl, { TextColor3 = enabled and v_u_10(110, 110, 116) or v_u_64.disabledTxt }, 0.15)
					end,
					SetVisible = function(_, vv) if f then f.Visible = vv ~= false end end,
					SetTitle = function(_, vv) if titleLbl then titleLbl.Text = tostring(vv) end end,
					SetCallback = function(_, fn) callback = fn end,
					Destroy = function(_)
						pcall(function() slMoveConn:Disconnect() end)
						pcall(function() slEndConn:Disconnect() end)
						drag = false
						pcall(function() f:Destroy() end)
					end,
				}
			end

			function v_u_120:AddDropdown(cfg)
				if type(cfg) == "string" then
					cfg = { Title = cfg }
				end
				cfg = cfg or {}
				local titulo = cfg.Title or "Dropdown"
				local desc = cfg.Description or ""
				local saveId = cfg.SaveId or ""
				local callback = cfg.Callback
				local options = cfg.Options or {}
				local isPlayers = cfg.Players == true
				local selected = cfg.Default or options[1] or ""
				local enabled = true
				local open = false
				local placeholder = ""
				local ITEM_H = 30
				local MAX_VISIBLE = 5
				local GAP = 4

				if isPlayers then
					options = v_u_61()
					if #options > 0 and selected == "" then selected = options[1] end
				end

				local hasDesc = desc and desc ~= ""
				local baseH = hasDesc and v_u_66 or v_u_65

				v_u_110[v_u_111] = v_u_110[v_u_111] + 1
				local wrap = v_u_54("Frame", {
					Size = v_u_7(1, 0, 0, baseH),
					BackgroundTransparency = 1, ClipsDescendants = false,
					LayoutOrder = v_u_110[v_u_111], ZIndex = 10, Parent = v_u_114,
				})

				local header = v_u_54("Frame", {
					Size = v_u_7(1, 0, 0, baseH),
					BackgroundColor3 = v_u_64.elBg,
					BorderSizePixel = 0, ZIndex = 11, Parent = wrap,
				})
				v_u_50(header, 7)

				local titleLbl = v_u_54("TextLabel", {
					Size = v_u_7(0.55, -16, 0, 14),
					Position = hasDesc and v_u_7(0, 12, 0, 8) or v_u_7(0, 12, 0.5, -7),
					BackgroundTransparency = 1, Text = titulo,
					TextColor3 = v_u_64.textPri, TextSize = 11, Font = v_u_15.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 12, Parent = header,
				})
				local descLbl = hasDesc and v_u_124(header, 12, true, desc) or nil

				local selLbl = v_u_54("TextLabel", {
					Size = v_u_7(0.45, -28, 0, 14),
					Position = hasDesc and v_u_7(0.55, 0, 0, 8) or v_u_7(0.55, 0, 0.5, -7),
					BackgroundTransparency = 1, Text = selected,
					TextColor3 = v_u_64.textSec, TextSize = 10, Font = v_u_15.Gotham,
					TextXAlignment = Enum.TextXAlignment.Right,
					TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 12, Parent = header,
				})

				local colorBox = v_u_54("Frame", {
					Size = v_u_7(0, 14, 0, 14),
					Position = v_u_7(1, -26, 0.5, -7),
					BackgroundColor3 = v_u_10(80, 80, 88),
					BorderSizePixel = 0, ZIndex = 13, Parent = header,
				})
				v_u_50(colorBox, 3)

				if isPlayers then
					v_u_54("ImageLabel", {
						Size = v_u_7(0, 10, 0, 10),
						Position = v_u_7(0, 12, 0.5, -5),
						BackgroundTransparency = 1, Image = v_u_56("users"),
						ImageColor3 = v_u_64.muted, ZIndex = 13, Parent = header,
					})
					titleLbl.Position = hasDesc and v_u_7(0, 26, 0, 8) or v_u_7(0, 26, 0.5, -7)
				end

				local panel = v_u_54("Frame", {
					Size = v_u_7(1, 0, 0, 0),
					Position = v_u_7(0, 0, 0, baseH + GAP),
					BackgroundColor3 = v_u_10(19, 19, 22),
					BorderSizePixel = 0, ClipsDescendants = true,
					ZIndex = 20, Parent = wrap,
				})
				v_u_50(panel, 8)

				local listScroll = v_u_54("ScrollingFrame", {
					Size = v_u_8(1, 1),
					BackgroundTransparency = 1,
					ScrollBarThickness = 2,
					ScrollBarImageColor3 = v_u_10(50, 50, 58),
					ScrollingDirection = Enum.ScrollingDirection.Y,
					CanvasSize = v_u_7(0, 0, 0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ElasticBehavior = Enum.ElasticBehavior.Never,
					ZIndex = 21, Parent = panel,
				})
				v_u_54("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = v_u_9(0, 0),
					Parent = listScroll,
				})
				v_u_54("UIPadding", {
					PaddingTop = v_u_9(0, 4),
					PaddingBottom = v_u_9(0, 4),
					PaddingLeft = v_u_9(0, 4),
					PaddingRight = v_u_9(0, 4),
					Parent = listScroll,
				})

				local function getExpandedH()
					return math.min(#options, MAX_VISIBLE) * ITEM_H + 8
				end

				local function closeDropdown()
					open = false
					v_u_49(panel, { Size = v_u_7(1, 0, 0, 0) }, 0.2, v_u_14.Quint)
					v_u_49(wrap, { Size = v_u_7(1, 0, 0, baseH) }, 0.2, v_u_14.Quint)
					v_u_49(colorBox, { BackgroundColor3 = v_u_10(80, 80, 88) }, 0.16)
					v_u_49(header, { BackgroundColor3 = v_u_64.elBg }, 0.14)
				end

				local function buildItems()
					for _, c in ipairs(listScroll:GetChildren()) do
						if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then
							pcall(function() c:Destroy() end)
						end
					end
					for i, opt in ipairs(options) do
						local isSel = opt == selected
						local BG_SEL = v_u_10(32, 32, 38)
						local BG_IDLE = v_u_10(19, 19, 22)
						local BG_HOV = v_u_10(27, 27, 33)

						local row = v_u_54("Frame", {
							Size = v_u_7(1, 0, 0, ITEM_H),
							BackgroundColor3 = isSel and BG_SEL or BG_IDLE,
							BackgroundTransparency = 0,
							BorderSizePixel = 0, LayoutOrder = i, ZIndex = 22, Parent = listScroll,
						})
						v_u_50(row, 5)

						v_u_54("TextLabel", {
							Size = v_u_7(1, -24, 1, 0),
							Position = UDim2.fromOffset(12, 0),
							BackgroundTransparency = 1, Text = opt,
							TextColor3 = isSel and v_u_10(242, 242, 248) or v_u_10(148, 148, 158),
							TextSize = 10,
							Font = isSel and v_u_15.GothamSemibold or v_u_15.Gotham,
							TextXAlignment = Enum.TextXAlignment.Left,
							TextTruncate = Enum.TextTruncate.AtEnd,
							ZIndex = 23, Parent = row,
						})

						local ob = v_u_54("TextButton", {
							Size = v_u_8(1, 1), BackgroundTransparency = 1,
							Text = "", ZIndex = 24, Parent = row,
						})
						ob.MouseEnter:Connect(function()
							v_u_49(row, { BackgroundColor3 = isSel and BG_SEL or BG_HOV }, 0.08)
						end)
						ob.MouseLeave:Connect(function()
							v_u_49(row, { BackgroundColor3 = isSel and BG_SEL or BG_IDLE }, 0.1)
						end)
						ob.MouseButton1Down:Connect(function()
							v_u_49(row, { BackgroundColor3 = v_u_10(20, 20, 24) }, 0.05)
						end)
						ob.MouseButton1Click:Connect(function()
							if not enabled then return end
							selected = opt
							if selLbl then
								selLbl.Text = selected
								selLbl.TextColor3 = v_u_64.textSec
							end
							buildItems()
							local ok, err = pcall(function() if callback then callback(selected) end end)
							if not ok then v_u_58("Dropdown", err) end
							closeDropdown()
						end)
					end
				end
				buildItems()

				local playerAddConn, playerRemoveConn
				if isPlayers then
					playerAddConn = v_u_4.PlayerAdded:Connect(function(p)
						options = v_u_61()
						buildItems()
					end)
					playerRemoveConn = v_u_4.PlayerRemoving:Connect(function(p)
						options = v_u_61()
						if selected == p.Name then
							selected = options[1] or ""
							if selLbl then
								selLbl.Text = (selected ~= "") and selected or placeholder
								selLbl.TextColor3 = (selected ~= "") and v_u_64.textSec or v_u_64.muted
							end
						end
						buildItems()
					end)
				end

				local togBtn = v_u_54("TextButton", {
					Size = v_u_8(1, 1), BackgroundTransparency = 1,
					Text = "", ZIndex = 15, Parent = header,
				})
				togBtn.MouseButton1Click:Connect(function()
					if not enabled then return end
					open = not open
					if open then
						if isPlayers then options = v_u_61() end
						buildItems()
						local fH = getExpandedH()
						v_u_49(panel, { Size = v_u_7(1, 0, 0, fH) }, 0.22, v_u_14.Quint)
						v_u_49(wrap, { Size = v_u_7(1, 0, 0, baseH + GAP + fH) }, 0.22, v_u_14.Quint)
						v_u_49(colorBox, { BackgroundColor3 = v_u_10(100, 180, 255) }, 0.18)
						v_u_49(header, { BackgroundColor3 = v_u_64.elBgHov }, 0.12)
					else
						closeDropdown()
					end
				end)
				togBtn.MouseEnter:Connect(function()
					if not open and enabled then v_u_49(header, { BackgroundColor3 = v_u_64.elBgHov }, 0.1) end
				end)
				togBtn.MouseLeave:Connect(function()
					if not open and enabled then v_u_49(header, { BackgroundColor3 = v_u_64.elBg }, 0.1) end
				end)

				return {
					Set = function(_, v)
						selected = v
						if selLbl then
							selLbl.Text = (v and v ~= "") and v or placeholder
							selLbl.TextColor3 = (v and v ~= "") and v_u_64.textSec or v_u_64.muted
						end
						buildItems()
					end,
					Get = function(_) return selected end,
					SetOptions = function(_, o)
						options = o or {}
						if not table.find(options, selected) then
							selected = options[1] or ""
							if selLbl then
								selLbl.Text = (selected ~= "") and selected or placeholder
								selLbl.TextColor3 = (selected ~= "") and v_u_64.textSec or v_u_64.muted
							end
						end
						if open then buildItems() end
					end,
					AddOption = function(_, opt)
						if not table.find(options, opt) then
							table.insert(options, opt)
							if open then buildItems() end
						end
					end,
					RemoveOption = function(_, opt)
						for i, v in ipairs(options) do
							if v == opt then
								table.remove(options, i)
								if selected == opt then
									selected = options[1] or ""
									if selLbl then
										selLbl.Text = (selected ~= "") and selected or placeholder
										selLbl.TextColor3 = (selected ~= "") and v_u_64.textSec or v_u_64.muted
									end
									pcall(function() if callback then callback(selected) end end)
								end
								if open then buildItems() end
								break
							end
						end
					end,
					SetPlaceholder = function(_, txt)
						placeholder = tostring(txt or "")
						if (not selected or selected == "") and selLbl then
							selLbl.Text = placeholder
							selLbl.TextColor3 = v_u_64.muted
						end
					end,
					SetDescription = function(_, v)
						if descLbl then
							local nd = v and v ~= ""
							descLbl.Text = tostring(v or "")
							descLbl.Visible = nd
							local newH = nd and v_u_66 or v_u_65
							baseH = newH
							header.Size = v_u_7(1, 0, 0, newH)
							panel.Position = v_u_7(0, 0, 0, newH + GAP)
							if not open then
								wrap.Size = v_u_7(1, 0, 0, newH)
							end
						end
					end,
					SetEnabled = function(_, v)
						enabled = v ~= false
						if not enabled and open then closeDropdown() end
						v_u_123(header, not enabled)
						v_u_49(titleLbl, { TextColor3 = enabled and v_u_64.textPri or v_u_64.disabledTxt }, 0.15)
						v_u_49(colorBox, { BackgroundColor3 = enabled and v_u_10(80,80,88) or v_u_64.dim }, 0.15)
					end,
					SetVisible = function(_, v) if wrap then wrap.Visible = v ~= false end end,
					SetTitle = function(_, v) if titleLbl then titleLbl.Text = tostring(v) end end,
					SetCallback = function(_, fn) callback = fn end,
					Destroy = function(_)
						if playerAddConn then pcall(function() playerAddConn:Disconnect() end) end
						if playerRemoveConn then pcall(function() playerRemoveConn:Disconnect() end) end
						pcall(function() wrap:Destroy() end)
					end,
				}
			end

			local v_u_125 = setmetatable({}, { __index = v_u_120 })

			function v_u_125:SetTitle(newText)
				if v_u_119 then
					v_u_119.Text = string.upper(tostring(newText or ""))
				end
			end

			function v_u_125:SetVisible(v)
				if v_u_115 then v_u_115.Visible = v ~= false end
			end

			function v_u_125:Destroy()
				pcall(function() v_u_115:Destroy() end)
			end

			return v_u_125
		end

		return v_u_109
	end

	local v_u_126 = v_u_54("Frame", {
		Name = "MinButton", Parent = v_u_74,
		BackgroundColor3 = v_u_10(25, 25, 30),
		Position = v_u_7(1, -56, 1, -56), Size = v_u_7(0, 48, 0, 48),
		BorderSizePixel = 0, ZIndex = 50,
		Visible = false,
	})
	v_u_50(v_u_126, 8)
	v_u_52(v_u_126, v_u_10(60, 60, 65), 1.5)
	v_u_126.Active = true
	v_u_126.Draggable = true

	local minImg = v_u_54("ImageLabel", {
		Parent = v_u_126, BackgroundTransparency = 1,
		Size = v_u_7(0, 24, 0, 24),
		Position = v_u_7(0.5, -12, 0.5, -12),
		Image = v_u_56("move"), ImageColor3 = v_u_10(200, 200, 205), ZIndex = 51,
	})

	local minBtn = v_u_54("TextButton", {
		Parent = v_u_126, Size = v_u_8(1, 1),
		BackgroundTransparency = 1, Text = "", ZIndex = 51,
	})

	local isDragging = false
	local dragStart = nil

	minBtn.MouseButton1Down:Connect(function(x, y)
		isDragging = false
		dragStart = Vector2.new(x, y)
	end)

	minBtn.MouseMove:Connect(function(x, y)
		if dragStart then
			local delta = Vector2.new(x, y) - dragStart
			if delta.Magnitude > 5 then
				isDragging = true
			end
		end
	end)

	minBtn.MouseButton1Up:Connect(function()
		if not isDragging then
			v_u_126.Visible = false
			v_u_75.Visible = true
			v_u_75.Size = v_u_7(0, v_u_67, 0, 0)
			v_u_49(v_u_75, { Size = v_u_7(0, v_u_67, 0, v_u_68) }, 0.25, v_u_14.Quint)
		end
		isDragging = false
		dragStart = nil
	end)

	v_u_81.MouseButton1Click:Connect(function()
		v_u_49(v_u_75, { Size = v_u_7(0, v_u_67, 0, 0) }, 0.2, v_u_14.Quint)
		task.delay(0.22, function()
			if v_u_75 and v_u_75.Parent then
				v_u_75.Visible = false
				v_u_126.Visible = true
			end
		end)
	end)

	return v_u_94
end

return EcoHub
