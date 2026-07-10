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
notifications:Notify(nomeDoJogo .. " | mode by rip_sheldoohz (: | V2.1 - AIMBOT ULTRA GRUENTO")

-- Serviços
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- Configurações
local DISTANCIA_MAXIMA_ESP = 600
local AIMBOT_SMOOTHNESS = 0.35  -- AUMENTADO: Gruda mais na cabeça
local AIMBOT_PREDICTION = 0.5
local AIMBOT_DISTANCIA_MAX = 500  -- AUMENTADO: De 300 para 500 metros
local ESP_UPDATE_RATE = 1

-- Variáveis de Controle
local ativoHighlight = false
local aimbotAtivo = false
local modoFFA = false

-- Tabelas ESP
local espBoxes = {}
local espTraces = {}
local espLabels = {}
local espChams = {}
local playerTargets = {}

local function pcallSeguro(funcao, ...)
    local sucesso, resultado = pcall(funcao, ...)
    if not sucesso then
        warn("ERRO no script: " .. tostring(resultado))
    end
    return sucesso, resultado
end

function mostrarAviso(tag, texto)
    pcallSeguro(function()
        notifications:Notify("[" .. string.upper(tag) .. "] " .. string.upper(texto))
    end)
end

-- Detecção de Time Ultra Melhorada
local function obterClasseDoJogador(player)
    if not player or not player.Character then return nil end
    
    local char = player.Character
    if not char.Parent then return nil end
    
    local nomeClasse = char.Parent.Name
    
    if nomeClasse == "A" or nomeClasse == "B" then
        return nomeClasse
    end
    
    if char.Parent.Parent then
        local avoPai = char.Parent.Parent.Name
        if avoPai == "A" or avoPai == "B" then
            return avoPai
        end
    end
    
    if string.find(nomeClasse, "TeamA") or string.find(nomeClasse, "Team A") or string.find(nomeClasse, "team_a") then
        return "A"
    elseif string.find(nomeClasse, "TeamB") or string.find(nomeClasse, "Team B") or string.find(nomeClasse, "team_b") then
        return "B"
    end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        if humanoid:FindFirstChild("TeamTag") then
            local tag = humanoid.TeamTag.Value
            if tag == "A" or tag == "B" then
                return tag
            end
        end
    end
    
    if char:GetAttribute("Team") then
        return char:GetAttribute("Team")
    end
    
    return nil
end

-- Analisa se todos estão no mesmo time ou se uma classe está vazia
local function atualizarModoDeJogo()
    local qtdA = 0
    local qtdB = 0
    local jogadoresComClasse = 0
    local jogadoresSemClasse = 0

    for _, p in pairs(Players:GetPlayers()) do
        local classe = obterClasseDoJogador(p)
        if classe then
            jogadoresComClasse = jogadoresComClasse + 1
            if classe == "A" then
                qtdA = qtdA + 1
            elseif classe == "B" then
                qtdB = qtdB + 1
            end
        else
            jogadoresSemClasse = jogadoresSemClasse + 1
        end
    end

    if jogadoresComClasse == 0 then
        if not modoFFA then
            modoFFA = true
            mostrarAviso("Team", "FFA MODE (Sem times detectados)")
        end
    elseif (qtdA > 0 and qtdB == 0) or (qtdB > 0 and qtdA == 0) then
        if not modoFFA then
            modoFFA = true
            local timeAtivo = (qtdA > 0) and "A" or "B"
            mostrarAviso("Team", "FFA MODE (Só Time " .. timeAtivo .. ")")
        end
    else
        if modoFFA then
            modoFFA = false
            mostrarAviso("Team", "TEAM MODE (Time A:" .. qtdA .. " | Time B:" .. qtdB .. ")")
        end
    end
end

-- Validação de Alvos e Aliados
local function verificarSeEhAliado(player)
    if player == LocalPlayer then return true end
    if modoFFA then return false end

    local minhaClasse = obterClasseDoJogador(LocalPlayer)
    local classeDeles = obterClasseDoJogador(player)

    if not minhaClasse or not classeDeles then
        return false
    end

    return minhaClasse == classeDeles
end

-- Sistema de Visibilidade Melhorado
local function estaVisivel(playerCharacter, targetPart)
    local localCharacter = LocalPlayer.Character
    if not localCharacter or not targetPart then return false end
    
    local localHrp = localCharacter:FindFirstChild("HumanoidRootPart")
    if not localHrp then return false end
    
    local pontosVerificacao = {
        localHrp.Position + Vector3.new(0, 2, 0),
        Camera.CFrame.Position
    }
    
    for _, origem in ipairs(pontosVerificacao) do
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
    end
    
    return false
end

-- Sistema ESP Melhorado
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
    playerTargets[player] = nil
end

function removerHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        limparESP(player)
    end
end

local function criarBox2D()
    local outline = Drawing.new("Square")
    outline.Thickness = 1
    outline.Filled = false
    outline.Color = Color3.fromRGB(255, 255, 255)
    outline.Transparency = 0.3
    outline.Visible = false

    local box = Drawing.new("Square")
    box.Thickness = 1
    box.Filled = false
    box.Color = Color3.fromRGB(255, 255, 255)
    box.Transparency = 0.5
    box.Visible = false

    return {Box = box, Outline = outline}
end

local function criarTrace()
    local line = Drawing.new("Line")
    line.Thickness = 1
    line.Color = Color3.fromRGB(255, 255, 255)
    line.Transparency = 0.4
    line.Visible = false
    return line
end

