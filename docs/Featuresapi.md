# Ecohub Features API

Guia completo de como carregar outros arquivos (tabs + elements) dentro da mesma janela da Ecohub.

---

## 1. O que é

A Features API deixa você dividir o hub em vários arquivos. Em vez de um script gigante com todas as tabs, você tem um script principal pequeno que cria a janela e manda carregar arquivos separados. Cada arquivo cria as próprias tabs, sections e elements na mesma janela.

Vantagens:

- O script principal fica curto.
- Cada jogo pode ter a própria pasta de features.
- Você edita um arquivo no GitHub sem mexer nos outros.
- O mesmo script principal serve para vários jogos.

---

## 2. O que significa "baixar"

Quando se diz que a lib "baixa" um arquivo, quer dizer que ela busca o texto do arquivo no seu GitHub pela internet usando `game:HttpGet` e roda esse texto como código com `loadstring`. Nada é salvo no PC nem no celular.

Quando você faz:

```luau
Windows:LoadFeature("nomejogo/Combate")
```

a lib monta este link:

```
https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/library/features/nomejogo/Combate.luau
```

Depois ela faz o `HttpGet` nesse link, pega o código, executa, e as tabs e elements aparecem na janela. É o mesmo que você já faz no começo do script com o `loadstring(game:HttpGet(...))` da lib, só que a lib monta o link por você a partir do nome.

Por isso o arquivo precisa existir no GitHub, no caminho certo. Se não existir, aparece a notificação "Feature nao encontrada".

---

## 3. Estrutura de pastas no GitHub

Todas as features ficam em `library/features/`. Pode ter arquivo solto e pode ter pasta:

```
library/
└── features/
    ├── Visual.luau
    ├── Combate.luau
    ├── meianoite/
    │   ├── Corrida.luau
    │   ├── Farm.luau
    │   └── Visual.luau
    └── boneville/
        ├── Corrida.luau
        └── Teleporte.luau
```

Regras:

- Arquivo solto: `library/features/Combate.luau`.
- Arquivo dentro de pasta: `library/features/meianoite/Farm.luau`.
- A extensão é sempre `.luau` (a lib também aceita `.lua` na hora de listar pasta).
- Pode ter pasta dentro de pasta (a lib entra até 3 níveis ao carregar uma pasta inteira).

---

## 4. Script principal

```luau
-- // Games
local Librarys = loadstring(game:HttpGet("https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/library/Librarys.luau"))()

-- // Librarys Windows
local Windows = Librarys:CreateWindow({
    Title = "Ecohub [" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "]",
    SubTitle = "by rip_sheldoohz",
    Size = UDim2.fromOffset(580, 350),
    MinimizeKey = Enum.KeyCode.RightShift
})

-- // Features
Windows:LoadFeatures({ "meianoite/Corrida", "meianoite/Farm", "meianoite/Visual" })
```

Observação: no script principal a janela se chama `Windows` (nome que você escolheu). Dentro dos arquivos de feature ela se chama sempre `Window`, sem o "s". Veja a seção 7.

O `GetProductInfo` pode dar erro se o Roblox não responder. Se quiser evitar que isso derrube o script, envolva em `pcall` e use um nome fixo como alternativa.

---

## 5. Formas de carregar

### 5.1 LoadFeature (uma feature)

```luau
Windows:LoadFeature("Combate")
```

Carrega `features/Combate.luau`. Retorna `true` se carregou e `false` se falhou.

### 5.2 LoadFeature com pasta/arquivo

```luau
Windows:LoadFeature("meianoite/Farm")
```

Carrega `features/meianoite/Farm.luau`. Use `/` para separar pasta e arquivo.

### 5.3 LoadFeature com pasta inteira

```luau
Windows:LoadFeature("meianoite")
```

Carrega todos os arquivos `.luau` de `features/meianoite/` em ordem alfabética, incluindo subpastas.

### 5.4 LoadFeatures (várias de uma vez)

```luau
Windows:LoadFeatures({ "Combate", "meianoite/Farm", "Visual" })
```

É um atalho. Faz o mesmo que três linhas de `LoadFeature`, na ordem da lista.

- Se uma falhar, as outras continuam.
- Retorna uma tabela com o resultado de cada uma, por exemplo `{ Combate = true, ["meianoite/Farm"] = true, Visual = false }`.

### 5.5 Link direto

```luau
Windows:LoadFeature("https://raw.githubusercontent.com/usuario/repo/refs/heads/main/Teste.luau")
```

