-- // rip_sheldoohz
-- // console_utils v2

local global_env = getgenv() or shared or _G or {}
if global_env["console_utils_v2"] then return global_env.console_utils_v2 end

local cloneref = cloneref or clonereference or function(i) return i end

local RunService = cloneref(game:GetService("RunService"))
local LogService = cloneref(game:GetService("LogService"))
local CoreGui    = cloneref(game:GetService("CoreGui"))

if not global_env._cutils_counter then
    global_env._cutils_counter = 3000
end

local module = {}

local DEFAULT_COLOR  = Color3.fromRGB(255, 255, 255)
local SUCCESS_COLOR  = Color3.fromRGB(100, 220, 100)
local WARNING_COLOR  = Color3.fromRGB(255, 200, 50)
local ERROR_COLOR    = Color3.fromRGB(255, 80, 80)
local INFO_COLOR     = Color3.fromRGB(100, 180, 255)

local CHAR_FULL  = "\xe2\x96\x88"
local CHAR_EMPTY = "\xe2\x96\x91"
local CHAR_HALF  = "\xe2\x96\x93"

local function get_guid()
    global_env._cutils_counter = global_env._cutils_counter + 1
    return tostring(global_env._cutils_counter)
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
    local index   = -1
    local tries   = 0
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
    local message = ""
    local image   = ""
    local color   = DEFAULT_COLOR

    local first = select(1, ...)

    if typeof(first) == "table" then
        local t = first
        if typeof(t.message) == "string" then message = t.message
        elseif typeof(t.msg)  == "string" then message = t.msg end

        if typeof(t.image) == "string" then image = t.image
        elseif typeof(t.img) == "string" then image = t.img end

        if typeof(t.color) == "Color3" then color = t.color
        elseif typeof(t.clr) == "Color3" then color = t.clr end
    else
        local msg = select(1, ...)
        local img = select(2, ...)
        local clr = select(3, ...)

        if typeof(msg) == "string" then message = msg end
        if typeof(img) == "string" then image   = img end
        if typeof(clr) == "Color3" then color   = clr end
    end

    return message, image, color
end

function module.print(...)
    local message, image, color = resolve_params(...)
    local timestamp = get_timestamp()
    local UMID = get_guid()

    print(UMID)

    local index = find_message_index(UMID)

    if index == -1 then
        warn("[console_utils] mensagem nao encontrada no log history.")
        return nil
    end

    local ConsoleUI = nil
    local active    = true

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

        msg_label.Text       = timestamp .. " -- " .. message
        msg_label.TextColor3 = color
        msg_label.TextWrapped = true

        img_label.Image      = image
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

        if new_msg ~= "" then message = new_msg end
        if new_img ~= "" then image   = new_img end
        if new_clr ~= DEFAULT_COLOR then color = new_clr end

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

    local msg = params.message or params.msg or ""
    local img = params.image   or params.img or ""
    local clr = params.color   or params.clr or INFO_COLOR

    local style        = params.style or "block"
    local bar_size     = params.bar_size or 10
    local show_percent = params.show_percent ~= false

    local CHAR_ON  = CHAR_FULL
    local CHAR_OFF = CHAR_EMPTY

    if style == "arrow" then
        CHAR_ON  = "="
        CHAR_OFF = "-"
    elseif style == "dot" then
        CHAR_ON  = "•"
        CHAR_OFF = "·"
    end

    local handle  = module.print(msg, img, clr)
    if not handle then
        warn("[console_utils] falha ao criar progressbar.")
        return nil
    end

    local current_progress = 0
    local current_msg      = msg

    local bar = {}

    local function render_bar(progress)
        local normalized = math.min(math.max(math.floor(progress), 0), 100)
        local filled     = math.floor((normalized / 100) * bar_size)
        local bar_str    = ""

        for i = 1, bar_size do
            if i <= filled then
                bar_str = bar_str .. CHAR_ON
            else
                bar_str = bar_str .. CHAR_OFF
            end
        end

        local suffix = show_percent and (" " .. normalized .. "%") or ""
        return "[" .. bar_str .. "]" .. suffix
    end

    function bar.set_progress(progress)
        current_progress = progress
        handle.update({
            message          = current_msg .. " " .. render_bar(progress),
            image            = img,
            color            = clr,
            update_timestamp = false,
        })
    end

    function bar.set_message(new_msg)
        current_msg = new_msg
        handle.update({
            message          = current_msg .. " " .. render_bar(current_progress),
            image            = img,
            color            = clr,
            update_timestamp = false,
        })
    end

    function bar.set_message_and_progress(new_msg, progress)
        current_msg      = new_msg
        current_progress = progress or current_progress
        handle.update({
            message          = current_msg .. " " .. render_bar(current_progress),
            image            = img,
            color            = clr,
            update_timestamp = false,
        })
    end

    function bar.set_color(new_clr)
        clr = new_clr
        handle.set_color(new_clr)
    end

    function bar.complete(final_msg)
        clr = SUCCESS_COLOR
        current_msg = final_msg or current_msg
        handle.update({
            message          = current_msg .. " " .. render_bar(100),
            image            = img,
            color            = SUCCESS_COLOR,
            update_timestamp = true,
        })
    end

    function bar.fail(fail_msg)
        clr = ERROR_COLOR
        current_msg = fail_msg or current_msg
        handle.update({
            message          = current_msg .. " " .. render_bar(current_progress),
            image            = img,
            color            = ERROR_COLOR,
            update_timestamp = true,
        })
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

    local msg    = params.message or params.msg or ""
    local img    = params.image   or params.img or ""
    local clr    = params.color   or params.clr or INFO_COLOR
    local speed  = params.speed   or 0.15

    local frames = { "|", "/", "-", "\\" }
    local frame  = 1
    local active = true

    local handle = module.print(msg .. " " .. frames[frame], img, clr)
    if not handle then
        warn("[console_utils] falha ao criar spinner.")
        return nil
    end

    local spin_conn = task.spawn(function()
        while active do
            task.wait(speed)
            frame = (frame % #frames) + 1
            handle.set_message(msg .. " " .. frames[frame])
        end
    end)

    local spin = {}

    function spin.set_message(new_msg)
        msg = new_msg
    end

    function spin.set_color(new_clr)
        handle.set_color(new_clr)
    end

    function spin.complete(final_msg)
        active = false
        handle.update({
            message = (final_msg or msg) .. " concluido",
            color   = SUCCESS_COLOR,
        })
    end

    function spin.fail(fail_msg)
        active = false
        handle.update({
            message = (fail_msg or msg) .. " falhou",
            color   = ERROR_COLOR,
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
    local group   = {}

    function group.add(...)
        local h = module.print(...)
        if h then table.insert(entries, h) end
        return h
    end

    function group.cleanup()
        if header then header.cleanup() end
        for _, h in ipairs(entries) do
            if h and h.cleanup then h.cleanup() end
        end
    end

    return group
end

module.colors = {
    white   = DEFAULT_COLOR,
    success = SUCCESS_COLOR,
    warning = WARNING_COLOR,
    error   = ERROR_COLOR,
    info    = INFO_COLOR,
}

module.custom_print              = module.print
module.custom_console_progressbar = module.progressbar

global_env.console_utils_v2 = module
global_env.console_utils     = module
return module
