-- // Paragraph
Elements.Register("Paragraph", function(section, options)
    local COLORS = {
        TextActive = Color3.fromRGB(255, 255, 255),
        DescText = Color3.fromRGB(105, 105, 115),
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

    local function warnf(msg)
        pcall(function() Notify({ Title = "CodyWas | Paragraph", Description = msg, Duration = 5 }) end)
    end

    local title = options.title       or options.Name        or ""
    local description = options.description or options.Description or ""
    local thumbnail = options.thumbnail   or options.Thumbnail   or nil
    local disabled = options.disabled    or false

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
    thumbStroke.Parent = thumbFrame

    local thumbImage = Instance.new("ImageLabel")
    thumbImage.Name = "Image"
    thumbImage.Size = UDim2.new(1, 0, 1, 0)
    thumbImage.BackgroundTransparency = 1
    thumbImage.Image = thumbnail or ""
    thumbImage.ScaleType = Enum.ScaleType.Crop
    thumbImage.ZIndex = 2
    thumbImage.Parent = thumbFrame

    local thumbImageCorner = Instance.new("UICorner")
    thumbImageCorner.CornerRadius = UDim.new(0, 6)
    thumbImageCorner.Parent = thumbImage

    local textOffset = thumbnail ~= nil and (THUMB_SIZE + THUMB_GAP) or 0

    local textFrame = Instance.new("Frame")
    textFrame.Name = "TextBlock"
    textFrame.BackgroundTransparency = 1
    textFrame.Position = UDim2.new(0, textOffset, 0, 0)
    textFrame.Size = UDim2.new(1, -textOffset, 0, 0)
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
    titleLabel.Text = title
    titleLabel.TextColor3 = COLORS.TextActive
    titleLabel.TextSize = TITLE_SIZE
    titleLabel.Font = FONT_BOLD
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextWrapped = true
    titleLabel.RichText = true
    titleLabel.LayoutOrder = 1
    titleLabel.Visible = title ~= ""
    titleLabel.Parent = textFrame

    local descLabel = Instance.new("TextLabel")
    descLabel.Name = "Description"
    descLabel.Size = UDim2.new(1, 0, 0, 0)
    descLabel.AutomaticSize = Enum.AutomaticSize.Y
    descLabel.BackgroundTransparency = 1
    descLabel.Text = description
    descLabel.TextColor3 = COLORS.DescText
    descLabel.TextSize = DESC_SIZE
    descLabel.Font = FONT
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextWrapped = true
    descLabel.LineHeight = 1.2
    descLabel.RichText = true
    descLabel.LayoutOrder = 2
    descLabel.Visible = description ~= ""
    descLabel.Parent = textFrame

    local liveActive = false
    local liveUserId = nil

    local function applyThumbnail(id)
        if id and id ~= "" then
            thumbFrame.Visible = true
            thumbImage.Image = id
            textFrame.Position = UDim2.new(0, THUMB_SIZE + THUMB_GAP, 0, 0)
            textFrame.Size = UDim2.new(1, -(THUMB_SIZE + THUMB_GAP), 0, 0)
        else
            thumbFrame.Visible = false
            thumbImage.Image = ""
            textFrame.Position = UDim2.new(0, 0, 0, 0)
            textFrame.Size = UDim2.new(1, 0, 0, 0)
        end
    end

    local function resolveUserId(userId)
        local ok, result = pcall(function()
            return Players:GetUserThumbnailAsync(
                userId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size100x100
            )
        end)
        if ok and result then return result end
        warnf("Falha ao buscar thumbnail do userId " .. tostring(userId))
        return nil
    end

    local function startLiveUpdate(userId)
        liveActive = true
        liveUserId = userId

        task.spawn(function()
            while liveActive and liveUserId == userId do
                local img = resolveUserId(userId)
                if img and liveActive and liveUserId == userId then
                    thumbImage.Image = img
                end
                task.wait(UPDATE_INTERVAL)
            end
        end)
    end

    if thumbnail then
        if type(thumbnail) == "number" then
            task.spawn(function()
                applyThumbnail("")
                startLiveUpdate(thumbnail)
            end)
        else
            applyThumbnail(thumbnail)
        end
    end

    function data:SetTitle(newTitle)
        if type(newTitle) ~= "string" then
            warnf("SetTitle() esperava string")
            return
        end
        data.title = newTitle
        titleLabel.Text = newTitle
        titleLabel.Visible = newTitle ~= ""
    end

    function data:SetDescription(newDesc)
        if type(newDesc) ~= "string" then
            warnf("SetDescription() esperava string")
            return
        end
        data.description = newDesc
        descLabel.Text = newDesc
        descLabel.Visible = newDesc ~= ""
    end

    function data:SetThumbnail(id)
        liveActive = false
        liveUserId = nil
        data.thumbnail = id
        if type(id) == "number" then
            task.spawn(function()
                applyThumbnail("")
                startLiveUpdate(id)
            end)
        else
            applyThumbnail(id)
        end
    end

    function data:SetDisabled(value)
        data.disabled = value
        titleLabel.TextColor3 = value and Color3.fromRGB(70, 70, 78) or COLORS.TextActive
        descLabel.TextColor3 = value and Color3.fromRGB(60, 60, 68) or COLORS.DescText
    end

    function data:Destroy()
        liveActive = false
        liveUserId = nil
        container:Destroy()
    end

    return data
end)