-- // Inkwell v2
local global_env = (typeof(getgenv) == "function" and getgenv()) or shared or _G or {}
if global_env["Inkwell"] then return global_env.Inkwell end

local cloneref = cloneref or clonereference or function(i) return i end

local RunService = cloneref(game:GetService("RunService"))
local LogService = cloneref(game:GetService("LogService"))
local CoreGui = cloneref(game:GetService("CoreGui"))

if not global_env._inkwell_counter then
    global_env._inkwell_counter = 3000
end

local module = { version = "2.0.0" }

local DEFAULT_COLOR = Color3.fromRGB(255, 255, 255)
local SUCCESS_COLOR = Color3.fromRGB(100, 220, 100)
local WARNING_COLOR = Color3.fromRGB(255, 200, 50)
local ERROR_COLOR = Color3.fromRGB(255, 80, 80)
local INFO_COLOR = Color3.fromRGB(100, 180, 255)

local CHAR_FULL = "\xe2\x96\x88"
local CHAR_EMPTY = "\xe2\x96\x91"
local CHAR_HALF = "\xe2\x96\x93"

local function get_guid()
    global_env._inkwell_counter = global_env._inkwell_counter + 1
    return tostring(global_env._inkwell_counter)
        .. tostring(tick())
        .. tostring(math.random(1000, 9999))
end

local function get_timestamp()
    return os.date("%H:%M:%S")
end

local function is_console_open()
    local master = CoreGui:FindFirstChild("DevConsoleMaster")
    if not master then return false end

    local window = master:FindFirstChild("DevConsoleWindow")
    if not window then return false end

    local ui = window:FindFirstChild("DevConsoleUI")
    if not ui then return false end

    local main = ui:FindFirstChild("MainView")
    if not main then return false end

    return main:FindFirstChild("ClientLog") ~= nil
end

local function get_console_ui()
    local ok, result = pcall(function()
        return CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI
    end)
    if ok then return result end
    return nil
end

local function find_message_index(UMID)
    local index = -1
    local tries = 0
    local max_try = 120

    repeat
        task.wait(0.05)
        tries = tries + 1

        for idx, entry in pairs(LogService:GetLogHistory()) do
            if tostring(entry.message) == tostring(UMID) then
                index = idx + 1
                break
            end
        end
    until index ~= -1 or tries >= max_try

    return index
end

local function resolve_params(...)
    local first = select(1, ...)

    if typeof(first) == "table" then
        local t = first
        local message = t.message or t.msg
        local image = t.image or t.img
        local color = t.color or t.clr

        if typeof(message) == "string" then message = message else message = nil end
        if typeof(image) == "string" then image = image else image = nil end
        if typeof(color) == "Color3" then color = color else color = nil end

        return message, image, color
    end

    local msg = select(1, ...)
    local img = select(2, ...)
    local clr = select(3, ...)

    local message = (typeof(msg) == "string") and msg or nil
    local image = (typeof(img) == "string") and img or nil
    local color = (typeof(clr) == "Color3") and clr or nil

    return message, image, color
end

function module.print(...)
    local message, image, color = resolve_params(...)
    message = message or ""
    image = image or ""
    color = color or DEFAULT_COLOR

    local timestamp = get_timestamp()
    local UMID = get_guid()

    print(UMID)

    local index = find_message_index(UMID)

    if index == -1 then
        warn("[Inkwell] mensagem nao encontrada no log history.")
        return nil
    end

    local ConsoleUI = nil
    local active = true

    local conn = RunService.RenderStepped:Connect(function()
        if not active then return end
        if not is_console_open() then return end

        if not ConsoleUI or not ConsoleUI.Parent then
            ConsoleUI = get_console_ui()
            if not ConsoleUI then return end
        end

        local log_frame = ConsoleUI.MainView.ClientLog:FindFirstChild(tostring(index))
        if not log_frame then return end

        local msg_label = log_frame:FindFirstChild("msg")
        local img_label = log_frame:FindFirstChild("image")
        if not msg_label or not img_label then return end

        msg_label.Text = timestamp .. " -- " .. message
        msg_label.TextColor3 = color
        msg_label.TextWrapped = true

        img_label.Image = image
        img_label.ImageColor3 = color
    end)

    local handle = {}

    function handle.update(...)
        local new_msg, new_img, new_clr = resolve_params(...)
        local update_ts = true

        if typeof(select(1, ...)) == "table" then
            local t = select(1, ...)
            if typeof(t.update_timestamp) == "boolean" then
                update_ts = t.update_timestamp
            end
        end

        if new_msg ~= nil then message = new_msg end
        if new_img ~= nil then image = new_img end
        if new_clr ~= nil then color = new_clr end

        if update_ts then
            timestamp = get_timestamp()
        end
    end

    function handle.set_message(msg)
        if typeof(msg) == "string" then message = msg end
    end

    function handle.set_color(clr)
        if typeof(clr) == "Color3" then color = clr end
    end

    function handle.set_image(img)
        if typeof(img) == "string" then image = img end
    end

    function handle.cleanup()
        if not active then return end
        active = false
        conn:Disconnect()
    end

    function handle.is_active()
        return active
    end

    return handle
end

function module.print_success(msg, img)
    return module.print(msg, img or "", SUCCESS_COLOR)
end

function module.print_warning(msg, img)
    return module.print(msg, img or "", WARNING_COLOR)
end

function module.print_error(msg, img)
    return module.print(msg, img or "", ERROR_COLOR)
end

function module.print_info(msg, img)
    return module.print(msg, img or "", INFO_COLOR)
