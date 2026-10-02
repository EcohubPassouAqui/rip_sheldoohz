local API = "https://hwid.vertraweb.app/validate"
local SCRIPT_URL = "https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/games/MidnightChasers.luau"

local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Analytics = game:GetService("RbxAnalyticsService")

local env = getgenv()
local key = env.key
local id = env.id

local messages = {
    invalid_key = "Invalid key.",
    expired = "Your key has expired.",
    hwid_mismatch = "This key is bound to another device. Use /resethwid on Discord.",
    id_mismatch = "This key belongs to another Discord account.",
    bad_request = "Could not read your device ID.",
}

local function notify(text)
    warn("[Eco hub] " .. text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Eco hub",
            Text = text,
            Duration = 8,
        })
    end)
end

local function getHwid()
    local ok, value = pcall(function()
        if gethwid then
            return gethwid()
        end
        if get_hwid then
            return get_hwid()
        end
        return Analytics:GetClientId()
    end)
    if ok and value ~= nil and tostring(value) ~= "" then
        return tostring(value)
    end
    return nil
end

if type(key) ~= "string" or key == "" or type(id) ~= "string" or id == "" then
    notify("Set your key and id before running the script. (key: " .. typeof(key) .. ", id: " .. typeof(id) .. ")")
    return
end

local hwid = getHwid()
if not hwid then
    notify(messages.bad_request)
    return
end

local url = API
    .. "?key=" .. HttpService:UrlEncode(key)
    .. "&id=" .. HttpService:UrlEncode(id)
    .. "&hwid=" .. HttpService:UrlEncode(hwid)

local okRequest, body = pcall(function()
    return game:HttpGet(url)
end)
if not okRequest then
    notify("Could not reach the key server. Try again in a minute.")
    return
end

local okDecode, result = pcall(function()
    return HttpService:JSONDecode(body)
end)
if not okDecode or type(result) ~= "table" then
    notify("Invalid response from the key server.")
    return
end

if not result.ok then
    notify(messages[result.error] or "Key validation failed.")
    return
end

local okSource, source = pcall(function()
    return game:HttpGet(SCRIPT_URL)
end)
if not okSource then
    notify("Could not download the script.")
    return
end

local fn, loadError = loadstring(source)
if not fn then
    notify("Script error: " .. tostring(loadError))
    return
end

fn()