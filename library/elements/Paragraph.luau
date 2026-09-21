-- // Paragraph
Elements.Register("Paragraph", function(section, options)
    options = type(options) == "table" and options or {}

    local COLORS = {
        TextActive = Color3.fromRGB(255, 255, 255),
        TextDisabled = Color3.fromRGB(70, 70, 78),
        DescText = Color3.fromRGB(105, 105, 115),
        DescDisabled = Color3.fromRGB(60, 60, 68),
        Line = Color3.fromRGB(32, 32, 32),
        ThumbBg = Color3.fromRGB(24, 24, 24),
    }

    local TITLE_SIZE = 12
    local DESC_SIZE = 10
    local THUMB_SIZE = 36
    local PADDING_X = 0
    local PADDING_Y = 10
    local THUMB_GAP = 10
    local MIN_HEIGHT = 40
    local UPDATE_INTERVAL = 3
    local WORD_MAX = 30

    local players = Players or game:GetService("Players")
    local fontBold = FONT_BOLD or Enum.Font.SourceSansBold
    local fontRegular = FONT or Enum.Font.SourceSans

    local destroyed = false
    local liveToken = 0
    local thumbWarned = false

    local function warnf(msg)
        pcall(function()
            Notify({ Title = "CodyWas | Paragraph", Description = msg, Duration = 5 })
        end)
    end

    local function breakLongWords(text, maxLen)
        text = tostring(text or "")
        local lines = {}
        for line in (text .. "\n"):gmatch("(.-)\n") do
            local result = {}
            for word in line:gmatch("%S+") do
                while #word > maxLen do
                    table.insert(result, word:sub(1, maxLen))
                    word = word:sub(maxLen + 1)
                end
                table.insert(result, word)
            end
            table.insert(lines, table.concat(result, " "))
        end
        return table.concat(lines, "\n")
    end

    local title = tostring(options.title or options.Name or "")
    local description = tostring(options.description or options.Description or "")
    local thumbnail = options.thumbnail or options.Thumbnail
    local disabled = options.disabled == true
    local richText = options.richText ~= false

    if thumbnail ~= nil and type(thumbnail) ~= "string" and type(thumbnail) ~= "number" then
        warnf("thumbnail deve ser string ou number (userId)")
        thumbnail = nil
    end

    local function formatText(text)
        if richText then
            return text
        end
        return breakLongWords(text, WORD_MAX)
    end

    local data = {
        disabled = disabled,
        title = title,
        description = description,
        thumbnail = thumbnail,
    }

    local container = Instance.new("Frame")
    container.Name = (title ~= "" and title or "Paragraph") .. "_Paragraph"
    container.Size = UDim2.new(1, 0, 0, MIN_HEIGHT)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = false
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.Parent = section.frame

    local sizeConstraint = Instance.new("UISizeConstraint")
    sizeConstraint.MinSize = Vector2.new(0, MIN_HEIGHT)
    sizeConstraint.Parent = container

    local innerPad = Instance.new("UIPadding")
    innerPad.PaddingTop = UDim.new(0, PADDING_Y)
    innerPad.PaddingBottom = UDim.new(0, PADDING_Y)
    innerPad.PaddingLeft = UDim.new(0, PADDING_X)
    innerPad.PaddingRight = UDim.new(0, PADDING_X)
    innerPad.Parent = container

    local rowFrame = Instance.new("Frame")
    rowFrame.Name = "Row"
    rowFrame.BackgroundTransparency = 1
    rowFrame.Size = UDim2.new(1, 0, 0, 0)
    rowFrame.AutomaticSize = Enum.AutomaticSize.Y
    rowFrame.Parent = container

    local thumbFrame = Instance.new("Frame")
    thumbFrame.Name = "Thumbnail"
    thumbFrame.Size = UDim2.fromOffset(THUMB_SIZE, THUMB_SIZE)
    thumbFrame.Position = UDim2.new(0, 0, 0, 0)
    thumbFrame.BackgroundColor3 = COLORS.ThumbBg
    thumbFrame.BorderSizePixel = 0
    thumbFrame.Visible = thumbnail ~= nil
    thumbFrame.Parent = rowFrame

    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(0, 6)
    thumbCorner.Parent = thumbFrame

    local thumbStroke = Instance.new("UIStroke")
    thumbStroke.Color = COLORS.Line
    thumbStroke.Thickness = 1
    thumbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    thumbStroke.Parent = thumbFrame

    local thumbImage = Instance.new("ImageLabel")
    thumbImage.Name = "Image"
    thumbImage.Size = UDim2.new(1, 0, 1, 0)
    thumbImage.BackgroundTransparency = 1
    thumbImage.Image = type(thumbnail) == "string" and thumbnail or ""
    thumbImage.ScaleType = Enum.ScaleType.Crop
    thumbImage.ZIndex = 2
    thumbImage.Parent = thumbFrame

    local thumbImageCorner = Instance.new("UICorner")
    thumbImageCorner.CornerRadius = UDim.new(0, 6)
    thumbImageCorner.Parent = thumbImage

    local textFrame = Instance.new("Frame")
    textFrame.Name = "TextBlock"
    textFrame.BackgroundTransparency = 1
    textFrame.Position = UDim2.new(0, 0, 0, 0)
    textFrame.Size = UDim2.new(1, 0, 0, 0)
    textFrame.AutomaticSize = Enum.AutomaticSize.Y
    textFrame.Parent = rowFrame

    local textLayout = Instance.new("UIListLayout")
    textLayout.SortOrder = Enum.SortOrder.LayoutOrder
    textLayout.Padding = UDim.new(0, 4)
    textLayout.Parent = textFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 0)
    titleLabel.AutomaticSize = Enum.AutomaticSize.Y
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = formatText(title)
    titleLabel.TextColor3 = COLORS.TextActive
    titleLabel.TextSize = TITLE_SIZE
    titleLabel.Font = fontBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Top
    titleLabel.TextWrapped = true
    titleLabel.RichText = richText
    titleLabel.LayoutOrder = 1
    titleLabel.Visible = title ~= ""
    titleLabel.Parent = textFrame

    local descLabel = Instance.new("TextLabel")
    descLabel.Name = "Description"
    descLabel.Size = UDim2.new(1, 0, 0, 0)
    descLabel.AutomaticSize = Enum.AutomaticSize.Y
    descLabel.BackgroundTransparency = 1
    descLabel.Text = formatText(description)
    descLabel.TextColor3 = COLORS.DescText
    descLabel.TextSize = DESC_SIZE
    descLabel.Font = fontRegular
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextYAlignment = Enum.TextYAlignment.Top
    descLabel.TextWrapped = true
    descLabel.LineHeight = 1.2
    descLabel.RichText = richText
    descLabel.LayoutOrder = 2
    descLabel.Visible = description ~= ""
    descLabel.Parent = textFrame

    local function layoutThumbnail(hasThumb)
        if hasThumb then
            local offset = THUMB_SIZE + THUMB_GAP
            thumbFrame.Visible = true
            textFrame.Position = UDim2.new(0, offset, 0, 0)
            textFrame.Size = UDim2.new(1, -offset, 0, 0)
        else
            thumbFrame.Visible = false
            thumbImage.Image = ""
            textFrame.Position = UDim2.new(0, 0, 0, 0)
            textFrame.Size = UDim2.new(1, 0, 0, 0)
        end
    end

    local function applyDisabled()
        titleLabel.TextColor3 = data.disabled and COLORS.TextDisabled or COLORS.TextActive
        descLabel.TextColor3 = data.disabled and COLORS.DescDisabled or COLORS.DescText
        thumbImage.ImageTransparency = data.disabled and 0.5 or 0
    end

    local function fetchUserThumb(userId)
        local ok, result = pcall(function()
            return players:GetUserThumbnailAsync(
                userId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size100x100
            )
        end)
        if ok and result then
            thumbWarned = false
            return result
        end
        if not thumbWarned then
            thumbWarned = true
            warnf("Falha ao buscar thumbnail do userId " .. tostring(userId))
        end
        return nil
    end

    local function stopLive()
        liveToken = liveToken + 1
    end

    local function startLive(userId)
        liveToken = liveToken + 1
        local myToken = liveToken
        thumbWarned = false

        task.spawn(function()
            while not destroyed and liveToken == myToken do
                local img = fetchUserThumb(userId)
                if destroyed or liveToken ~= myToken then return end
                if img and thumbImage.Image ~= img then
                    thumbImage.Image = img
                end
                task.wait(UPDATE_INTERVAL)
            end
        end)
    end

    local function setThumbnailInternal(value)
        stopLive()
        data.thumbnail = value

        if value == nil or value == "" then
            layoutThumbnail(false)
            return
        end

        layoutThumbnail(true)

        if type(value) == "number" then
            thumbImage.Image = ""
            startLive(value)
        elseif type(value) == "string" then
            thumbImage.Image = value
        else
            warnf("thumbnail deve ser string ou number (userId)")
            layoutThumbnail(false)
        end
    end

    setThumbnailInternal(thumbnail)
    applyDisabled()

    function data:SetTitle(newTitle)
        if destroyed then return end
        newTitle = tostring(newTitle or "")
        data.title = newTitle
        titleLabel.Text = formatText(newTitle)
        titleLabel.Visible = newTitle ~= ""
        container.Name = (newTitle ~= "" and newTitle or "Paragraph") .. "_Paragraph"
    end

    function data:SetDescription(newDesc)
        if destroyed then return end
        newDesc = tostring(newDesc or "")
        data.description = newDesc
        descLabel.Text = formatText(newDesc)
        descLabel.Visible = newDesc ~= ""
    end

    function data:SetThumbnail(value)
        if destroyed then return end
        setThumbnailInternal(value)
    end

    function data:SetDisabled(value)
        if destroyed then return end
        data.disabled = value == true
        applyDisabled()
    end

    function data:GetTitle()
        return data.title
    end

    function data:GetDescription()
        return data.description
    end

    function data:Destroy()
        if destroyed then return end
        destroyed = true
        stopLive()
        container:Destroy()
    end

    return data
end)