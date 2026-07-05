-- // Dump v1.0
local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/src/console/Console.lua"))()

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- // get_placeinfo
local function get_placeinfo()
	local placeId = game.PlaceId
	local gameName = "game_" .. placeId
	
	pcall(function()
		local info = game:GetService("MarketplaceService"):GetProductInfoAsync(placeId)
		if info and info.Name then
			gameName = info.Name:gsub('[<>:"/\\|?*%z%c]', "_"):sub(1, 60)
		end
	end)
	
	return placeId, gameName
end

-- // setup_folders
local function setup_folders(root)
	local folders = {root, root .. "/Scripts", root .. "/Remotes", root .. "/Info", root .. "/Modules", root .. "/Functions"}
	for _, f in ipairs(folders) do
		if not isfolder(f) then
			makefolder(f)
		end
	end
end

-- // sanitize
local function sanitize(s)
	return tostring(s):gsub('[<>:"/\\|?*%z%c]', "_"):sub(1, 80)
end

-- // build_path
local function build_path(obj)
	local t, c = {}, obj
	while c and c ~= game do
		table.insert(t, 1, sanitize(c.Name))
		c = c.Parent
	end
	return table.concat(t, "/")
end

-- // get_extension
local function get_extension(script)
	if script.ClassName == "LocalScript" then
		return ".client.lua"
	end
	if script.ClassName == "ModuleScript" then
		return ".lua"
	end
	return ".server.lua"
end

-- // get_bytecode
local function get_bytecode(script)
	local ok, bc = pcall(getscriptbytecode, script)
	if not ok or not bc or bc == "" then
		return nil
	end
	return bc
end

