-- // Colorpick
Elements.Register("ColorPicker", function(section, options)
    local COLORS = {
        TextActive = Color3.fromRGB(255, 255, 255),
        TextInactive = Color3.fromRGB(105, 105, 115),
        TextDisabled = Color3.fromRGB(70, 70, 78),
        Line = Color3.fromRGB(32, 32, 32),
        Field = Color3.fromRGB(24, 24, 24),
        FieldAlt = Color3.fromRGB(30, 30, 30),
        MenuBackground = Color3.fromRGB(18, 18, 18),
        SectionBackground = Color3.fromRGB(22, 22, 22),
        DescriptionText = Color3.fromRGB(105, 105, 115),
        Accent = Color3.fromRGB(255, 255, 255),
    }

    local TITLE_TEXT_SIZE = 12
    local DESCRIPTION_TEXT_SIZE = 10
    local LABEL_TEXT_SIZE = 11
    local ROW_HEIGHT = 50
    local FIELD_WIDTH = 120
    local FIELD_HEIGHT = 28
    local OVERLAY_ZINDEX = 1000

    local function warnf(msg)
        pcall(function() Notify({ Title = "CodyWas | ColorPicker", Description = msg, Duration = 5 }) end)
    end

    local function rgbToHex(color)
        local r = math.floor(color.R * 255)
        local g = math.floor(color.G * 255)
        local b = math.floor(color.B * 255)
        return string.format("%02X%02X%02X", r, g, b)
    end

    local function getContrastColor(color)
        local luminance = (0.299 * color.R) + (0.587 * color.G) + (0.114 * color.B)
        if luminance > 0.55 then
            return Color3.fromRGB(20, 20, 20)
        end
        return Color3.fromRGB(255, 255, 255)
    end

    local title = options.title or options.Name or "Color"
    local description = options.description or ""
    local defaultColor = options.default or options.Default or Color3.fromRGB(68, 120, 255)
    local defaultTransparency = options.transparency or 0
    local disabled = options.disabled or false
    local callback = options.callback or options.Callback or function() end

    local hasDescription = description ~= ""

    local data = { disabled = disabled, opened = false, value = defaultColor, transparency = defaultTransparency }
    local hue, sat, vib = Color3.toHSV(data.value)

    local container = Instance.new("Frame")
    container.Name = title .. "_ColorPicker"
    container.Size = UDim2.new(1, 0, 0, ROW_HEIGHT)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = false
    container.Parent = section.frame

    local textContainer = Instance.new("Frame")
    textContainer.Name = "TextContainer"
    textContainer.Size = UDim2.new(1, -(FIELD_WIDTH + 16), 1, 0)
    textContainer.BackgroundTransparency = 1
    textContainer.Parent = container

    local label = Instance.new("TextLabel")
    label.Name = "Title"
    label.Size = UDim2.new(1, 0, 0, 16)
    label.Position = UDim2.new(0, 0, 0, hasDescription and 2 or 0)
    label.AnchorPoint = Vector2.new(0, hasDescription and 0 or 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = COLORS.TextActive
    label.TextSize = TITLE_TEXT_SIZE
    label.Font = FONT
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = textContainer

    if not hasDescription then
        label.Position = UDim2.new(0, 0, 0.5, 0)
        label.AnchorPoint = Vector2.new(0, 0.5)
    end

    if hasDescription then
        local dl = Instance.new("TextLabel")
        dl.Name = "Desc"
        dl.Size = UDim2.new(1, 0, 0, 0)
        dl.Position = UDim2.new(0, 0, 0, 18)
        dl.AutomaticSize = Enum.AutomaticSize.Y
        dl.BackgroundTransparency = 1
        dl.Text = description
        dl.TextColor3 = COLORS.DescriptionText
        dl.TextSize = DESCRIPTION_TEXT_SIZE
        dl.Font = FONT
        dl.TextXAlignment = Enum.TextXAlignment.Left
        dl.TextWrapped = true
        dl.LineHeight = 1.1
        dl.Parent = textContainer
    end

    local field = Instance.new("TextButton")
    field.Name = "Field"
    field.Size = UDim2.new(0, FIELD_WIDTH, 0, FIELD_HEIGHT)
    field.Position = UDim2.new(1, 0, 0.5, 0)
    field.AnchorPoint = Vector2.new(1, 0.5)
    field.BackgroundColor3 = data.value
    field.BorderSizePixel = 0
    field.Text = ""
    field.AutoButtonColor = false
    field.Selectable = false
    field.ZIndex = 10
    field.Parent = container

    local fieldCorner = Instance.new("UICorner")
    fieldCorner.CornerRadius = UDim.new(0, 6)
    fieldCorner.Parent = field

    local fieldStroke = Instance.new("UIStroke")
    fieldStroke.Color = COLORS.Line
    fieldStroke.Thickness = 1
    fieldStroke.Parent = field

    local checkerBoard = Instance.new("ImageLabel")
    checkerBoard.Name = "CheckerBoard"
    checkerBoard.Size = UDim2.new(1, 0, 1, 0)
    checkerBoard.BackgroundTransparency = 1
    checkerBoard.Image = "rbxasset://textures/Checkerboard.png"
    checkerBoard.ImageTransparency = 0.45
    checkerBoard.ScaleType = Enum.ScaleType.Tile
    checkerBoard.TileSize = UDim2.fromOffset(8, 8)
    checkerBoard.ZIndex = 9
    checkerBoard.Parent = field

    local fieldColor = Instance.new("Frame")
    fieldColor.Name = "FieldColor"
    fieldColor.Size = UDim2.new(1, 0, 1, 0)
    fieldColor.BackgroundColor3 = data.value
    fieldColor.BackgroundTransparency = data.transparency
    fieldColor.BorderSizePixel = 0
    fieldColor.ZIndex = 10
    fieldColor.Parent = field

    local fieldColorCorner = Instance.new("UICorner")
    fieldColorCorner.CornerRadius = UDim.new(0, 6)
    fieldColorCorner.Parent = fieldColor

    local fieldLabel = Instance.new("TextLabel")
    fieldLabel.Name = "FieldLabel"
    fieldLabel.Size = UDim2.new(1, 0, 1, 0)
    fieldLabel.BackgroundTransparency = 1
    fieldLabel.Text = rgbToHex(data.value)
    fieldLabel.TextColor3 = getContrastColor(data.value)
    fieldLabel.TextSize = LABEL_TEXT_SIZE
    fieldLabel.Font = FONT_BOLD
    fieldLabel.ZIndex = 11
    fieldLabel.Parent = fieldColor

    local overlayCanvas = Instance.new("Frame")
    overlayCanvas.Name = title .. "_PickerOverlay"
    overlayCanvas.Size = UDim2.new(1, 0, 0, 0)
    overlayCanvas.Position = UDim2.new(0, 0, 1, 10)
    overlayCanvas.BackgroundColor3 = COLORS.MenuBackground
    overlayCanvas.BorderSizePixel = 0
    overlayCanvas.ClipsDescendants = true
    overlayCanvas.Visible = false
    overlayCanvas.ZIndex = OVERLAY_ZINDEX
    overlayCanvas.Parent = container.Parent

    local overlayCorner = Instance.new("UICorner")
    overlayCorner.CornerRadius = UDim.new(0, 8)
    overlayCorner.Parent = overlayCanvas

    local overlayStroke = Instance.new("UIStroke")
    overlayStroke.Color = COLORS.Line
    overlayStroke.Thickness = 1
    overlayStroke.Parent = overlayCanvas

    local overlayPadding = Instance.new("UIPadding")
    overlayPadding.PaddingTop = UDim.new(0, 14)
    overlayPadding.PaddingBottom = UDim.new(0, 14)
    overlayPadding.PaddingLeft = UDim.new(0, 14)
    overlayPadding.PaddingRight = UDim.new(0, 14)
    overlayPadding.Parent = overlayCanvas

    local pickerLayout = Instance.new("UIListLayout")
    pickerLayout.Padding = UDim.new(0, 14)
    pickerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pickerLayout.Parent = overlayCanvas

    local function fireCallback()
        local ok, err = pcall(callback, data.value, data.transparency)
        if not ok then
            warnf("callback error: " .. tostring(err))
        end
    end

    local function updateFieldVisuals()
        fieldColor.BackgroundColor3 = data.value
        fieldColor.BackgroundTransparency = data.transparency
        fieldLabel.Text = rgbToHex(data.value)
        fieldLabel.TextColor3 = getContrastColor(data.value)
    end

    local mapHeight = 130

    local satVibMap = Instance.new("ImageLabel")
    satVibMap.Name = "SatVibMap"
    satVibMap.Size = UDim2.new(1, 0, 0, mapHeight)
    satVibMap.Image = "rbxassetid://4155801252"
    satVibMap.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
    satVibMap.BorderSizePixel = 0
    satVibMap.LayoutOrder = 2
    satVibMap.ZIndex = OVERLAY_ZINDEX + 1
    satVibMap.Parent = overlayCanvas

    local satVibCorner = Instance.new("UICorner")
    satVibCorner.CornerRadius = UDim.new(0, 6)
    satVibCorner.Parent = satVibMap

    local satVibStroke = Instance.new("UIStroke")
    satVibStroke.Color = COLORS.Line
    satVibStroke.Thickness = 1
    satVibStroke.Parent = satVibMap

    local satCursorOuter = Instance.new("Frame")
    satCursorOuter.Name = "SatCursorOuter"
    satCursorOuter.Size = UDim2.fromOffset(18, 18)
    satCursorOuter.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    satCursorOuter.BackgroundTransparency = 0.35
    satCursorOuter.BorderSizePixel = 0
    satCursorOuter.ZIndex = OVERLAY_ZINDEX + 2
    satCursorOuter.Parent = satVibMap

    local satCursorOuterCorner = Instance.new("UICorner")
    satCursorOuterCorner.CornerRadius = UDim.new(1, 0)
    satCursorOuterCorner.Parent = satCursorOuter

    local satCursor = Instance.new("Frame")
    satCursor.Name = "SatCursor"
    satCursor.Size = UDim2.fromOffset(14, 14)
    satCursor.Position = UDim2.new(0.5, 0, 0.5, 0)
    satCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    satCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    satCursor.BorderSizePixel = 0
    satCursor.ZIndex = OVERLAY_ZINDEX + 3
    satCursor.Parent = satCursorOuter

    local satCursorCorner = Instance.new("UICorner")
    satCursorCorner.CornerRadius = UDim.new(1, 0)
    satCursorCorner.Parent = satCursor

    local satCursorInnerStroke = Instance.new("UIStroke")
    satCursorInnerStroke.Color = Color3.fromRGB(0, 0, 0)
    satCursorInnerStroke.Thickness = 1
    satCursorInnerStroke.Transparency = 0.5
    satCursorInnerStroke.Parent = satCursor

    local hueSlider = Instance.new("Frame")
    hueSlider.Name = "HueSlider"
    hueSlider.Size = UDim2.new(1, 0, 0, 18)
    hueSlider.LayoutOrder = 3
    hueSlider.BorderSizePixel = 0
    hueSlider.ZIndex = OVERLAY_ZINDEX + 1
    hueSlider.Parent = overlayCanvas

    local hueCorner = Instance.new("UICorner")
    hueCorner.CornerRadius = UDim.new(0, 6)
    hueCorner.Parent = hueSlider

    local hueStroke = Instance.new("UIStroke")
    hueStroke.Color = COLORS.Line
    hueStroke.Thickness = 1
    hueStroke.Parent = hueSlider

    local hueSequence = {}
    for i = 0, 1, 0.1 do
        table.insert(hueSequence, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1)))
    end
    if hueSequence[#hueSequence].Time ~= 1.0 then
        table.insert(hueSequence, ColorSequenceKeypoint.new(1.0, Color3.fromHSV(1, 1, 1)))
    end

    local hueGradient = Instance.new("UIGradient")
    hueGradient.Color = ColorSequence.new(hueSequence)
    hueGradient.Rotation = 0
    hueGradient.Parent = hueSlider

    local hueCursor = Instance.new("Frame")
    hueCursor.Name = "HueCursor"
    hueCursor.Size = UDim2.fromOffset(6, 22)
    hueCursor.Position = UDim2.new(0, 0, 0.5, 0)
    hueCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    hueCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueCursor.BorderSizePixel = 0
    hueCursor.ZIndex = OVERLAY_ZINDEX + 2
    hueCursor.Parent = hueSlider

    local hueCursorCorner = Instance.new("UICorner")
    hueCursorCorner.CornerRadius = UDim.new(0, 3)
    hueCursorCorner.Parent = hueCursor

    local hueCursorStroke = Instance.new("UIStroke")
    hueCursorStroke.Color = Color3.fromRGB(0, 0, 0)
    hueCursorStroke.Thickness = 1.5
    hueCursorStroke.Transparency = 0.3
    hueCursorStroke.Parent = hueCursor

    local OVERLAY_HEIGHT = 28 + mapHeight + 18 + 14

    local closeMenu

    local function openMenu()
        if data.disabled or data.opened then return end
        data.opened = true
        data.openedAt = os.clock()

        overlayCanvas.Visible = true
        TweenService:Create(overlayCanvas, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { Size = UDim2.new(1, 0, 0, OVERLAY_HEIGHT) }):Play()
    end

    closeMenu = function()
        if not data.opened then return end
        data.opened = false

        local tween = TweenService:Create(overlayCanvas, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            { Size = UDim2.new(1, 0, 0, 0) })
        tween:Play()
        tween.Completed:Connect(function()
            if not data.opened then
                overlayCanvas.Visible = false
            end
        end)
    end

    local function display()
        satVibMap.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        satCursorOuter.Position = UDim2.new(sat, -9, 1 - vib, -9)
        hueCursor.Position = UDim2.new(hue, 0, 0.5, 0)

        data.value = Color3.fromHSV(hue, sat, vib)
        updateFieldVisuals()
    end

    display()

    local draggingSatVib = false
    local draggingHue = false

    local function updateSatVibFromInput(inputPos)
        local minX = satVibMap.AbsolutePosition.X
        local maxX = minX + satVibMap.AbsoluteSize.X
        local mouseX = math.clamp(inputPos.X, minX, maxX)

        local minY = satVibMap.AbsolutePosition.Y
        local maxY = minY + satVibMap.AbsoluteSize.Y
        local mouseY = math.clamp(inputPos.Y, minY, maxY)

        sat = (maxX > minX) and ((mouseX - minX) / (maxX - minX)) or sat
        vib = (maxY > minY) and (1 - ((mouseY - minY) / (maxY - minY))) or vib
        display()
        fireCallback()
    end

    local function updateHueFromInput(inputPos)
        local minX = hueSlider.AbsolutePosition.X
        local maxX = minX + hueSlider.AbsoluteSize.X
        local mouseX = math.clamp(inputPos.X, minX, maxX)

        hue = (maxX > minX) and ((mouseX - minX) / (maxX - minX)) or hue
        display()
        fireCallback()
    end

    satVibMap.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSatVib = true
            data.dragStartedAt = os.clock()
            updateSatVibFromInput(input.Position)
        end
    end)

    hueSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingHue = true
            data.dragStartedAt = os.clock()
            updateHueFromInput(input.Position)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if draggingSatVib then
                updateSatVibFromInput(input.Position)
            elseif draggingHue then
                updateHueFromInput(input.Position)
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSatVib = false
            draggingHue = false
        end
    end)

    field.MouseButton1Click:Connect(function()
        if data.opened then
            closeMenu()
        else
            openMenu()
        end
    end)

    UserInputService.InputBegan:Connect(function(input)
        if not data.opened then return end
        if draggingSatVib or draggingHue then return end
        if data.dragStartedAt and (os.clock() - data.dragStartedAt) < 0.1 then return end
        if data.openedAt and (os.clock() - data.openedAt) < 0.1 then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local mousePos = UserInputService:GetMouseLocation()
            local overlayPos = overlayCanvas.AbsolutePosition
            local overlaySize = Vector2.new(overlayCanvas.AbsoluteSize.X, math.max(overlayCanvas.AbsoluteSize.Y, OVERLAY_HEIGHT))
            local fieldPos = field.AbsolutePosition
            local fieldSize = field.AbsoluteSize

            local insideOverlay = mousePos.X >= overlayPos.X and mousePos.X <= overlayPos.X + overlaySize.X
                and mousePos.Y >= overlayPos.Y and mousePos.Y <= overlayPos.Y + overlaySize.Y
            local insideField = mousePos.X >= fieldPos.X and mousePos.X <= fieldPos.X + fieldSize.X
                and mousePos.Y >= fieldPos.Y and mousePos.Y <= fieldPos.Y + fieldSize.Y

            if not insideOverlay and not insideField then
                closeMenu()
            end
        end
    end)

    function data:Set(color, transparency)
        if typeof(color) ~= "Color3" then
            warnf("Set() esperava Color3, recebeu " .. typeof(color))
            return
        end
        data.value = color
        data.transparency = transparency or 0
        hue, sat, vib = Color3.toHSV(data.value)
        display()
        fireCallback()
    end

    function data:Get()
        return data.value
    end

    function data:GetHex()
        return rgbToHex(data.value)
    end

    function data:GetTransparency()
        return data.transparency
    end

    function data:SetCallback(newCallback)
        if type(newCallback) ~= "function" then
            warnf("SetCallback() esperava function")
            return
        end
        callback = newCallback
    end

    function data:SetDisabled(value)
        data.disabled = value
        field.Active = not value
        if value and data.opened then
            closeMenu()
        end
    end

    function data:Open()
        openMenu()
    end

    function data:Close()
        closeMenu()
    end

    function data:Destroy()
        overlayCanvas:Destroy()
        container:Destroy()
    end

    return data
end)