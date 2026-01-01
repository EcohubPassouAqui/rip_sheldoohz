local HttpService = game:GetService("HttpService")

local WebhookURL = "https://discord.com/api/webhooks/1454737241598595227/moJaONAnm9j2Pl3Bwph7uryJ-p2o99QLqp4p88zu-QOvoTgmXXNfD5SZGVPMLHQXMsVF"

local GameAnalyzer = {
    Scripts = {},
    ModuleScripts = {},
    LocalScripts = {},
    Remotes = {},
    WorkspaceFolders = {},
    WorkspaceModels = {}
}

local function SafeRequest(data)
    local success = false
    local jsonData = HttpService:JSONEncode(data)
    
    if syn and syn.request then
        success = pcall(function()
            syn.request({
                Url = WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonData
            })
        end)
    end
    
    if not success and http and http.request then
        success = pcall(function()
            http.request({
                Url = WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonData
            })
        end)
    end
    
    if not success and http_request then
        success = pcall(function()
            http_request({
                Url = WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonData
            })
        end)
    end
    
    if not success and request then
        success = pcall(function()
            request({
                Url = WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonData
            })
        end)
    end
    
    return success
end

local function ScanForScripts(parent, depth)
    depth = depth or 0
    if depth > 25 then return end
    
    for _, child in pairs(parent:GetChildren()) do
        local success = pcall(function()
            if child:IsA("Script") then
                local sourceSuccess, source = pcall(function()
                    return child.Source
                end)
                
                table.insert(GameAnalyzer.Scripts, {
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Parent = child.Parent.Name,
                    Enabled = child.Enabled,
                    HasSource = sourceSuccess
                })
            elseif child:IsA("LocalScript") then
                local sourceSuccess, source = pcall(function()
                    return child.Source
                end)
                
                table.insert(GameAnalyzer.LocalScripts, {
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Parent = child.Parent.Name,
                    Enabled = child.Enabled,
                    HasSource = sourceSuccess
                })
            elseif child:IsA("ModuleScript") then
                local sourceSuccess, source = pcall(function()
                    return child.Source
                end)
                
                table.insert(GameAnalyzer.ModuleScripts, {
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Parent = child.Parent.Name,
                    HasSource = sourceSuccess
                })
            elseif child:IsA("RemoteEvent") then
                table.insert(GameAnalyzer.Remotes, {
                    Type = "RemoteEvent",
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Parent = child.Parent.Name
                })
            elseif child:IsA("RemoteFunction") then
                table.insert(GameAnalyzer.Remotes, {
                    Type = "RemoteFunction",
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Parent = child.Parent.Name
                })
            elseif child:IsA("BindableEvent") then
                table.insert(GameAnalyzer.Remotes, {
                    Type = "BindableEvent",
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Parent = child.Parent.Name
                })
            elseif child:IsA("BindableFunction") then
                table.insert(GameAnalyzer.Remotes, {
                    Type = "BindableFunction",
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Parent = child.Parent.Name
                })
            end
            
            ScanForScripts(child, depth + 1)
        end)
    end
end

local function AnalyzeWorkspaceFolders(parent, depth)
    depth = depth or 0
    if depth > 15 then return end
    
    for _, child in pairs(parent:GetChildren()) do
        pcall(function()
            if child:IsA("Folder") then
                local childCount = #child:GetChildren()
                table.insert(GameAnalyzer.WorkspaceFolders, {
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Children = childCount
                })
                AnalyzeWorkspaceFolders(child, depth + 1)
            elseif child:IsA("Model") then
                local parts = 0
                for _, descendant in pairs(child:GetDescendants()) do
                    if descendant:IsA("BasePart") then
                        parts = parts + 1
                    end
                end
                table.insert(GameAnalyzer.WorkspaceModels, {
                    Name = child.Name,
                    Path = child:GetFullName(),
                    PrimaryPart = child.PrimaryPart and child.PrimaryPart.Name or "None",
                    TotalParts = parts
                })
                AnalyzeWorkspaceFolders(child, depth + 1)
            end
        end)
    end
end

local function CreateEmbed(title, description, color, fields)
    return {
        title = title,
        description = description,
        color = color,
        fields = fields or {},
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
    }
end

local function SendWebhook(embeds)
    local data = {
        username = "Game Analyzer",
        avatar_url = "https://cdn.discordapp.com/embed/avatars/0.png",
        embeds = embeds
    }
    
    SafeRequest(data)
end

