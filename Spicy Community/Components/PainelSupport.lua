local Library = {}
Library.__index = Library

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Icons = {
    Close = "rbxassetid://10747384394",
    Min = "rbxassetid://10734896206",
    Max = "rbxassetid://10734886735",
    Restore = "rbxassetid://10734886496",
}

local LucideIcons = {
    accessibility = "rbxassetid://10709751939",
    activity = "rbxassetid://10709752035",
    airvent = "rbxassetid://10709752131",
    airplay = "rbxassetid://10709752254",
    alarmcheck = "rbxassetid://10709752405",
    alarmclock = "rbxassetid://10709752630",
    album = "rbxassetid://10709752906",
    alertcircle = "rbxassetid://10709752996",
    alerttriangle = "rbxassetid://10709753149",
    anchor = "rbxassetid://10709761530",
    angry = "rbxassetid://10709761629",
    aperture = "rbxassetid://10709761813",
    archive = "rbxassetid://10709762233",
    arrowdown = "rbxassetid://10709767827",
    arrowleft = "rbxassetid://10709768114",
    arrowright = "rbxassetid://10709768347",
    arrowup = "rbxassetid://10709768939",
    award = "rbxassetid://10709769406",
    axe = "rbxassetid://10709769508",
    baby = "rbxassetid://10709769732",
    backpack = "rbxassetid://10709769841",
    barchart = "rbxassetid://10709773755",
    battery = "rbxassetid://10709774640",
    bell = "rbxassetid://10709775704",
    bike = "rbxassetid://10709775894",
    bitcoin = "rbxassetid://10709776126",
    bluetooth = "rbxassetid://10709776655",
    bold = "rbxassetid://10747813908",
    bomb = "rbxassetid://10709781460",
    book = "rbxassetid://10709781824",
    bookmark = "rbxassetid://10709782154",
    box = "rbxassetid://10709782497",
    briefcase = "rbxassetid://10709782662",
    bug = "rbxassetid://10709782845",
    building = "rbxassetid://10709783051",
    calendar = "rbxassetid://10709789505",
    camera = "rbxassetid://10709789686",
    car = "rbxassetid://10709789810",
    check = "rbxassetid://10709790644",
    checkcircle = "rbxassetid://10709790387",
    chevrondown = "rbxassetid://10709790948",
    chevronleft = "rbxassetid://10709791281",
    chevronright = "rbxassetid://10709791437",
    chevronup = "rbxassetid://10709791523",
    chrome = "rbxassetid://10709797725",
    circle = "rbxassetid://10709798174",
    clipboard = "rbxassetid://10709799288",
    clock = "rbxassetid://10709805144",
    cloud = "rbxassetid://10709806740",
    code = "rbxassetid://10709810463",
    cog = "rbxassetid://10709810948",
    command = "rbxassetid://10709811365",
    compass = "rbxassetid://10709811445",
    copy = "rbxassetid://10709812159",
    cpu = "rbxassetid://10709813383",
    crown = "rbxassetid://10709818626",
    database = "rbxassetid://10709818996",
    delete = "rbxassetid://10709819059",
    diamond = "rbxassetid://10709819149",
    download = "rbxassetid://10723344270",
    droplet = "rbxassetid://10723344432",
    edit = "rbxassetid://10734883598",
    eye = "rbxassetid://10723346959",
    eyeoff = "rbxassetid://10723346871",
    file = "rbxassetid://10723374641",
    film = "rbxassetid://10723374981",
    filter = "rbxassetid://10723375128",
    flag = "rbxassetid://10723375890",
    flame = "rbxassetid://10723376114",
    flashlight = "rbxassetid://10723376471",
    folder = "rbxassetid://10723387563",
    gamepad = "rbxassetid://10723395457",
    gem = "rbxassetid://10723396000",
    gift = "rbxassetid://10723396402",
    globe = "rbxassetid://10723404337",
    grid = "rbxassetid://10723404936",
    hammer = "rbxassetid://10723405360",
    hash = "rbxassetid://10723405975",
    headphones = "rbxassetid://10723406165",
    heart = "rbxassetid://10723406885",
    helpcircle = "rbxassetid://10723406988",
    home = "rbxassetid://10723407389",
    image = "rbxassetid://10723415040",
    inbox = "rbxassetid://10723415335",
    info = "rbxassetid://10723415903",
    key = "rbxassetid://10723416652",
    keyboard = "rbxassetid://10723416765",
    layers = "rbxassetid://10723424505",
    layout = "rbxassetid://10723425376",
    lightbulb = "rbxassetid://10723425852",
    link = "rbxassetid://10723426722",
    list = "rbxassetid://10723433811",
    lock = "rbxassetid://10723434711",
    login = "rbxassetid://10723434830",
    logout = "rbxassetid://10723434906",
    mail = "rbxassetid://10734885430",
    map = "rbxassetid://10734886202",
    mappin = "rbxassetid://10734886004",
    maximize = "rbxassetid://10734886735",
    menu = "rbxassetid://10734887784",
    messagecircle = "rbxassetid://10734888000",
    messagesquare = "rbxassetid://10734888228",
    mic = "rbxassetid://10734888864",
    minimize = "rbxassetid://10734895698",
    minus = "rbxassetid://10734896206",
    monitor = "rbxassetid://10734896881",
    moon = "rbxassetid://10734897102",
    morehorizontal = "rbxassetid://10734897250",
    morevertical = "rbxassetid://10734897387",
    music = "rbxassetid://10734905958",
    navigation = "rbxassetid://10734906744",
    package = "rbxassetid://10734909540",
    paperclip = "rbxassetid://10734910927",
    pause = "rbxassetid://10734919336",
    phone = "rbxassetid://10734921524",
    piechart = "rbxassetid://10734921727",
    pin = "rbxassetid://10734922324",
    play = "rbxassetid://10734923549",
    plus = "rbxassetid://10734924532",
    power = "rbxassetid://10734930466",
    printer = "rbxassetid://10734930632",
    radio = "rbxassetid://10734931596",
    refreshcw = "rbxassetid://10734933222",
    rocket = "rbxassetid://10734934585",
    save = "rbxassetid://10734941499",
    search = "rbxassetid://10734943674",
    send = "rbxassetid://10734943902",
    settings = "rbxassetid://10734950309",
    share = "rbxassetid://10734950813",
    shield = "rbxassetid://10734951847",
    shoppingbag = "rbxassetid://10734952273",
    shoppingcart = "rbxassetid://10734952479",
    shuffle = "rbxassetid://10734953451",
    sidebar = "rbxassetid://10734954301",
    sliders = "rbxassetid://10734963400",
    smartphone = "rbxassetid://10734963940",
    smile = "rbxassetid://10734964441",
    star = "rbxassetid://10734966248",
    sun = "rbxassetid://10734974297",
    tag = "rbxassetid://10734976528",
    target = "rbxassetid://10734977012",
    terminal = "rbxassetid://10734982144",
    thumbsup = "rbxassetid://10734983629",
    thumbsdown = "rbxassetid://10734983359",
    tool = "rbxassetid://10747383470",
    trash = "rbxassetid://10747362393",
    trendingup = "rbxassetid://10747363465",
    trophy = "rbxassetid://10747363809",
    truck = "rbxassetid://10747364031",
    tv = "rbxassetid://10747364593",
    umbrella = "rbxassetid://10747364971",
    unlock = "rbxassetid://10747366027",
    upload = "rbxassetid://10747366434",
    user = "rbxassetid://10747373176",
    users = "rbxassetid://10747373426",
    video = "rbxassetid://10747374938",
    volume = "rbxassetid://10747376008",
    wallet = "rbxassetid://10747376205",
    watch = "rbxassetid://10747376722",
    wifi = "rbxassetid://10747382504",
    x = "rbxassetid://10747384394",
    xcircle = "rbxassetid://10747383819",
    zap = "rbxassetid://10723345749",
    zoomin = "rbxassetid://10747384552",
    zoomout = "rbxassetid://10747384679",
}

