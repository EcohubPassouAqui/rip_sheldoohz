-- // Dropdown
Elements.Register("Dropdown", function(section, options)
    options = type(options) == "table" and options or {}

    local COLORS = {
        TextActive = Color3.fromRGB(255, 255, 255),
        TextInactive = Color3.fromRGB(105, 105, 115),
        TextDisabled = Color3.fromRGB(60, 60, 68),
        FieldBg = Color3.fromRGB(22, 22, 22),
        FieldBorder = Color3.fromRGB(38, 38, 38),
        RowBg = Color3.fromRGB(20, 20, 20),
        RowHover = Color3.fromRGB(30, 30, 30),
        RowSelected = Color3.fromRGB(36, 36, 36),
        OverlayBg = Color3.fromRGB(20, 20, 20),
        OverlayBorder = Color3.fromRGB(38, 38, 38),
        DescText = Color3.fromRGB(100, 100, 110),
        TitleText = Color3.fromRGB(255, 255, 255),
        Icon = Color3.fromRGB(100, 100, 110),
    }

    local TITLE_SIZE = 12
    local DESC_SIZE = 10
    local LABEL_SIZE = 11
    local ROW_H = 40
    local FIELD_W = 150
    local FIELD_H = 24
    local OPT_H = 30
    local MAX_H = 180
    local ANIM_T = 0.12
    local WORD_BREAK = 20
    local Z = 900

    local tweenService = TweenService or game:GetService("TweenService")
    local userInputService = UserInputService or game:GetService("UserInputService")
    local runService = game:GetService("RunService")
    local fontRegular = FONT or Enum.Font.SourceSans
    local fontTitle = FONT or Enum.Font.SourceSansSemibold

    local TI_FAST = TweenInfo.new(0.1)
    local TI_ROW = TweenInfo.new(0.09)
    local TI_HOVER = TweenInfo.new(0.07)
    local TI_OPEN = TweenInfo.new(ANIM_T, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local TI_CLOSE = TweenInfo.new(ANIM_T, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local TI_ICON = TweenInfo.new(ANIM_T)

    local connections = {}
    local rowConnections = {}
    local destroyed = false
    local followConn
    local closeTween
    local closeTweenConn
    local openTween

    local function connect(signal, fn)
        local conn = signal:Connect(fn)
        table.insert(connections, conn)
        return conn
    end

    local function warnf(msg)
        pcall(function()
            Notify({ Title = "CodyWas | Dropdown", Description = msg, Duration = 5 })
        end)
    end

    local function breakWords(text, maxRun)
        text = tostring(text or "")
        local lines = {}
        for line in (text .. "\n"):gmatch("(.-)\n") do
            local r = {}
            for w in line:gmatch("%S+") do
                while #w > maxRun do
                    table.insert(r, w:sub(1, maxRun))
                    w = w:sub(maxRun + 1)
                end
                table.insert(r, w)
            end
            table.insert(lines, table.concat(r, " "))
        end
        return table.concat(lines, "\n")
    end

    local function tw(obj, info, props)
        if destroyed or not obj or not obj.Parent then return end
        pcall(function()
            tweenService:Create(obj, info, props):Play()
        end)
    end

    local function isPointerInput(input)
        return input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
    end

    local function isInside(guiObject, pos)
        local p = guiObject.AbsolutePosition
        local s = guiObject.AbsoluteSize
        return pos.X >= p.X and pos.X <= p.X + s.X and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
    end

    local title = tostring(options.title or options.Name or "Dropdown")
    local desc = tostring(options.description or "")
    local values = type(options.values or options.Options) == "table" and (options.values or options.Options) or {}
    local multi = options.multi == true
    local disabled = options.disabled == true
    local callback = options.callback or options.Callback
    local placeholder = tostring(options.placeholder or "Selecione...")
    local allowDeselect = options.allowDeselect ~= false

    if type(callback) ~= "function" then
        callback = function() end
    end

    local hasDesc = desc ~= ""

    local data = { disabled = disabled, expanded = false }

    local function hasValue(v)
        return table.find(values, v) ~= nil
    end

    if multi then
        data.value = {}
        if type(options.default) == "table" then
            for _, v in ipairs(options.default) do
                if hasValue(v) then data.value[v] = true end
            end
        end
    else
        data.value = nil
        if options.default ~= nil and hasValue(options.default) then
            data.value = options.default
        end
    end

    local screenGui = section.frame:FindFirstAncestorWhichIsA("ScreenGui")

    local container = Instance.new("Frame")
    container.Name = title .. "_Dropdown"
    container.Size = UDim2.new(1, 0, 0, ROW_H)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = false
    container.Parent = section.frame

    local headerRow = Instance.new("Frame")
    headerRow.Name = "Header"
    headerRow.Size = UDim2.new(1, 0, 0, ROW_H)
    headerRow.BackgroundTransparency = 1
    headerRow.Parent = container

    local textSide = Instance.new("Frame")
    textSide.Name = "TextSide"
    textSide.Size = UDim2.new(1, -(FIELD_W + 16), 1, 0)
    textSide.BackgroundTransparency = 1
    textSide.Parent = headerRow

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = disabled and COLORS.TextDisabled or COLORS.TitleText
    titleLabel.TextSize = TITLE_SIZE
    titleLabel.Font = fontTitle
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    titleLabel.Parent = textSide

    local descLabel

    local function layoutText()
        if descLabel then
            titleLabel.Size = UDim2.new(1, 0, 0, 16)
            titleLabel.Position = UDim2.new(0, 0, 0, 2)
        else
            titleLabel.Size = UDim2.new(1, 0, 1, 0)
            titleLabel.Position = UDim2.new(0, 0, 0, 0)
        end
    end

    local function createDescription(text)
        descLabel = Instance.new("TextLabel")
        descLabel.Name = "Desc"
        descLabel.Size = UDim2.new(1, 0, 0, 0)
        descLabel.Position = UDim2.new(0, 0, 0, 18)
        descLabel.AutomaticSize = Enum.AutomaticSize.Y
        descLabel.BackgroundTransparency = 1
        descLabel.Text = breakWords(text, WORD_BREAK)
        descLabel.TextColor3 = COLORS.DescText
        descLabel.TextSize = DESC_SIZE
        descLabel.Font = fontRegular
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.TextYAlignment = Enum.TextYAlignment.Top
        descLabel.TextWrapped = true
        descLabel.LineHeight = 1.1
        descLabel.Parent = textSide
    end

    if hasDesc then
        createDescription(desc)
    end

    layoutText()

    local field = Instance.new("TextButton")
    field.Name = "Field"
    field.Size = UDim2.new(0, FIELD_W, 0, FIELD_H)
    field.Position = UDim2.new(1, 0, 0.5, 0)
    field.AnchorPoint = Vector2.new(1, 0.5)
    field.BackgroundColor3 = COLORS.FieldBg
    field.BorderSizePixel = 0
    field.Text = ""
    field.AutoButtonColor = false
    field.Selectable = false
    field.Active = not disabled
    field.Parent = headerRow

    local fieldCorner = Instance.new("UICorner")
    fieldCorner.CornerRadius = UDim.new(0, 6)
    fieldCorner.Parent = field

    local fStroke = Instance.new("UIStroke")
    fStroke.Color = COLORS.FieldBorder
    fStroke.Thickness = 1
    fStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    fStroke.Parent = field

    local fieldText = Instance.new("TextLabel")
    fieldText.Name = "FieldText"
    fieldText.Size = UDim2.new(1, -24, 1, 0)
    fieldText.Position = UDim2.new(0, 8, 0, 0)
    fieldText.BackgroundTransparency = 1
    fieldText.Text = placeholder
    fieldText.TextColor3 = COLORS.TextInactive
    fieldText.TextSize = LABEL_SIZE
    fieldText.Font = fontRegular
    fieldText.TextXAlignment = Enum.TextXAlignment.Left
    fieldText.TextTruncate = Enum.TextTruncate.AtEnd
    fieldText.Parent = field

    local fieldIcon = Instance.new("ImageLabel")
    fieldIcon.Name = "Icon"
    fieldIcon.Size = UDim2.new(0, 11, 0, 11)
    fieldIcon.Position = UDim2.new(1, -7, 0.5, 0)
    fieldIcon.AnchorPoint = Vector2.new(1, 0.5)
    fieldIcon.BackgroundTransparency = 1
    fieldIcon.Image = "rbxassetid://10709790948"
    fieldIcon.ImageColor3 = COLORS.Icon
    fieldIcon.Parent = field

    local overlay = Instance.new("Frame")
    overlay.Name = title .. "_Overlay"
    overlay.BackgroundColor3 = COLORS.OverlayBg
    overlay.BorderSizePixel = 0
    overlay.Size = UDim2.fromOffset(0, 0)
    overlay.Visible = false
    overlay.ZIndex = Z
    overlay.ClipsDescendants = true
    overlay.Parent = screenGui or container

    local overlayCorner = Instance.new("UICorner")
    overlayCorner.CornerRadius = UDim.new(0, 6)
    overlayCorner.Parent = overlay

    local oStroke = Instance.new("UIStroke")
    oStroke.Color = COLORS.OverlayBorder
    oStroke.Thickness = 1
    oStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    oStroke.Parent = overlay

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "Scroll"
    scroll.Size = UDim2.new(1, -4, 1, -4)
    scroll.Position = UDim2.new(0, 2, 0, 2)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    scroll.ScrollBarImageTransparency = 0
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ZIndex = Z
    scroll.Parent = overlay

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 1)
    listLayout.Parent = scroll

    local listPad = Instance.new("UIPadding")
    listPad.PaddingTop = UDim.new(0, 3)
    listPad.PaddingBottom = UDim.new(0, 3)
    listPad.Parent = scroll

    local optRows = {}

    local function isSelected(value)
        if multi then
            return data.value[value] == true
        end
        return data.value == value
    end

    local function hasSelection()
        if multi then
            return next(data.value) ~= nil
        end
        return data.value ~= nil
    end

    local function getSelectedList()
        local sel = {}
        for _, v in ipairs(values) do
            if data.value[v] then
                table.insert(sel, v)
            end
        end
        return sel
    end

    local function getOutput()
        if multi then
            return getSelectedList()
        end
        return data.value
    end

    local function getDisplayText()
        if multi then
            local sel = getSelectedList()
            if #sel == 0 then return placeholder end
            local names = {}
            for i, v in ipairs(sel) do
                names[i] = tostring(v)
            end
            return table.concat(names, ", ")
        end
        if data.value == nil then return placeholder end
        return tostring(data.value)
    end

    local function updateField(animate)
        local col
        if data.disabled then
            col = COLORS.TextDisabled
        elseif hasSelection() then
            col = COLORS.TextActive
        else
            col = COLORS.TextInactive
        end
        fieldText.Text = getDisplayText()
        titleLabel.TextColor3 = data.disabled and COLORS.TextDisabled or COLORS.TitleText
        if animate then
            tw(fieldText, TI_FAST, { TextColor3 = col })
        else
            fieldText.TextColor3 = col
        end
    end

    local function updateRow(row, animate)
        local sel = isSelected(row.value)
        local bg = sel and COLORS.RowSelected or COLORS.RowBg
        local tc = sel and COLORS.TextActive or (data.disabled and COLORS.TextDisabled or COLORS.TextInactive)
        if animate then
            tw(row.frame, TI_ROW, { BackgroundColor3 = bg })
            tw(row.label, TI_ROW, { TextColor3 = tc })
        else
            row.frame.BackgroundColor3 = bg
            row.label.TextColor3 = tc
        end
    end

    local function fireCallback()
        local ok, err = pcall(callback, getOutput())
        if not ok then warnf("callback: " .. tostring(err)) end
    end

    local function getOverlayH()
        return math.min(listLayout.AbsoluteContentSize.Y + 6, MAX_H)
    end

    local function computePlacement()
        local cam = workspace.CurrentCamera
        local fPos = field.AbsolutePosition
        local fSize = field.AbsoluteSize
        local h = getOverlayH()
        local screenH = cam and cam.ViewportSize.Y or 600
        local goUp = (screenH - fPos.Y - fSize.Y) < h + 6
        local startY = goUp and (fPos.Y - 4) or (fPos.Y + fSize.Y + 4)
        local endY = goUp and (fPos.Y - h - 4) or (fPos.Y + fSize.Y + 4)
        return fPos, fSize, h, startY, endY
    end

    local function stopFollow()
        if followConn then
            followConn:Disconnect()
            followConn = nil
        end
    end

    local function cancelTweens()
        if openTween then
            openTween:Cancel()
            openTween = nil
        end
        if closeTweenConn then
            closeTweenConn:Disconnect()
            closeTweenConn = nil
        end
        if closeTween then
            closeTween:Cancel()
            closeTween = nil
        end
    end

    local closeOverlay

    local function reposition()
        if destroyed or not data.expanded then return end
        local cam = workspace.CurrentCamera
        local fPos, fSize, h, _, endY = computePlacement()
        if cam then
            local vp = cam.ViewportSize
            if fPos.Y + fSize.Y < 0 or fPos.Y > vp.Y or fPos.X + fSize.X < 0 or fPos.X > vp.X then
                closeOverlay(true)
                return
            end
        end
        overlay.Position = UDim2.fromOffset(fPos.X, endY)
        overlay.Size = UDim2.fromOffset(fSize.X, h)
    end

    local function startFollow()
        stopFollow()
        followConn = runService.RenderStepped:Connect(reposition)
    end

    closeOverlay = function(instant)
        if not data.expanded then return end
        data.expanded = false
        stopFollow()
        cancelTweens()
        tw(fieldIcon, TI_ICON, { Rotation = 0 })

        if instant then
            overlay.Visible = false
            overlay.Size = UDim2.fromOffset(0, 0)
            return
        end

        local fSize = field.AbsoluteSize
        closeTween = tweenService:Create(overlay, TI_CLOSE, { Size = UDim2.fromOffset(fSize.X, 0) })
        closeTweenConn = closeTween.Completed:Connect(function()
            if not data.expanded and not destroyed then
                overlay.Visible = false
            end
            if closeTweenConn then
                closeTweenConn:Disconnect()
                closeTweenConn = nil
            end
        end)
        closeTween:Play()
    end

    local function selectValue(value)
        if destroyed or data.disabled then return end
        if multi then
            if data.value[value] then
                data.value[value] = nil
            else
                data.value[value] = true
            end
        else
            if data.value == value then
                if not allowDeselect then
                    closeOverlay(false)
                    return
                end
                data.value = nil
            else
                data.value = value
            end
        end
        for _, row in ipairs(optRows) do updateRow(row, true) end
        updateField(true)
        fireCallback()
        if not multi then closeOverlay(false) end
    end

    local function clearRowConnections()
        for _, conn in ipairs(rowConnections) do
            conn:Disconnect()
        end
        table.clear(rowConnections)
    end

    local function buildOptions()
        clearRowConnections()
        for _, row in ipairs(optRows) do
            if row.frame then row.frame:Destroy() end
        end
        optRows = {}

        for i, value in ipairs(values) do
            local optFrame = Instance.new("Frame")
            optFrame.Name = "Opt_" .. i
            optFrame.Size = UDim2.new(1, 0, 0, OPT_H)
            optFrame.BackgroundColor3 = COLORS.RowBg
            optFrame.BorderSizePixel = 0
            optFrame.LayoutOrder = i
            optFrame.ZIndex = Z

            local optCorner = Instance.new("UICorner")
            optCorner.CornerRadius = UDim.new(0, 4)
            optCorner.Parent = optFrame

            optFrame.Parent = scroll

            local optLabel = Instance.new("TextLabel")
            optLabel.Name = "Label"
            optLabel.Size = UDim2.new(1, -16, 1, 0)
            optLabel.Position = UDim2.new(0, 10, 0, 0)
            optLabel.BackgroundTransparency = 1
            optLabel.Text = tostring(value)
            optLabel.TextColor3 = COLORS.TextInactive
            optLabel.TextSize = LABEL_SIZE
            optLabel.Font = fontRegular
            optLabel.TextXAlignment = Enum.TextXAlignment.Left
            optLabel.TextYAlignment = Enum.TextYAlignment.Center
            optLabel.TextTruncate = Enum.TextTruncate.AtEnd
            optLabel.ZIndex = Z + 1
            optLabel.Parent = optFrame

            local btn = Instance.new("TextButton")
            btn.Name = "Btn"
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.AutoButtonColor = false
            btn.Selectable = false
            btn.ZIndex = Z + 2
            btn.Parent = optFrame

            local row = { frame = optFrame, label = optLabel, value = value }
            table.insert(optRows, row)

            updateRow(row, false)

            table.insert(rowConnections, btn.MouseEnter:Connect(function()
                if not isSelected(value) and not data.disabled then
                    tw(optFrame, TI_HOVER, { BackgroundColor3 = COLORS.RowHover })
                end
            end))
            table.insert(rowConnections, btn.MouseLeave:Connect(function()
                if not isSelected(value) then
                    tw(optFrame, TI_HOVER, { BackgroundColor3 = COLORS.RowBg })
                end
            end))
            table.insert(rowConnections, btn.MouseButton1Click:Connect(function()
                selectValue(value)
            end))
        end
    end

    local openedAt = 0

    local function openOverlay()
        if destroyed or data.disabled or data.expanded or #values == 0 then return end
        data.expanded = true
        openedAt = os.clock()
        cancelTweens()

        task.defer(function()
            if destroyed or not data.expanded then return end
            local fPos, fSize, h, startY, endY = computePlacement()

            overlay.Size = UDim2.fromOffset(fSize.X, 0)
            overlay.Position = UDim2.fromOffset(fPos.X, startY)
            overlay.Visible = true

            tw(fieldIcon, TI_ICON, { Rotation = 180 })
            openTween = tweenService:Create(overlay, TI_OPEN, {
                Size = UDim2.fromOffset(fSize.X, h),
                Position = UDim2.fromOffset(fPos.X, endY),
            })
            openTween:Play()
            startFollow()
        end)
    end

    connect(field.MouseButton1Click, function()
        if data.expanded then
            closeOverlay(false)
        else
            openOverlay()
        end
    end)

    connect(userInputService.InputBegan, function(input)
        if destroyed or not data.expanded then return end
        if os.clock() - openedAt < 0.15 then return end
        if not isPointerInput(input) then return end
        local pos = Vector2.new(input.Position.X, input.Position.Y)
        if not isInside(field, pos) and not isInside(overlay, pos) then
            closeOverlay(false)
        end
    end)

    buildOptions()
    updateField(false)

    if hasSelection() then
        fireCallback()
    end

    local function sameSelection(a, b)
        if multi then
            for k in pairs(a) do
                if not b[k] then return false end
            end
            for k in pairs(b) do
                if not a[k] then return false end
            end
            return true
        end
        return a == b
    end

    function data:Set(value)
        if destroyed then return end
        local new
        if multi then
            new = {}
            if type(value) == "table" then
                for _, v in ipairs(value) do
                    if hasValue(v) then new[v] = true end
                end
            end
        else
            if value ~= nil and not hasValue(value) then
                warnf("valor '" .. tostring(value) .. "' nao existe.")
                return
            end
            new = value
        end
        if sameSelection(data.value, new) then return end
        data.value = new
        for _, row in ipairs(optRows) do updateRow(row, true) end
        updateField(true)
        fireCallback()
    end

    function data:Get()
        return getOutput()
    end

    function data:SetValues(newValues)
        if destroyed then return end
        values = type(newValues) == "table" and newValues or {}

        local changed = false
        if multi then
            local f = {}
            for v in pairs(data.value) do
                if hasValue(v) then
                    f[v] = true
                else
                    changed = true
                end
            end
            data.value = f
        elseif data.value ~= nil and not hasValue(data.value) then
            data.value = nil
            changed = true
        end

        buildOptions()
        updateField(false)

        if #values == 0 and data.expanded then
            closeOverlay(true)
        elseif data.expanded then
            task.defer(reposition)
        end

        if changed then
            fireCallback()
        end
    end

    function data:SetDisabled(value)
        if destroyed then return end
        data.disabled = value == true
        field.Active = not data.disabled
        if data.disabled then closeOverlay(true) end
        for _, row in ipairs(optRows) do updateRow(row, false) end
        updateField(true)
    end

    function data:SetTitle(newTitle)
        if destroyed then return end
        title = tostring(newTitle or "")
        titleLabel.Text = title
        container.Name = title .. "_Dropdown"
        overlay.Name = title .. "_Overlay"
    end

    function data:SetDescription(newDesc)
        if destroyed then return end
        newDesc = tostring(newDesc or "")
        if newDesc == "" then
            if descLabel then
                descLabel:Destroy()
                descLabel = nil
            end
            layoutText()
            return
        end
        if not descLabel then
            createDescription(newDesc)
        else
            descLabel.Text = breakWords(newDesc, WORD_BREAK)
        end
        layoutText()
    end

    function data:Open()
        openOverlay()
    end

    function data:Close()
        closeOverlay(false)
    end

    function data:Destroy()
        if destroyed then return end
        destroyed = true
        stopFollow()
        cancelTweens()
        clearRowConnections()
        for _, conn in ipairs(connections) do
            conn:Disconnect()
        end
        table.clear(connections)
        overlay:Destroy()
        container:Destroy()
    end

    return data
end)