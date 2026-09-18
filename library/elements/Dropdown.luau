-- // Dropdown
Elements.Register("Dropdown", function(section, options)
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
    local Z = 100

    local function warnf(msg)
        pcall(function() Notify({ Title = "CodyWas | Dropdown", Description = msg, Duration = 5 }) end)
    end

    local function breakWords(text, maxRun)
        local r = {}
        for w in text:gmatch("%S+") do
            while #w > maxRun do
                table.insert(r, w:sub(1, maxRun))
                w = w:sub(maxRun + 1)
            end
            table.insert(r, w)
        end
        return table.concat(r, " ")
    end

    local function tw(obj, info, props)
        pcall(function() TweenService:Create(obj, info, props):Play() end)
    end

    local title = options.title or options.Name or "Dropdown"
    local desc = options.description or ""
    local values = options.values or options.Options or {}
    local multi = options.multi or false
    local disabled = options.disabled or false
    local callback = options.callback or options.Callback or function() end

    local hasDesc = desc ~= ""
    local displayDesc = breakWords(desc, WORD_BREAK)

    local data = { disabled = disabled, expanded = false }

    if multi then
        data.value = {}
        if type(options.default) == "table" then
            for _, v in ipairs(options.default) do
                if table.find(values, v) then data.value[v] = true end
            end
        end
    else
        data.value = nil
        if type(options.default) == "string" and table.find(values, options.default) then
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
    titleLabel.TextColor3 = COLORS.TitleText
    titleLabel.TextSize = TITLE_SIZE
    titleLabel.Font = FONT or Enum.Font.SourceSansSemibold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Parent = textSide

    if hasDesc then
        titleLabel.Size = UDim2.new(1, 0, 0, 16)
        titleLabel.Position = UDim2.new(0, 0, 0, 2)

        local dl = Instance.new("TextLabel")
        dl.Name = "Desc"
        dl.Size = UDim2.new(1, 0, 0, 0)
        dl.Position = UDim2.new(0, 0, 0, 18)
        dl.AutomaticSize = Enum.AutomaticSize.Y
        dl.BackgroundTransparency = 1
        dl.Text = displayDesc
        dl.TextColor3 = COLORS.DescText
        dl.TextSize = DESC_SIZE
        dl.Font = FONT or Enum.Font.SourceSans
        dl.TextXAlignment = Enum.TextXAlignment.Left
        dl.TextWrapped = true
        dl.LineHeight = 1.1
        dl.Parent = textSide
    else
        titleLabel.Size = UDim2.new(1, 0, 1, 0)
        titleLabel.Position = UDim2.new(0, 0, 0, 0)
    end

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
    field.Parent = headerRow

    Instance.new("UICorner", field).CornerRadius = UDim.new(0, 6)

    local fStroke = Instance.new("UIStroke")
    fStroke.Color = COLORS.FieldBorder
    fStroke.Thickness = 1
    fStroke.Parent = field

    local fieldText = Instance.new("TextLabel")
    fieldText.Name = "FieldText"
    fieldText.Size = UDim2.new(1, -24, 1, 0)
    fieldText.Position = UDim2.new(0, 8, 0, 0)
    fieldText.BackgroundTransparency = 1
    fieldText.Text = "Selecione..."
    fieldText.TextColor3 = COLORS.TextInactive
    fieldText.TextSize = LABEL_SIZE
    fieldText.Font = FONT or Enum.Font.SourceSans
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

    Instance.new("UICorner", overlay).CornerRadius = UDim.new(0, 6)

    local oStroke = Instance.new("UIStroke")
    oStroke.Color = COLORS.OverlayBorder
    oStroke.Thickness = 1
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
        return multi and data.value[value] == true or (not multi and data.value == value)
    end

    local function getDisplayText()
        if multi then
            local sel = {}
            for _, v in ipairs(values) do
                if data.value[v] then table.insert(sel, v) end
            end
            return #sel == 0 and "Selecione..." or table.concat(sel, ", ")
        end
        return data.value or "Selecione..."
    end

    local function updateField(animate)
        local hasSel = multi and next(data.value) ~= nil or (not multi and data.value ~= nil)
        local col = data.disabled and COLORS.TextDisabled or (hasSel and COLORS.TextActive or COLORS.TextInactive)
        fieldText.Text = getDisplayText()
        if animate then
            tw(fieldText, TweenInfo.new(0.1), { TextColor3 = col })
        else
            fieldText.TextColor3 = col
        end
    end

    local function updateRow(row, animate)
        local sel = isSelected(row.value)
        local bg = sel and COLORS.RowSelected or COLORS.RowBg
        local tc = sel and COLORS.TextActive or (data.disabled and COLORS.TextDisabled or COLORS.TextInactive)
        if animate then
            local ti = TweenInfo.new(0.09)
            tw(row.frame, ti, { BackgroundColor3 = bg })
            tw(row.label, ti, { TextColor3 = tc })
        else
            row.frame.BackgroundColor3 = bg
            row.label.TextColor3 = tc
        end
    end

    local function fireCallback()
        local ok, err = pcall(callback, data.value)
        if not ok then warnf("callback: " .. tostring(err)) end
    end

    local closeOverlay

    local function selectValue(value)
        if data.disabled then return end
        if multi then
            data.value[value] = not data.value[value] or nil
        else
            data.value = data.value == value and nil or value
        end
        for _, row in ipairs(optRows) do updateRow(row, true) end
        updateField(true)
        fireCallback()
        if not multi then closeOverlay(false) end
    end

    local function buildOptions()
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
            Instance.new("UICorner", optFrame).CornerRadius = UDim.new(0, 4)
            optFrame.Parent = scroll

            local optLabel = Instance.new("TextLabel")
            optLabel.Name = "Label"
            optLabel.Size = UDim2.new(1, -16, 1, 0)
            optLabel.Position = UDim2.new(0, 10, 0, 0)
            optLabel.BackgroundTransparency = 1
            optLabel.Text = tostring(value)
            optLabel.TextColor3 = isSelected(value) and COLORS.TextActive or COLORS.TextInactive
            optLabel.TextSize = LABEL_SIZE
            optLabel.Font = FONT or Enum.Font.SourceSans
            optLabel.TextXAlignment = Enum.TextXAlignment.Left
            optLabel.TextYAlignment = Enum.TextYAlignment.Center
            optLabel.TextTruncate = Enum.TextTruncate.AtEnd
            optLabel.ZIndex = Z + 1
            optLabel.Parent = optFrame

            local btn = Instance.new("TextButton")
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

            btn.MouseEnter:Connect(function()
                if not isSelected(value) and not data.disabled then
                    tw(optFrame, TweenInfo.new(0.07), { BackgroundColor3 = COLORS.RowHover })
                end
            end)
            btn.MouseLeave:Connect(function()
                if not isSelected(value) then
                    tw(optFrame, TweenInfo.new(0.07), { BackgroundColor3 = COLORS.RowBg })
                end
            end)
            btn.MouseButton1Click:Connect(function()
                selectValue(value)
            end)
        end

        scroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)
    end

    local function getOverlayH()
        return math.min(listLayout.AbsoluteContentSize.Y + 6, MAX_H)
    end

    local function reposition()
        if not data.expanded then return end
        local cam = workspace.CurrentCamera
        local fPos = field.AbsolutePosition
        local fSize = field.AbsoluteSize
        local h = getOverlayH()
        local screenH = cam and cam.ViewportSize.Y or 600
        local goUp = (screenH - fPos.Y - fSize.Y) < h + 6
        local y = goUp and (fPos.Y - h - 4) or (fPos.Y + fSize.Y + 4)
        overlay.Position = UDim2.fromOffset(fPos.X, y)
    end

    local function openOverlay()
        if data.disabled or data.expanded or #values == 0 then return end
        data.expanded = true
        data.openedAt = os.clock()

        task.defer(function()
            if not data.expanded then return end
            local cam = workspace.CurrentCamera
            local fPos = field.AbsolutePosition
            local fSize = field.AbsoluteSize
            local h = getOverlayH()
            local screenH = cam and cam.ViewportSize.Y or 600
            local goUp = (screenH - fPos.Y - fSize.Y) < h + 6
            local startY = goUp and (fPos.Y - 4) or (fPos.Y + fSize.Y + 4)
            local endY = goUp and (fPos.Y - h - 4) or (fPos.Y + fSize.Y + 4)

            overlay.Size = UDim2.fromOffset(fSize.X, 0)
            overlay.Position = UDim2.fromOffset(fPos.X, startY)
            overlay.Visible = true

            scroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)

            tw(fieldIcon, TweenInfo.new(ANIM_T), { Rotation = 180 })
            local t = TweenService:Create(overlay,
                TweenInfo.new(ANIM_T, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Size = UDim2.fromOffset(fSize.X, h), Position = UDim2.fromOffset(fPos.X, endY) })
            t:Play()
        end)
    end

    closeOverlay = function(animate)
        if not data.expanded then return end
        data.expanded = false
        tw(fieldIcon, TweenInfo.new(ANIM_T), { Rotation = 0 })
        if animate == false then
            local fSize = field.AbsoluteSize
            local t = TweenService:Create(overlay,
                TweenInfo.new(ANIM_T, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                { Size = UDim2.fromOffset(fSize.X, 0) })
            t:Play()
            t.Completed:Connect(function()
                if not data.expanded then overlay.Visible = false end
            end)
        else
            overlay.Visible = false
            overlay.Size = UDim2.fromOffset(0, 0)
        end
    end

    field.MouseButton1Click:Connect(function()
        if data.expanded then closeOverlay(false) else openOverlay() end
    end)

    field:GetPropertyChangedSignal("AbsolutePosition"):Connect(reposition)
    field:GetPropertyChangedSignal("AbsoluteSize"):Connect(reposition)

    UserInputService.InputEnded:Connect(function(input)
        if not data.expanded then return end
        if data.openedAt and (os.clock() - data.openedAt) < 0.15 then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
        and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local mp = UserInputService:GetMouseLocation()
        local fP = field.AbsolutePosition
        local fS = field.AbsoluteSize
        local oP = overlay.AbsolutePosition
        local oS = overlay.AbsoluteSize
        local inField = mp.X >= fP.X and mp.X <= fP.X + fS.X and mp.Y >= fP.Y and mp.Y <= fP.Y + fS.Y
        local inOver = mp.X >= oP.X and mp.X <= oP.X + oS.X and mp.Y >= oP.Y and mp.Y <= oP.Y + oS.Y
        if not inField and not inOver then closeOverlay(false) end
    end)

    buildOptions()
    updateField(false)

    if not multi and data.value ~= nil then fireCallback()
    elseif multi and next(data.value) then fireCallback() end

    function data:Set(value)
        if multi then
            local new = {}
            if type(value) == "table" then
                for _, v in ipairs(value) do
                    if table.find(values, v) then new[v] = true end
                end
            end
            data.value = new
        else
            if value == nil or table.find(values, value) then
                data.value = value
            else
                warnf("valor '" .. tostring(value) .. "' nao existe.")
                return
            end
        end
        for _, row in ipairs(optRows) do updateRow(row, true) end
        updateField(true)
        fireCallback()
    end

    function data:Get()
        return data.value
    end

    function data:SetValues(newValues)
        values = newValues or {}
        if multi then
            local f = {}
            for v in pairs(data.value) do
                if table.find(values, v) then f[v] = true end
            end
            data.value = f
        elseif data.value and not table.find(values, data.value) then
            data.value = nil
        end
        buildOptions()
        updateField(false)
        if data.expanded then
            task.defer(function()
                local h = getOverlayH()
                overlay.Size = UDim2.fromOffset(field.AbsoluteSize.X, h)
                reposition()
            end)
        end
    end

    function data:SetDisabled(value)
        data.disabled = value
        if value then closeOverlay(true) end
        for _, row in ipairs(optRows) do updateRow(row, false) end
        updateField(true)
    end

    function data:SetTitle(newTitle)
        title = newTitle
        titleLabel.Text = newTitle
        container.Name = newTitle .. "_Dropdown"
        overlay.Name = newTitle .. "_Overlay"
    end

    function data:SetDescription(newDesc)
        desc = newDesc or ""
        displayDesc = breakWords(desc, WORD_BREAK)
        hasDesc = desc ~= ""
        local existing = textSide:FindFirstChild("Desc")
        if hasDesc then
            titleLabel.Size = UDim2.new(1, 0, 0, 16)
            titleLabel.Position = UDim2.new(0, 0, 0, 2)
            titleLabel.AnchorPoint = Vector2.new(0, 0)
            if not existing then
                local dl = Instance.new("TextLabel")
                dl.Name = "Desc"
                dl.Size = UDim2.new(1, 0, 0, 0)
                dl.Position = UDim2.new(0, 0, 0, 18)
                dl.AutomaticSize = Enum.AutomaticSize.Y
                dl.BackgroundTransparency = 1
                dl.TextColor3 = COLORS.DescText
                dl.TextSize = DESC_SIZE
                dl.Font = FONT or Enum.Font.SourceSans
                dl.TextXAlignment = Enum.TextXAlignment.Left
                dl.TextWrapped = true
                dl.LineHeight = 1.1
                dl.Parent = textSide
                existing = dl
            end
            existing.Text = displayDesc
        else
            titleLabel.Size = UDim2.new(1, 0, 1, 0)
            titleLabel.Position = UDim2.new(0, 0, 0, 0)
            titleLabel.AnchorPoint = Vector2.new(0, 0)
            if existing then existing:Destroy() end
        end
    end

    function data:Open()
        openOverlay()
    end

    function data:Close()
        closeOverlay(false)
    end

    function data:Destroy()
        overlay:Destroy()
        container:Destroy()
    end

    return data
end)