local TabColors = {
    Color3.fromRGB(88, 101, 242),
    Color3.fromRGB(235, 69, 158),
    Color3.fromRGB(87, 242, 135),
    Color3.fromRGB(254, 231, 92),
    Color3.fromRGB(32, 201, 151),
    Color3.fromRGB(250, 84, 84),
    Color3.fromRGB(148, 87, 235),
    Color3.fromRGB(242, 138, 54),
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 128, 0),
    Color3.fromRGB(128, 0, 255),
    Color3.fromRGB(255, 20, 147),
    Color3.fromRGB(0, 191, 255),
    Color3.fromRGB(50, 205, 50),
    Color3.fromRGB(255, 215, 0),
    Color3.fromRGB(220, 20, 60),
    Color3.fromRGB(138, 43, 226),
    Color3.fromRGB(255, 105, 180),
    Color3.fromRGB(64, 224, 208),
    Color3.fromRGB(255, 140, 0),
    Color3.fromRGB(186, 85, 211),
    Color3.fromRGB(34, 139, 34),
    Color3.fromRGB(255, 69, 0),
    Color3.fromRGB(30, 144, 255),
    Color3.fromRGB(154, 205, 50),
    Color3.fromRGB(255, 99, 71),
    Color3.fromRGB(72, 61, 139),
    Color3.fromRGB(46, 139, 87),
    Color3.fromRGB(255, 192, 203),
    Color3.fromRGB(65, 105, 225),
    Color3.fromRGB(218, 112, 214),
    Color3.fromRGB(127, 255, 0),
    Color3.fromRGB(255, 127, 80),
    Color3.fromRGB(100, 149, 237),
    Color3.fromRGB(255, 228, 181),
    Color3.fromRGB(176, 224, 230),
    Color3.fromRGB(240, 128, 128),
    Color3.fromRGB(221, 160, 221),
    Color3.fromRGB(144, 238, 144),
    Color3.fromRGB(255, 182, 193),
    Color3.fromRGB(135, 206, 250),
    Color3.fromRGB(238, 130, 238),
    Color3.fromRGB(152, 251, 152),
    Color3.fromRGB(255, 160, 122),
    Color3.fromRGB(173, 216, 230),
    Color3.fromRGB(219, 112, 147),
    Color3.fromRGB(60, 179, 113),
    Color3.fromRGB(255, 218, 185),
    Color3.fromRGB(123, 104, 238),
    Color3.fromRGB(250, 128, 114),
    Color3.fromRGB(32, 178, 170),
    Color3.fromRGB(255, 239, 213),
    Color3.fromRGB(106, 90, 205),
    Color3.fromRGB(233, 150, 122),
    Color3.fromRGB(72, 209, 204),
    Color3.fromRGB(255, 222, 173),
    Color3.fromRGB(147, 112, 219),
    Color3.fromRGB(244, 164, 96),
    Color3.fromRGB(95, 158, 160),
    Color3.fromRGB(255, 250, 205),
    Color3.fromRGB(189, 183, 107),
    Color3.fromRGB(210, 105, 30),
    Color3.fromRGB(107, 142, 35),
    Color3.fromRGB(205, 133, 63),
    Color3.fromRGB(85, 107, 47),
    Color3.fromRGB(184, 134, 11),
    Color3.fromRGB(128, 128, 0),
    Color3.fromRGB(160, 82, 45),
    Color3.fromRGB(139, 69, 19),
    Color3.fromRGB(165, 42, 42),
    Color3.fromRGB(178, 34, 34),
    Color3.fromRGB(199, 21, 133),
    Color3.fromRGB(216, 191, 216),
    Color3.fromRGB(255, 240, 245),
    Color3.fromRGB(230, 230, 250),
    Color3.fromRGB(245, 255, 250),
    Color3.fromRGB(240, 255, 240),
    Color3.fromRGB(255, 245, 238),
    Color3.fromRGB(245, 245, 220),
    Color3.fromRGB(253, 245, 230),
    Color3.fromRGB(255, 248, 220),
    Color3.fromRGB(255, 255, 240),
    Color3.fromRGB(240, 255, 255),
    Color3.fromRGB(248, 248, 255),
    Color3.fromRGB(245, 222, 179),
    Color3.fromRGB(255, 228, 196),
    Color3.fromRGB(255, 235, 205),
    Color3.fromRGB(255, 228, 225),
    Color3.fromRGB(255, 240, 245),
    Color3.fromRGB(250, 235, 215),
    Color3.fromRGB(255, 239, 213),
    Color3.fromRGB(255, 245, 238),
    Color3.fromRGB(245, 245, 245),
    Color3.fromRGB(220, 220, 220),
}

