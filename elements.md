# Notifications
```md
local Notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/core/Notifications.lua"))();
local Notify = Notifications.Notify;
# Part 1
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
