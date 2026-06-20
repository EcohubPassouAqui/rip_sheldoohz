# CRYON
```md
local EcoHub = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/cryon/Lib.lua"
))()

local Window = EcoHub:CreateWindow({
	Title    = "Universal",
	SubTitle = "discord.gg/?",
})

local Tab = Window:AddTab({
	Name = "Hub",
	Sub  = "menu",
	Icon = "home",
})

local secLeft  = Tab:AddSection({ Box = "left",  Name = "Geral",  Icon = "home" })
local secRight = Tab:AddSection({ Box = "right", Name = "Visual", Icon = "eye" })

local togSpeedhack = secLeft:AddToggle({
	Title    = "Speedhack",
	Default  = false,
	SaveId   = "mx_speedhack",
	Callback = function(v)
		print("Speedhack:", v)
	end,
})

local chkSilencioso = secLeft:AddCheckbox({
	Title    = "Modo Silencioso",
	Default  = false,
	SaveId   = "mx_silencioso",
	Callback = function(v)
		print("Silencioso:", v)
	end,
})

local lblStatus = secLeft:AddLabel({
	Title  = "Status",
	Value  = "Inativo",
	SaveId = "mx_status",
})

local btnRecarregar = secLeft:AddButton({
	Title    = "Recarregar",
	Callback = function()
		lblStatus:Set("Recarregado")
	end,
})

local sldWalkSpeed = secLeft:AddSlider({
	Title    = "Walk Speed",
	Min      = 16,
	Max      = 500,
	Default  = 16,
	Rounding = 1,
	SaveId   = "mx_walkspeed",
	Callback = function(v)
		print("WalkSpeed:", v)
	end,
})

local cpESP = secLeft:AddColorPicker({
	Title    = "Cor ESP",
	Default  = Color3.fromRGB(255, 100, 50),
	SaveId   = "mx_cor_esp",
	Callback = function(c)
		print("CorESP:", c)
	end,
})

local ddParte = secLeft:AddDropdown({
	Title    = "Parte do Corpo",
	Options  = { "Head", "Torso", "HumanoidRootPart", "LeftArm", "RightArm" },
	Default  = "Head",
	SaveId   = "mx_parte_corpo",
	Callback = function(v)
		print("Parte:", v)
	end,
})

local togESP = secRight:AddToggle({
	Title    = "ESP Ativo",
	Default  = false,
	SaveId   = "mx_esp",
	Callback = function(v)
		print("ESP:", v)
	end,
})

local chkSilentAim = secRight:AddCheckbox({
	Title    = "Silent Aim",
	Default  = false,
	SaveId   = "mx_silent_aim",
	Callback = function(v)
		print("SilentAim:", v)
	end,
})

local lblKills = secRight:AddLabel({
	Title  = "Kills",
	Value  = "0",
	SaveId = "mx_kills",
})

local btnResetAim = secRight:AddButton({
	Title    = "Reset Aim",
	Callback = function()
		print("Reset!")
	end,
})

local sldFOV = secRight:AddSlider({
	Title    = "FOV",
	Min      = 10,
	Max      = 500,
	Default  = 120,
	Rounding = 5,
	SaveId   = "mx_fov",
	Callback = function(v)
		print("FOV:", v)
	end,
})

local cpAimColor = secRight:AddColorPicker({
	Title    = "Cor Aimbot",
	Default  = Color3.fromRGB(255, 50, 50),
	SaveId   = "mx_aim_color",
	Callback = function(c)
		print("AimColor:", c)
	end,
})

local ddChamsMode = secRight:AddDropdown({
	Title    = "Modo Chams",
	Options  = { "Flat", "Neon", "Glass" },
	Default  = "Flat",
	SaveId   = "mx_chams_mode",
	Callback = function(v)
		print("ChamsMode:", v)
	end,
})
```

# Notifications
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
local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/src/console/module.lua"))()

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
