local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/main/LIbraryOfc/Library.lua"))()


-- Exemplo de uso com os novos ícones
local Window = Library:CreateWindow({
    Title = "EcoHub",
    SubTitle = "discord.gg/ecohub - By rip_sheldoohz",
    TabWidth = 160,
    Size = UDim2.fromOffset(550, 500),
    MinimizeKey = Enum.KeyCode.K
})

-- Tabs com diferentes ícones
local MainTab = Window:AddTab({
    Name = "Main",
    Icon = "Home"
})

local SettingsTab = Window:AddTab({
    Name = "Settings",
    Icon = "Settings"
})

local PlayerTab = Window:AddTab({
    Name = "Player",
    Icon = "User"
})

local GameTab = Window:AddTab({
    Name = "Game",
    Icon = "Gamepad"
})

-- Exemplos de componentes
MainTab:AddSection({Name = "Main Features"})

MainTab:AddButton({
    Name = "Test Button",
    Callback = function()
        print("Button clicked")
    end
})

MainTab:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(value)
        print("Toggle:", value)
    end
})

MainTab:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Rounding = 1,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

MainTab:AddDivider()

MainTab:AddDropdown({
    Name = "Select Option",
    Options = {"Option 1", "Option 2", "Option 3"},
    Callback = function(option)
        print("Selected:", option)
    end
})

-- Settings Tab
SettingsTab:AddSection({Name = "UI Settings"})

SettingsTab:AddParagraph({
    Title = "Information",
    Content = "This is an example UI library with Lucide icons support. You can customize everything!"
})

SettingsTab:AddColorPicker({
    Name = "Accent Color",
    Default = Color3.fromRGB(0, 170, 255),
    Callback = function(color)
        print("Color changed:", color)
    end
})

SettingsTab:AddDivider({Text = "More Options"})

SettingsTab:AddLabel({
    Text = "Made with ❤️ by rip_sheldoohz"
})
