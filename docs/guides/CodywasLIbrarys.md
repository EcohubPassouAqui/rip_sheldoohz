# Codywas LIbrarys

```md
-- Librarys Codywas
local Librarys = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/library/CodywasLIbrarys.luau"))()

-- Window
local win = Librarys.new("Codywas", "by rip_sheldoohz | V1.0")

-- Tab Checkbox
local ElementsTab = win:CreateTab({
    tab = "CheckBox",
    section = "Librarys",
    icon = "check-square"
})

local CheckBoxSection = ElementsTab:CreateSection("Checkbox")

-- Simples
local toggle1 = CheckBoxSection:CreateToggle({
    title = "Wallbang",
    default = false,
    callback = function(state)
        print("Wallbang:", state)
    end,
})

-- Com descrição
local toggle2 = CheckBoxSection:CreateToggle({
    title = "God Mode",
    description = "Ativa invencibilidade",
    default = false,
    callback = function(state)
        print("God Mode:", state)
    end,
})

-- Com keybind teclado
local toggle3 = CheckBoxSection:CreateToggle({
    title = "Speed Hack",
    description = "Aumenta velocidade",
    default = false,
    keybind = Enum.KeyCode.G,
    callback = function(state)
        print("Speed:", state)
    end,
})

-- Com keybind e keybindCallback
local toggle4 = CheckBoxSection:CreateToggle({
    title = "Fly",
    description = "Ativa voo",
    default = false,
    keybind = Enum.KeyCode.F,
    keybindCallback = function(state)
        print("Pressionou F, estado:", state)
    end,
    callback = function(state)
        print("Fly:", state)
    end,
})

-- Com keybind mouse botão esquerdo
local toggle5 = CheckBoxSection:CreateToggle({
    title = "Aimbot",
    default = false,
    keybind = Enum.UserInputType.MouseButton1,
    callback = function(state)
        print("Aimbot:", state)
    end,
})

-- Com keybind mouse botão direito
local toggle6 = CheckBoxSection:CreateToggle({
    title = "ESP",
    default = false,
    keybind = Enum.UserInputType.MouseButton2,
    callback = function(state)
        print("ESP:", state)
    end,
})

-- Ativado por padrão
local toggle7 = CheckBoxSection:CreateToggle({
    title = "Auto Farm",
    default = true,
    callback = function(state)
        print("Auto Farm:", state)
    end,
})

-- Desabilitado
local toggle8 = CheckBoxSection:CreateToggle({
    title = "Bloqueado",
    default = false,
    disabled = true,
    callback = function(state) end,
})

-- API toggle
toggle1:Set(true)
toggle1:Set(false)
toggle1:Toggle()
toggle1:SetTitle("Wallbang ATIVO")
toggle2:SetDescription("Agora com dano 2x")
toggle8:SetDisabled(false)
toggle8:SetDisabled(true)
toggle3:SetKeybind(Enum.KeyCode.H)
toggle3:SetKeybind(Enum.UserInputType.MouseButton2)
toggle3:ClearKeybind()
toggle1:Destroy()

local estado = toggle1:Get()
local bind = toggle3:GetKeybind()

-- Tab Button
local ButtonTab = win:CreateTab({
    tab = "Button",
    section = "Librarys",
    icon = "mouse-pointer"
})

local ButtonSection = ButtonTab:CreateSection("Button")

-- Simples
local btn1 = ButtonSection:CreateButton({
    title = "Teleportar",
    callback = function()
        print("clicou")
    end,
})

-- Com descrição
local btn2 = ButtonSection:CreateButton({
    title = "Resetar Personagem",
    description = "Respawna no spawn inicial",
    callback = function()
        print("resetou")
    end,
})

-- Desabilitado
local btn3 = ButtonSection:CreateButton({
    title = "Bloqueado",
    disabled = true,
    callback = function() end,
})

-- API button
btn1:SetTitle("Novo Titulo")
btn2:SetDescription("Nova descricao")
btn3:SetDisabled(false)
btn1:Fire()

-- Tab Slider
local SliderTab = win:CreateTab({
    tab = "Slider",
    section = "Librarys",
    icon = "sliders"
})

local SliderSection = SliderTab:CreateSection("Slider")

-- Simples
local sliderBasico = SliderSection:CreateSlider({
    title = "Velocidade",
    min = 0,
    max = 100,
    default = 16,
    callback = function(value)
        print("Velocidade:", value)
    end,
})

-- Com descrição
local sliderDesc = SliderSection:CreateSlider({
    title = "Dano",
    description = "Multiplicador de dano do jogador",
    min = 1,
    max = 10,
    default = 1,
    callback = function(value)
        print("Dano:", value)
    end,
})

-- Com sufixo
local sliderSufixo = SliderSection:CreateSlider({
    title = "Volume",
    min = 0,
    max = 100,
    default = 50,
    suffix = "%",
    callback = function(value)
        print("Volume:", value)
    end,
})

-- Com decimais
local sliderDecimal = SliderSection:CreateSlider({
    title = "Gravidade",
    min = 0,
    max = 1,
    default = 0.5,
    rounding = 2,
    suffix = "x",
    callback = function(value)
        print("Gravidade:", value)
    end,
})

-- Desabilitado
local sliderDisabled = SliderSection:CreateSlider({
    title = "Bloqueado",
    min = 0,
    max = 100,
    default = 30,
    disabled = true,
    callback = function(value) end,
})

-- Completo
local sliderCompleto = SliderSection:CreateSlider({
    title = "Walk Speed",
    description = "Velocidade de caminhada",
    min = 0,
    max = 500,
    default = 16,
    rounding = 0,
    suffix = " sp",
    disabled = false,
    callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end,
})

-- API slider
sliderCompleto:Set(100)
sliderCompleto:SetMin(10)
sliderCompleto:SetMax(300)
sliderCompleto:SetSuffix(" km/h")
sliderCompleto:SetTitle("Speed")
sliderCompleto:SetDescription("Velocidade atualizada")
sliderCompleto:SetDisabled(true)
sliderCompleto:SetDisabled(false)

local atual = sliderCompleto:Get()

-- Tab Dropdown
local DropTab = win:CreateTab({
    tab = "Dropdown",
    section = "Librarys",
    icon = "list"
})

local DropSection = DropTab:CreateSection("Dropdown")

-- Simples
local dropBasico = DropSection:CreateDropdown({
    title = "Arma",
    values = { "Espada", "Arco", "Machado" },
    default = "Espada",
    callback = function(value)
        print("Arma:", value)
    end,
})

-- Com descrição
local dropDesc = DropSection:CreateDropdown({
    title = "Classe",
    description = "Escolha a classe do personagem",
    values = { "Guerreiro", "Mago", "Arqueiro" },
    default = "Guerreiro",
    callback = function(value)
        print("Classe:", value)
    end,
})

-- Multi seleção
local dropMulti = DropSection:CreateDropdown({
    title = "Efeitos Ativos",
    values = { "Velocidade", "Forca", "Invisibilidade", "Voo" },
    default = { "Velocidade", "Forca" },
    multi = true,
    callback = function(value)
        for efeito, ativo in pairs(value) do
            print(efeito, ativo)
        end
    end,
})

-- Desabilitado
local dropDisabled = DropSection:CreateDropdown({
    title = "Bloqueado",
    values = { "A", "B", "C" },
    default = "A",
    disabled = true,
    callback = function(value) end,
})

-- Completo
local dropCompleto = DropSection:CreateDropdown({
    title = "Time",
    description = "Escolha seu time",
    values = { "Azul", "Vermelho", "Verde" },
    default = "Azul",
    multi = false,
    disabled = false,
    callback = function(value)
        print("Time:", value)
    end,
})

-- Tab ColorPicker
local ColorTab = win:CreateTab({
    tab = "ColorPicker",
    section = "Librarys",
    icon = "palette"
})

local ColorSection = ColorTab:CreateSection("ColorPicker")

-- Simples
local cpBasico = ColorSection:CreateColorPicker({
    title = "Cor Principal",
    default = Color3.fromRGB(68, 120, 255),
    callback = function(color, transparency)
        print("Cor:", color)
    end,
})

-- Com descrição
local cpDesc = ColorSection:CreateColorPicker({
    title = "Cor do Personagem",
    description = "Escolha a cor do seu personagem",
    default = Color3.fromRGB(255, 80, 80),
    callback = function(color, transparency)
        print("Cor Personagem:", color)
    end,
})

-- Com transparência
local cpTransparency = ColorSection:CreateColorPicker({
    title = "Cor com Transparência",
    description = "Suporta transparência",
    default = Color3.fromRGB(80, 200, 120),
    transparency = 0.5,
    callback = function(color, transparency)
        print("Cor:", color, "Transparência:", transparency)
    end,
})

-- Desabilitado
local cpDisabled = ColorSection:CreateColorPicker({
    title = "Bloqueado",
    default = Color3.fromRGB(150, 150, 150),
    disabled = true,
    callback = function(color, transparency) end,
})

-- Completo
local cpCompleto = ColorSection:CreateColorPicker({
    title = "Cor do Time",
    description = "Escolha a cor do seu time",
    default = Color3.fromRGB(68, 120, 255),
    transparency = 0,
    disabled = false,
    callback = function(color, transparency)
        print("Time cor:", color, "alpha:", transparency)
    end,
})

-- Tab Paragraph
local ParaTab = win:CreateTab({
    tab = "Status",
    section = "Librarys",
    icon = "activity"
})

local ParaSection = ParaTab:CreateSection("Paragraph")

local player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

-- Status do servidor
local paraServidor = ParaSection:CreateParagraph({
    title = "Servidor • by rip_sheldoohz",
    description = "Carregando...",
})

-- Status do player com thumbnail em tempo real
local paraPlayer = ParaSection:CreateParagraph({
    title = player.DisplayName .. " (@" .. player.Name .. ")",
    description = "Carregando...",
    thumbnail = player.UserId,
})

local tick = 0

-- Atualiza tudo a cada 1 segundo
RunService.Heartbeat:Connect(function(dt)
    tick = tick + dt
    if tick < 1 then return end
    tick = 0

    -- Dados do servidor
    pcall(function()
        local plrs = game:GetService("Players")
        local total = #plrs:GetPlayers()
        local max = plrs.MaxPlayers
        local jobId = game.JobId ~= "" and game.JobId:sub(1, 20) .. "..." or "Privado"

        local ok, ping = pcall(function()
            return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        local pingStr = ok and (tostring(ping) .. " ms") or "N/A"

        local fps = math.floor(1 / dt)

        paraServidor:SetDescription(
            "Jogadores: " .. total .. " / " .. max .. "\n" ..
            "Job ID: " .. jobId .. "\n" ..
            "Ping: " .. pingStr .. "\n" ..
            "FPS: " .. fps
        )
    end)

    -- Dados do player
    pcall(function()
        local char = player.Character
        local humDesc = "Sem personagem"

        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            local lvl = player.leaderstats and player.leaderstats:FindFirstChild("Level")

            local hp = hum and (math.floor(hum.Health) .. " / " .. math.floor(hum.MaxHealth)) or "N/A"
            local walk = hum and tostring(hum.WalkSpeed) or "N/A"
            local jump = hum and tostring(hum.JumpPower) or "N/A"
            local nivel = lvl and tostring(lvl.Value) or "N/A"

            local pos = "N/A"
            if root then
                local p = root.Position
                pos = "X: " .. math.floor(p.X) .. " Y: " .. math.floor(p.Y) .. " Z: " .. math.floor(p.Z)
            end

            humDesc =
                "Vida: " .. hp .. "\n" ..
                "WalkSpeed: " .. walk .. "\n" ..
                "JumpPower: " .. jump .. "\n" ..
                "Nível: " .. nivel .. "\n" ..
                "Posição: " .. pos
        end

        paraPlayer:SetDescription(humDesc)
    end)
end)
```