Se o texto começar com `http://` ou `https://`, a lib usa o link como está, sem montar caminho.

---

## 6. Como a lib acha o arquivo

Quando você passa um nome (sem ser link), a lib tenta nesta ordem e para na primeira que existir:

1. `features/NOME.luau`
2. `features/NOME/ULTIMA_PARTE.luau` (por exemplo, `"Combate"` tenta `features/Combate/Combate.luau`)
3. `features/NOME/init.luau`
4. Se nada acima existir, trata `NOME` como pasta e carrega todos os arquivos dela

Isso é a detecção automática. Você não precisa dizer se é arquivo ou pasta, a lib descobre.

Detalhes:

- A extensão é opcional: `"Combate"` e `"Combate.luau"` funcionam igual.
- `\` é trocado por `/`.
- Espaços e barras sobrando no começo e no fim são removidos.
- A listagem de pasta usa a API do GitHub (`api.github.com`). Sem autenticação ela tem limite de requisições por hora. Se estourar o limite, o carregamento de pasta falha, mas arquivo direto (`pasta/arquivo`) continua funcionando porque usa o `raw.githubusercontent.com`.

---

## 7. Como o arquivo de feature enxerga a janela

Antes de rodar o arquivo, a lib injeta duas variáveis nele:

| Variável | O que é |
|----------|---------|
| `Window` | a janela criada no script principal |
| `Librarys` | a própria lib (Theme, Elements, Notify, etc.) |

Então dentro do arquivo você usa direto, sem `loadstring`, sem `require`, sem criar janela nova:

```luau
-- // Combate
local Tab = Window:CreateTab({ tab = "Combate", section = "Features", icon = "swords" })
local Section = Tab:CreateSection("Aimbot")

Section:CreateToggle({
    title = "Aimbot",
    default = false,
    callback = function(state)
        print("Aimbot:", state)
    end,
})
```

Se o executor não tiver `setfenv`, a lib coloca `Window` e `Librarys` em variáveis globais temporárias (`getgenv`). Funciona normal com uma janela. Com duas janelas ao mesmo tempo as variáveis podem se misturar.

---

## 8. Criando tab, section e elements

Dentro de qualquer feature:

```luau
-- // Tab
local Tab = Window:CreateTab({
    tab = "Farm",
    section = "Corrida",
    icon = "flag"
})

-- // Section
local Section = Tab:CreateSection("Auto Farm")
```

- `tab` é o nome que aparece na barra lateral.
- `section` é o título do grupo na barra lateral. Tabs com a mesma `section` ficam agrupadas.
- `icon` é o nome de um ícone lucide (sem o prefixo `lucide-`). Se não existir, a tab fica sem ícone.
- `CreateSection` cria o bloco dentro da página da tab.

Elements disponíveis em uma section:

| Método | Element |
|--------|---------|
| `Section:CreateToggle(opts)` | Checkbox |
| `Section:CreateButton(opts)` | Button |
| `Section:CreateSlider(opts)` | Slider |
| `Section:CreateDropdown(opts)` | Dropdown |
| `Section:CreateColorPicker(opts)` | ColorPicker |
| `Section:CreateParagraph(opts)` | Paragraph |
| `Section:CreateElement(nome, opts)` | qualquer element registrado |

Exemplo completo de uma feature:

```luau
-- // Farm
local Tab = Window:CreateTab({ tab = "Farm", section = "meianoite", icon = "flag" })
local Section = Tab:CreateSection("Auto Farm")

local farm = Section:CreateToggle({
    title = "Auto Farm",
    description = "Farma automaticamente",
    default = false,
    callback = function(state)
        print("Auto Farm:", state)
    end,
})

Section:CreateSlider({
    title = "Delay",
    min = 0,
    max = 5,
    default = 1,
    rounding = 1,
    suffix = "s",
    callback = function(value)
        print("Delay:", value)
    end,
})

Section:CreateButton({
    title = "Teleportar",
    callback = function()
        print("teleportou")
    end,
})
```

---

## 9. Criando um element novo

Os elements ficam em `Librarys.Elements.List`. Para criar um novo, registre o construtor com um nome e depois chame com `CreateElement`.

```luau
-- // Element Label
Librarys.Elements.Register("Label", function(section, opts)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = opts.text
    label.Font = Librarys.FONT
    label.TextSize = 13
    label.TextColor3 = Librarys.Theme.TextPrimary
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = section.frame

    return {
        SetText = function(_, text)
            label.Text = text
        end
    }
end)

