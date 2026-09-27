-- // Inkwell v2
local global_env = (typeof(getgenv) == "function" and getgenv()) or shared or _G or {}

if global_env.Inkwell then
    return global_env.Inkwell
end

local cloneref = cloneref or clonereference or function(v)
    return v
end

local RunService = cloneref(game:GetService("RunService"))
local LogService = cloneref(game:GetService("LogService"))
local CoreGui = cloneref(game:GetService("CoreGui"))

global_env._inkwell_counter = tonumber(global_env._inkwell_counter) or 3000

local module = {
    version = "2.1.0"
}

local DEFAULT_COLOR = Color3.fromRGB(255, 255, 255)
local SUCCESS_COLOR = Color3.fromRGB(100, 220, 100)
local WARNING_COLOR = Color3.fromRGB(255, 200, 50)
local ERROR_COLOR = Color3.fromRGB(255, 80, 80)
local INFO_COLOR = Color3.fromRGB(100, 180, 255)

local CHAR_FULL = "█"
local CHAR_EMPTY = "░"
local CHAR_HALF = "▓"

local function get_id()
    global_env._inkwell_counter += 1
    return tostring(global_env._inkwell_counter) .. tostring(math.floor(os.clock() * 1000)) .. tostring(math.random(1000, 9999))
end

local function get_timestamp()
    return os.date("%H:%M:%S")
end

local function get_console_ui()
    local ok, result = pcall(function()
        local master = CoreGui:FindFirstChild("DevConsoleMaster")
        if not master then
            return nil
        end

        local window = master:FindFirstChild("DevConsoleWindow")
        if not window then
            return nil
        end

        local ui = window:FindFirstChild("DevConsoleUI")
        if not ui then
            return nil
        end

        return ui
    end)

    return ok and result or nil
end

local function get_log_history()
    local ok, result = pcall(function()
        return LogService:GetLogHistory()
    end)

    if not ok or typeof(result) ~= "table" then
        return {}
    end

    return result
end

local function find_message_index(id)
    for _ = 1, 120 do
        local history = get_log_history()

        for index, entry in ipairs(history) do
            if entry and tostring(entry.message) == tostring(id) then
                return index + 1
            end
        end

        task.wait(0.05)
    end

    return nil
end

local function resolve_params(...)
    local first = select(1, ...)

    if typeof(first) == "table" then
        local message = first.message
        if message == nil then
            message = first.msg
        end

        local image = first.image
        if image == nil then
            image = first.img
        end

        local color = first.color
        if color == nil then
            color = first.clr
        end

        return
            typeof(message) == "string" and message or nil,
            typeof(image) == "string" and image or nil,
            typeof(color) == "Color3" and color or nil
    end

    local message = select(1, ...)
    local image = select(2, ...)
    local color = select(3, ...)

    return
        typeof(message) == "string" and message or nil,
        typeof(image) == "string" and image or nil,
        typeof(color) == "Color3" and color or nil
end

local function find_log_frame(console_ui, index)
    if not console_ui or not console_ui.Parent then
        return nil
    end

    local main = console_ui:FindFirstChild("MainView")
    if not main then
        return nil
    end

    local client_log = main:FindFirstChild("ClientLog")
    if not client_log then
        return nil
    end

    return client_log:FindFirstChild(tostring(index))
end

function module.print(...)
    local message, image, color = resolve_params(...)

    message = message or ""
    image = image or ""
    color = color or DEFAULT_COLOR

    local timestamp = get_timestamp()
    local id = get_id()

    print(id)

    local index = find_message_index(id)

    if not index then
        return nil
    end

    local active = true
    local console_ui
    local connection

    local handle = {}

    local function update_console()
        if not active then
            return
        end

        if not console_ui or not console_ui.Parent then
            console_ui = get_console_ui()
        end

        if not console_ui then
            return
        end

        local frame = find_log_frame(console_ui, index)
        if not frame then
            return
        end

        local msg_label = frame:FindFirstChild("msg")
        local image_label = frame:FindFirstChild("image")

        if msg_label then
            pcall(function()
                msg_label.Text = timestamp .. " -- " .. message
                msg_label.TextColor3 = color
                msg_label.TextWrapped = true
            end)
        end

        if image_label then
            pcall(function()
                image_label.Image = image
                image_label.ImageColor3 = color
            end)
        end
    end

    connection = RunService.RenderStepped:Connect(update_console)

    function handle.update(...)
        local new_message, new_image, new_color = resolve_params(...)
        local update_timestamp = true

        local first = select(1, ...)

        if typeof(first) == "table" and typeof(first.update_timestamp) == "boolean" then
            update_timestamp = first.update_timestamp
        end

        if new_message ~= nil then
            message = new_message
        end

        if new_image ~= nil then
            image = new_image
        end

        if new_color ~= nil then
            color = new_color
        end

        if update_timestamp then
            timestamp = get_timestamp()
        end
    end

    function handle.set_message(value)
        if typeof(value) == "string" then
            message = value
        end
    end

    function handle.set_color(value)
        if typeof(value) == "Color3" then
            color = value
        end
    end

    function handle.set_image(value)
        if typeof(value) == "string" then
            image = value
        end
    end

    function handle.cleanup()
        if not active then
            return
        end

        active = false

        if connection then
            connection:Disconnect()
            connection = nil
        end
    end

    function handle.is_active()
        return active
    end

    return handle
end

function module.print_success(message, image)
    return module.print(message, image or "", SUCCESS_COLOR)
end

function module.print_warning(message, image)
    return module.print(message, image or "", WARNING_COLOR)
