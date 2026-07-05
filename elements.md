# CODY WAS
```md
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/codywas/Codywas.lua"))()
local ui = Window.new()

local aimPage = ui:addTab({
    section = "Combat",
    tab = "Aim Assist",
    icon = "crosshair"
})

local section = ui:addSection(aimPage, "Configurações Principais")

ui:addCheckbox(section, {
    title = "Aim Assist",
    description = "Ativa o aim assist",
    default = true,
    callback = function(state)
        print("Checkbox:", state)
    end,
    keybind = {
        default = Enum.KeyCode.E,
        callback = function(key)
            print("Keybind:", key.Name)
        end
    },
    colorpick = {
        default = Color3.fromRGB(0, 220, 120),
        callback = function(color)
            print("Color:", color)
        end
    }
})

ui:addSlider(section, {
    title = "Sensibilidade",
    description = "Ajuste a sensibilidade",
    min = 10,
    max = 300,
    default = 143,
    callback = function(value)
        print("Slider:", value)
    end
})

ui:addDropdown(section, {
    title = "Alvo",
    list = {"Head", "HumanoidRootPart", "Torso"},
    default = "Head",
    callback = function(selected)
        print("Dropdown:", selected)
    end
})

ui:addButton(section, {
    title = "Executar Ação",
    callback = function()
        print("Button clicado!")
    end
})

local label = ui:addLabel(section, "Texto dinâmico aqui")
label:SetText("Novo texto")
label:SetColor(Color3.fromRGB(255, 100, 100))

local para = ui:addParagraph(section, {
    title = "Informação",
    content = "Este é um parágrafo de informação"
})
para:SetTitle("Novo Título")
para:SetContent("Novo conteúdo")

ui:addKeybind(section, {
    title = "Tecla de Atalho",
    default = Enum.KeyCode.K,
    callback = function(key)
        print("Keybind solitário:", key.Name)
    end
})

local checkbox = ui:addCheckbox(section, {title = "Test"})
checkbox:Set(true)
checkbox:SetColor(Color3.fromRGB(255, 0, 0))

local slider = ui:addSlider(section, {title = "Test Slider"})
slider:Set(50)

local dropdown = ui:addDropdown(section, {title = "Test Dropdown", list = {"A", "B"}})
dropdown:Set("A")

local button = ui:addButton(section, {title = "Test Button"})
button:SetText("Novo Texto")

local label2 = ui:addLabel(section, "Inicial")
label2:SetText("Novo")
label2:SetColor(Color3.fromRGB(0, 255, 0))

local para2 = ui:addParagraph(section, {title = "T", content = "C"})
para2:SetTitle("Novo Título")
para2:SetContent("Novo Conteúdo")

local keybind = ui:addKeybind(section, {title = "Test Keybind"})
keybind:Set(Enum.KeyCode.L)
```
# XAXAS-NOTIFICATIONS
```md
local notificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/core/Xaxas-notification.lua"))();
local notifications = notificationLibrary.new({            
    NotificationLifetime = 3, 
    NotificationPosition = "Middle",
    
    TextFont = Enum.Font.Code,
    TextColor = Color3.fromRGB(255, 255, 255),
    TextSize = 15,
    
    TextStrokeTransparency = 0, 
    TextStrokeColor = Color3.fromRGB(0, 0, 0)
});

notifications:BuildNotificationUI();
notifications:Notify("Hello notification test");
```

# NOTIFICATIONS
```md
local Notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/core/Notifications.lua"))();
local Notify = Notifications.Notify;

wait(1);

Notify({
Description = "This description is super long and should cause an overlap in wrapping";
Title = "Early | Wave 1";
Duration = 5;
});
```

# MODULE LIB
```md
local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/src/console/Console.lua"))()

local msg1 = module.print({
    message = "iniciando script dump",
    color   = Color3.fromRGB(200, 200, 200),
})

local s = module.print_success("dump finalizado com sucesso")
local w = module.print_warning("bytecode v5 pode ter erros")
local e = module.print_error("falha ao decompile: script protegido")
local i = module.print_info("65 scripts encontrados no jogo")

msg1.set_message("dump em andamento...")
msg1.set_color(Color3.fromRGB(120, 180, 255))

local bar = module.progressbar({
    message      = "decompilando scripts",
    style        = "block",
    bar_size     = 10,
    show_percent = true,
})

for i = 1, 65 do
    bar.set_message_and_progress(
        "decompilando scripts (" .. i .. "/65)",
        math.floor(i / 65 * 100)
    )
    task.wait()
end

bar.complete("decompilando scripts")

local spin = module.spinner({
    message = "buscando remotes no jogo",
    speed   = 0.15,
})

task.wait(2)
spin.set_message("analisando RemoteEvent e RemoteFunction")
task.wait(2)
spin.complete("remotes salvos com sucesso")

local grp = module.group("relatorio final")
grp.add("decompilados: 48")
grp.add("via api: 12  |  via local: 36")
grp.add("vazios: 17  |  total: 65")
grp.add("api falhas: 0")

task.wait(5)
bar.cleanup()
spin.cleanup()
grp.cleanup()
msg1.cleanup()
```
