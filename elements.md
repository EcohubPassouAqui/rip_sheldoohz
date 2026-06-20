

# MODULE LIB
```md
-- Module
local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/src/console/module.lua"))()

-- print simples com cor personalizada
local msg1 = module.print({
    message = "iniciando script dump",
    color   = Color3.fromRGB(200, 200, 200),
})

-- tipos prontos (success / warning / error / info)
local s = module.print_success("dump finalizado com sucesso")
local w = module.print_warning("bytecode v5 pode ter erros")
local e = module.print_error("falha ao decompile: script protegido")
local i = module.print_info("65 scripts encontrados no jogo")

-- atualizar mensagem em tempo real
msg1.set_message("dump em andamento...")
msg1.set_color(Color3.fromRGB(120, 180, 255))

-- progressbar com estilo block (padrao)
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

-- spinner enquanto busca remotes
local spin = module.spinner({
    message = "buscando remotes no jogo",
    speed   = 0.15,
})

task.wait(2)
spin.set_message("analisando RemoteEvent e RemoteFunction")
task.wait(2)
spin.complete("remotes salvos com sucesso")

-- grupo para relatorio final
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
