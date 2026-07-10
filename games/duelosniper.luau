-- Mensagem de Inicialização
local MarketPlaceService = game:GetService("MarketplaceService")
local success, info = pcall(function()
    return MarketPlaceService:GetProductInfo(game.PlaceId)
end)

local nomeDoJogo = success and info.Name or "Jogo"

local notificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/core/Xaxas-notification.lua"))();
local notifications = notificationLibrary.new({            
    NotificationLifetime = 4, 
    NotificationPosition = "Middle",
    
    TextFont = Enum.Font.Code,
    TextColor = Color3.fromRGB(255, 255, 255),
    TextSize = 15,
    
    TextStrokeTransparency = 0, 
    TextStrokeColor = Color3.fromRGB(0, 0, 0)
});

notifications:BuildNotificationUI();
notifications:Notify(nomeDoJogo .. " | mode by rip_sheldoohz (: | V1")
-- Serviços
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- Configurações
local DISTANCIA_MAXIMA_ESP = 600
local AIMBOT_SMOOTHNESS = 0.15 

-- Variáveis de Controle
local ativoHighlight = false
local aimbotAtivo = false
local modoFFA = false 

-- Tabelas ESP
local espBoxes = {}
local espTraces = {}
local espLabels = {}
local espChams = {}

function mostrarAviso(tag, texto)
    notifications:Notify("[" .. string.upper(tag) .. "] " .. string.upper(texto))
end

-- Descobre em qual subpasta de classe (A ou B) o jogador se encontra
local function obterClasseDoJogador(player)
    local char = player.Character
    if char and char.Parent then
        local nomeClasse = char.Parent.Name
        if nomeClasse == "A" or nomeClasse == "B" then
            return nomeClasse
        end
        if char.Parent.Parent and (char.Parent.Parent.Name == "A" or char.Parent.Parent.Name == "B") then
            return char.Parent.Parent.Name
        end
    end
    return nil
end

-- Analisa se todos estão no mesmo time ou se uma classe está vazia (Ativação FFA)
local function atualizarModoDeJogo()
    local qtdA = 0
    local qtdB = 0

    for _, p in pairs(Players:GetPlayers()) do
        local classe = obterClasseDoJogador(p)
        if classe == "A" then
            qtdA = qtdA + 1
        elseif classe == "B" then
            qtdB = qtdB + 1
        end
    end

    if (qtdA > 0 and qtdB == 0) or (qtdB > 0 and qtdA == 0) then
        if not modoFFA then
            modoFFA = true
            mostrarAviso("Team", "FFA MODE ACTIVATED")
        end
    else
        if modoFFA then
            modoFFA = false
            mostrarAviso("Team", "TEAM MODE ACTIVATED")
        end
    end
end

-- Validação de Alvos e Aliados
local function verificarSeEhAliado(player)
    if player == LocalPlayer then return true end
    if modoFFA then return false end

    local minhaClasse = obterClasseDoJogador(LocalPlayer)
    local classeDeles = obterClasseDoJogador(player)

    if minhaClasse and classeDeles then
        return minhaClasse == classeDeles
    end

    return false
end

-- Checagem de Obstrução Visual (Raycast / Wall Check)
local function estaVisivel(playerCharacter, targetPart)
    local localCharacter = LocalPlayer.Character
    if not localCharacter or not targetPart then return false end
    
    local origem = Camera.CFrame.Position
    local destino = targetPart.Position
    local direcao = destino - origem
    
    local parametros = RaycastParams.new()
    parametros.FilterType = Enum.RaycastFilterType.Exclude
    parametros.FilterDescendantsInstances = {localCharacter, playerCharacter, game:GetService("CoreGui")}
    parametros.IgnoreWater = true
    
    local resultado = workspace:Raycast(origem, direcao, parametros)
    
    if not resultado then
        return true
    end
    return false
end

local function limparESP(player)
    if espBoxes[player] then
        if espBoxes[player].Box then espBoxes[player].Box:Remove() end
        if espBoxes[player].Outline then espBoxes[player].Outline:Remove() end
        espBoxes[player] = nil
    end
    if espTraces[player] then
        espTraces[player]:Remove()
        espTraces[player] = nil
    end
    if espLabels[player] then
        espLabels[player]:Remove()
        espLabels[player] = nil
    end
    if espChams[player] then
        espChams[player]:Destroy()
        espChams[player] = nil
    end
end

function removerHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        limparESP(player)
    end
end

local function criarBox2D()
    local outline = Drawing.new("Square")
    outline.Thickness = 3
    outline.Filled = false
    outline.Color = Color3.fromRGB(0, 0, 0)
    outline.Transparency = 0.8
    outline.Visible = false

    local box = Drawing.new("Square")
    box.Thickness = 1
    box.Filled = false
    box.Color = Color3.fromRGB(255, 255, 255)
    box.Transparency = 1
    box.Visible = false

    return {Box = box, Outline = outline}
end

local function criarTrace()
    local line = Drawing.new("Line")
    line.Thickness = 1
    line.Color = Color3.fromRGB(255, 255, 255)
    line.Transparency = 0.6
    line.Visible = false
    return line
end

local function criarLabel()
    local text = Drawing.new("Text")
    text.Size = 14
    text.Center = true
    text.Outline = true
    text.OutlineColor = Color3.fromRGB(0, 0, 0)
    text.Color = Color3.fromRGB(255, 255, 255)
    text.Visible = false
    return text