local SpecialDates = {
    {Month = 1, StartDay = 1, EndDay = 7, Name = "Ano Novo", Emoji = "🎉", Color = Color3.fromRGB(255, 215, 0)},
    {Month = 2, StartDay = 10, EndDay = 14, Name = "Dia dos Namorados", Emoji = "💖", Color = Color3.fromRGB(255, 105, 180)},
    {Month = 3, StartDay = 20, EndDay = 31, Name = "Primavera", Emoji = "🌸", Color = Color3.fromRGB(255, 182, 193)},
    {Month = 4, StartDay = 1, EndDay = 30, Name = "Páscoa", Emoji = "🐰", Color = Color3.fromRGB(186, 85, 211)},
    {Month = 6, StartDay = 1, EndDay = 30, Name = "Festa Junina", Emoji = "🎪", Color = Color3.fromRGB(255, 140, 0)},
    {Month = 10, StartDay = 25, EndDay = 31, Name = "Halloween", Emoji = "🎃", Color = Color3.fromRGB(255, 140, 0)},
    {Month = 12, StartDay = 1, EndDay = 31, Name = "Natal", Emoji = "🎅", Color = Color3.fromRGB(220, 20, 60)},
}

function Library:GetCurrentSpecialDate()
    local currentDate = os.date("*t")
    local currentMonth = currentDate.month
    local currentDay = currentDate.day
    
    for _, event in ipairs(SpecialDates) do
        if event.Month == currentMonth and currentDay >= event.StartDay and currentDay <= event.EndDay then
            return event
        end
    end
    
    return nil