-- // Usar Label
local info = Section:CreateElement("Label", { text = "Olá" })
info:SetText("Novo texto")
```

- O construtor recebe `section` (use `section.frame` como pai) e `opts` (a tabela que você passou).
- O que o construtor retornar é o objeto que você usa depois.
- Se `opts` tiver `name`, `title`, `text` ou `label`, o element entra automaticamente na pesquisa da janela.
- Quem registra o element precisa carregar antes de quem usa. Se o element novo está numa feature, carregue essa feature primeiro.

---

## 10. Uma pasta por jogo

Para usar o mesmo script principal em vários jogos, escolha a pasta pelo `PlaceId`:

```luau
-- // Jogos
local Jogos = {
    [123456789] = "meianoite",
    [987654321] = "boneville",
}

-- // Carregar Jogo
local pasta = Jogos[game.PlaceId]

if pasta then
    Windows:LoadFeature(pasta)
end
```

Troque os números e os nomes pelos seus. Cada jogo carrega só a própria pasta.

Se quiser carregar features comuns a todos os jogos e depois as do jogo atual:

```luau
-- // Features Gerais
Windows:LoadFeatures({ "Visual", "Player" })

-- // Features do Jogo
local pasta = Jogos[game.PlaceId]

if pasta then
    Windows:LoadFeature(pasta)
end
```

---

## 11. Ordem de carregamento

- `LoadFeatures` carrega exatamente na ordem da lista.
- Pasta inteira (`LoadFeature("pasta")`) carrega em ordem alfabética dos nomes dos arquivos.
- As tabs aparecem na janela na ordem em que foram criadas. A primeira tab criada fica selecionada.
- Se a ordem das tabs importa, use a lista, ou nomeie os arquivos para a ordem alfabética ficar certa (`1_Combate.luau`, `2_Visual.luau`).

---

## 12. Erros e notificações

| Notificação | Causa |
|-------------|-------|
| `Use Window:LoadFeature(...), nao Librarys:LoadFeature(...)` | você chamou com `Librarys:` em vez da janela |
| `LoadFeature precisa de um nome ou link` | passou vazio ou algo que não é texto |
| `Feature nao encontrada: nome` | nenhum caminho existe no GitHub |
| `Falha ao baixar: nome` | o link existe mas o download falhou |
| Título com o nome da feature e uma mensagem | erro de sintaxe ou erro ao rodar o arquivo |

Dicas:

- Confira se o nome do arquivo no GitHub tem a mesma capitalização. `combate.luau` e `Combate.luau` são diferentes.
- O GitHub pode demorar alguns minutos para atualizar o arquivo depois de um commit (cache do `raw`).
- Uma feature com erro não derruba as outras.

---

## 13. Referência rápida

```luau
-- // API
Windows:LoadFeature("Combate")
Windows:LoadFeature("meianoite/Farm")
Windows:LoadFeature("meianoite")
Windows:LoadFeature("https://link/direto.luau")
Windows:LoadFeatures({ "Combate", "meianoite/Farm", "Visual" })

-- // Dentro da feature
Window:CreateTab({ tab = "Nome", section = "Grupo", icon = "icone" })
Tab:CreateSection("Titulo")
Section:CreateToggle({ title = "X", default = false, callback = function(state) end })
Section:CreateButton({ title = "X", callback = function() end })
Section:CreateSlider({ title = "X", min = 0, max = 100, default = 50, callback = function(value) end })
Section:CreateDropdown({ title = "X", values = { "A", "B" }, default = "A", callback = function(value) end })
Section:CreateColorPicker({ title = "X", default = Color3.new(1, 1, 1), callback = function(color) end })
Section:CreateParagraph({ title = "X", description = "Texto" })
Section:CreateElement("NomeRegistrado", { text = "X" })

-- // Config da lib
Librarys.FeaturesUrl = "https://raw.githubusercontent.com/EcohubPassouAqui/rip_sheldoohz/refs/heads/main/library/features/"
Librarys.FeaturesApi = "https://api.github.com/repos/EcohubPassouAqui/rip_sheldoohz/contents/library/features/"
Librarys.FeaturesBranch = "main"
```

`FeaturesUrl`, `FeaturesApi` e `FeaturesBranch` só precisam ser mudados se você mover as features para outro repositório ou outra branch.