end

local function criarChams(char)
    local highlight = Instance.new("Highlight")
    highlight.Name = "EspChams"
    highlight.FillColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = char
    highlight.Parent = game:GetService("CoreGui")
    return highlight
end

-- Renderização da API Visual Reestruturada
local function atualizarESP()
    local localCharacter = LocalPlayer.Character
    if not localCharacter then return end
    local localHrp = localCharacter:FindFirstChild("HumanoidRootPart")
    if not localHrp then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local char = player.Character
        
        if ativoHighlight and char and char:IsDescendantOf(workspace) and not verificarSeEhAliado(player) then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local humanoid = char:FindFirstChild("Humanoid")
            
            if hrp and humanoid and humanoid.Health > 0 then
                local distancia = (localHrp.Position - hrp.Position).Magnitude
                if distancia > DISTANCIA_MAXIMA_ESP then
                    limparESP(player)
                    continue
                end

                local hrpPos, emTela = Camera:WorldToViewportPoint(hrp.Position)
                if not emTela then
                    limparESP(player)
                    continue
                end

                -- 1. TRACES
                if not espTraces[player] then espTraces[player] = criarTrace() end
                local traceLine = espTraces[player]
                traceLine.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                traceLine.To = Vector2.new(hrpPos.X, hrpPos.Y)
                traceLine.Visible = true

                -- 2. BOXES 2D
                if not espBoxes[player] then espBoxes[player] = criarBox2D() end
                local boxData = espBoxes[player]
                
                local topPos = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
                local bottomPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.5, 0))
                
                local boxHeight = math.abs(topPos.Y - bottomPos.Y)
                local boxWidth = boxHeight / 1.8

                boxData.Outline.Size = Vector2.new(boxWidth, boxHeight)
                boxData.Outline.Position = Vector2.new(hrpPos.X - boxWidth / 2, hrpPos.Y - boxHeight / 2)
                boxData.Outline.Visible = true

                boxData.Box.Size = Vector2.new(boxWidth, boxHeight)
                boxData.Box.Position = boxData.Outline.Position
                boxData.Box.Visible = true

                -- 3. LABELS
                if not espLabels[player] then espLabels[player] = criarLabel() end
                local label = espLabels[player]
                label.Position = Vector2.new(hrpPos.X, (hrpPos.Y - boxHeight / 2) - 18)
                label.Text = player.Name .. " [" .. math.floor(distancia) .. "m]"
                label.Visible = true

                -- 4. CHAMS
                if not espChams[player] then 
                    espChams[player] = criarChams(char) 
                end
            else
                limparESP(player)
            end
        else
            limparESP(player)
        end
    end
end

-- Seleciona Próximo Alvo Válido
function encontrarInimigoMaisProximo()
    local inimigoMaisProximo = nil
    local menorDistancia = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local char = player.Character
        if not char or not char:IsDescendantOf(workspace) then continue end
        
        local head = char:FindFirstChild("Head")
        local humanoid = char:FindFirstChild("Humanoid")
        if not head or not humanoid or humanoid.Health <= 0 or humanoid:GetState() == Enum.HumanoidStateType.Dead then 
            continue 
        end
        
        if verificarSeEhAliado(player) then continue end
        if not estaVisivel(char, head) then continue end

        local posTela, visivel = Camera:WorldToViewportPoint(head.Position)
        if visivel then
            local dist = (Vector2.new(posTela.X, posTela.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if dist < menorDistancia then
                menorDistancia = dist
                inimigoMaisProximo = player
            end
        end
    end

    return inimigoMaisProximo
end

-- Loop de Renderização Principal e Interpolação de Câmera
local ffaContador = 0
RunService.RenderStepped:Connect(function()
    ffaContador = ffaContador + 1
    if ffaContador % 30 == 0 then
        atualizarModoDeJogo()
    end

    atualizarESP()
    
    if aimbotAtivo then
        local alvo = encontrarInimigoMaisProximo()
        if alvo and alvo.Character and alvo.Character:FindFirstChild("Head") then
            local humanoid = alvo.Character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
                local alvoPos = alvo.Character.Head.Position
                local currentPos = Camera.CFrame.Position
                
                local novaDirecao = CFrame.new(currentPos, alvoPos)
                Camera.CFrame = Camera.CFrame:Lerp(novaDirecao, AIMBOT_SMOOTHNESS)
            end
        end
    end
end)

-- Eventos de Entrada por Teclado (Atalhos)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        -- Tecla K: Alterna Estado Visual (ESP)
        if input.KeyCode == Enum.KeyCode.K then
            ativoHighlight = not ativoHighlight
            if ativoHighlight then
                mostrarAviso("Visuals", "ENABLED")
            else
                mostrarAviso("Visuals", "DISABLED")
                removerHighlights()
            end
        -- Tecla L: Alterna Estado Combate (Aimbot Permanente)
        elseif input.KeyCode == Enum.KeyCode.L then
            aimbotAtivo = not aimbotAtivo
            if aimbotAtivo then
                mostrarAviso("Combate", "ENABLED")
            else
                mostrarAviso("Combate", "DISABLED")
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    limparESP(player)
end)