end

function Library:GetIcon(iconName)
    local cleanName = string.lower(iconName):gsub("-", ""):gsub("_", ""):gsub(" ", "")
    return LucideIcons[cleanName] or LucideIcons["home"]
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpicyUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game:GetService("CoreGui")
else
    ScreenGui.Parent = game:GetService("CoreGui")
end

local Utils = {}

function Utils:CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

function Utils:Tween(object, properties, duration)
    TweenService:Create(object, TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties):Play()
end

function Utils:CreateGradient(parent, colors)
    local gradient = Instance.new("UIGradient")
    local colorSequence = ColorSequence.new(colors)
    gradient.Color = colorSequence
    gradient.Parent = parent
    return gradient
end

function Utils:CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.Thickness = thickness or 1
    stroke.Transparency = 0.8
    stroke.Parent = parent
    return stroke
end

function Library:CreateWindow(config)
    
    local Window = {}
    local MinimizeKey = config.MinimizeKey or Enum.KeyCode.LeftControl
    
    local specialEvent = Library:GetCurrentSpecialDate()
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainWindow"
    MainFrame.Size = config.Size or UDim2.fromOffset(600, 400)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    Utils:CreateCorner(MainFrame, 12)
    Utils:CreateStroke(MainFrame, Color3.fromRGB(60, 60, 70), 1)
    
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = -1
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.Parent = MainFrame
    
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 55)
    TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    Utils:CreateCorner(TopBar, 12)
    
    local TopBarFix = Instance.new("Frame")
    TopBarFix.Size = UDim2.new(1, 0, 0, 15)
    TopBarFix.Position = UDim2.new(0, 0, 1, -15)
    TopBarFix.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    TopBarFix.BorderSizePixel = 0
    TopBarFix.Parent = TopBar
    
    local AccentLine = Instance.new("Frame")
    AccentLine.Name = "AccentLine"
    AccentLine.Size = UDim2.new(1, 0, 0, 2)
    AccentLine.Position = UDim2.new(0, 0, 1, 0)
    AccentLine.BorderSizePixel = 0
    AccentLine.Parent = TopBar
    
    if specialEvent then
        AccentLine.BackgroundColor3 = specialEvent.Color
    else
        AccentLine.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        Utils:CreateGradient(AccentLine, {
            Color3.fromRGB(88, 101, 242),
            Color3.fromRGB(235, 69, 158)
        })
    end
    
    local EventEmoji = Instance.new("TextLabel")
    EventEmoji.Name = "EventEmoji"
    EventEmoji.Size = UDim2.fromOffset(35, 35)
    EventEmoji.Position = UDim2.new(0, 15, 0, 10)
    EventEmoji.BackgroundTransparency = 1
    EventEmoji.Text = specialEvent and specialEvent.Emoji or "✨"
    EventEmoji.TextSize = 26
    EventEmoji.ZIndex = 5
    EventEmoji.Parent = TopBar
    
    task.spawn(function()
        while EventEmoji.Parent do
            Utils:Tween(EventEmoji, {Rotation = 15}, 0.5)
            task.wait(0.5)
            Utils:Tween(EventEmoji, {Rotation = -15}, 0.5)
            task.wait(0.5)
            Utils:Tween(EventEmoji, {Rotation = 0}, 0.5)
            task.wait(2)
        end
    end)
    
    local StatusIndicator = Instance.new("Frame")
    StatusIndicator.Name = "StatusIndicator"
    StatusIndicator.Size = UDim2.fromOffset(10, 10)
    StatusIndicator.Position = UDim2.new(1, -75, 0, 22)
    StatusIndicator.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
    StatusIndicator.BorderSizePixel = 0
    StatusIndicator.Parent = TopBar
    
    Utils:CreateCorner(StatusIndicator, 5)
    
    local StatusGlow = Instance.new("Frame")
    StatusGlow.Size = UDim2.fromOffset(16, 16)
    StatusGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    StatusGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    StatusGlow.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
    StatusGlow.BackgroundTransparency = 0.7
    StatusGlow.BorderSizePixel = 0
    StatusGlow.ZIndex = -1
    StatusGlow.Parent = StatusIndicator
    
    Utils:CreateCorner(StatusGlow, 8)
    
    task.spawn(function()
        while StatusIndicator.Parent do
            Utils:Tween(StatusGlow, {Size = UDim2.fromOffset(20, 20), BackgroundTransparency = 0.9}, 1)
            task.wait(1)
            Utils:Tween(StatusGlow, {Size = UDim2.fromOffset(16, 16), BackgroundTransparency = 0.7}, 1)
            task.wait(1)
        end
    end)
    
    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.fromOffset(32, 32)
    MinimizeButton.Position = UDim2.new(1, -45, 0, 11)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
    MinimizeButton.Image = Icons.Min
    MinimizeButton.ImageColor3 = Color3.fromRGB(200, 200, 210)
    MinimizeButton.Parent = TopBar
    
    Utils:CreateCorner(MinimizeButton, 8)
    
    MinimizeButton.MouseEnter:Connect(function()
        Utils:Tween(MinimizeButton, {BackgroundColor3 = Color3.fromRGB(40, 40, 48)}, 0.2)
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        Utils:Tween(MinimizeButton, {BackgroundColor3 = Color3.fromRGB(30, 30, 36)}, 0.2)
    end)
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -120, 0, 25)
    Title.Position = UDim2.new(0, 55, 0, 8)
    Title.BackgroundTransparency = 1
    Title.Text = config.Title or "Window"
    Title.TextColor3 = Color3.fromRGB(240, 240, 250)
    Title.TextSize = 17
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Name = "SubTitle"
    SubTitle.Size = UDim2.new(1, -120, 0, 18)
    SubTitle.Position = UDim2.new(0, 55, 0, 32)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = config.SubTitle or ""
    SubTitle.TextColor3 = Color3.fromRGB(140, 140, 160)
    SubTitle.TextSize = 12
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Parent = TopBar
    
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, 0, 1, -55)
    ContentFrame.Position = UDim2.new(0, 0, 0, 55)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, config.TabWidth or 180, 1, -15)
    TabContainer.Position = UDim2.new(0, 10, 0, 10)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = ContentFrame
    
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Size = UDim2.new(1, 0, 1, 0)
    TabList.BackgroundTransparency = 1
    TabList.BorderSizePixel = 0
    TabList.ScrollBarThickness = 0
    TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabList.Parent = TabContainer
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 10)
    TabListLayout.Parent = TabList
    
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -(config.TabWidth or 180) - 30, 1, -15)
    ContentContainer.Position = UDim2.new(0, (config.TabWidth or 180) + 20, 0, 10)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = ContentFrame
    
    local Tabs = {}
    local SelectedTab = nil
    local TabColorIndex = 1
    
    function Window:AddTab(config)
        local Tab = {}
        local tabColor = TabColors[TabColorIndex]
        TabColorIndex = (TabColorIndex % 8) + 1
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = config.Name or "Tab"
        TabButton.Size = UDim2.new(1, 0, 0, 45)
        TabButton.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
        TabButton.Text = ""
        TabButton.AutoButtonColor = false
        TabButton.Parent = TabList
        
        Utils:CreateCorner(TabButton, 10)
        
        local TabAccent = Instance.new("Frame")
        TabAccent.Name = "Accent"
        TabAccent.Size = UDim2.new(0, 3, 1, -8)
        TabAccent.Position = UDim2.new(0, 4, 0, 4)
        TabAccent.BackgroundColor3 = tabColor
        TabAccent.BorderSizePixel = 0
        TabAccent.BackgroundTransparency = 1
        TabAccent.Parent = TabButton
        
        Utils:CreateCorner(TabAccent, 2)
        
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Name = "Icon"
        TabIcon.Size = UDim2.fromOffset(22, 22)
        TabIcon.Position = UDim2.new(0, 15, 0.5, -11)
        TabIcon.BackgroundTransparency = 1
        TabIcon.ImageColor3 = Color3.fromRGB(160, 160, 180)
        TabIcon.Image = Library:GetIcon(config.Icon or "home")
        TabIcon.Parent = TabButton
        
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Name = "Label"
        TabLabel.Size = UDim2.new(1, -50, 1, 0)
        TabLabel.Position = UDim2.new(0, 42, 0, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Text = config.Name or "Tab"
        TabLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
        TabLabel.TextSize = 14
        TabLabel.Font = Enum.Font.GothamMedium
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.Parent = TabButton
        
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "TabContent"
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 10)
        ContentLayout.Parent = TabContent
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingLeft = UDim.new(0, 5)
        ContentPadding.PaddingRight = UDim.new(0, 5)
        ContentPadding.Parent = TabContent
        
        TabButton.MouseEnter:Connect(function()
            if SelectedTab ~= Tab then
                Utils:Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(30, 30, 36)}, 0.2)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if SelectedTab ~= Tab then
                Utils:Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(24, 24, 28)}, 0.2)
            end
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Tabs) do
                Utils:Tween(tab.Button, {BackgroundColor3 = Color3.fromRGB(24, 24, 28)}, 0.2)
                Utils:Tween(tab.Icon, {ImageColor3 = Color3.fromRGB(160, 160, 180)}, 0.2)
                Utils:Tween(tab.Label, {TextColor3 = Color3.fromRGB(180, 180, 200)}, 0.2)
                Utils:Tween(tab.Accent, {BackgroundTransparency = 1}, 0.2)
                tab.Content.Visible = false
            end
            
            Utils:Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(30, 30, 36)}, 0.2)
            Utils:Tween(TabIcon, {ImageColor3 = tabColor}, 0.2)
            Utils:Tween(TabLabel, {TextColor3 = Color3.fromRGB(240, 240, 250)}, 0.2)
            Utils:Tween(TabAccent, {BackgroundTransparency = 0}, 0.2)
            TabContent.Visible = true
            SelectedTab = Tab
        end)
        
        if not SelectedTab then
            TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
            TabIcon.ImageColor3 = tabColor
            TabLabel.TextColor3 = Color3.fromRGB(240, 240, 250)
            TabAccent.BackgroundTransparency = 0
            TabContent.Visible = true
            SelectedTab = Tab
        end
        
        Tab.Button = TabButton
        Tab.Icon = TabIcon
        Tab.Label = TabLabel
        Tab.Content = TabContent
        Tab.Layout = ContentLayout
        Tab.Accent = TabAccent
        Tab.Color = tabColor
        
        table.insert(Tabs, Tab)
        return Tab
    end
    
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    local minimized = false
    local originalSize = config.Size or UDim2.fromOffset(600, 400)
    
    local function ToggleMinimize()
        minimized = not minimized
        
        if minimized then
            Utils:Tween(MainFrame, {Size = UDim2.fromOffset(MainFrame.Size.X.Offset, 55)}, 0.3)
            Utils:Tween(StatusIndicator, {BackgroundColor3 = Color3.fromRGB(251, 146, 60)}, 0.2)
            Utils:Tween(StatusGlow, {BackgroundColor3 = Color3.fromRGB(251, 146, 60)}, 0.2)
            MinimizeButton.Image = Icons.Max
        else
            Utils:Tween(MainFrame, {Size = originalSize}, 0.3)
            Utils:Tween(StatusIndicator, {BackgroundColor3 = Color3.fromRGB(34, 197, 94)}, 0.2)
            Utils:Tween(StatusGlow, {BackgroundColor3 = Color3.fromRGB(34, 197, 94)}, 0.2)
            MinimizeButton.Image = Icons.Min
        end
    end
    
    MinimizeButton.MouseButton1Click:Connect(ToggleMinimize)
    
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == MinimizeKey then
            ToggleMinimize()
        end
    end)
    
    return Window
end

return Library
