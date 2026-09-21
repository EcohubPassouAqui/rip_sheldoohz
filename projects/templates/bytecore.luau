-- bytecore

local ok_notif, CodywasNotif = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/library/notifications/CodywasNotif.luau"))()
end)

local Notify
if ok_notif and CodywasNotif and CodywasNotif.Notify then
    Notify = CodywasNotif.Notify
else
    Notify = function(t)
        print("[bytecore] " .. tostring(t.Title) .. " | " .. tostring(t.Description))
    end
end

local HttpService = game:GetService("HttpService")

local function remove_accents(s)
    local map = {
        {"á","a"},{"à","a"},{"â","a"},{"ã","a"},{"ä","a"},
        {"é","e"},{"è","e"},{"ê","e"},{"ë","e"},
        {"í","i"},{"ì","i"},{"î","i"},{"ï","i"},
        {"ó","o"},{"ò","o"},{"ô","o"},{"õ","o"},{"ö","o"},
        {"ú","u"},{"ù","u"},{"û","u"},{"ü","u"},
        {"ç","c"},{"ñ","n"},
        {"Á","A"},{"À","A"},{"Â","A"},{"Ã","A"},{"Ä","A"},
        {"É","E"},{"È","E"},{"Ê","E"},{"Ë","E"},
        {"Í","I"},{"Ì","I"},{"Î","I"},{"Ï","I"},
        {"Ó","O"},{"Ò","O"},{"Ô","O"},{"Õ","O"},{"Ö","O"},
        {"Ú","U"},{"Ù","U"},{"Û","U"},{"Ü","U"},
        {"Ç","C"},{"Ñ","N"},
    }
    for _, pair in ipairs(map) do
        s = s:gsub(pair[1], pair[2])
    end
    return s
end

local function get_placeinfo()
    local placeId = game.PlaceId
    local gameName = "game"
    pcall(function()
        local info = game:GetService("MarketplaceService"):GetProductInfoAsync(placeId)
        if info and info.Name then
            gameName = info.Name:gsub('[^%w%-%_%. ]', "_"):gsub("%s+", " "):match("^%s*(.-)%s*$"):sub(1, 50)
            if gameName == "" or gameName:match("^%s*$") then gameName = "game" end
        end
    end)
    return placeId, gameName
end

local function build_root(gameName, placeId)
    return gameName .. "_" .. tostring(placeId)
end

local function sanitize(s)
    return tostring(s):gsub('[^%w%-%_%. ]', "_"):sub(1, 80)
end

local function build_path(obj)
    local t, c = {}, obj
    while c and c ~= game do
        local name = sanitize(c.Name)
        if name == "" or name:match("^%s*$") then name = "_" end
        table.insert(t, 1, name)
        c = c.Parent
    end
    return table.concat(t, "/")
end

local function get_extension(script)
    if script.ClassName == "LocalScript" then return ".client.lua" end
    if script.ClassName == "ModuleScript" then return ".lua" end
    return ".server.lua"
end

local function get_bytecode(script)
    local ok, bc = pcall(getscriptbytecode, script)
    if not ok or not bc or bc == "" then return nil end
    return bc
end

