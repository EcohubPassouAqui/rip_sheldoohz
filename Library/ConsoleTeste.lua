--[[

Copyright (C) 2025 github.com/donfushii
Powered By Imperium ♡
Debug Version - Para identificar problemas

--]]

local global_env = getgenv() or shared or _G or {}
if global_env["console_utils"] then return global_env.console_utils end

-- Debug: Verifica se funções existem
print("[DEBUG] Verificando funções...")
print("[DEBUG] getgenv:", getgenv ~= nil)
print("[DEBUG] cloneref:", cloneref ~= nil)
print("[DEBUG] task.wait:", task and task.wait ~= nil)

local cloneref = (cloneref or clonereference or function(instance: any) return instance end)

local RunService = cloneref(game:GetService("RunService"))
local LogService = cloneref(game:GetService("LogService"))
local CoreGui = cloneref(game:GetService("CoreGui"))

print("[DEBUG] Serviços carregados com sucesso")

if not global_env._console_message_counter then
    global_env._console_message_counter = 3000
end

local module = {}

function _internal_get_guid()
    global_env._console_message_counter = global_env._console_message_counter + 1
    return tostring(global_env._console_message_counter) .. tostring(tick())
end

function _internal_get_message_index(UMID)
    print("[DEBUG] Procurando índice para:", UMID)
    local message_index = -1
    local attempts = 0
    local max_attempts = 40
    
    repeat 
        task.wait(.05)
        attempts = attempts + 1
        
        local success, log_history = pcall(function()
            return LogService:GetLogHistory()
        end)
        
        if success and log_history then
            print("[DEBUG] Tentativa", attempts, "- Logs encontrados:", #log_history)
            for idx, data in pairs(log_history) do
                if tostring(data.message) == tostring(UMID) then
                    message_index = idx + 1
                    print("[DEBUG] ✅ Índice encontrado:", message_index)
                    break
                end
            end
        else
            print("[DEBUG] ❌ Falha ao obter histórico de logs")
        end
    until message_index ~= -1 or attempts >= max_attempts

    if message_index == -1 then
        print("[DEBUG] ❌ Índice não encontrado após", max_attempts, "tentativas")
    end

    return message_index
end

function _internal_is_console_open()
    local success, result = pcall(function()
        local console_master = CoreGui:FindFirstChild("DevConsoleMaster")
        if not console_master then
            return false
        end

        local window = console_master:FindFirstChild("DevConsoleWindow")
        if not window then
            return false
        end

        local dev_console_ui = window:FindFirstChild("DevConsoleUI")
        if not dev_console_ui then
            return false
        end

        return (dev_console_ui:FindFirstChild("MainView") and dev_console_ui.MainView:FindFirstChild("ClientLog"))
    end)
    
    return success and result
end

function module.custom_print(...)
    print("[DEBUG] custom_print chamado")
    
    local message = ""
    local image = ""
    local color = Color3.fromRGB(255, 255, 255)
    local timestamp = os.date("%H:%M:%S")

    if typeof(select(1, ...)) == "table" then
        local data = select(1, ...)
        message = typeof(data.message) == "string" and data.message or ""
        image = typeof(data.image) == "string" and data.image or ""
        color = typeof(data.color) == "Color3" and data.color or color
        print("[DEBUG] Modo tabela - Mensagem:", message)
    else
        local msg = select(1, ...)
        local img = select(2, ...)
        local clr = select(3, ...)

        message = typeof(msg) == "string" and msg or ""
        image = typeof(img) == "string" and img or ""
        color = typeof(clr) == "Color3" and clr or color
        print("[DEBUG] Modo argumentos - Mensagem:", message)
    end
    
    local UMID = _internal_get_guid()
    print(UMID)
    print("[DEBUG] UMID gerado:", UMID)
    
    local message_index = _internal_get_message_index(UMID)
    
    if message_index == -1 then
        warn("[Console] ❌ Falha ao encontrar índice da mensagem")
        print("[DEBUG] Retornando módulo vazio")
        return {
            update_message = function() end,
            cleanup = function() end
        }
    end
    
    print("[DEBUG] ✅ Índice válido, conectando ao RenderStepped")
    
    local ConsoleUI;
    local conn; 
    local is_connected = true
    local render_count = 0
    
    conn = RunService.RenderStepped:Connect(function()
        if not is_connected then return end
        
        render_count = render_count + 1
        if render_count % 60 == 0 then
            print("[DEBUG] RenderStepped rodando... (frame", render_count, ")")
        end
        
        local success, err = pcall(function()
            if _internal_is_console_open() then
                if render_count == 1 then
                    print("[DEBUG] ✅ Console está aberto!")
                end
                
                if not ConsoleUI or not ConsoleUI.Parent or not ConsoleUI:IsDescendantOf(CoreGui) then
                    ConsoleUI = CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI
                    print("[DEBUG] ConsoleUI atualizado")
                end
                
                local log = ConsoleUI.MainView.ClientLog:FindFirstChild(tostring(message_index))
                
                if not log then
                    return
                end

                local msg = log:FindFirstChild("msg")
                local img = log:FindFirstChild("image")

                if not msg or not img then
                    return
                end

                if render_count == 1 then
                    print("[DEBUG] ✅ Elementos encontrados, aplicando estilo")
                end

                msg.Text = timestamp .. " -- " .. message
                msg.TextColor3 = color
                msg.TextWrapped = true

                img.Image = image
                img.ImageColor3 = color
            else
                if render_count == 1 then
                    print("[DEBUG] ⚠️ Console não está aberto. Abra com F9 ou Fn+F9")
                end
            end
        end)
        
        if not success then
            print("[DEBUG] Erro no RenderStepped:", err)
        end
    end)

    print("[DEBUG] ✅ custom_print configurado com sucesso")

    local log_module = {}

    function log_module.update_message(...)
        print("[DEBUG] update_message chamado")
        local update_timestamp = true
        if typeof(select(1, ...)) == "table" then
            local data = select(1, ...)

            if typeof(data.message) == "string" then
                message = data.message
            end

            if typeof(data.image) == "string" then
                image = data.image
            end

            if typeof(data.color) == "Color3" then
                color = data.color
            end

            if typeof(data.update_timestamp) == "boolean" then
                update_timestamp = data.timestamp
            end
        else
            local msg = select(1, ...)
            local img = select(2, ...)
            local clr = select(3, ...)
            local update = select(4, ...)

            if typeof(msg) == "string" then
                message = msg
            end

            if typeof(img) == "string" then
                image = img
            end
            
            if typeof(clr) == "Color3" then
                color = clr
            end

            if typeof(update_timestamp) == "boolean" then
                update_timestamp = update
            end
        end

        if update_timestamp then
            timestamp = os.date("%H:%M:%S")
        end
        
        print("[DEBUG] Mensagem atualizada para:", message)
    end

    function log_module.cleanup()
        print("[DEBUG] cleanup chamado")
        is_connected = false
        if conn then
            pcall(function()
                conn:Disconnect()
            end)
        end
    end

    return log_module
end

function module.custom_console_progressbar(params)
    print("[DEBUG] custom_console_progressbar chamado")
    
    if typeof(params) == "string" then
        params = {msg = params}
    end

    local msg = params["msg"] or params["message"] or ""
    local clr = params["clr"] or params["color"] or Color3.fromRGB(255, 255, 255)
    local img = params["img"] or params["image"] or ""

    print("[DEBUG] Progressbar config - Mensagem:", msg)

    local progressbar_length = params["length"] or 10

    local progressbar_char = "█"
    local progressbar_empty = "░"

    local message = module.custom_print(msg, img, clr)
    local progress = 0

    local progressbar_module = {}

    function progressbar_module.update_message(_message, _image, _color)
        print("[DEBUG] progressbar update_message")
        message.update_message({
            message = _message,
            image = _image,
            color = _color,
            update_timestamp = false
        })
    end

    function progressbar_module.update_progress(_progress)
        print("[DEBUG] update_progress:", _progress)
        progress = _progress
        local progressbar_string = ""
    
        local normalized_progress = math.min(math.floor((_progress / 25) * 100), 100)
    
        for i = 1, 10 do
            if i <= (normalized_progress / 10) then
                progressbar_string = progressbar_string .. progressbar_char
            else
                progressbar_string = progressbar_string .. progressbar_empty
            end
        end
    
        message.update_message(msg .. " [" .. progressbar_string .. "] " .. normalized_progress .. "%", img, clr, false)
    end

    function progressbar_module.update_message_with_progress(_message, _progress)
        print("[DEBUG] update_message_with_progress")
        _progress = _progress or progress

        msg = _message
        progressbar_module.update_progress(_progress)
    end

    function progressbar_module.cleanup()
        print("[DEBUG] progressbar cleanup")
        message.cleanup()
    end

    return progressbar_module
end

global_env.console_utils = module
print("[DEBUG] ✅ Módulo console_utils registrado")
return module