end

function module.progressbar(params)
    if typeof(params) == "string" then
        params = { message = params }
    end
    params = params or {}

    local msg = params.message or params.msg or ""
    local img = params.image or params.img or ""
    local clr = params.color or params.clr or INFO_COLOR

    local style = params.style or "block"
    local bar_size = params.bar_size or 10
    local show_percent = params.show_percent ~= false

    local CHAR_ON = CHAR_FULL
    local CHAR_OFF = CHAR_EMPTY

    if style == "arrow" then
        CHAR_ON = "="
        CHAR_OFF = "-"
    elseif style == "dot" then
        CHAR_ON = "•"
        CHAR_OFF = "·"
    end

    local handle = module.print(msg, img, clr)
    if not handle then
        warn("[Inkwell] falha ao criar progressbar.")
        return nil
    end

    local current_progress = 0
    local current_msg = msg

    local bar = {}

    local function render_bar(progress)
        local normalized = math.min(math.max(progress, 0), 100)
        local filled_float = (normalized / 100) * bar_size
        local filled = math.floor(filled_float)
        local fraction = filled_float - filled
        local use_half = style == "block" and fraction >= 0.5

        local parts = {}
        for i = 1, bar_size do
            if i <= filled then
                parts[i] = CHAR_ON
            elseif i == filled + 1 and use_half then
                parts[i] = CHAR_HALF
            else
                parts[i] = CHAR_OFF
            end
        end

        local suffix = show_percent and (" " .. math.floor(normalized) .. "%") or ""
        return "[" .. table.concat(parts) .. "]" .. suffix
    end

    local function push()
        handle.update({
            message = current_msg .. " " .. render_bar(current_progress),
            image = img,
            color = clr,
            update_timestamp = false,
        })
    end

    function bar.set_progress(progress)
        if typeof(progress) ~= "number" then return end
        current_progress = progress
        push()
    end

    function bar.set_message(new_msg)
        if typeof(new_msg) ~= "string" then return end
        current_msg = new_msg
        push()
    end

    function bar.set_message_and_progress(new_msg, progress)
        if typeof(new_msg) == "string" then current_msg = new_msg end
        if typeof(progress) == "number" then current_progress = progress end
        push()
    end

    function bar.set_color(new_clr)
        if typeof(new_clr) ~= "Color3" then return end
        clr = new_clr
        handle.set_color(new_clr)
    end

    function bar.complete(final_msg)
        clr = SUCCESS_COLOR
        current_progress = 100
        if typeof(final_msg) == "string" then current_msg = final_msg end
        handle.update({
            message = current_msg .. " " .. render_bar(100),
            image = img,
            color = SUCCESS_COLOR,
            update_timestamp = true,
        })
    end

    function bar.fail(fail_msg)
        clr = ERROR_COLOR
        if typeof(fail_msg) == "string" then current_msg = fail_msg end
        handle.update({
            message = current_msg .. " " .. render_bar(current_progress),
            image = img,
            color = ERROR_COLOR,
            update_timestamp = true,
        })
    end

    function bar.get_progress()
        return current_progress
    end

    function bar.cleanup()
        handle.cleanup()
    end

    return bar
end

function module.spinner(params)
    if typeof(params) == "string" then
        params = { message = params }
    end
    params = params or {}

    local msg = params.message or params.msg or ""
    local img = params.image or params.img or ""
    local clr = params.color or params.clr or INFO_COLOR
    local speed = typeof(params.speed) == "number" and math.max(params.speed, 0.01) or 0.15

    local frames = { "|", "/", "-", "\\" }
    local frame = 1
    local active = true

    local handle = module.print(msg .. " " .. frames[frame], img, clr)
    if not handle then
        warn("[Inkwell] falha ao criar spinner.")
        return nil
    end

    task.spawn(function()
        while active do
            task.wait(speed)
            frame = (frame % #frames) + 1
            handle.set_message(msg .. " " .. frames[frame])
        end
    end)

    local spin = {}

    function spin.set_message(new_msg)
        if typeof(new_msg) == "string" then msg = new_msg end
    end

    function spin.set_color(new_clr)
        if typeof(new_clr) == "Color3" then handle.set_color(new_clr) end
    end

    function spin.complete(final_msg)
        if not active then return end
        active = false
        handle.update({
            message = (final_msg or msg) .. " concluido",
            color = SUCCESS_COLOR,
        })
    end

    function spin.fail(fail_msg)
        if not active then return end
        active = false
        handle.update({
            message = (fail_msg or msg) .. " falhou",
            color = ERROR_COLOR,
        })
    end

    function spin.cleanup()
        active = false
        handle.cleanup()
    end

    return spin
end

function module.group(label, clr)
    local header = module.print(
        "--- " .. (label or "grupo") .. " ---",
        "",
        clr or WARNING_COLOR
    )

    local entries = {}
    local group = { active = true }

    function group.add(...)
        local h = module.print(...)
        if h then table.insert(entries, h) end
        return h
    end

    function group.cleanup()
        if not group.active then return end
        group.active = false
        if header then header.cleanup() end
        for _, h in ipairs(entries) do
            if h and h.cleanup then h.cleanup() end
        end
    end

    return group
end

module.colors = {
    white = DEFAULT_COLOR,
    success = SUCCESS_COLOR,
    warning = WARNING_COLOR,
    error = ERROR_COLOR,
    info = INFO_COLOR,
}

module.custom_print = module.print
module.custom_console_progressbar = module.progressbar

global_env.Inkwell = module
global_env.inkwell = module
return module