local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function base64_encode(data)
    local result = {}
    local len = #data
    for idx = 1, len, 3 do
        local b1 = data:byte(idx) or 0
        local b2 = data:byte(idx + 1) or 0
        local b3 = data:byte(idx + 2) or 0
        local n = b1 * 65536 + b2 * 256 + b3
        result[#result + 1] = b64chars:sub(math.floor(n / 262144) % 64 + 1, math.floor(n / 262144) % 64 + 1)
        result[#result + 1] = b64chars:sub(math.floor(n / 4096) % 64 + 1, math.floor(n / 4096) % 64 + 1)
        result[#result + 1] = (idx + 1 <= len) and b64chars:sub(math.floor(n / 64) % 64 + 1, math.floor(n / 64) % 64 + 1) or "="
        result[#result + 1] = (idx + 2 <= len) and b64chars:sub(n % 64 + 1, n % 64 + 1) or "="
    end
    return table.concat(result)
end

local apiCache, lastReq, apiOk, apiFail = {}, 0, 0, 0

local function is_valid_source(src)
    if not src or src == "" then return false end
    local lower = src:lower()
    if lower:find("^%s*$") then return false end
    if lower:find("unsupported") and not lower:find("local") then return false end
    if lower:find("^decompile error") then return false end
    if lower:find("^error:") then return false end
    return true
end

local function api_decompile(bc)
    local enc = base64_encode(bc)
    if apiCache[enc] then return apiCache[enc], "api" end

    local el = os.clock() - lastReq
    if el < 0.8 then task.wait(0.8 - el) end

    local ok, res = pcall(request, {
        Url = "https://api.lua.expert/decompile",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({script = enc}),
    })
    lastReq = os.clock()

    if ok and res and res.StatusCode == 200 and res.Body and res.Body ~= "" then
        local parseOk, parsed = pcall(HttpService.JSONDecode, HttpService, res.Body)
        local src
        if parseOk and type(parsed) == "table" then
            src = parsed.source or parsed.result or parsed.output or parsed.decompiled
        elseif not parseOk then
            src = res.Body
        end
        if is_valid_source(src) then
            apiCache[enc] = src
            apiOk = apiOk + 1
            return src, "api_lua_expert"
        end
    end

    local ok2, res2 = pcall(request, {
        Url = "https://lua-decompiler.ferib.dev/decompile",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({bytecode = enc}),
    })
    lastReq = os.clock()

    if ok2 and res2 and res2.StatusCode == 200 and res2.Body and res2.Body ~= "" then
        local parseOk2, parsed2 = pcall(HttpService.JSONDecode, HttpService, res2.Body)
        local src2
        if parseOk2 and type(parsed2) == "table" then
            src2 = parsed2.source or parsed2.result or parsed2.output or parsed2.decompiled or parsed2.code
        elseif not parseOk2 then
            src2 = res2.Body
        end
        if is_valid_source(src2) then
            apiCache[enc] = src2
            apiOk = apiOk + 1
            return src2, "api_ferib"
        end
    end

    apiFail = apiFail + 1
    return nil
end

local function extract_strings(bc)
    local result, seen, cur = {}, {}, ""
    for idx = 1, #bc do
        local b = bc:byte(idx)
        if b >= 32 and b <= 126 then
            cur = cur .. string.char(b)
        else
            if #cur >= 4 and not seen[cur] then
                seen[cur] = true
                table.insert(result, cur)
            end
            cur = ""
        end
    end
    if #cur >= 4 and not seen[cur] then
        table.insert(result, cur)
    end
    return result
end

local function extract_constants(script)
    local ok, closure = pcall(getscriptclosure, script)
    if not ok or not closure then return nil end
    local ok2, consts = pcall(debug.getconstants, closure)
    if not ok2 or not consts then return nil end
    local lines = {"-- constants via debug.getconstants"}
    for _, v in ipairs(consts) do
        if type(v) == "string" and #v >= 4 then
            table.insert(lines, v)
        end
    end
    if #lines <= 1 then return nil end
    return table.concat(lines, "\n"), "constants"
end

local intercepted = {}
local orig_loadstring = nil

local function hook_cb(src, chunkname)
    if type(src) == "string" and is_valid_source(src) and #src > 100 then
        local key = sanitize(tostring(chunkname or src:sub(1, 60)))
        if key ~= "" then intercepted[key] = src end
    end
    return orig_loadstring(src, chunkname)
end

if oth and oth.hook then
    orig_loadstring = oth.hook(loadstring, hook_cb)
elseif hookfunction then
    orig_loadstring = hookfunction(loadstring, newcclosure(hook_cb))
end

local function try_decompile(script, bc)
    local ver = bc and bc:byte(1) or 0
    local fullName = ""
    pcall(function() fullName = script:GetFullName() end)

    if intercepted[sanitize(fullName)] then
        return intercepted[sanitize(fullName)], "intercepted", ver
    end

    local ok1, src1 = pcall(decompile, script)
    if ok1 and is_valid_source(src1) then return src1, "local_direct", ver end

    local ok2, cl = pcall(getscriptclosure, script)
    if ok2 and cl then
        local ok3, src2 = pcall(decompile, cl)
        if ok3 and is_valid_source(src2) then return src2, "local_closure", ver end
    end

    local ok4, env = pcall(getsenv, script)
    if ok4 and env then
        for _, v in pairs(env) do
            if type(v) == "function" then
                local ok5, src3 = pcall(decompile, v)
                if ok5 and is_valid_source(src3) then return src3, "local_senv", ver end
            end
        end
    end

    local ok6, upvals = pcall(getupvalues, script)
    if ok6 and upvals then
        for _, v in pairs(upvals) do
            if type(v) == "function" then
                local ok7, src4 = pcall(decompile, v)
                if ok7 and is_valid_source(src4) then return src4, "local_upvalue", ver end
            end
        end
    end

    local ok8, protos = pcall(getprotos, script)
    if ok8 and protos then
        for _, proto in ipairs(protos) do
            local ok9, src5 = pcall(decompile, proto)
            if ok9 and is_valid_source(src5) then return src5, "local_proto", ver end
        end
    end

    if bc then
        local api_src, api_method = api_decompile(bc)
        if api_src then return api_src, api_method, ver end
    end

    local csrc, cmethod = extract_constants(script)
    if csrc then return csrc, cmethod, ver end

    local strs = extract_strings(bc)
    if #strs > 0 then
        local lines = {"bytecode v" .. ver}
        for _, s in ipairs(strs) do table.insert(lines, s) end
        return table.concat(lines, "\n"), "strings", ver
    end

    return nil, nil, ver
end

local function scan_remotes(src)
    local found, seen = {}, {}
    local pats = {
        ":FireServer", ":InvokeServer", ":FireClient",
        ":FireAllClients", ".OnServerEvent", ".OnClientEvent",
        ".OnServerInvoke", ".OnClientInvoke",
        "RemoteEvent", "RemoteFunction", "UnreliableRemoteEvent",
    }
    for _, p in ipairs(pats) do
        if src:find(p, 1, true) and not seen[p] then
            seen[p] = true
            table.insert(found, p)
        end
    end
    return found
end

local KEYWORDS = {
    farm = {"farm","collect","harvest","gather","auto","loop","repeat","while true","wait","task.wait","yield","gold","coin","cash","resource","ore","wood","fish","crop","plant","mine","chop","click","idle","rebirth","prestige","level","xp","exp","currency"},
    movement = {"speed","walkspeed","jump","jumppower","fly","noclip","teleport","tween","moveto","position","cframe","vehicle","sit","boost"},
    gui = {"screengui","frame","textlabel","textbutton","imagelabel","imagebutton","scrollingframe","uilistlayout","uipadding","uicorner","visible","enabled","toggle","menu","hub","panel","window","notify","notification","popup"},
    network = {"remotevent","remotefunction","fireserver","invokeserver","fireclient","fireallclients","onserverevent","onclientevent","unreliable","bindable","bind"},
    util = {"module","require","service","getservice","waitforchild","findfirstchild","findfirstchildofclass","getdescendants","getchildren","instance","new","clone","destroy","connect","disconnect","event"},
}

local function classify_script(src)
    if not src then return {} end
    local lower = src:lower()
    local tags = {}
    for cat, words in pairs(KEYWORDS) do
        local score = 0
        for _, w in ipairs(words) do
            if lower:find(w, 1, true) then score = score + 1 end
        end
        if score >= 2 then table.insert(tags, cat) end
    end
    return tags
end

local function ensure_dirs(path)
    local parts = {}
    for part in path:gmatch("[^/]+") do
        table.insert(parts, part)
    end
    local cur = ""
    for idx = 1, #parts - 1 do
        cur = cur == "" and parts[idx] or (cur .. "/" .. parts[idx])
        local ok = pcall(function()
            if not isfolder(cur) then
                makefolder(cur)
            end
        end)
        if not ok then return false end
    end
    return true
end

local function resolve_output_path(root, script, fpath, ext)
    local class = script.ClassName
    local base
    if class == "ModuleScript" then
        base = root .. "/Modules"
    elseif class == "Script" then
        base = root .. "/Functions"
    else
        base = root .. "/Scripts"
    end
    return base .. "/" .. fpath .. ext
end

local function write_file(path, content)
    if not ensure_dirs(path) then return end
    pcall(writefile, path, content)
end

local function already_dumped(root, script, fpath)
    local exts = {get_extension(script), ".txt"}
    for _, ext in ipairs(exts) do
        if isfile(resolve_output_path(root, script, fpath, ext)) then
            return true
        end
    end
    return false
end

local function collect_all_instances(class)
    local seen, result = {}, {}

    local function add_list(list)
        if not list then return end
        for _, inst in ipairs(list) do
            if inst.ClassName == class then
                local path = ""
                pcall(function() path = inst:GetFullName() end)
                if path ~= "" and not seen[path] then
                    seen[path] = true
                    table.insert(result, path)
                end
            end
        end
    end

    local ok1, desc = pcall(function() return game:GetDescendants() end)
    if ok1 then add_list(desc) end

    if getinstances then
        local ok2, all = pcall(getinstances)
        if ok2 then add_list(all) end
    end

    if getnilinstances then
        local ok3, nil_insts = pcall(getnilinstances)
        if ok3 then add_list(nil_insts) end
    end

    return result
end

if setstackhidden then
    pcall(setstackhidden, try_decompile, true)
    pcall(setstackhidden, api_decompile, true)
    pcall(setstackhidden, write_file, true)
    pcall(setstackhidden, hook_cb, true)
end

local placeId, gameName = get_placeinfo()
local displayName = remove_accents(gameName)
local ROOT = build_root(remove_accents(gameName), placeId)
local isResuming = isfolder(ROOT)

if not isResuming then
    local ok = pcall(makefolder, ROOT)
    if not ok then
        ROOT = "bytecore_" .. tostring(placeId)
        isResuming = isfolder(ROOT)
        if not isResuming then pcall(makefolder, ROOT) end
    end
end

Notify({
    Title = "bytecore",
    Description = (isResuming and "Continuando | " or "Iniciando | ") .. displayName .. " | " .. placeId,
    Duration = 5,
})

local scripts = getscripts()
local stats = {
    total = #scripts,
    decompiled = 0,
    api = 0,
    strings = 0,
    empty = 0,
    skipped = 0,
    versions = {},
    tags = {},
}

local scriptList = {}
local taggedList = {}
local remoteLogs = {}

for _, script in ipairs(scripts) do
    pcall(function()
        local fpath = build_path(script)
        if fpath == "" then return end

        local bc = get_bytecode(script)
        local ver = bc and bc:byte(1) or 0
        local vkey = "v" .. ver

        stats.versions[vkey] = (stats.versions[vkey] or 0) + 1
        table.insert(scriptList, "[" .. vkey .. "] " .. script.ClassName .. " " .. script:GetFullName())

        if not bc then
            stats.empty = stats.empty + 1
            return
        end

        if isResuming and already_dumped(ROOT, script, fpath) then
            stats.skipped = stats.skipped + 1
            return
        end

        local src, method = try_decompile(script, bc)

        if not src then
            stats.empty = stats.empty + 1
            return
        end

        local isStr = method and method:find("strings")
        local isAPI = method and method:find("api")
        local fileExt = isStr and ".txt" or get_extension(script)
        local filePath = resolve_output_path(ROOT, script, fpath, fileExt)

        write_file(filePath, src)

        local tags = classify_script(src)
        if #tags > 0 then
            table.insert(taggedList, table.concat(tags, " | ") .. " | " .. script:GetFullName())
            for _, t in ipairs(tags) do
                stats.tags[t] = (stats.tags[t] or 0) + 1
            end
        end

        local calls = scan_remotes(src)
        if #calls > 0 then
            remoteLogs[script:GetFullName()] = calls
        end

        if isStr then
            stats.strings = stats.strings + 1
        elseif isAPI then
            stats.api = stats.api + 1
            stats.decompiled = stats.decompiled + 1
        else
            stats.decompiled = stats.decompiled + 1
        end
    end)
end

for name, src in pairs(intercepted) do
    pcall(function()
        if name ~= "" then
            write_file(ROOT .. "/Intercepted/" .. name .. ".lua", src)
        end
    end)
end

if oth and oth.unhook and orig_loadstring then
    pcall(oth.unhook, loadstring)
elseif orig_loadstring and restorefunction then
    pcall(restorefunction, loadstring)
end

if #scriptList > 0 then
    write_file(ROOT .. "/Info/scripts.txt", table.concat(scriptList, "\n"))
end
if #taggedList > 0 then
    write_file(ROOT .. "/Info/tagged.txt", table.concat(taggedList, "\n"))
end

local skipMsg = stats.skipped > 0 and (" | Pulados: " .. stats.skipped) or ""
Notify({
    Title = "bytecore | Scripts",
    Description = "Decompilados: " .. stats.decompiled .. " | API: " .. stats.api .. " | Strings: " .. stats.strings .. " | Vazios: " .. stats.empty .. skipMsg,
    Duration = 6,
})

local remoteClasses = {"RemoteEvent", "RemoteFunction", "UnreliableRemoteEvent", "BindableEvent", "BindableFunction"}
local allRemoteLines = {}
local totalRemotes = 0

for _, class in ipairs(remoteClasses) do
    local paths = collect_all_instances(class)
    if #paths > 0 then
        totalRemotes = totalRemotes + #paths
        local lines = {class .. " (" .. #paths .. ")"}
        for _, p in ipairs(paths) do table.insert(lines, "  " .. p) end
        local content = table.concat(lines, "\n")
        write_file(ROOT .. "/Remotes/" .. class .. ".txt", content)
        table.insert(allRemoteLines, content)
    end
end

if #allRemoteLines > 0 then
    write_file(ROOT .. "/Remotes/todos.txt", table.concat(allRemoteLines, "\n\n"))
end

if next(remoteLogs) then
    local lines = {"chamadas de remotes detectadas\n"}
    for path, calls in pairs(remoteLogs) do
        table.insert(lines, path)
        for _, c in ipairs(calls) do table.insert(lines, "  " .. c) end
    end
    write_file(ROOT .. "/Remotes/calls.txt", table.concat(lines, "\n"))
end

Notify({
    Title = "bytecore | Remotes",
    Description = "Total: " .. totalRemotes .. " | API ok: " .. apiOk .. " | Falhas: " .. apiFail,
    Duration = 5,
})

local dominant, maxCount = "nenhum", 0
for v, count in pairs(stats.versions) do
    if count > maxCount then
        maxCount = count
        dominant = v
    end
end

task.wait(1)

Notify({
    Title = "bytecore | Finalizado",
    Description = displayName .. " | " .. placeId .. " | Versao: " .. dominant,
    Duration = 8,
})