-- // base64_encode
local function base64_encode(data)
	local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	return ((data:gsub(".", function(x)
		local r, byte = "", x:byte()
		for i = 8, 1, -1 do
			r = r .. (byte % 2 ^ i - byte % 2 ^ (i - 1) > 0 and "1" or "0")
		end
		return r
	end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
		if #x < 6 then return "" end
		local c = 0
		for i = 1, 6 do
			c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
		end
		return b:sub(c + 1, c + 1)
	end) .. ({"", "==", "="})[#data % 3 + 1])
end

-- // api_decompile
local apiCache, lastReq, apiOk, apiFail = {}, 0, 0, 0

local function api_decompile(bc)
	local enc = base64_encode(bc)
	if apiCache[enc] then
		return apiCache[enc], "api"
	end
	
	local el = os.clock() - lastReq
	if el < 0.6 then
		task.wait(0.6 - el)
	end
	
	local ok, res = pcall(request, {
		Url = "https://api.lua.expert/decompile",
		Method = "POST",
		Headers = {["content-type"] = "application/json"},
		Body = HttpService:JSONEncode({script = enc}),
	})
	
	lastReq = os.clock()
	if not ok or not res or res.StatusCode ~= 200 then
		apiFail = apiFail + 1
		return nil
	end
	
	local src = res.Body
	if not src or src == "" or src:find("error", 1, true) then
		apiFail = apiFail + 1
		return nil
	end
	
	apiCache[enc] = src
	apiOk = apiOk + 1
	return src, "api"
end

-- // extract_strings
local function extract_strings(bc)
	local result, seen, cur = {}, {}, ""
	for i = 1, #bc do
		local b = string.byte(bc, i)
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

-- // try_decompile
local function try_decompile(script, bc)
	local ver = string.byte(bc, 1)
	
	local ok1, src1 = pcall(decompile, script)
	if ok1 and src1 and src1 ~= "" and not src1:find("Unsupported") and not src1:find("error") then
		return src1, "local_direct", ver
	end
	
	local ok2, cl = pcall(getscriptclosure, script)
	if ok2 and cl then
		local ok3, src2 = pcall(decompile, cl)
		if ok3 and src2 and src2 ~= "" and not src2:find("Unsupported") and not src2:find("error") then
			return src2, "local_closure", ver
		end
	end
	
	local ok4, env = pcall(getsenv, script)
	if ok4 and env then
		for _, v in pairs(env) do
			if type(v) == "function" then
				local ok5, src3 = pcall(decompile, v)
				if ok5 and src3 and src3 ~= "" and not src3:find("Unsupported") and not src3:find("error") then
					return src3, "local_senv", ver
				end
			end
		end
	end
	
	local ok6, upvals = pcall(getupvalues, script)
	if ok6 and upvals then
		for _, v in pairs(upvals) do
			if type(v) == "function" then
				local ok7, src4 = pcall(decompile, v)
				if ok7 and src4 and src4 ~= "" and not src4:find("Unsupported") and not src4:find("error") then
					return src4, "local_upvalue", ver
				end
			end
		end
	end
	
	local ok8, protos = pcall(getprotos, script)
	if ok8 and protos then
		for _, proto in ipairs(protos) do
			local ok9, src5 = pcall(decompile, proto)
			if ok9 and src5 and src5 ~= "" and not src5:find("Unsupported") and not src5:find("error") then
				return src5, "local_proto", ver
			end
		end
	end
	
	local api_src, api_method = api_decompile(bc)
	if api_src then
		return api_src, api_method, ver
	end
	
	local strs = extract_strings(bc)
	if #strs > 0 then
		local lines = {"bytecode v" .. ver}
		for _, s in ipairs(strs) do
			table.insert(lines, s)
		end
		return table.concat(lines, "\n"), "strings", ver
	end
	
	return nil, nil, ver
end

-- // scan_remotes
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

-- // classify_script
local KEYWORDS = {
	farm = {"farm", "collect", "harvest", "gather", "auto", "loop", "repeat", "while true", "wait", "task.wait", "yield", "gold", "coin", "cash", "resource", "ore", "wood", "fish", "crop", "plant", "mine", "chop", "click", "idle", "rebirth", "prestige", "level", "xp", "exp", "currency"},
	movement = {"speed", "walkspeed", "jump", "jumppower", "fly", "noclip", "teleport", "tween", "moveto", "position", "cframe", "vehicle", "sit", "boost"},
	gui = {"screengui", "frame", "textlabel", "textbutton", "imagelabel", "imagebutton", "scrollingframe", "uilistlayout", "uipadding", "uicorner", "visible", "enabled", "toggle", "menu", "hub", "panel", "window", "notify", "notification", "popup"},
	network = {"remotevent", "remotefunction", "fireserver", "invokeserver", "fireclient", "fireallclients", "onserverevent", "onclientevent", "unreliable", "bindable", "bind"},
	util = {"module", "require", "service", "getservice", "waitforchild", "findfirstchild", "findfirstchildofclass", "getdescendants", "getchildren", "instance", "new", "clone", "destroy", "connect", "disconnect", "event"},
}

local function classify_script(src)
	if not src then
		return {}
	end
	local lower = src:lower()
	local tags = {}
	for cat, words in pairs(KEYWORDS) do
		local score = 0
		for _, w in ipairs(words) do
			if lower:find(w, 1, true) then
				score = score + 1
			end
		end
		if score >= 2 then
			table.insert(tags, cat)
		end
	end
	return tags
end

-- // mkdir
local function mkdir(base, fpath)
	local parts = string.split(fpath, "/")
	local cur = base
	for i = 1, #parts - 1 do
		cur = cur .. "/" .. parts[i]
		if not isfolder(cur) then
			makefolder(cur)
		end
	end
end

-- // main
local placeId, gameName = get_placeinfo()
local ROOT = gameName

setup_folders(ROOT)

module.print_info("iniciando script dump | " .. gameName .. " | placeId: " .. placeId)

local scripts = getscripts()
local stats = {
	total = #scripts,
	decompiled = 0,
	api = 0,
	strings = 0,
	empty = 0,
	versions = {},
	tags = {},
}

local scriptList = {}
local taggedList = {}
local remoteLogs = {}

local bar = module.progressbar({
	message = "decompilando scripts",
	style = "block",
	bar_size = 20,
	show_percent = true,
})

for i, script in ipairs(scripts) do
	pcall(function()
		local fpath = build_path(script)
		if fpath == "" then
			return
		end
		
		local bc = get_bytecode(script)
		local ver = bc and string.byte(bc, 1) or 0
		local vkey = "v" .. ver
		
		stats.versions[vkey] = (stats.versions[vkey] or 0) + 1
		table.insert(scriptList, "[" .. vkey .. "] " .. script.ClassName .. " " .. script:GetFullName())
		
		if not bc then
			stats.empty = stats.empty + 1
		else
			local src, method, version = try_decompile(script, bc)
			
			if src then
				local isStr = method and method:find("strings")
				local isAPI = method and method:find("api")
				local fileExt = isStr and ".txt" or get_extension(script)
				
				local base_dir = ROOT .. "/Scripts"
				if script.ClassName == "ModuleScript" then
					base_dir = ROOT .. "/Modules"
				elseif script.ClassName == "Script" then
					base_dir = ROOT .. "/Functions"
				end
				
				local filePath = base_dir .. "/" .. fpath .. fileExt
				mkdir(base_dir, fpath)
				writefile(filePath, src)
				
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
			else
				stats.empty = stats.empty + 1
			end
		end
		
		bar.set_message_and_progress(
			"decompilando (" .. i .. "/" .. stats.total .. ")",
			math.floor(i / stats.total * 100)
		)
	end)
end

bar.complete("scripts decompilados")
task.wait(0.5)
bar.cleanup()

writefile(ROOT .. "/Info/scripts.txt", table.concat(scriptList, "\n"))
writefile(ROOT .. "/Info/tagged.txt", table.concat(taggedList, "\n"))

module.print_success("decompilacao finalizada com sucesso")

local spin = module.spinner({message = "buscando remotes no jogo", speed = 0.12})

local classes = {"RemoteEvent", "RemoteFunction", "UnreliableRemoteEvent", "BindableEvent", "BindableFunction"}
local allLines = {}
local totalRemotes = 0

for _, class in ipairs(classes) do
	local found = {}
	for _, inst in ipairs(game:GetDescendants()) do
		if inst.ClassName == class then
			table.insert(found, inst:GetFullName())
			totalRemotes = totalRemotes + 1
		end
	end
	if #found > 0 then
		local lines = {class .. " (" .. #found .. ")"}
		for _, p in ipairs(found) do
			table.insert(lines, "  " .. p)
		end
		local content = table.concat(lines, "\n")
		writefile(ROOT .. "/Remotes/" .. class .. ".txt", content)
		table.insert(allLines, content)
	end
end

writefile(ROOT .. "/Remotes/todos.txt", table.concat(allLines, "\n\n"))

if next(remoteLogs) then
	local lines = {"chamadas de remotes detectadas\n"}
	for path, calls in pairs(remoteLogs) do
		table.insert(lines, path)
		for _, c in ipairs(calls) do
			table.insert(lines, "  " .. c)
		end
	end
	writefile(ROOT .. "/Remotes/calls.txt", table.concat(lines, "\n"))
end

spin.complete("remotes encontrados | total: " .. totalRemotes)
task.wait(0.5)
spin.cleanup()

local vlist = {}
local dominant, maxCount = "nenhum", 0
for v, count in pairs(stats.versions) do
	table.insert(vlist, v .. " " .. count)
	if count > maxCount then
		maxCount = count
		dominant = v
	end
end
table.sort(vlist)

local tlist = {}
for tag, count in pairs(stats.tags) do
	table.insert(tlist, tag .. " " .. count)
end
table.sort(tlist)

local grp = module.group("relatorio final")
grp.add("jogo: " .. gameName .. " | placeid: " .. placeId)
grp.add("versao dominante: " .. dominant)
grp.add("decompilados: " .. stats.decompiled .. " | api: " .. stats.api .. " | local: " .. (stats.decompiled - stats.api))
grp.add("strings: " .. stats.strings .. " | vazios: " .. stats.empty .. " | total: " .. stats.total)
if #tlist > 0 then
	grp.add("tags: " .. table.concat(tlist, " | "))
end
grp.add("api sucesso: " .. apiOk .. " | falhas: " .. apiFail)

module.print_success("dump finalizado na pasta: " .. gameName)
