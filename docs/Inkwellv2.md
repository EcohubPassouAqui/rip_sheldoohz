# Inkwell

```md
local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/projects/templates/Inkwell.luau"))()

if not module then
    return
end

local msg1 = module.print({
    message = "iniciando script dump",
    color = Color3.fromRGB(200, 200, 200),
})

local s = module.print_success("dump finalizado com sucesso")
local w = module.print_warning("bytecode v5 pode ter erros")
local e = module.print_error("falha ao decompile: script protegido")
local i = module.print_info("65 scripts encontrados no jogo")

if msg1 then
    msg1.update({
        message = "dump em andamento...",
        color = Color3.fromRGB(120, 180, 255),
    })
end

local bar = module.progressbar({
    message = "decompilando scripts",
    style = "block",
    bar_size = 10,
    show_percent = true,
})

if bar then
    for idx = 1, 65 do
        bar.set_message_and_progress(
            "decompilando scripts (" .. idx .. "/65)",
            math.floor(idx / 65 * 100)
        )

        task.wait()
    end

    bar.complete("decompilando scripts")
end

local spin = module.spinner({
    message = "buscando remotes no jogo",
    speed = 0.15,
})

if spin then
    task.wait(2)

    spin.set_message("analisando RemoteEvent e RemoteFunction")

    task.wait(2)

    spin.complete("remotes salvos com sucesso")
end

local grp = module.group("relatorio final")

if grp then
    grp.add("decompilados: 48")
    grp.add("via api: 12  |  via local: 36")
    grp.add("vazios: 17  |  total: 65")
    grp.add("api falhas: 0")
end

task.wait(5)

if bar then
    bar.cleanup()
end

if spin then
    spin.cleanup()
end

if grp then
    grp.cleanup()
end

if msg1 then
    msg1.cleanup()
end

if s then
    s.cleanup()
end

if w then
    w.cleanup()
end

if e then
    e.cleanup()
end

if i then
    i.cleanup()
end
```