end

function module.print_error(message, image)
    return module.print(message, image or "", ERROR_COLOR)
end

function module.print_info(message, image)
    return module.print(message, image or "", INFO_COLOR)
end

function module.progressbar(params)
    if typeof(params) == "string" then
        params = {
            message = params
        }
    end

    params = params or {}

    local message = params.message or params.msg or ""
    local image = params.image or params.img or ""
    local color = params.color or params.clr or INFO_COLOR

    local style = params.style or "block"
    local bar_size = math.max(1, math.floor(tonumber(params.bar_size) or 10))
    local show_percent = params.show_percent ~= false

    local char_on = CHAR_FULL
    local char_off = CHAR_EMPTY

    if style == "arrow" then
        char_on = "="
        char_off = "-"
    elseif style == "dot" then
        char_on = "•"
        char_off = "·"
    end

    local handle = module.print(message, image, color)

    if not handle then
        return nil
    end

    local current_progress = 0
    local current_message = message

    local bar = {}

    local function normalize(value)
        return math.clamp(value, 0, 100)
    end

    local function render(value)
        value = normalize(value)

        local amount = (value / 100) * bar_size
        local filled = math.floor(amount)
        local fraction = amount - filled
        local half = style == "block" and fraction >= 0.5

        local parts = table.create(bar_size)

        for i = 1, bar_size do
            if i <= filled then
                parts[i] = char_on
            elseif i == filled + 1 and half then
                parts[i] = CHAR_HALF
            else
                parts[i] = char_off
            end
        end

        local percent = ""

        if show_percent then
            percent = " " .. math.floor(value) .. "%"
        end

        return "[" .. table.concat(parts) .. "]" .. percent
    end

    local function push(update_timestamp)
        handle.update({
            message = current_message .. " " .. render(current_progress),
            image = image,
            color = color,
            update_timestamp = update_timestamp == true
        })
    end

    function bar.set_progress(value)
        if typeof(value) ~= "number" then
            return
        end

        current_progress = normalize(value)
        push(false)
    end

    function bar.set_message(value)
        if typeof(value) ~= "string" then
            return
        end

        current_message = value
        push(false)
    end

    function bar.set_message_and_progress(new_message, value)
        if typeof(new_message) == "string" then
            current_message = new_message
        end

        if typeof(value) == "number" then
            current_progress = normalize(value)
        end

        push(false)
    end

    function bar.set_color(value)
        if typeof(value) ~= "Color3" then
            return
        end

        color = value
        handle.set_color(value)
    end

    function bar.complete(final_message)
        current_progress = 100
        color = SUCCESS_COLOR

        if typeof(final_message) == "string" then
            current_message = final_message
        end

        push(true)
    end

    function bar.fail(final_message)
        color = ERROR_COLOR

        if typeof(final_message) == "string" then
            current_message = final_message
        end

        push(true)
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
        params = {
            message = params
        }
    end

    params = params or {}

    local message = params.message or params.msg or ""
    local image = params.image or params.img or ""
    local color = params.color or params.clr or INFO_COLOR

    local speed = tonumber(params.speed) or 0.15
    speed = math.max(speed, 0.01)

    local frames = {
        "|",
        "/",
        "-",
        "\\"
    }

    local frame = 1
    local active = true

    local handle = module.print(
        message .. " " .. frames[frame],
        image,
        color
    )

    if not handle then
        return nil
    end

    local spinner = {}

    task.spawn(function()
        while active and handle.is_active() do
            task.wait(speed)

            if not active then
                break
            end

            frame = frame % #frames + 1
            handle.set_message(message .. " " .. frames[frame])
        end
    end)

    function spinner.set_message(value)
        if typeof(value) == "string" then
            message = value
        end
    end

    function spinner.set_color(value)
        if typeof(value) == "Color3" then
            color = value
            handle.set_color(value)
        end
    end

    function spinner.complete(final_message)
        if not active then
            return
        end

        active = false

        if typeof(final_message) ~= "string" then
            final_message = message
        end

        handle.update({
            message = final_message .. " concluido",
            color = SUCCESS_COLOR,
            update_timestamp = true
        })
    end

    function spinner.fail(final_message)
        if not active then
            return
        end

        active = false

        if typeof(final_message) ~= "string" then
            final_message = message
        end

        handle.update({
            message = final_message .. " falhou",
            color = ERROR_COLOR,
            update_timestamp = true
        })
    end

    function spinner.cleanup()
        active = false
        handle.cleanup()
    end

    return spinner
end

function module.group(label, color)
    local header = module.print(
        "--- " .. tostring(label or "grupo") .. " ---",
        "",
        color or WARNING_COLOR
    )

    local entries = {}
    local active = true

    local group = {
        active = true
    }

    function group.add(...)
        if not active then
            return nil
        end

        local handle = module.print(...)

        if handle then
            table.insert(entries, handle)
        end

        return handle
    end

    function group.cleanup()
        if not active then
            return
        end

        active = false
        group.active = false

        if header then
            header.cleanup()
        end

        for _, handle in ipairs(entries) do
            if handle then
                handle.cleanup()
            end
        end

        table.clear(entries)
    end

    return group
end

module.colors = {
    white = DEFAULT_COLOR,
    success = SUCCESS_COLOR,
    warning = WARNING_COLOR,
    error = ERROR_COLOR,
    info = INFO_COLOR
}

module.custom_print = module.print
module.custom_console_progressbar = module.progressbar

global_env.Inkwell = module
global_env.inkwell = module

return module