local function criarLabel()
    local text = Drawing.new("Text")
    text.Size = 8
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
    highlight.FillTransparency = 0.6
    highlight.OutlineTransparency = 0.5
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = char
    highlight.Parent = game:GetService("CoreGui")
    return highlight
end

-- Cores Dinâmicas (Tudo Branco)
local function obterCorESP(player, distancia)
    return Color3.fromRGB(255, 255, 255)
end

-- Renderização ESP Ultra Otimizada
local function atualizarESP()
    local localCharacter = LocalPlayer.Character
    if not localCharacter then return end
    local localHrp = localCharacter:FindFirstChild("HumanoidRootPart")
    if not localHrp then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local char = player.Character
        if not (ativoHighlight and char and char:IsDescendantOf(workspace) and not verificarSeEhAliado(player)) then
            limparESP(player)
            continue
        end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChild("Humanoid")
        
        if not (hrp and humanoid and humanoid.Health > 0) then
            limparESP(player)
            continue
        end

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

        local corBranca = Color3.fromRGB(255, 255, 255)

        if not espTraces[player] then espTraces[player] = criarTrace() end
        local traceLine = espTraces[player]
        traceLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
        traceLine.To = Vector2.new(hrpPos.X, hrpPos.Y)
        traceLine.Visible = true

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

        if not espLabels[player] then espLabels[player] = criarLabel() end
        local label = espLabels[player]
        label.Position = Vector2.new(hrpPos.X, (hrpPos.Y - boxHeight / 2) - 12)
        label.Text = math.floor(distancia) .. "m"
        label.Visible = true

        if not espChams[player] then 
            espChams[player] = criarChams(char) 
        end
    end
end

-- Sistema de Aimbot Ultra Melhorado
local function preverPosicaoAlvo(player, tempo)
    if not player or not player.Character then return nil end
    
    local char = player.Character
    local humanoidRP = char:FindFirstChild("HumanoidRootPart")
    if not humanoidRP then return nil end
    
    local ultimaPosicao = playerTargets[player] or humanoidRP.Position
    local velocidade = humanoidRP.Velocity
    
    playerTargets[player] = humanoidRP.Position
    
    return humanoidRP.Position + (velocidade * tempo * AIMBOT_PREDICTION)
end

function encontrarInimigoMaisProximo()
    local inimigoMaisProximo = nil
    local menorDistancia = math.huge
    local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not localHrp then return nil end

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local char = player.Character
        if not char or not char:IsDescendantOf(workspace) then continue end
        
        local head = char:FindFirstChild("Head")
        local humanoid = char:FindFirstChild("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if not head or not humanoid or not hrp then continue end
        if humanoid.Health <= 0 then continue end
        if humanoid:GetState() == Enum.HumanoidStateType.Dead then continue end
        
        if verificarSeEhAliado(player) then continue end
        if not estaVisivel(char, head) then continue end

        local distanciaReal = (localHrp.Position - hrp.Position).Magnitude
        if distanciaReal > AIMBOT_DISTANCIA_MAX then continue end

        local posTela, visivel = Camera:WorldToViewportPoint(head.Position)
        if visivel then
            local distTela = (Vector2.new(posTela.X, posTela.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            local distTotalPrioritizada = (distTela * 0.7) + (distanciaReal * 0.3)
            
            if distTotalPrioritizada < menorDistancia then
                menorDistancia = distTotalPrioritizada
                inimigoMaisProximo = player
            end
        end
    end

    return inimigoMaisProximo
end

local function executarAimbot()
    pcallSeguro(function()
        local alvo = encontrarInimigoMaisProximo()
        if alvo and alvo.Character and alvo.Character:FindFirstChild("Head") then
            local humanoid = alvo.Character:FindFirstChild("Humanoid")
            local head = alvo.Character:FindFirstChild("Head")
            
            if humanoid and humanoid.Health > 0 and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
                local alvoPos = preverPosicaoAlvo(alvo, 0.016) or head.Position
                local currentPos = Camera.CFrame.Position
                
                -- MELHORADO: Foca direto na cabeça com suavização aumentada
                local novaDirecao = CFrame.new(currentPos, alvoPos)
                
                local velocidadeAlvo = head.Velocity.Magnitude
                local suavizacaoAdaptativa = AIMBOT_SMOOTHNESS * (1 + math.min(velocidadeAlvo / 100, 0.3))
                local suavizacaoFinal = math.min(suavizacaoAdaptativa, 0.6)
                
                Camera.CFrame = Camera.CFrame:Lerp(novaDirecao, suavizacaoFinal)
            end
        end
    end)
end

-- Loop Principal Otimizado
local ffaContador = 0
RunService.RenderStepped:Connect(function()
    ffaContador = ffaContador + 1
    
    if ffaContador % 30 == 0 then
        atualizarModoDeJogo()
        ffaContador = 0
    end

    if ativoHighlight then
        atualizarESP()
    end
    
    if aimbotAtivo then
        executarAimbot()
    end
end)

-- Controles do Teclado
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.K then
            ativoHighlight = not ativoHighlight
            if ativoHighlight then
                mostrarAviso("Visuals", "ENABLED")
            else
                mostrarAviso("Visuals", "DISABLED")
                removerHighlights()
            end
        elseif input.KeyCode == Enum.KeyCode.X then
            aimbotAtivo = not aimbotAtivo
            if aimbotAtivo then
                mostrarAviso("Aimbot", "ENABLED")
            else
                mostrarAviso("Aimbot", "DISABLED")
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    limparESP(player)
end)

mostrarAviso("Sistema", "Pronto! K=ESP | X=AIMBOT | AIMBOT ULTRA GRUENTO")