local function SendWorkspaceFoldersEmbed()
    local description = ""
    
    if #GameAnalyzer.WorkspaceFolders == 0 then
        description = "Nenhuma Folder encontrada no Workspace"
    else
        for i, folder in ipairs(GameAnalyzer.WorkspaceFolders) do
            if i > 20 then
                description = description .. "\n... e mais " .. (#GameAnalyzer.WorkspaceFolders - 20) .. " folders"
                break
            end
            description = description .. string.format("\n**%s**\nPath: `%s`\nChildren: %d\n", 
                folder.Name, folder.Path, folder.Children)
        end
    end
    
    local embed = CreateEmbed(
        "Workspace Folders (" .. #GameAnalyzer.WorkspaceFolders .. " encontradas)",
        description,
        3066993,
        {}
    )
    
    SendWebhook({embed})
end

local function SendWorkspaceModelsEmbed()
    local description = ""
    
    if #GameAnalyzer.WorkspaceModels == 0 then
        description = "Nenhum Model encontrado no Workspace"
    else
        for i, model in ipairs(GameAnalyzer.WorkspaceModels) do
            if i > 20 then
                description = description .. "\n... e mais " .. (#GameAnalyzer.WorkspaceModels - 20) .. " models"
                break
            end
            description = description .. string.format("\n**%s**\nPath: `%s`\nParts: %d | PrimaryPart: `%s`\n", 
                model.Name, model.Path, model.TotalParts, model.PrimaryPart)
        end
    end
    
    local embed = CreateEmbed(
        "Workspace Models (" .. #GameAnalyzer.WorkspaceModels .. " encontrados)",
        description,
        15844367,
        {}
    )
    
    SendWebhook({embed})
end

local function SendRemotesEmbed()
    local description = ""
    
    if #GameAnalyzer.Remotes == 0 then
        description = "Nenhum Remote encontrado"
    else
        for i, remote in ipairs(GameAnalyzer.Remotes) do
            if i > 25 then
                description = description .. "\n... e mais " .. (#GameAnalyzer.Remotes - 25) .. " remotes"
                break
            end
            description = description .. string.format("\n**[%s]** `%s`\nPath: `%s`\n", 
                remote.Type, remote.Name, remote.Path)
        end
    end
    
    local embed = CreateEmbed(
        "Remotes Analysis (" .. #GameAnalyzer.Remotes .. " encontrados)",
        description,
        15158332,
        {}
    )
    
    SendWebhook({embed})
end

local function SendScriptsEmbed()
    local description = ""
    
    if #GameAnalyzer.Scripts == 0 then
        description = "Nenhum Script encontrado"
    else
        for i, script in ipairs(GameAnalyzer.Scripts) do
            if i > 15 then
                description = description .. "\n... e mais " .. (#GameAnalyzer.Scripts - 15) .. " scripts"
                break
            end
            description = description .. string.format("\n**%s** %s %s\nPath: `%s`\n", 
                script.Name, 
                script.Enabled and "✅" or "❌",
                script.HasSource and "📄" or "🔒",
                script.Path)
        end
    end
    
    local embed = CreateEmbed(
        "Scripts Analysis (" .. #GameAnalyzer.Scripts .. " encontrados)",
        description,
        10181046,
        {}
    )
    
    SendWebhook({embed})
end

local function SendModuleScriptsEmbed()
    local description = ""
    
    if #GameAnalyzer.ModuleScripts == 0 then
        description = "Nenhum ModuleScript encontrado"
    else
        for i, module in ipairs(GameAnalyzer.ModuleScripts) do
            if i > 15 then
                description = description .. "\n... e mais " .. (#GameAnalyzer.ModuleScripts - 15) .. " modules"
                break
            end
            description = description .. string.format("\n**%s** %s\nPath: `%s`\n", 
                module.Name,
                module.HasSource and "📄" or "🔒",
                module.Path)
        end
    end
    
    local embed = CreateEmbed(
        "ModuleScripts Analysis (" .. #GameAnalyzer.ModuleScripts .. " encontrados)",
        description,
        16776960,
        {}
    )
    
    SendWebhook({embed})
end

local function SendLocalScriptsEmbed()
    local description = ""
    
    if #GameAnalyzer.LocalScripts == 0 then
        description = "Nenhum LocalScript encontrado"
    else
        for i, localScript in ipairs(GameAnalyzer.LocalScripts) do
            if i > 15 then
                description = description .. "\n... e mais " .. (#GameAnalyzer.LocalScripts - 15) .. " local scripts"
                break
            end
            description = description .. string.format("\n**%s** %s %s\nPath: `%s`\n", 
                localScript.Name,
                localScript.Enabled and "✅" or "❌",
                localScript.HasSource and "📄" or "🔒",
                localScript.Path)
        end
    end
    
    local embed = CreateEmbed(
        "LocalScripts Analysis (" .. #GameAnalyzer.LocalScripts .. " encontrados)",
        description,
        5793266,
        {}
    )
    
    SendWebhook({embed})
end

local function SendGameInfoEmbed()
    local fields = {
        {name = "Game Name", value = game.Name, inline = true},
        {name = "Game ID", value = tostring(game.PlaceId), inline = true},
        {name = "Creator Type", value = game.CreatorType == Enum.CreatorType.User and "User" or "Group", inline = true},
        {name = "Players Online", value = tostring(#game.Players:GetPlayers()), inline = true}
    }
    
    local embed = CreateEmbed(
        "Game Information",
        "Análise iniciada do jogo",
        65280,
        fields
    )
    
    SendWebhook({embed})
end

local function StartAnalysis()
    SendGameInfoEmbed()
    task.wait(1)
    
    AnalyzeWorkspaceFolders(game.Workspace)
    SendWorkspaceFoldersEmbed()
    task.wait(1)
    
    SendWorkspaceModelsEmbed()
    task.wait(1)
    
    ScanForScripts(game)
    
    SendRemotesEmbed()
    task.wait(1)
    
    SendScriptsEmbed()
    task.wait(1)
    
    SendModuleScriptsEmbed()
    task.wait(1)
    
    SendLocalScriptsEmbed()
    task.wait(1)
    
    local summaryEmbed = CreateEmbed(
        "Analysis Complete",
        string.format(
            "Análise completa do jogo finalizada\n\n" ..
            "Scripts: %d\n" ..
            "LocalScripts: %d\n" ..
            "ModuleScripts: %d\n" ..
            "Remotes: %d\n" ..
            "Workspace Folders: %d\n" ..
            "Workspace Models: %d",
            #GameAnalyzer.Scripts,
            #GameAnalyzer.LocalScripts,
            #GameAnalyzer.ModuleScripts,
            #GameAnalyzer.Remotes,
            #GameAnalyzer.WorkspaceFolders,
            #GameAnalyzer.WorkspaceModels
        ),
        3447003,
        {}
    )
    
    SendWebhook({summaryEmbed})
end

StartAnalysis()
