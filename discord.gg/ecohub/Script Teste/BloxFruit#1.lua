local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Blox Fruit - EcoHub",
    SubTitle = "By rip_sheldoohz - discord.gg/ecohub",
    TabWidth = 160,
    Size = UDim2.fromOffset(550, 350),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

if game.PlaceId == 2753915549 then
    World1 = true
elseif game.PlaceId == 4442272183 then
    World2 = true
elseif game.PlaceId == 7449423635 then
    World3 = true
end

local Tabs = {
    Farm = Window:AddTab({ Title = "Farming", Icon = "home" }),
}

--Farm Quest
function MaterialMon()
    if _G.SelectMaterial ~= "Radiactive Material" then
        if _G.SelectMaterial ~= "Leather + Scrap Metal" then
            if _G.SelectMaterial ~= "Magma Ore" then
                if _G.SelectMaterial ~= "Fish Tail" then
                    if _G.SelectMaterial == "Angel Wings" then
                        MMon = "Royal Soldier"
                        MPos = CFrame.new(-7759.45898, 5606.93652, -1862.70276, -0.866007447, 0, -0.500031412, 0, 1, 0, 0.500031412, 0, -0.866007447)
                        SP = "SkyArea2"
                    elseif _G.SelectMaterial == "Mystic Droplet" then
                        MMon = "Water Fighter"
                        MPos = CFrame.new(-3331.70459, 239.138336, -10553.3564, -0.29242146, 0, 0.95628953, 0, 1, 0, -0.95628953, 0, -0.29242146)
                        SP = "ForgottenIsland"
                    elseif _G.SelectMaterial == "Vampire Fang" then
                        MMon = "Vampire"
                        MPos = CFrame.new(-6132.39453, 9.00769424, -1466.16919, -0.927179813, 0, -0.374617696, 0, 1, 0, 0.374617696, 0, -0.927179813)
                        SP = "Graveyard"
                    elseif _G.SelectMaterial == "Gunpowder" then
                        MMon = "Pistol Billionaire"
                        MPos = CFrame.new(-185.693283, 84.7088699, 6103.62744, 0.90629667, 0, -0.422642082, 0, 1, 0, 0.422642082, 0, 0.90629667)
                        SP = "Mansion"
                    elseif _G.SelectMaterial ~= "Mini Tusk" then
                        if _G.SelectMaterial == "Conjured Cocoa" then
                            MMon = "Chocolate Bar Battler"
                            MPos = CFrame.new(582.828674, 25.5824986, -12550.7041, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
                            SP = "Chocolate"
                        end
                    else
                        MMon = "Mythological Pirate"
                        MPos = CFrame.new(-13456.0498, 469.433228, -7039.96436, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                        SP = "BigMansion"
                    end
                elseif game.PlaceId == 2753915549 then
                    MMon = "Fishman Warrior"
                    MPos = CFrame.new(60943.9023, 17.9492188, 1744.11133, 0.826706648, 0, -0.562633216, 0, 1, 0, 0.562633216, 0, 0.826706648)
                    SP = "Underwater City"
                    MMon = "Fishman Commando"
                    MPos = CFrame.new(61760.8984, 18.0800781, 1460.11133, -0.632549644, 0, -0.774520278, 0, 1, 0, 0.774520278, 0, -0.632549644)
                    SP = "Underwater City"
                elseif game.PlaceId == 7449423635 then
                    MMon = "Fishman Captain"
                    MPos = CFrame.new(-10828.1064, 331.825989, -9049.14648, -0.0912091732, 0, 0.995831788, 0, 1, 0, -0.995831788, 0, -0.0912091732)
                    SP = "PineappleTown"
                end
            elseif game.PlaceId == 2753915549 then
                MMon = "Military Soldier"
                MPos = CFrame.new(-5565.60156, 9.10001755, 8327.56934, -0.838688731, 0, -0.544611216, 0, 1, 0, 0.544611216, 0, -0.838688731)
                SP = "Magma"
                MMon = "Military Spy"
                MPos = CFrame.new(-5806.70068, 78.5000458, 8904.46973, 0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, 0.707134247)
                SP = "Magma"
            elseif game.PlaceId == 4442272183 then
                MMon = "Lava Pirate"
                MPos = CFrame.new(-5158.77051, 14.4791956, -4654.2627, -0.848060489, 0, -0.529899538, 0, 1, 0, 0.529899538, 0, -0.848060489)
                SP = "CircleIslandFire"
            end
        elseif game.PlaceId == 2753915549 then
            MMon = "Pirate"
            MPos = CFrame.new(-967.433105, 13.5999937, 4034.24707, -0.258864403, 0, -0.965913713, 0, 1, 0, 0.965913713, 0, -0.258864403)
            SP = "Pirate"
            MMon = "Brute"
            MPos = CFrame.new(-1191.41235, 15.5999985, 4235.50928, 0.629286051, 0, -0.777173758, 0, 1, 0, 0.777173758, 0, 0.629286051)
            SP = "Pirate"
        elseif game.PlaceId ~= 4442272183 then
            if game.PlaceId == 7449423635 then
                MMon = "Pirate Millionaire"
                MPos = CFrame.new(-118.809372, 55.4874573, 5649.17041, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
                SP = "Default"
            end
        else
            MMon = "Mercenary"
            MPos = CFrame.new(-986.774475, 72.8755951, 1088.44653, -0.656062722, 0, 0.754706323, 0, 1, 0, -0.754706323, 0, -0.656062722)
            SP = "DressTown"
        end
    else
        MMon = "Factory Staff"
        MPos = CFrame.new(-105.889565, 72.8076935, -670.247986, -0.965929747, 0, -0.258804798, 0, 1, 0, 0.258804798, 0, -0.965929747)
        SP = "Bar"
    end
end
function CheckQuest()
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    if World1 then
        if MyLevel >= 1 and MyLevel <= 9 or SelectMonster == "Bandit" then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, -0, 1, -0, 0.341998369, -0, 0.939700544)
            CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
        elseif (MyLevel < 10 or MyLevel > 14) and SelectMonster ~= "Monkey" then
            if (MyLevel < 15 or MyLevel > 29) and SelectMonster ~= "Gorilla" then
                if (MyLevel < 30 or MyLevel > 39) and SelectMonster ~= "Pirate" then
                    if (MyLevel < 40 or MyLevel > 59) and SelectMonster ~= "Brute" then
                        if MyLevel >= 60 and MyLevel <= 74 or SelectMonster == "Desert Bandit" then
                            Mon = "Desert Bandit"
                            LevelQuest = 1
                            NameQuest = "DesertQuest"
                            NameMon = "Desert Bandit"
                            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, -0, 1, -0, 0.573571265, -0, 0.819155693)
                            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
                        elseif (MyLevel < 75 or MyLevel > 89) and SelectMonster ~= "Desert Officer" then
                            if (MyLevel < 90 or MyLevel > 99) and SelectMonster ~= "Snow Bandit" then
                                if MyLevel >= 100 and MyLevel <= 119 or SelectMonster == "Snowman" then
                                    Mon = "Snowman"
                                    LevelQuest = 2
                                    NameQuest = "SnowQuest"
                                    NameMon = "Snowman"
                                    CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, -0, 0.939684391, -0, 1, -0, -0.939684391, -0, -0.342042685)
                                    CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
                                elseif (MyLevel < 120 or MyLevel > 149) and SelectMonster ~= "Chief Petty Officer" then
                                    if (MyLevel < 150 or MyLevel > 174) and SelectMonster ~= "Sky Bandit" then
                                        if (MyLevel < 175 or MyLevel > 189) and SelectMonster ~= "Dark Master" then
                                            if MyLevel >= 190 and MyLevel <= 209 or SelectMonster == "Prisoner" then
                                                Mon = "Prisoner"
                                                LevelQuest = 1
                                                NameQuest = "PrisonerQuest"
                                                NameMon = "Prisoner"
                                                CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918E-9, -0.995993316, 1.60817859E-9, 1, -5.16744869E-9, 0.995993316, -2.06384709E-9, -0.0894274712)
                                                CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
                                            elseif (MyLevel < 210 or MyLevel > 249) and SelectMonster ~= "Dangerous Prisone" then
                                                if MyLevel >= 250 and MyLevel <= 274 or SelectMonster == "Toga Warrior" then
                                                    Mon = "Toga Warrior"
                                                    LevelQuest = 1
                                                    NameQuest = "ColosseumQuest"
                                                    NameMon = "Toga Warrior"
                                                    CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, -0, -0.857167721, -0, 1, -0, 0.857167721, -0, -0.515037298)
                                                    CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
                                                elseif (MyLevel < 275 or MyLevel > 299) and SelectMonster ~= "Gladiator" then
                                                    if (MyLevel < 300 or MyLevel > 324) and SelectMonster ~= "Military Soldier" then
                                                        if (MyLevel < 325 or MyLevel > 374) and SelectMonster ~= "Military Spy" then
                                                            if (MyLevel < 375 or MyLevel > 399) and SelectMonster ~= "Fishman Warrior" then
                                                                if (MyLevel < 400 or MyLevel > 449) and SelectMonster ~= "Fishman Commando" then
                                                                    if MyLevel >= 450 and MyLevel <= 474 or SelectMonster == "God's Guard" then
                                                                        Mon = "God's Guard"
                                                                        LevelQuest = 1
                                                                        NameQuest = "SkyExp1Quest"
                                                                        NameMon = "God's Guard"
                                                                        CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, -0, 1, -0, 0.0871884301, -0, 0.996191859)
                                                                        CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
                                                                        if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688))
                                                                        end
                                                                    elseif MyLevel >= 475 and MyLevel <= 524 or SelectMonster == "Shanda" then
                                                                        Mon = "Shanda"
                                                                        LevelQuest = 2
                                                                        NameQuest = "SkyExp1Quest"
                                                                        NameMon = "Shanda"
                                                                        CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, -0, 0.906319618, -0, 1, -0, -0.906319618, -0, -0.422592998)
                                                                        CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
                                                                        if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
                                                                        end
                                                                    elseif MyLevel >= 525 and MyLevel <= 549 or SelectMonster == "Royal Squad" then
                                                                        Mon = "Royal Squad"
                                                                        LevelQuest = 1
                                                                        NameQuest = "SkyExp2Quest"
                                                                        NameMon = "Royal Squad"
                                                                        CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                                        CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
                                                                    elseif (MyLevel < 550 or MyLevel > 624) and SelectMonster ~= "Royal Soldier" then
                                                                        if MyLevel >= 625 and MyLevel <= 649 or SelectMonster == "Galley Pirate" then
                                                                            Mon = "Galley Pirate"
                                                                            LevelQuest = 1
                                                                            NameQuest = "FountainQuest"
                                                                            NameMon = "Galley Pirate"
                                                                            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, 0.087131381)
                                                                            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
                                                                        elseif MyLevel >= 650 or SelectMonster == "Galley Captain" then
                                                                            Mon = "Galley Captain"
                                                                            LevelQuest = 2
                                                                            NameQuest = "FountainQuest"
                                                                            NameMon = "Galley Captain"
                                                                            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, 0.087131381)
                                                                            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
                                                                        end
                                                                    else
                                                                        Mon = "Royal Soldier"
                                                                        LevelQuest = 2
                                                                        NameQuest = "SkyExp2Quest"
                                                                        NameMon = "Royal Soldier"
                                                                        CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                                        CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
                                                                    end
                                                                else
                                                                    Mon = "Fishman Commando"
                                                                    LevelQuest = 2
                                                                    NameQuest = "FishmanQuest"
                                                                    NameMon = "Fishman Commando"
                                                                    CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                                                                    CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
                                                                    if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                                                    end
                                                                end
                                                            else
                                                                Mon = "Fishman Warrior"
                                                                LevelQuest = 1
                                                                NameQuest = "FishmanQuest"
                                                                NameMon = "Fishman Warrior"
                                                                CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                                                                CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
                                                                if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                                                end
                                                            end
                                                        else
                                                            Mon = "Military Spy"
                                                            LevelQuest = 2
                                                            NameQuest = "MagmaQuest"
                                                            NameMon = "Military Spy"
                                                            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, -0.499959469)
                                                            CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
                                                        end
                                                    else
                                                        Mon = "Military Soldier"
                                                        LevelQuest = 1
                                                        NameQuest = "MagmaQuest"
                                                        NameMon = "Military Soldier"
                                                        CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, -0.499959469)
                                                        CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
                                                    end
                                                else
                                                    Mon = "Gladiator"
                                                    LevelQuest = 2
                                                    NameQuest = "ColosseumQuest"
                                                    NameMon = "Gladiator"
                                                    CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, -0, -0.857167721, -0, 1, -0, 0.857167721, -0, -0.515037298)
                                                    CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
                                                end
                                            else
                                                Mon = "Dangerous Prisoner"
                                                LevelQuest = 2
                                                NameQuest = "PrisonerQuest"
                                                NameMon = "Dangerous Prisoner"
                                                CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918E-9, -0.995993316, 1.60817859E-9, 1, -5.16744869E-9, 0.995993316, -2.06384709E-9, -0.0894274712)
                                                CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
                                            end
                                        else
                                            Mon = "Dark Master"
                                            LevelQuest = 2
                                            NameQuest = "SkyQuest"
                                            NameMon = "Dark Master"
                                            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                                            CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
                                        end
                                    else
                                        Mon = "Sky Bandit"
                                        LevelQuest = 1
                                        NameQuest = "SkyQuest"
                                        NameMon = "Sky Bandit"
                                        CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                                        CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
                                    end
                                else
                                    Mon = "Chief Petty Officer"
                                    LevelQuest = 1
                                    NameQuest = "MarineQuest2"
                                    NameMon = "Chief Petty Officer"
                                    CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                    CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
                                end
                            else
                                Mon = "Snow Bandit"
                                LevelQuest = 1
                                NameQuest = "SnowQuest"
                                NameMon = "Snow Bandit"
                                CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, -0, 0.939684391, -0, 1, -0, -0.939684391, -0, -0.342042685)
                                CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
                            end
                        else
                            Mon = "Desert Officer"
                            LevelQuest = 2
                            NameQuest = "DesertQuest"
                            NameMon = "Desert Officer"
                            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, -0, 1, -0, 0.573571265, -0, 0.819155693)
                            CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
                        end
                    else
                        Mon = "Brute"
                        LevelQuest = 2
                        NameQuest = "BuggyQuest1"
                        NameMon = "Brute"
                        CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                        CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
                    end
                else
                    Mon = "Pirate"
                    LevelQuest = 1
                    NameQuest = "BuggyQuest1"
                    NameMon = "Pirate"
                    CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                    CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
                end
            else
                Mon = "Gorilla"
                LevelQuest = 2
                NameQuest = "JungleQuest"
                NameMon = "Gorilla"
                CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
            end
        else
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, -0, -0, 1, -0, 1, -0, -1, -0, -0)
            CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
        end
    elseif not World2 then
        if World3 then
            if MyLevel >= 1500 and MyLevel <= 1524 or SelectMonster == "Pirate Millionaire" then
                Mon = "Pirate Millionaire"
                LevelQuest = 1
                NameQuest = "PiratePortQuest"
                NameMon = "Pirate Millionaire"
                CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607, 0.957107544, -0, -0.289732844, -0, 1, -0, 0.289732844, -0, 0.957107544)
                CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
            elseif (MyLevel < 1525 or MyLevel > 1574) and SelectMonster ~= "Pistol Billionaire" then
                if MyLevel >= 1575 and MyLevel <= 1599 or SelectMonster == "Dragon Crew Warrior" then
                    Mon = "Dragon Crew Warrior"
                    LevelQuest = 1
                    NameQuest = "DragonCrewQuest"
                    NameMon = "Dragon Crew Warrior"
                    CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
                    CFrameMon = CFrame.new(6709.76367, 52.3442993, -1139.02966, -0.763515472, -0, 0.645789504, -0, 1, -0, -0.645789504, -0, -0.763515472)
                elseif MyLevel >= 1600 and MyLevel <= 1624 or SelectMonster == "Dragon Crew Archer" then
                    Mon = "Dragon Crew Archer"
                    NameQuest = "DragonCrewQuest"
                    LevelQuest = 2
                    NameMon = "Dragon Crew Archer"
                    CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
                    CFrameMon = CFrame.new(6668.76172, 481.376923, 329.12207, -0.121787429, -0, -0.992556155, -0, 1, -0, 0.992556155, -0, -0.121787429)
                elseif (MyLevel < 1625 or MyLevel > 1649) and SelectMonster ~= "Hydra Enforcer" then
                    if (MyLevel < 1650 or MyLevel > 1699) and SelectMonster ~= "Venomous Assailant" then
                        if (MyLevel < 1700 or MyLevel > 1724) and SelectMonster ~= "Marine Commodore" then
                            if (MyLevel < 1725 or MyLevel > 1774) and SelectMonster ~= "Marine Rear Admiral" then
                                if (MyLevel < 1775 or MyLevel > 1799) and SelectMonster ~= "Fishman Raider" then
                                    if MyLevel >= 1800 and MyLevel <= 1824 or SelectMonster == "Fishman Captain" then
                                        Mon = "Fishman Captain"
                                        LevelQuest = 2
                                        NameQuest = "DeepForestIsland3"
                                        NameMon = "Fishman Captain"
                                        CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                                        CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
                                    elseif (MyLevel < 1825 or MyLevel > 1849) and SelectMonster ~= "Forest Pirate" then
                                        if (MyLevel < 1850 or MyLevel > 1899) and SelectMonster ~= "Mythological Pirate" then
                                            if MyLevel >= 1900 and MyLevel <= 1924 or SelectMonster == "Jungle Pirate" then
                                                Mon = "Jungle Pirate"
                                                LevelQuest = 1
                                                NameQuest = "DeepForestIsland2"
                                                NameMon = "Jungle Pirate"
                                                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, -0.0871315002)
                                                CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
                                            elseif MyLevel >= 1925 and MyLevel <= 1974 or SelectMonster == "Musketeer Pirate" then
                                                Mon = "Musketeer Pirate"
                                                LevelQuest = 2
                                                NameQuest = "DeepForestIsland2"
                                                NameMon = "Musketeer Pirate"
                                                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, -0.0871315002)
                                                CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
                                            elseif MyLevel >= 1975 and MyLevel <= 1999 or SelectMonster == "Reborn Skeleton" then
                                                Mon = "Reborn Skeleton"
                                                LevelQuest = 1
                                                NameQuest = "HauntedQuest1"
                                                NameMon = "Reborn Skeleton"
                                                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                                                CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
                                            elseif (MyLevel < 2000 or MyLevel > 2024) and SelectMonster ~= "Living Zombie" then
                                                if MyLevel >= 2025 and MyLevel <= 2049 or SelectMonster == "Demonic Soul" then
                                                    Mon = "Demonic Soul"
                                                    LevelQuest = 1
                                                    NameQuest = "HauntedQuest2"
                                                    NameMon = "Demonic Soul"
                                                    CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                    CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
                                                elseif MyLevel >= 2050 and MyLevel <= 2074 or SelectMonster == "Posessed Mummy" then
                                                    Mon = "Posessed Mummy"
                                                    LevelQuest = 2
                                                    NameQuest = "HauntedQuest2"
                                                    NameMon = "Posessed Mummy"
                                                    CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                    CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
                                                elseif (MyLevel < 2075 or MyLevel > 2099) and SelectMonster ~= "Peanut Scout" then
                                                    if MyLevel >= 2100 and MyLevel <= 2124 or SelectMonster == "Peanut President" then
                                                        Mon = "Peanut President"
                                                        LevelQuest = 2
                                                        NameQuest = "NutsIslandQuest"
                                                        NameMon = "Peanut President"
                                                        CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                        CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
                                                    elseif MyLevel >= 2125 and MyLevel <= 2149 or SelectMonster == "Ice Cream Chef" then
                                                        Mon = "Ice Cream Chef"
                                                        LevelQuest = 1
                                                        NameQuest = "IceCreamIslandQuest"
                                                        NameMon = "Ice Cream Chef"
                                                        CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                        CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
                                                    elseif MyLevel >= 2150 and MyLevel <= 2199 or SelectMonster == "Ice Cream Commander" then
                                                        Mon = "Ice Cream Commander"
                                                        LevelQuest = 2
                                                        NameQuest = "IceCreamIslandQuest"
                                                        NameMon = "Ice Cream Commander"
                                                        CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                        CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
                                                    elseif MyLevel >= 2200 and MyLevel <= 2224 or SelectMonster == "Cookie Crafter" then
                                                        Mon = "Cookie Crafter"
                                                        LevelQuest = 1
                                                        NameQuest = "CakeQuest1"
                                                        NameMon = "Cookie Crafter"
                                                        CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053E-8, 0.288177818, 6.9301187E-8, 1, 7.51931211E-8, -0.288177818, -5.2032135E-8, 0.957576931)
                                                        CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
                                                    elseif (MyLevel < 2225 or MyLevel > 2249) and SelectMonster ~= "Cake Guard" then
                                                        if MyLevel >= 2250 and MyLevel <= 2274 or SelectMonster == "Baking Staff" then
                                                            Mon = "Baking Staff"
                                                            LevelQuest = 1
                                                            NameQuest = "CakeQuest2"
                                                            NameMon = "Baking Staff"
                                                            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143E-8, 0.250778586, 4.74911062E-8, 1, 1.49904711E-8, -0.250778586, 2.64211941E-8, -0.96804446)
                                                            CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
                                                        elseif MyLevel >= 2275 and MyLevel <= 2299 or SelectMonster == "Head Baker" then
                                                            Mon = "Head Baker"
                                                            LevelQuest = 2
                                                            NameQuest = "CakeQuest2"
                                                            NameMon = "Head Baker"
                                                            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143E-8, 0.250778586, 4.74911062E-8, 1, 1.49904711E-8, -0.250778586, 2.64211941E-8, -0.96804446)
                                                            CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
                                                        elseif (MyLevel < 2300 or MyLevel > 2324) and SelectMonster ~= "Cocoa Warrior" then
                                                            if MyLevel >= 2325 and MyLevel <= 2349 or SelectMonster == "Chocolate Bar Battler" then
                                                                Mon = "Chocolate Bar Battler"
                                                                LevelQuest = 2
                                                                NameQuest = "ChocQuest1"
                                                                NameMon = "Chocolate Bar Battler"
                                                                CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
                                                                CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
                                                            elseif MyLevel >= 2350 and MyLevel <= 2374 or SelectMonster == "Sweet Thief" then
                                                                Mon = "Sweet Thief"
                                                                LevelQuest = 1
                                                                NameQuest = "ChocQuest2"
                                                                NameMon = "Sweet Thief"
                                                                CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
                                                                CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
                                                            elseif MyLevel >= 2375 and MyLevel <= 2399 or SelectMonster == "Candy Rebel" then
                                                                Mon = "Candy Rebel"
                                                                LevelQuest = 2
                                                                NameQuest = "ChocQuest2"
                                                                NameMon = "Candy Rebel"
                                                                CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
                                                                CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
                                                            elseif (MyLevel < 2400 or MyLevel > 2424) and SelectMonster ~= "Candy Pirate" then
                                                                if MyLevel >= 2425 and MyLevel <= 2449 or SelectMonster == "Snow Demon" then
                                                                    Mon = "Snow Demon"
                                                                    LevelQuest = 2
                                                                    NameQuest = "CandyQuest1"
                                                                    NameMon = "Snow Demon"
                                                                    CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
                                                                    CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
                                                                elseif MyLevel >= 2450 and MyLevel <= 2474 or SelectMonster == "Isle Outlaw" then
                                                                    Mon = "Isle Outlaw"
                                                                    LevelQuest = 1
                                                                    NameQuest = "TikiQuest1"
                                                                    NameMon = "Isle Outlaw"
                                                                    CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
                                                                    CFrameMon = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656)
                                                                elseif (MyLevel < 2475 or MyLevel > 2524) and SelectMonster ~= "Island Boy" then
                                                                    if MyLevel >= 2525 and MyLevel <= 2550 or SelectMonster == "Isle Champion" then
                                                                        Mon = "Isle Champion"
                                                                        LevelQuest = 2
                                                                        NameQuest = "TikiQuest2"
                                                                        NameMon = "Isle Champion"
                                                                        CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
                                                                        CFrameMon = CFrame.new(-16641.6796875, 235.7825469970703, 1031.282958984375)
                                                                    elseif (MyLevel < 2550 or MyLevel > 2574) and SelectMonster ~= "Serpent Hunter" then
                                                                        if MyLevel >= 2575 or SelectMonster == "Skull Slayer" then
                                                                            Mon = "Skull Slayer"
                                                                            LevelQuest = 2
                                                                            NameQuest = "TikiQuest3"
                                                                            NameMon = "Skull Slayer"
                                                                            CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, -0, 1, -0, 0.308980465, -0, 0.951068401)
                                                                            CFrameMon = CFrame.new(-16855.043, 122.457253, 1478.15308, -0.999392271, -0, -0.0348687991, -0, 1, -0, 0.0348687991, -0, -0.999392271)
                                                                        end
                                                                    else
                                                                        Mon = "Serpent Hunter"
                                                                        LevelQuest = 1
                                                                        NameQuest = "TikiQuest3"
                                                                        NameMon = "Serpent Hunter"
                                                                        CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, -0, 1, -0, 0.308980465, -0, 0.951068401)
                                                                        CFrameMon = CFrame.new(-16521.0625, 106.09285, 1488.78467, 0.469467044, -0, 0.882950008, -0, 1, -0, -0.882950008, -0, 0.469467044)
                                                                    end
                                                                else
                                                                    Mon = "Island Boy"
                                                                    LevelQuest = 2
                                                                    NameQuest = "TikiQuest1"
                                                                    NameMon = "Island Boy"
                                                                    CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
                                                                    CFrameMon = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351562)
                                                                end
                                                            else
                                                                Mon = "Candy Pirate"
                                                                LevelQuest = 1
                                                                NameQuest = "CandyQuest1"
                                                                NameMon = "Candy Pirate"
                                                                CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
                                                                CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
                                                            end
                                                        else
                                                            Mon = "Cocoa Warrior"
                                                            LevelQuest = 1
                                                            NameQuest = "ChocQuest1"
                                                            NameMon = "Cocoa Warrior"
                                                            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
                                                            CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
                                                        end
                                                    else
                                                        Mon = "Cake Guard"
                                                        LevelQuest = 2
                                                        NameQuest = "CakeQuest1"
                                                        NameMon = "Cake Guard"
                                                        CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053E-8, 0.288177818, 6.9301187E-8, 1, 7.51931211E-8, -0.288177818, -5.2032135E-8, 0.957576931)
                                                        CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
                                                    end
                                                else
                                                    Mon = "Peanut Scout"
                                                    LevelQuest = 1
                                                    NameQuest = "NutsIslandQuest"
                                                    NameMon = "Peanut Scout"
                                                    CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                    CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
                                                end
                                            else
                                                Mon = "Living Zombie"
                                                LevelQuest = 2
                                                NameQuest = "HauntedQuest1"
                                                NameMon = "Living Zombie"
                                                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                                                CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
                                            end
                                        else
                                            Mon = "Mythological Pirate"
                                            LevelQuest = 2
                                            NameQuest = "DeepForestIsland"
                                            NameMon = "Mythological Pirate"
                                            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, -0, 1, -0, 0.707079291, -0, 0.707134247)
                                            CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
                                        end
                                    else
                                        Mon = "Forest Pirate"
                                        LevelQuest = 1
                                        NameQuest = "DeepForestIsland"
                                        NameMon = "Forest Pirate"
                                        CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, -0, 1, -0, 0.707079291, -0, 0.707134247)
                                        CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
                                    end
                                else
                                    Mon = "Fishman Raider"
                                    LevelQuest = 1
                                    NameQuest = "DeepForestIsland3"
                                    NameMon = "Fishman Raider"
                                    CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                                    CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
                                end
                            else
                                Mon = "Marine Rear Admiral"
                                LevelQuest = 2
                                NameQuest = "MarineTreeIsland"
                                NameMon = "Marine Rear Admiral"
                                CFrameQuest = CFrame.new(2481.09228515625, 74.27049255371094, -6779.640625)
                                CFrameMon = CFrame.new(3761.81006, 123.912003, -6823.52197, 0.961273968, -0, 0.275594592, -0, 1, -0, -0.275594592, -0, 0.961273968)
                            end
                        else
                            Mon = "Marine Commodore"
                            LevelQuest = 1
                            NameQuest = "MarineTreeIsland"
                            NameMon = "Marine Commodore"
                            CFrameQuest = CFrame.new(2481.09228515625, 74.27049255371094, -6779.640625)
                            CFrameMon = CFrame.new(2577.25391, 75.6100006, -7739.87207, 0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, 0.499959469)
                        end
                    else
                        Mon = "Venomous Assailant"
                        NameQuest = "VenomCrewQuest"
                        LevelQuest = 2
                        NameMon = "Venomous Assailant"
                        CFrameQuest = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
                        CFrameMon = CFrame.new(4674.92676, 1134.82654, 996.308838, 0.731321394, -0, -0.682033002, -0, 1, -0, 0.682033002, -0, 0.731321394)
                    end
                else
                    Mon = "Hydra Enforcer"
                    NameQuest = "VenomCrewQuest"
                    LevelQuest = 1
                    NameMon = "Hydra Enforcer"
                    CFrameQuest = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
                    CFrameMon = CFrame.new(4547.11523, 1003.10217, 334.194824, 0.388810456, -0, -0.921317935, -0, 1, -0, 0.921317935, -0, 0.388810456)
                end
            else
                Mon = "Pistol Billionaire"
                LevelQuest = 2
                NameQuest = "PiratePortQuest"
                NameMon = "Pistol Billionaire"
                CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607, 0.957107544, -0, -0.289732844, -0, 1, -0, 0.289732844, -0, 0.957107544)
                CFrameMon = CFrame.new(-54.8110352, 83.7698746, 5947.84082, -0.965929747, -0, 0.258804798, -0, 1, -0, -0.258804798, -0, -0.965929747)
            end
        end
    elseif (MyLevel < 700 or MyLevel > 724) and SelectMonster ~= "Raider" then
        if MyLevel >= 725 and MyLevel <= 774 or SelectMonster == "Mercenary" then
            Mon = "Mercenary"
            LevelQuest = 2
            NameQuest = "Area1Quest"
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, -0, -0.974368095, -0, 1, -0, 0.974368095, -0, -0.22495985)
            CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
        elseif MyLevel >= 775 and MyLevel <= 799 or SelectMonster == "Swan Pirate" then
            Mon = "Swan Pirate"
            LevelQuest = 1
            NameQuest = "Area2Quest"
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, -0, 0.99026376, -0, 1, -0, -0.99026376, -0, 0.139203906)
            CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
        elseif (MyLevel < 800 or MyLevel > 874) and SelectMonster ~= "Factory Staff" then
            if MyLevel >= 875 and MyLevel <= 899 or SelectMonster == "Marine Lieutenant" then
                Mon = "Marine Lieutenant"
                LevelQuest = 1
                NameQuest = "MarineQuest3"
                NameMon = "Marine Lieutenant"
                CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
            elseif MyLevel >= 900 and MyLevel <= 949 or SelectMonster == "Marine Captain" then
                Mon = "Marine Captain"
                LevelQuest = 2
                NameQuest = "MarineQuest3"
                NameMon = "Marine Captain"
                CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
            elseif (MyLevel < 950 or MyLevel > 974) and SelectMonster ~= "Zombie" then
                if MyLevel >= 975 and MyLevel <= 999 or SelectMonster == "Vampire" then
                    Mon = "Vampire"
                    LevelQuest = 2
                    NameQuest = "ZombieQuest"
                    NameMon = "Vampire"
                    CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, -0, -0.95628953, -0, 1, -0, 0.95628953, -0, -0.29242146)
                    CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
                elseif (MyLevel < 1000 or MyLevel > 1049) and SelectMonster ~= "Snow Trooper" then
                    if MyLevel >= 1050 and MyLevel <= 1099 or SelectMonster == "Winter Warrior" then
                        Mon = "Winter Warrior"
                        LevelQuest = 2
                        NameQuest = "SnowMountainQuest"
                        NameMon = "Winter Warrior"
                        CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, -0, 0.92718488, -0, 1, -0, -0.92718488, -0, -0.374604106)
                        CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
                    elseif MyLevel >= 1100 and MyLevel <= 1124 or SelectMonster == "Lab Subordinate" then
                        Mon = "Lab Subordinate"
                        LevelQuest = 1
                        NameQuest = "IceSideQuest"
                        NameMon = "Lab Subordinate"
                        CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, -0, 1, -0, 0.891015649, -0, 0.453972578)
                        CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
                    elseif MyLevel >= 1125 and MyLevel <= 1174 or SelectMonster == "Horned Warrior" then
                        Mon = "Horned Warrior"
                        LevelQuest = 2
                        NameQuest = "IceSideQuest"
                        NameMon = "Horned Warrior"
                        CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, -0, 1, -0, 0.891015649, -0, 0.453972578)
                        CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
                    elseif (MyLevel < 1175 or MyLevel > 1199) and SelectMonster ~= "Magma Ninja" then
                        if (MyLevel < 1200 or MyLevel > 1249) and SelectMonster ~= "Lava Pirate" then
                            if MyLevel >= 1250 and MyLevel <= 1274 or SelectMonster == "Ship Deckhand" then
                                Mon = "Ship Deckhand"
                                LevelQuest = 1
                                NameQuest = "ShipQuest1"
                                NameMon = "Ship Deckhand"
                                CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
                                CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)
                                if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                end
                            elseif (MyLevel < 1275 or MyLevel > 1299) and SelectMonster ~= "Ship Engineer" then
                                if MyLevel >= 1300 and MyLevel <= 1324 or SelectMonster == "Ship Steward" then
                                    Mon = "Ship Steward"
                                    LevelQuest = 1
                                    NameQuest = "ShipQuest2"
                                    NameMon = "Ship Steward"
                                    CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
                                    CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)
                                    if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                    end
                                elseif (MyLevel < 1325 or MyLevel > 1349) and SelectMonster ~= "Ship Officer" then
                                    if (MyLevel < 1350 or MyLevel > 1374) and SelectMonster ~= "Arctic Warrior" then
                                        if MyLevel >= 1375 and MyLevel <= 1424 or SelectMonster == "Snow Lurker" then
                                            Mon = "Snow Lurker"
                                            LevelQuest = 2
                                            NameQuest = "FrostQuest"
                                            NameMon = "Snow Lurker"
                                            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, -0, -0.358349502, -0, 1, -0, 0.358349502, -0, -0.933587909)
                                            CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
                                        elseif (MyLevel < 1425 or MyLevel > 1449) and SelectMonster ~= "Sea Soldier" then
                                            if MyLevel >= 1450 or SelectMonster == "Water Fighter" then
                                                Mon = "Water Fighter"
                                                LevelQuest = 2
                                                NameQuest = "ForgottenQuest"
                                                NameMon = "Water Fighter"
                                                CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, -0, 1, -0, 0.13915664, -0, 0.990270376)
                                                CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
                                            end
                                        else
                                            Mon = "Sea Soldier"
                                            LevelQuest = 1
                                            NameQuest = "ForgottenQuest"
                                            NameMon = "Sea Soldier"
                                            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, -0, 1, -0, 0.13915664, -0, 0.990270376)
                                            CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
                                        end
                                    else
                                        Mon = "Arctic Warrior"
                                        LevelQuest = 1
                                        NameQuest = "FrostQuest"
                                        NameMon = "Arctic Warrior"
                                        CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, -0, -0.358349502, -0, 1, -0, 0.358349502, -0, -0.933587909)
                                        CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
                                        if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422))
                                        end
                                    end
                                else
                                    Mon = "Ship Officer"
                                    LevelQuest = 2
                                    NameQuest = "ShipQuest2"
                                    NameMon = "Ship Officer"
                                    CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
                                    CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
                                    if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                    end
                                end
                            else
                                Mon = "Ship Engineer"
                                LevelQuest = 2
                                NameQuest = "ShipQuest1"
                                NameMon = "Ship Engineer"
                                CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
                                CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)
                                if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                end
                            end
                        else
                            Mon = "Lava Pirate"
                            LevelQuest = 2
                            NameQuest = "FireSideQuest"
                            NameMon = "Lava Pirate"
                            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                            CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
                        end
                    else
                        Mon = "Magma Ninja"
                        LevelQuest = 1
                        NameQuest = "FireSideQuest"
                        NameMon = "Magma Ninja"
                        CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                        CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
                    end
                else
                    Mon = "Snow Trooper"
                    LevelQuest = 1
                    NameQuest = "SnowMountainQuest"
                    NameMon = "Snow Trooper"
                    CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, -0, 0.92718488, -0, 1, -0, -0.92718488, -0, -0.374604106)
                    CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
                end
            else
                Mon = "Zombie"
                LevelQuest = 1
                NameQuest = "ZombieQuest"
                NameMon = "Zombie"
                CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, -0, -0.95628953, -0, 1, -0, 0.95628953, -0, -0.29242146)
                CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
            end
        else
            Mon = "Factory Staff"
            NameQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881E-10, -0.999488771, 1.36326533E-10, 1, 8.92172336E-10, 0.999488771, -1.07732087E-10, -0.0319722369)
            CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
        end
    else
        Mon = "Raider"
        LevelQuest = 1
        NameQuest = "Area1Quest"
        NameMon = "Raider"
        CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, -0, -0.974368095, -0, 1, -0, 0.974368095, -0, -0.22495985)
        CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
    end
end

--Teleporte Blox Fruit
function Hop()
    local l_PlaceId_0 = game.PlaceId
    local v1 = {}
    local v2 = ""
    local l_hour_0 = os.date("!*t").hour
    local _ = false
    function TPReturner()
        local v5
        if v2 ~= "" then
            v5 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. l_PlaceId_0 .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. v2))
        else
            v5 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. l_PlaceId_0 .. "/servers/Public?sortOrder=Asc&limit=100"))
        end
        local v6 = ""
        if v5.nextPageCursor and v5.nextPageCursor ~= "null" and v5.nextPageCursor ~= "null" then
            v2 = v5.nextPageCursor
        end
        local v7 = 0
        for _, v9 in pairs(v5.data) do
            local v10 = true
            v6 = tostring(v9.id)
            if tonumber(v9.maxPlayers) > tonumber(v9.playing) then
                for _, v12 in pairs(v1) do
                    if v7 ~= 0 then
                        if v6 == tostring(v12) then
                            v10 = false
                        end
                    elseif tonumber(l_hour_0) ~= tonumber(v12) then
                        local _ = pcall(function()
                            v1 = {}
                            table.insert(v1, l_hour_0)
                        end)
                    end
                    v7 = v7 + 1
                end
                if v10 == true then
                    table.insert(v1, v6)
                    wait(0.1)
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(l_PlaceId_0, v6, game.Players.LocalPlayer)
                    end)
                    wait(0.1)
                end
            end
        end
    end
    function Teleport()
        while wait(0.1) do
            pcall(function()
                TPReturner()
                if v2 ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end
function CheckItem(v14)
    for _, v16 in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if v16.Name == v14 then
            return v16
        end
    end
end
function UpdateIslandESP()
    for _, v18 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v18_0 = v18
            pcall(function()
                if IslandESP then
                    if l_v18_0.Name ~= "Sea" then
                        if not l_v18_0:FindFirstChild("NameEsp") then
                            local v20 = Instance.new("BillboardGui", l_v18_0)
                            v20.Name = "NameEsp"
                            v20.ExtentsOffset = Vector3.new(0, 1, 0)
                            v20.Size = UDim2.new(1, 200, 1, 30)
                            v20.Adornee = l_v18_0
                            v20.AlwaysOnTop = true
                            local v21 = Instance.new("TextLabel", v20)
                            v21.Font = "GothamSemibold"
                            v21.FontSize = "Size14"
                            v21.TextWrapped = true
                            v21.Size = UDim2.new(1, 0, 1, 0)
                            v21.TextYAlignment = "Top"
                            v21.BackgroundTransparency = 1
                            v21.TextStrokeTransparency = 0.5
                            v21.TextColor3 = Color3.fromRGB(255, 255, 255)
                        else
                            l_v18_0.NameEsp.TextLabel.Text = l_v18_0.Name .. "   \n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v18_0.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v18_0:FindFirstChild("NameEsp") then
                    l_v18_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
function isnil(v22)
    local v23 = nil
    if v22 ~= v23 then
        local _ = false
    end
    return true
end
local function v26(v25)
    return math.floor(tonumber(v25) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v28 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v28_0 = v28
            pcall(function()
                if not isnil(l_v28_0.Character) then
                    if not ESPPlayer then
                        if l_v28_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v28_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif not isnil(l_v28_0.Character.Head) and not l_v28_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        local v30 = Instance.new("BillboardGui", l_v28_0.Character.Head)
                        v30.Name = "NameEsp" .. Number
                        v30.ExtentsOffset = Vector3.new(0, 1, 0)
                        v30.Size = UDim2.new(1, 200, 1, 30)
                        v30.Adornee = l_v28_0.Character.Head
                        v30.AlwaysOnTop = true
                        local v31 = Instance.new("TextLabel", v30)
                        v31.Font = Enum.Font.GothamSemibold
                        v31.FontSize = "Size14"
                        v31.TextWrapped = true
                        v31.Text = l_v28_0.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v28_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v31.Size = UDim2.new(1, 0, 1, 0)
                        v31.TextYAlignment = "Top"
                        v31.BackgroundTransparency = 1
                        v31.TextStrokeTransparency = 0.5
                        if l_v28_0.Team == game.Players.LocalPlayer.Team then
                            v31.TextColor3 = Color3.new(0, 255, 0)
                        else
                            v31.TextColor3 = Color3.new(255, 0, 0)
                        end
                    else
                        l_v28_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v28_0.Name .. " | " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v28_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v26(l_v28_0.Character.Humanoid.Health * 100 / l_v28_0.Character.Humanoid.MaxHealth) .. "%"
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v33 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v33_0 = v33
            pcall(function()
                if _G.ChestESP then
                    if not l_v33_0:GetAttribute("IsDisabled") then
                        if not l_v33_0:FindFirstChild("ChestEsp") then
                            local v35 = Instance.new("BillboardGui", l_v33_0)
                            v35.Name = "ChestEsp"
                            v35.ExtentsOffset = Vector3.new(0, 1, 0)
                            v35.Size = UDim2.new(1, 200, 1, 30)
                            v35.Adornee = l_v33_0
                            v35.AlwaysOnTop = true
                            local v36 = Instance.new("TextLabel", v35)
                            v36.Font = "Code"
                            v36.FontSize = "Size14"
                            v36.TextWrapped = true
                            v36.Size = UDim2.new(1, 0, 1, 0)
                            v36.TextYAlignment = "Top"
                            v36.BackgroundTransparency = 1
                            v36.TextStrokeTransparency = 0.5
                            v36.TextColor3 = Color3.fromRGB(255, 215, 0)
                        else
                            local v37 = v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v33_0:GetPivot().Position).Magnitude / 3)
                            l_v33_0.ChestEsp.TextLabel.Text = "Chest\n" .. v37 .. " M"
                        end
                    end
                elseif l_v33_0:FindFirstChild("ChestEsp") then
                    l_v33_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v26(v38)
    return math.floor(v38 + 0.5)
end
function UpdateDevilChams()
    for _, v40 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v40_0 = v40
            pcall(function()
                if DevilFruitESP then
                    if string.find(l_v40_0.Name, "Fruit") then
                        if not l_v40_0.Handle:FindFirstChild("NameEsp" .. Number) then
                            local v42 = Instance.new("BillboardGui", l_v40_0.Handle)
                            v42.Name = "NameEsp" .. Number
                            v42.ExtentsOffset = Vector3.new(0, 1, 0)
                            v42.Size = UDim2.new(1, 200, 1, 30)
                            v42.Adornee = l_v40_0.Handle
                            v42.AlwaysOnTop = true
                            local v43 = Instance.new("TextLabel", v42)
                            v43.Font = Enum.Font.GothamSemibold
                            v43.FontSize = "Size14"
                            v43.TextWrapped = true
                            v43.Size = UDim2.new(1, 0, 1, 0)
                            v43.TextYAlignment = "Top"
                            v43.BackgroundTransparency = 1
                            v43.TextStrokeTransparency = 0.5
                            v43.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v43.Text = l_v40_0.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v40_0.Handle.Position).Magnitude / 3) .. " Distance"
                        else
                            l_v40_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v40_0.Name .. "   \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v40_0.Handle.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v40_0.Handle:FindFirstChild("NameEsp" .. Number) then
                    l_v40_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end)
        end
    end
end
function UpdateFlowerChams()
    for _, v45 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v45_0 = v45
            pcall(function()
                if l_v45_0.Name == "Flower2" or l_v45_0.Name == "Flower1" then
                    if FlowerESP then
                        if l_v45_0:FindFirstChild("NameEsp" .. Number) then
                            l_v45_0["NameEsp" .. Number].TextLabel.Text = l_v45_0.Name .. "   \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v45_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v47 = Instance.new("BillboardGui", l_v45_0)
                            v47.Name = "NameEsp" .. Number
                            v47.ExtentsOffset = Vector3.new(0, 1, 0)
                            v47.Size = UDim2.new(1, 200, 1, 30)
                            v47.Adornee = l_v45_0
                            v47.AlwaysOnTop = true
                            local v48 = Instance.new("TextLabel", v47)
                            v48.Font = Enum.Font.GothamSemibold
                            v48.FontSize = "Size14"
                            v48.TextWrapped = true
                            v48.Size = UDim2.new(1, 0, 1, 0)
                            v48.TextYAlignment = "Top"
                            v48.BackgroundTransparency = 1
                            v48.TextStrokeTransparency = 0.5
                            v48.TextColor3 = Color3.fromRGB(255, 0, 0)
                            if l_v45_0.Name == "Flower1" then
                                v48.Text = "Blue Flower" .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v45_0.Position).Magnitude / 3) .. " Distance"
                                v48.TextColor3 = Color3.fromRGB(0, 0, 255)
                            end
                            if l_v45_0.Name == "Flower2" then
                                v48.Text = "Red Flower" .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v45_0.Position).Magnitude / 3) .. " Distance"
                                v48.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end
                    elseif l_v45_0:FindFirstChild("NameEsp" .. Number) then
                        l_v45_0:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v50 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v50:IsA("Tool") then
            if not RealFruitESP then
                if v50.Handle:FindFirstChild("NameEsp" .. Number) then
                    v50.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif v50.Handle:FindFirstChild("NameEsp" .. Number) then
                v50.Handle["NameEsp" .. Number].TextLabel.Text = v50.Name .. " " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v50.Handle.Position).Magnitude / 3) .. " Distance"
            else
                local v51 = Instance.new("BillboardGui", v50.Handle)
                v51.Name = "NameEsp" .. Number
                v51.ExtentsOffset = Vector3.new(0, 1, 0)
                v51.Size = UDim2.new(1, 200, 1, 30)
                v51.Adornee = v50.Handle
                v51.AlwaysOnTop = true
                local v52 = Instance.new("TextLabel", v51)
                v52.Font = Enum.Font.GothamSemibold
                v52.FontSize = "Size14"
                v52.TextWrapped = true
                v52.Size = UDim2.new(1, 0, 1, 0)
                v52.TextYAlignment = "Top"
                v52.BackgroundTransparency = 1
                v52.TextStrokeTransparency = 0.5
                v52.TextColor3 = Color3.fromRGB(255, 0, 0)
                v52.Text = v50.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v50.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v54 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v54:IsA("Tool") then
            if RealFruitESP then
                if v54.Handle:FindFirstChild("NameEsp" .. Number) then
                    v54.Handle["NameEsp" .. Number].TextLabel.Text = v54.Name .. " " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v54.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v55 = Instance.new("BillboardGui", v54.Handle)
                    v55.Name = "NameEsp" .. Number
                    v55.ExtentsOffset = Vector3.new(0, 1, 0)
                    v55.Size = UDim2.new(1, 200, 1, 30)
                    v55.Adornee = v54.Handle
                    v55.AlwaysOnTop = true
                    local v56 = Instance.new("TextLabel", v55)
                    v56.Font = Enum.Font.GothamSemibold
                    v56.FontSize = "Size14"
                    v56.TextWrapped = true
                    v56.Size = UDim2.new(1, 0, 1, 0)
                    v56.TextYAlignment = "Top"
                    v56.BackgroundTransparency = 1
                    v56.TextStrokeTransparency = 0.5
                    v56.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v56.Text = v54.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v54.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v54.Handle:FindFirstChild("NameEsp" .. Number) then
                v54.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v58 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v58:IsA("Tool") then
            if RealFruitESP then
                if not v58.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v59 = Instance.new("BillboardGui", v58.Handle)
                    v59.Name = "NameEsp" .. Number
                    v59.ExtentsOffset = Vector3.new(0, 1, 0)
                    v59.Size = UDim2.new(1, 200, 1, 30)
                    v59.Adornee = v58.Handle
                    v59.AlwaysOnTop = true
                    local v60 = Instance.new("TextLabel", v59)
                    v60.Font = Enum.Font.GothamSemibold
                    v60.FontSize = "Size14"
                    v60.TextWrapped = true
                    v60.Size = UDim2.new(1, 0, 1, 0)
                    v60.TextYAlignment = "Top"
                    v60.BackgroundTransparency = 1
                    v60.TextStrokeTransparency = 0.5
                    v60.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v60.Text = v58.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v58.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v58.Handle["NameEsp" .. Number].TextLabel.Text = v58.Name .. " " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v58.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v58.Handle:FindFirstChild("NameEsp" .. Number) then
                v58.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
function UpdateIslandESP()
    for _, v62 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v62_0 = v62
            pcall(function()
                if IslandESP then
                    if l_v62_0.Name ~= "Sea" then
                        if not l_v62_0:FindFirstChild("NameEsp") then
                            local v64 = Instance.new("BillboardGui", l_v62_0)
                            v64.Name = "NameEsp"
                            v64.ExtentsOffset = Vector3.new(0, 1, 0)
                            v64.Size = UDim2.new(1, 200, 1, 30)
                            v64.Adornee = l_v62_0
                            v64.AlwaysOnTop = true
                            local v65 = Instance.new("TextLabel", v64)
                            v65.Font = "GothamSemibold"
                            v65.FontSize = "Size14"
                            v65.TextWrapped = true
                            v65.Size = UDim2.new(1, 0, 1, 0)
                            v65.TextYAlignment = "Top"
                            v65.BackgroundTransparency = 1
                            v65.TextStrokeTransparency = 0.5
                            v65.TextColor3 = Color3.fromRGB(8, 247, 255)
                        else
                            l_v62_0.NameEsp.TextLabel.Text = l_v62_0.Name .. "   \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v62_0.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v62_0:FindFirstChild("NameEsp") then
                    l_v62_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
function isnil(v66)
    local v67 = nil
    if v66 ~= v67 then
        local _ = false
    end
    return true
end
local function v70(v69)
    return math.floor(tonumber(v69) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v72 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v72_0 = v72
            pcall(function()
                if not isnil(l_v72_0.Character) then
                    if ESPPlayer then
                        if not isnil(l_v72_0.Character.Head) and not l_v72_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            local v74 = Instance.new("BillboardGui", l_v72_0.Character.Head)
                            v74.Name = "NameEsp" .. Number
                            v74.ExtentsOffset = Vector3.new(0, 1, 0)
                            v74.Size = UDim2.new(1, 200, 1, 30)
                            v74.Adornee = l_v72_0.Character.Head
                            v74.AlwaysOnTop = true
                            local v75 = Instance.new("TextLabel", v74)
                            v75.Font = Enum.Font.GothamSemibold
                            v75.FontSize = "Size14"
                            v75.TextWrapped = true
                            v75.Text = l_v72_0.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v72_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v75.Size = UDim2.new(1, 0, 1, 0)
                            v75.TextYAlignment = "Top"
                            v75.BackgroundTransparency = 1
                            v75.TextStrokeTransparency = 0.5
                            if l_v72_0.Team == game.Players.LocalPlayer.Team then
                                v75.TextColor3 = Color3.new(0, 255, 0)
                            else
                                v75.TextColor3 = Color3.new(255, 0, 0)
                            end
                        else
                            l_v72_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v72_0.Name .. " | " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v72_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v70(l_v72_0.Character.Humanoid.Health * 100 / l_v72_0.Character.Humanoid.MaxHealth) .. "%"
                        end
                    elseif l_v72_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v72_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v77 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v77_0 = v77
            pcall(function()
                if _G.ChestESP then
                    if not l_v77_0:GetAttribute("IsDisabled") then
                        if l_v77_0:FindFirstChild("ChestEsp") then
                            local v79 = v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v77_0:GetPivot().Position).Magnitude / 3)
                            l_v77_0.ChestEsp.TextLabel.Text = "Chest\n" .. v79 .. " M"
                        else
                            local v80 = Instance.new("BillboardGui", l_v77_0)
                            v80.Name = "ChestEsp"
                            v80.ExtentsOffset = Vector3.new(0, 1, 0)
                            v80.Size = UDim2.new(1, 200, 1, 30)
                            v80.Adornee = l_v77_0
                            v80.AlwaysOnTop = true
                            local v81 = Instance.new("TextLabel", v80)
                            v81.Font = "Code"
                            v81.FontSize = "Size14"
                            v81.TextWrapped = true
                            v81.Size = UDim2.new(1, 0, 1, 0)
                            v81.TextYAlignment = "Top"
                            v81.BackgroundTransparency = 1
                            v81.TextStrokeTransparency = 0.5
                            v81.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v77_0:FindFirstChild("ChestEsp") then
                    l_v77_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v70(v82)
    return math.floor(v82 + 0.5)
end
function UpdateDevilChams()
    for _, v84 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v84_0 = v84
            pcall(function()
                if not DevilFruitESP then
                    if l_v84_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v84_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v84_0.Name, "Fruit") then
                    if l_v84_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v84_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v84_0.Name .. "   \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v84_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v86 = Instance.new("BillboardGui", l_v84_0.Handle)
                        v86.Name = "NameEsp" .. Number
                        v86.ExtentsOffset = Vector3.new(0, 1, 0)
                        v86.Size = UDim2.new(1, 200, 1, 30)
                        v86.Adornee = l_v84_0.Handle
                        v86.AlwaysOnTop = true
                        local v87 = Instance.new("TextLabel", v86)
                        v87.Font = Enum.Font.GothamSemibold
                        v87.FontSize = "Size14"
                        v87.TextWrapped = true
                        v87.Size = UDim2.new(1, 0, 1, 0)
                        v87.TextYAlignment = "Top"
                        v87.BackgroundTransparency = 1
                        v87.TextStrokeTransparency = 0.5
                        v87.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v87.Text = l_v84_0.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v84_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end
function UpdateFlowerChams()
    for _, v89 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v89_0 = v89
            pcall(function()
                if l_v89_0.Name == "Flower2" or l_v89_0.Name == "Flower1" then
                    if not FlowerESP then
                        if l_v89_0:FindFirstChild("NameEsp" .. Number) then
                            l_v89_0:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif l_v89_0:FindFirstChild("NameEsp" .. Number) then
                        l_v89_0["NameEsp" .. Number].TextLabel.Text = l_v89_0.Name .. "   \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v89_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v91 = Instance.new("BillboardGui", l_v89_0)
                        v91.Name = "NameEsp" .. Number
                        v91.ExtentsOffset = Vector3.new(0, 1, 0)
                        v91.Size = UDim2.new(1, 200, 1, 30)
                        v91.Adornee = l_v89_0
                        v91.AlwaysOnTop = true
                        local v92 = Instance.new("TextLabel", v91)
                        v92.Font = Enum.Font.GothamSemibold
                        v92.FontSize = "Size14"
                        v92.TextWrapped = true
                        v92.Size = UDim2.new(1, 0, 1, 0)
                        v92.TextYAlignment = "Top"
                        v92.BackgroundTransparency = 1
                        v92.TextStrokeTransparency = 0.5
                        v92.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if l_v89_0.Name == "Flower1" then
                            v92.Text = "Blue Flower" .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v89_0.Position).Magnitude / 3) .. " Distance"
                            v92.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if l_v89_0.Name == "Flower2" then
                            v92.Text = "Red Flower" .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v89_0.Position).Magnitude / 3) .. " Distance"
                            v92.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v94 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v94:IsA("Tool") then
            if not RealFruitESP then
                if v94.Handle:FindFirstChild("NameEsp" .. Number) then
                    v94.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif v94.Handle:FindFirstChild("NameEsp" .. Number) then
                v94.Handle["NameEsp" .. Number].TextLabel.Text = v94.Name .. " " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v94.Handle.Position).Magnitude / 3) .. " Distance"
            else
                local v95 = Instance.new("BillboardGui", v94.Handle)
                v95.Name = "NameEsp" .. Number
                v95.ExtentsOffset = Vector3.new(0, 1, 0)
                v95.Size = UDim2.new(1, 200, 1, 30)
                v95.Adornee = v94.Handle
                v95.AlwaysOnTop = true
                local v96 = Instance.new("TextLabel", v95)
                v96.Font = Enum.Font.GothamSemibold
                v96.FontSize = "Size14"
                v96.TextWrapped = true
                v96.Size = UDim2.new(1, 0, 1, 0)
                v96.TextYAlignment = "Top"
                v96.BackgroundTransparency = 1
                v96.TextStrokeTransparency = 0.5
                v96.TextColor3 = Color3.fromRGB(255, 0, 0)
                v96.Text = v94.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v94.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v98 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v98:IsA("Tool") then
            if RealFruitESP then
                if not v98.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v99 = Instance.new("BillboardGui", v98.Handle)
                    v99.Name = "NameEsp" .. Number
                    v99.ExtentsOffset = Vector3.new(0, 1, 0)
                    v99.Size = UDim2.new(1, 200, 1, 30)
                    v99.Adornee = v98.Handle
                    v99.AlwaysOnTop = true
                    local v100 = Instance.new("TextLabel", v99)
                    v100.Font = Enum.Font.GothamSemibold
                    v100.FontSize = "Size14"
                    v100.TextWrapped = true
                    v100.Size = UDim2.new(1, 0, 1, 0)
                    v100.TextYAlignment = "Top"
                    v100.BackgroundTransparency = 1
                    v100.TextStrokeTransparency = 0.5
                    v100.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v100.Text = v98.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v98.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v98.Handle["NameEsp" .. Number].TextLabel.Text = v98.Name .. " " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v98.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v98.Handle:FindFirstChild("NameEsp" .. Number) then
                v98.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v102 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v102:IsA("Tool") then
            if not RealFruitESP then
                if v102.Handle:FindFirstChild("NameEsp" .. Number) then
                    v102.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif not v102.Handle:FindFirstChild("NameEsp" .. Number) then
                local v103 = Instance.new("BillboardGui", v102.Handle)
                v103.Name = "NameEsp" .. Number
                v103.ExtentsOffset = Vector3.new(0, 1, 0)
                v103.Size = UDim2.new(1, 200, 1, 30)
                v103.Adornee = v102.Handle
                v103.AlwaysOnTop = true
                local v104 = Instance.new("TextLabel", v103)
                v104.Font = Enum.Font.GothamSemibold
                v104.FontSize = "Size14"
                v104.TextWrapped = true
                v104.Size = UDim2.new(1, 0, 1, 0)
                v104.TextYAlignment = "Top"
                v104.BackgroundTransparency = 1
                v104.TextStrokeTransparency = 0.5
                v104.TextColor3 = Color3.fromRGB(251, 255, 0)
                v104.Text = v102.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v102.Handle.Position).Magnitude / 3) .. " Distance"
            else
                v102.Handle["NameEsp" .. Number].TextLabel.Text = v102.Name .. " " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v102.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
end
function UpdateIslandESP()
    for _, v106 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v106_0 = v106
            pcall(function()
                if not IslandESP then
                    if l_v106_0:FindFirstChild("NameEsp") then
                        l_v106_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v106_0.Name ~= "Sea" then
                    if l_v106_0:FindFirstChild("NameEsp") then
                        l_v106_0.NameEsp.TextLabel.Text = l_v106_0.Name .. "   \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v106_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v108 = Instance.new("BillboardGui", l_v106_0)
                        v108.Name = "NameEsp"
                        v108.ExtentsOffset = Vector3.new(0, 1, 0)
                        v108.Size = UDim2.new(1, 200, 1, 30)
                        v108.Adornee = l_v106_0
                        v108.AlwaysOnTop = true
                        local v109 = Instance.new("TextLabel", v108)
                        v109.Font = "GothamSemibold"
                        v109.FontSize = "Size14"
                        v109.TextWrapped = true
                        v109.Size = UDim2.new(1, 0, 1, 0)
                        v109.TextYAlignment = "Top"
                        v109.BackgroundTransparency = 1
                        v109.TextStrokeTransparency = 0.5
                        v109.TextColor3 = Color3.fromRGB(8, 247, 255)
                    end
                end
            end)
        end
    end
end
function isnil(v110)
    local v111 = nil
    if v110 ~= v111 then
        local _ = false
    end
    return true
end
local function v114(v113)
    return math.floor(tonumber(v113) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v116 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v116_0 = v116
            pcall(function()
                if not isnil(l_v116_0.Character) then
                    if ESPPlayer then
                        if isnil(l_v116_0.Character.Head) or l_v116_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v116_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v116_0.Name .. " | " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v116_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v114(l_v116_0.Character.Humanoid.Health * 100 / l_v116_0.Character.Humanoid.MaxHealth) .. "%"
                        else
                            local v118 = Instance.new("BillboardGui", l_v116_0.Character.Head)
                            v118.Name = "NameEsp" .. Number
                            v118.ExtentsOffset = Vector3.new(0, 1, 0)
                            v118.Size = UDim2.new(1, 200, 1, 30)
                            v118.Adornee = l_v116_0.Character.Head
                            v118.AlwaysOnTop = true
                            local v119 = Instance.new("TextLabel", v118)
                            v119.Font = Enum.Font.GothamSemibold
                            v119.FontSize = "Size14"
                            v119.TextWrapped = true
                            v119.Text = l_v116_0.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v116_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v119.Size = UDim2.new(1, 0, 1, 0)
                            v119.TextYAlignment = "Top"
                            v119.BackgroundTransparency = 1
                            v119.TextStrokeTransparency = 0.5
                            if l_v116_0.Team ~= game.Players.LocalPlayer.Team then
                                v119.TextColor3 = Color3.new(255, 0, 0)
                            else
                                v119.TextColor3 = Color3.new(0, 255, 0)
                            end
                        end
                    elseif l_v116_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v116_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v121 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v121_0 = v121
            pcall(function()
                if _G.ChestESP then
                    if not l_v121_0:GetAttribute("IsDisabled") then
                        if l_v121_0:FindFirstChild("ChestEsp") then
                            local v123 = v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v121_0:GetPivot().Position).Magnitude / 3)
                            l_v121_0.ChestEsp.TextLabel.Text = "Chest\n" .. v123 .. " M"
                        else
                            local v124 = Instance.new("BillboardGui", l_v121_0)
                            v124.Name = "ChestEsp"
                            v124.ExtentsOffset = Vector3.new(0, 1, 0)
                            v124.Size = UDim2.new(1, 200, 1, 30)
                            v124.Adornee = l_v121_0
                            v124.AlwaysOnTop = true
                            local v125 = Instance.new("TextLabel", v124)
                            v125.Font = "Code"
                            v125.FontSize = "Size14"
                            v125.TextWrapped = true
                            v125.Size = UDim2.new(1, 0, 1, 0)
                            v125.TextYAlignment = "Top"
                            v125.BackgroundTransparency = 1
                            v125.TextStrokeTransparency = 0.5
                            v125.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v121_0:FindFirstChild("ChestEsp") then
                    l_v121_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v114(v126)
    return math.floor(v126 + 0.5)
end
function UpdateDevilChams()
    for _, v128 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v128_0 = v128
            pcall(function()
                if not DevilFruitESP then
                    if l_v128_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v128_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v128_0.Name, "Fruit") then
                    if l_v128_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v128_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v128_0.Name .. "   \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v128_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v130 = Instance.new("BillboardGui", l_v128_0.Handle)
                        v130.Name = "NameEsp" .. Number
                        v130.ExtentsOffset = Vector3.new(0, 1, 0)
                        v130.Size = UDim2.new(1, 200, 1, 30)
                        v130.Adornee = l_v128_0.Handle
                        v130.AlwaysOnTop = true
                        local v131 = Instance.new("TextLabel", v130)
                        v131.Font = Enum.Font.GothamSemibold
                        v131.FontSize = "Size14"
                        v131.TextWrapped = true
                        v131.Size = UDim2.new(1, 0, 1, 0)
                        v131.TextYAlignment = "Top"
                        v131.BackgroundTransparency = 1
                        v131.TextStrokeTransparency = 0.5
                        v131.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v131.Text = l_v128_0.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v128_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end
function UpdateFlowerChams()
    for _, v133 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v133_0 = v133
            pcall(function()
                if l_v133_0.Name == "Flower2" or l_v133_0.Name == "Flower1" then
                    if FlowerESP then
                        if l_v133_0:FindFirstChild("NameEsp" .. Number) then
                            l_v133_0["NameEsp" .. Number].TextLabel.Text = l_v133_0.Name .. "   \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v133_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v135 = Instance.new("BillboardGui", l_v133_0)
                            v135.Name = "NameEsp" .. Number
                            v135.ExtentsOffset = Vector3.new(0, 1, 0)
                            v135.Size = UDim2.new(1, 200, 1, 30)
                            v135.Adornee = l_v133_0
                            v135.AlwaysOnTop = true
                            local v136 = Instance.new("TextLabel", v135)
                            v136.Font = Enum.Font.GothamSemibold
                            v136.FontSize = "Size14"
                            v136.TextWrapped = true
                            v136.Size = UDim2.new(1, 0, 1, 0)
                            v136.TextYAlignment = "Top"
                            v136.BackgroundTransparency = 1
                            v136.TextStrokeTransparency = 0.5
                            v136.TextColor3 = Color3.fromRGB(255, 0, 0)
                            if l_v133_0.Name == "Flower1" then
                                v136.Text = "Blue Flower" .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v133_0.Position).Magnitude / 3) .. " Distance"
                                v136.TextColor3 = Color3.fromRGB(0, 0, 255)
                            end
                            if l_v133_0.Name == "Flower2" then
                                v136.Text = "Red Flower" .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v133_0.Position).Magnitude / 3) .. " Distance"
                                v136.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end
                    elseif l_v133_0:FindFirstChild("NameEsp" .. Number) then
                        l_v133_0:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v138 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v138:IsA("Tool") then
            if RealFruitESP then
                if v138.Handle:FindFirstChild("NameEsp" .. Number) then
                    v138.Handle["NameEsp" .. Number].TextLabel.Text = v138.Name .. " " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v138.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v139 = Instance.new("BillboardGui", v138.Handle)
                    v139.Name = "NameEsp" .. Number
                    v139.ExtentsOffset = Vector3.new(0, 1, 0)
                    v139.Size = UDim2.new(1, 200, 1, 30)
                    v139.Adornee = v138.Handle
                    v139.AlwaysOnTop = true
                    local v140 = Instance.new("TextLabel", v139)
                    v140.Font = Enum.Font.GothamSemibold
                    v140.FontSize = "Size14"
                    v140.TextWrapped = true
                    v140.Size = UDim2.new(1, 0, 1, 0)
                    v140.TextYAlignment = "Top"
                    v140.BackgroundTransparency = 1
                    v140.TextStrokeTransparency = 0.5
                    v140.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v140.Text = v138.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v138.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v138.Handle:FindFirstChild("NameEsp" .. Number) then
                v138.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v142 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v142:IsA("Tool") then
            if RealFruitESP then
                if v142.Handle:FindFirstChild("NameEsp" .. Number) then
                    v142.Handle["NameEsp" .. Number].TextLabel.Text = v142.Name .. " " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v142.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v143 = Instance.new("BillboardGui", v142.Handle)
                    v143.Name = "NameEsp" .. Number
                    v143.ExtentsOffset = Vector3.new(0, 1, 0)
                    v143.Size = UDim2.new(1, 200, 1, 30)
                    v143.Adornee = v142.Handle
                    v143.AlwaysOnTop = true
                    local v144 = Instance.new("TextLabel", v143)
                    v144.Font = Enum.Font.GothamSemibold
                    v144.FontSize = "Size14"
                    v144.TextWrapped = true
                    v144.Size = UDim2.new(1, 0, 1, 0)
                    v144.TextYAlignment = "Top"
                    v144.BackgroundTransparency = 1
                    v144.TextStrokeTransparency = 0.5
                    v144.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v144.Text = v142.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v142.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v142.Handle:FindFirstChild("NameEsp" .. Number) then
                v142.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v146 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v146:IsA("Tool") then
            if not RealFruitESP then
                if v146.Handle:FindFirstChild("NameEsp" .. Number) then
                    v146.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif not v146.Handle:FindFirstChild("NameEsp" .. Number) then
                local v147 = Instance.new("BillboardGui", v146.Handle)
                v147.Name = "NameEsp" .. Number
                v147.ExtentsOffset = Vector3.new(0, 1, 0)
                v147.Size = UDim2.new(1, 200, 1, 30)
                v147.Adornee = v146.Handle
                v147.AlwaysOnTop = true
                local v148 = Instance.new("TextLabel", v147)
                v148.Font = Enum.Font.GothamSemibold
                v148.FontSize = "Size14"
                v148.TextWrapped = true
                v148.Size = UDim2.new(1, 0, 1, 0)
                v148.TextYAlignment = "Top"
                v148.BackgroundTransparency = 1
                v148.TextStrokeTransparency = 0.5
                v148.TextColor3 = Color3.fromRGB(251, 255, 0)
                v148.Text = v146.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v146.Handle.Position).Magnitude / 3) .. " Distance"
            else
                v146.Handle["NameEsp" .. Number].TextLabel.Text = v146.Name .. " " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v146.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
end
function UpdateIslandESP()
    for _, v150 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v150_0 = v150
            pcall(function()
                if IslandESP then
                    if l_v150_0.Name ~= "Sea" then
                        if l_v150_0:FindFirstChild("NameEsp") then
                            l_v150_0.NameEsp.TextLabel.Text = l_v150_0.Name .. "   \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v150_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v152 = Instance.new("BillboardGui", l_v150_0)
                            v152.Name = "NameEsp"
                            v152.ExtentsOffset = Vector3.new(0, 1, 0)
                            v152.Size = UDim2.new(1, 200, 1, 30)
                            v152.Adornee = l_v150_0
                            v152.AlwaysOnTop = true
                            local v153 = Instance.new("TextLabel", v152)
                            v153.Font = "GothamSemibold"
                            v153.FontSize = "Size14"
                            v153.TextWrapped = true
                            v153.Size = UDim2.new(1, 0, 1, 0)
                            v153.TextYAlignment = "Top"
                            v153.BackgroundTransparency = 1
                            v153.TextStrokeTransparency = 0.5
                            v153.TextColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end
                elseif l_v150_0:FindFirstChild("NameEsp") then
                    l_v150_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
function isnil(v154)
    local v155 = nil
    if v154 ~= v155 then
        local _ = false
    end
    return true
end
local function v158(v157)
    return math.floor(tonumber(v157) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v160 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v160_0 = v160
            pcall(function()
                if not isnil(l_v160_0.Character) then
                    if not ESPPlayer then
                        if l_v160_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v160_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif isnil(l_v160_0.Character.Head) or l_v160_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v160_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v160_0.Name .. " | " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v160_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v158(l_v160_0.Character.Humanoid.Health * 100 / l_v160_0.Character.Humanoid.MaxHealth) .. "%"
                    else
                        local v162 = Instance.new("BillboardGui", l_v160_0.Character.Head)
                        v162.Name = "NameEsp" .. Number
                        v162.ExtentsOffset = Vector3.new(0, 1, 0)
                        v162.Size = UDim2.new(1, 200, 1, 30)
                        v162.Adornee = l_v160_0.Character.Head
                        v162.AlwaysOnTop = true
                        local v163 = Instance.new("TextLabel", v162)
                        v163.Font = Enum.Font.GothamSemibold
                        v163.FontSize = "Size14"
                        v163.TextWrapped = true
                        v163.Text = l_v160_0.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v160_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v163.Size = UDim2.new(1, 0, 1, 0)
                        v163.TextYAlignment = "Top"
                        v163.BackgroundTransparency = 1
                        v163.TextStrokeTransparency = 0.5
                        if l_v160_0.Team == game.Players.LocalPlayer.Team then
                            v163.TextColor3 = Color3.new(0, 255, 0)
                        else
                            v163.TextColor3 = Color3.new(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v165 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v165_0 = v165
            pcall(function()
                if _G.ChestESP then
                    if not l_v165_0:GetAttribute("IsDisabled") then
                        if l_v165_0:FindFirstChild("ChestEsp") then
                            local v167 = v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v165_0:GetPivot().Position).Magnitude / 3)
                            l_v165_0.ChestEsp.TextLabel.Text = "Chest\n" .. v167 .. " M"
                        else
                            local v168 = Instance.new("BillboardGui", l_v165_0)
                            v168.Name = "ChestEsp"
                            v168.ExtentsOffset = Vector3.new(0, 1, 0)
                            v168.Size = UDim2.new(1, 200, 1, 30)
                            v168.Adornee = l_v165_0
                            v168.AlwaysOnTop = true
                            local v169 = Instance.new("TextLabel", v168)
                            v169.Font = "Code"
                            v169.FontSize = "Size14"
                            v169.TextWrapped = true
                            v169.Size = UDim2.new(1, 0, 1, 0)
                            v169.TextYAlignment = "Top"
                            v169.BackgroundTransparency = 1
                            v169.TextStrokeTransparency = 0.5
                            v169.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v165_0:FindFirstChild("ChestEsp") then
                    l_v165_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v158(v170)
    return math.floor(v170 + 0.5)
end
function UpdateDevilChams()
    for _, v172 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v172_0 = v172
            pcall(function()
                if DevilFruitESP then
                    if string.find(l_v172_0.Name, "Fruit") then
                        if l_v172_0.Handle:FindFirstChild("NameEsp" .. Number) then
                            l_v172_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v172_0.Name .. "   \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v172_0.Handle.Position).Magnitude / 3) .. " Distance"
                        else
                            local v174 = Instance.new("BillboardGui", l_v172_0.Handle)
                            v174.Name = "NameEsp" .. Number
                            v174.ExtentsOffset = Vector3.new(0, 1, 0)
                            v174.Size = UDim2.new(1, 200, 1, 30)
                            v174.Adornee = l_v172_0.Handle
                            v174.AlwaysOnTop = true
                            local v175 = Instance.new("TextLabel", v174)
                            v175.Font = Enum.Font.GothamSemibold
                            v175.FontSize = "Size14"
                            v175.TextWrapped = true
                            v175.Size = UDim2.new(1, 0, 1, 0)
                            v175.TextYAlignment = "Top"
                            v175.BackgroundTransparency = 1
                            v175.TextStrokeTransparency = 0.5
                            v175.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v175.Text = l_v172_0.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v172_0.Handle.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v172_0.Handle:FindFirstChild("NameEsp" .. Number) then
                    l_v172_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end)
        end
    end
end
function UpdateFlowerChams()
    for _, v177 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v177_0 = v177
            pcall(function()
                if l_v177_0.Name == "Flower2" or l_v177_0.Name == "Flower1" then
                    if not FlowerESP then
                        if l_v177_0:FindFirstChild("NameEsp" .. Number) then
                            l_v177_0:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif l_v177_0:FindFirstChild("NameEsp" .. Number) then
                        l_v177_0["NameEsp" .. Number].TextLabel.Text = l_v177_0.Name .. "   \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v177_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v179 = Instance.new("BillboardGui", l_v177_0)
                        v179.Name = "NameEsp" .. Number
                        v179.ExtentsOffset = Vector3.new(0, 1, 0)
                        v179.Size = UDim2.new(1, 200, 1, 30)
                        v179.Adornee = l_v177_0
                        v179.AlwaysOnTop = true
                        local v180 = Instance.new("TextLabel", v179)
                        v180.Font = Enum.Font.GothamSemibold
                        v180.FontSize = "Size14"
                        v180.TextWrapped = true
                        v180.Size = UDim2.new(1, 0, 1, 0)
                        v180.TextYAlignment = "Top"
                        v180.BackgroundTransparency = 1
                        v180.TextStrokeTransparency = 0.5
                        v180.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if l_v177_0.Name == "Flower1" then
                            v180.Text = "Blue Flower" .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v177_0.Position).Magnitude / 3) .. " Distance"
                            v180.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if l_v177_0.Name == "Flower2" then
                            v180.Text = "Red Flower" .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v177_0.Position).Magnitude / 3) .. " Distance"
                            v180.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v182 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v182:IsA("Tool") then
            if RealFruitESP then
                if v182.Handle:FindFirstChild("NameEsp" .. Number) then
                    v182.Handle["NameEsp" .. Number].TextLabel.Text = v182.Name .. " " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v182.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v183 = Instance.new("BillboardGui", v182.Handle)
                    v183.Name = "NameEsp" .. Number
                    v183.ExtentsOffset = Vector3.new(0, 1, 0)
                    v183.Size = UDim2.new(1, 200, 1, 30)
                    v183.Adornee = v182.Handle
                    v183.AlwaysOnTop = true
                    local v184 = Instance.new("TextLabel", v183)
                    v184.Font = Enum.Font.GothamSemibold
                    v184.FontSize = "Size14"
                    v184.TextWrapped = true
                    v184.Size = UDim2.new(1, 0, 1, 0)
                    v184.TextYAlignment = "Top"
                    v184.BackgroundTransparency = 1
                    v184.TextStrokeTransparency = 0.5
                    v184.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v184.Text = v182.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v182.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v182.Handle:FindFirstChild("NameEsp" .. Number) then
                v182.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v186 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v186:IsA("Tool") then
            if RealFruitESP then
                if not v186.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v187 = Instance.new("BillboardGui", v186.Handle)
                    v187.Name = "NameEsp" .. Number
                    v187.ExtentsOffset = Vector3.new(0, 1, 0)
                    v187.Size = UDim2.new(1, 200, 1, 30)
                    v187.Adornee = v186.Handle
                    v187.AlwaysOnTop = true
                    local v188 = Instance.new("TextLabel", v187)
                    v188.Font = Enum.Font.GothamSemibold
                    v188.FontSize = "Size14"
                    v188.TextWrapped = true
                    v188.Size = UDim2.new(1, 0, 1, 0)
                    v188.TextYAlignment = "Top"
                    v188.BackgroundTransparency = 1
                    v188.TextStrokeTransparency = 0.5
                    v188.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v188.Text = v186.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v186.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v186.Handle["NameEsp" .. Number].TextLabel.Text = v186.Name .. " " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v186.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v186.Handle:FindFirstChild("NameEsp" .. Number) then
                v186.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v190 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v190:IsA("Tool") then
            if RealFruitESP then
                if v190.Handle:FindFirstChild("NameEsp" .. Number) then
                    v190.Handle["NameEsp" .. Number].TextLabel.Text = v190.Name .. " " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v190.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v191 = Instance.new("BillboardGui", v190.Handle)
                    v191.Name = "NameEsp" .. Number
                    v191.ExtentsOffset = Vector3.new(0, 1, 0)
                    v191.Size = UDim2.new(1, 200, 1, 30)
                    v191.Adornee = v190.Handle
                    v191.AlwaysOnTop = true
                    local v192 = Instance.new("TextLabel", v191)
                    v192.Font = Enum.Font.GothamSemibold
                    v192.FontSize = "Size14"
                    v192.TextWrapped = true
                    v192.Size = UDim2.new(1, 0, 1, 0)
                    v192.TextYAlignment = "Top"
                    v192.BackgroundTransparency = 1
                    v192.TextStrokeTransparency = 0.5
                    v192.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v192.Text = v190.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v190.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v190.Handle:FindFirstChild("NameEsp" .. Number) then
                v190.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
function UpdateIslandESP()
    for _, v194 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v194_0 = v194
            pcall(function()
                if not IslandESP then
                    if l_v194_0:FindFirstChild("NameEsp") then
                        l_v194_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v194_0.Name ~= "Sea" then
                    if l_v194_0:FindFirstChild("NameEsp") then
                        l_v194_0.NameEsp.TextLabel.Text = l_v194_0.Name .. "   \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v194_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v196 = Instance.new("BillboardGui", l_v194_0)
                        v196.Name = "NameEsp"
                        v196.ExtentsOffset = Vector3.new(0, 1, 0)
                        v196.Size = UDim2.new(1, 200, 1, 30)
                        v196.Adornee = l_v194_0
                        v196.AlwaysOnTop = true
                        local v197 = Instance.new("TextLabel", v196)
                        v197.Font = "GothamSemibold"
                        v197.FontSize = "Size14"
                        v197.TextWrapped = true
                        v197.Size = UDim2.new(1, 0, 1, 0)
                        v197.TextYAlignment = "Top"
                        v197.BackgroundTransparency = 1
                        v197.TextStrokeTransparency = 0.5
                        v197.TextColor3 = Color3.fromRGB(8, 247, 255)
                    end
                end
            end)
        end
    end
end
function isnil(v198)
    local v199 = nil
    if v198 ~= v199 then
        local _ = false
    end
    return true
end
local function v202(v201)
    return math.floor(tonumber(v201) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v204 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v204_0 = v204
            pcall(function()
                if not isnil(l_v204_0.Character) then
                    if ESPPlayer then
                        if isnil(l_v204_0.Character.Head) or l_v204_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v204_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v204_0.Name .. " | " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v204_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v202(l_v204_0.Character.Humanoid.Health * 100 / l_v204_0.Character.Humanoid.MaxHealth) .. "%"
                        else
                            local v206 = Instance.new("BillboardGui", l_v204_0.Character.Head)
                            v206.Name = "NameEsp" .. Number
                            v206.ExtentsOffset = Vector3.new(0, 1, 0)
                            v206.Size = UDim2.new(1, 200, 1, 30)
                            v206.Adornee = l_v204_0.Character.Head
                            v206.AlwaysOnTop = true
                            local v207 = Instance.new("TextLabel", v206)
                            v207.Font = Enum.Font.GothamSemibold
                            v207.FontSize = "Size14"
                            v207.TextWrapped = true
                            v207.Text = l_v204_0.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v204_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v207.Size = UDim2.new(1, 0, 1, 0)
                            v207.TextYAlignment = "Top"
                            v207.BackgroundTransparency = 1
                            v207.TextStrokeTransparency = 0.5
                            if l_v204_0.Team ~= game.Players.LocalPlayer.Team then
                                v207.TextColor3 = Color3.new(255, 0, 0)
                            else
                                v207.TextColor3 = Color3.new(0, 255, 0)
                            end
                        end
                    elseif l_v204_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v204_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v209 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v209_0 = v209
            pcall(function()
                if _G.ChestESP then
                    if not l_v209_0:GetAttribute("IsDisabled") then
                        if not l_v209_0:FindFirstChild("ChestEsp") then
                            local v211 = Instance.new("BillboardGui", l_v209_0)
                            v211.Name = "ChestEsp"
                            v211.ExtentsOffset = Vector3.new(0, 1, 0)
                            v211.Size = UDim2.new(1, 200, 1, 30)
                            v211.Adornee = l_v209_0
                            v211.AlwaysOnTop = true
                            local v212 = Instance.new("TextLabel", v211)
                            v212.Font = "Code"
                            v212.FontSize = "Size14"
                            v212.TextWrapped = true
                            v212.Size = UDim2.new(1, 0, 1, 0)
                            v212.TextYAlignment = "Top"
                            v212.BackgroundTransparency = 1
                            v212.TextStrokeTransparency = 0.5
                            v212.TextColor3 = Color3.fromRGB(255, 215, 0)
                        else
                            local v213 = v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v209_0:GetPivot().Position).Magnitude / 3)
                            l_v209_0.ChestEsp.TextLabel.Text = "Chest\n" .. v213 .. " M"
                        end
                    end
                elseif l_v209_0:FindFirstChild("ChestEsp") then
                    l_v209_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v202(v214)
    return math.floor(v214 + 0.5)
end
function UpdateDevilChams()
    for _, v216 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v216_0 = v216
            pcall(function()
                if not DevilFruitESP then
                    if l_v216_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v216_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v216_0.Name, "Fruit") then
                    if l_v216_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v216_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v216_0.Name .. "   \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v216_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v218 = Instance.new("BillboardGui", l_v216_0.Handle)
                        v218.Name = "NameEsp" .. Number
                        v218.ExtentsOffset = Vector3.new(0, 1, 0)
                        v218.Size = UDim2.new(1, 200, 1, 30)
                        v218.Adornee = l_v216_0.Handle
                        v218.AlwaysOnTop = true
                        local v219 = Instance.new("TextLabel", v218)
                        v219.Font = Enum.Font.GothamSemibold
                        v219.FontSize = "Size14"
                        v219.TextWrapped = true
                        v219.Size = UDim2.new(1, 0, 1, 0)
                        v219.TextYAlignment = "Top"
                        v219.BackgroundTransparency = 1
                        v219.TextStrokeTransparency = 0.5
                        v219.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v219.Text = l_v216_0.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v216_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end
function UpdateFlowerChams()
    for _, v221 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v221_0 = v221
            pcall(function()
                if l_v221_0.Name == "Flower2" or l_v221_0.Name == "Flower1" then
                    if not FlowerESP then
                        if l_v221_0:FindFirstChild("NameEsp" .. Number) then
                            l_v221_0:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif l_v221_0:FindFirstChild("NameEsp" .. Number) then
                        l_v221_0["NameEsp" .. Number].TextLabel.Text = l_v221_0.Name .. "   \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v221_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v223 = Instance.new("BillboardGui", l_v221_0)
                        v223.Name = "NameEsp" .. Number
                        v223.ExtentsOffset = Vector3.new(0, 1, 0)
                        v223.Size = UDim2.new(1, 200, 1, 30)
                        v223.Adornee = l_v221_0
                        v223.AlwaysOnTop = true
                        local v224 = Instance.new("TextLabel", v223)
                        v224.Font = Enum.Font.GothamSemibold
                        v224.FontSize = "Size14"
                        v224.TextWrapped = true
                        v224.Size = UDim2.new(1, 0, 1, 0)
                        v224.TextYAlignment = "Top"
                        v224.BackgroundTransparency = 1
                        v224.TextStrokeTransparency = 0.5
                        v224.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if l_v221_0.Name == "Flower1" then
                            v224.Text = "Blue Flower" .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v221_0.Position).Magnitude / 3) .. " Distance"
                            v224.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if l_v221_0.Name == "Flower2" then
                            v224.Text = "Red Flower" .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v221_0.Position).Magnitude / 3) .. " Distance"
                            v224.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v226 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v226:IsA("Tool") then
            if not RealFruitESP then
                if v226.Handle:FindFirstChild("NameEsp" .. Number) then
                    v226.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif v226.Handle:FindFirstChild("NameEsp" .. Number) then
                v226.Handle["NameEsp" .. Number].TextLabel.Text = v226.Name .. " " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v226.Handle.Position).Magnitude / 3) .. " Distance"
            else
                local v227 = Instance.new("BillboardGui", v226.Handle)
                v227.Name = "NameEsp" .. Number
                v227.ExtentsOffset = Vector3.new(0, 1, 0)
                v227.Size = UDim2.new(1, 200, 1, 30)
                v227.Adornee = v226.Handle
                v227.AlwaysOnTop = true
                local v228 = Instance.new("TextLabel", v227)
                v228.Font = Enum.Font.GothamSemibold
                v228.FontSize = "Size14"
                v228.TextWrapped = true
                v228.Size = UDim2.new(1, 0, 1, 0)
                v228.TextYAlignment = "Top"
                v228.BackgroundTransparency = 1
                v228.TextStrokeTransparency = 0.5
                v228.TextColor3 = Color3.fromRGB(255, 0, 0)
                v228.Text = v226.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v226.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v230 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v230:IsA("Tool") then
            if RealFruitESP then
                if v230.Handle:FindFirstChild("NameEsp" .. Number) then
                    v230.Handle["NameEsp" .. Number].TextLabel.Text = v230.Name .. " " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v230.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v231 = Instance.new("BillboardGui", v230.Handle)
                    v231.Name = "NameEsp" .. Number
                    v231.ExtentsOffset = Vector3.new(0, 1, 0)
                    v231.Size = UDim2.new(1, 200, 1, 30)
                    v231.Adornee = v230.Handle
                    v231.AlwaysOnTop = true
                    local v232 = Instance.new("TextLabel", v231)
                    v232.Font = Enum.Font.GothamSemibold
                    v232.FontSize = "Size14"
                    v232.TextWrapped = true
                    v232.Size = UDim2.new(1, 0, 1, 0)
                    v232.TextYAlignment = "Top"
                    v232.BackgroundTransparency = 1
                    v232.TextStrokeTransparency = 0.5
                    v232.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v232.Text = v230.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v230.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v230.Handle:FindFirstChild("NameEsp" .. Number) then
                v230.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v234 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v234:IsA("Tool") then
            if RealFruitESP then
                if not v234.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v235 = Instance.new("BillboardGui", v234.Handle)
                    v235.Name = "NameEsp" .. Number
                    v235.ExtentsOffset = Vector3.new(0, 1, 0)
                    v235.Size = UDim2.new(1, 200, 1, 30)
                    v235.Adornee = v234.Handle
                    v235.AlwaysOnTop = true
                    local v236 = Instance.new("TextLabel", v235)
                    v236.Font = Enum.Font.GothamSemibold
                    v236.FontSize = "Size14"
                    v236.TextWrapped = true
                    v236.Size = UDim2.new(1, 0, 1, 0)
                    v236.TextYAlignment = "Top"
                    v236.BackgroundTransparency = 1
                    v236.TextStrokeTransparency = 0.5
                    v236.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v236.Text = v234.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v234.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v234.Handle["NameEsp" .. Number].TextLabel.Text = v234.Name .. " " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v234.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v234.Handle:FindFirstChild("NameEsp" .. Number) then
                v234.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
function UpdateIslandESP()
    for _, v238 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v238_0 = v238
            pcall(function()
                if IslandESP then
                    if l_v238_0.Name ~= "Sea" then
                        if l_v238_0:FindFirstChild("NameEsp") then
                            l_v238_0.NameEsp.TextLabel.Text = l_v238_0.Name .. "   \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v238_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v240 = Instance.new("BillboardGui", l_v238_0)
                            v240.Name = "NameEsp"
                            v240.ExtentsOffset = Vector3.new(0, 1, 0)
                            v240.Size = UDim2.new(1, 200, 1, 30)
                            v240.Adornee = l_v238_0
                            v240.AlwaysOnTop = true
                            local v241 = Instance.new("TextLabel", v240)
                            v241.Font = "GothamSemibold"
                            v241.FontSize = "Size14"
                            v241.TextWrapped = true
                            v241.Size = UDim2.new(1, 0, 1, 0)
                            v241.TextYAlignment = "Top"
                            v241.BackgroundTransparency = 1
                            v241.TextStrokeTransparency = 0.5
                            v241.TextColor3 = Color3.fromRGB(8, 247, 255)
                        end
                    end
                elseif l_v238_0:FindFirstChild("NameEsp") then
                    l_v238_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
function isnil(v242)
    local v243 = nil
    if v242 ~= v243 then
        local _ = false
    end
    return true
end
local function v246(v245)
    return math.floor(tonumber(v245) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for _, v248 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v248_0 = v248
            pcall(function()
                if not isnil(l_v248_0.Character) then
                    if ESPPlayer then
                        if not isnil(l_v248_0.Character.Head) and not l_v248_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            local v250 = Instance.new("BillboardGui", l_v248_0.Character.Head)
                            v250.Name = "NameEsp" .. Number
                            v250.ExtentsOffset = Vector3.new(0, 1, 0)
                            v250.Size = UDim2.new(1, 200, 1, 30)
                            v250.Adornee = l_v248_0.Character.Head
                            v250.AlwaysOnTop = true
                            local v251 = Instance.new("TextLabel", v250)
                            v251.Font = Enum.Font.GothamSemibold
                            v251.FontSize = "Size14"
                            v251.TextWrapped = true
                            v251.Text = l_v248_0.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v248_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v251.Size = UDim2.new(1, 0, 1, 0)
                            v251.TextYAlignment = "Top"
                            v251.BackgroundTransparency = 1
                            v251.TextStrokeTransparency = 0.5
                            if l_v248_0.Team ~= game.Players.LocalPlayer.Team then
                                v251.TextColor3 = Color3.new(255, 0, 0)
                            else
                                v251.TextColor3 = Color3.new(0, 255, 0)
                            end
                        else
                            l_v248_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v248_0.Name .. " | " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v248_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v246(l_v248_0.Character.Humanoid.Health * 100 / l_v248_0.Character.Humanoid.MaxHealth) .. "%"
                        end
                    elseif l_v248_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v248_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateChestESP()
    for _, v253 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v253_0 = v253
            pcall(function()
                if _G.ChestESP then
                    if not l_v253_0:GetAttribute("IsDisabled") then
                        if l_v253_0:FindFirstChild("ChestEsp") then
                            local v255 = v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v253_0:GetPivot().Position).Magnitude / 3)
                            l_v253_0.ChestEsp.TextLabel.Text = "Chest\n" .. v255 .. " M"
                        else
                            local v256 = Instance.new("BillboardGui", l_v253_0)
                            v256.Name = "ChestEsp"
                            v256.ExtentsOffset = Vector3.new(0, 1, 0)
                            v256.Size = UDim2.new(1, 200, 1, 30)
                            v256.Adornee = l_v253_0
                            v256.AlwaysOnTop = true
                            local v257 = Instance.new("TextLabel", v256)
                            v257.Font = "Code"
                            v257.FontSize = "Size14"
                            v257.TextWrapped = true
                            v257.Size = UDim2.new(1, 0, 1, 0)
                            v257.TextYAlignment = "Top"
                            v257.BackgroundTransparency = 1
                            v257.TextStrokeTransparency = 0.5
                            v257.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v253_0:FindFirstChild("ChestEsp") then
                    l_v253_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end
function v246(v258)
    return math.floor(v258 + 0.5)
end
function UpdateDevilChams()
    for _, v260 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v260_0 = v260
            pcall(function()
                if not DevilFruitESP then
                    if l_v260_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v260_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v260_0.Name, "Fruit") then
                    if l_v260_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v260_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v260_0.Name .. "   \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v260_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v262 = Instance.new("BillboardGui", l_v260_0.Handle)
                        v262.Name = "NameEsp" .. Number
                        v262.ExtentsOffset = Vector3.new(0, 1, 0)
                        v262.Size = UDim2.new(1, 200, 1, 30)
                        v262.Adornee = l_v260_0.Handle
                        v262.AlwaysOnTop = true
                        local v263 = Instance.new("TextLabel", v262)
                        v263.Font = Enum.Font.GothamSemibold
                        v263.FontSize = "Size14"
                        v263.TextWrapped = true
                        v263.Size = UDim2.new(1, 0, 1, 0)
                        v263.TextYAlignment = "Top"
                        v263.BackgroundTransparency = 1
                        v263.TextStrokeTransparency = 0.5
                        v263.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v263.Text = l_v260_0.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v260_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end
function UpdateFlowerChams()
    for _, v265 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v265_0 = v265
            pcall(function()
                if l_v265_0.Name == "Flower2" or l_v265_0.Name == "Flower1" then
                    if FlowerESP then
                        if l_v265_0:FindFirstChild("NameEsp" .. Number) then
                            l_v265_0["NameEsp" .. Number].TextLabel.Text = l_v265_0.Name .. "   \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v265_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v267 = Instance.new("BillboardGui", l_v265_0)
                            v267.Name = "NameEsp" .. Number
                            v267.ExtentsOffset = Vector3.new(0, 1, 0)
                            v267.Size = UDim2.new(1, 200, 1, 30)
                            v267.Adornee = l_v265_0
                            v267.AlwaysOnTop = true
                            local v268 = Instance.new("TextLabel", v267)
                            v268.Font = Enum.Font.GothamSemibold
                            v268.FontSize = "Size14"
                            v268.TextWrapped = true
                            v268.Size = UDim2.new(1, 0, 1, 0)
                            v268.TextYAlignment = "Top"
                            v268.BackgroundTransparency = 1
                            v268.TextStrokeTransparency = 0.5
                            v268.TextColor3 = Color3.fromRGB(255, 0, 0)
                            if l_v265_0.Name == "Flower1" then
                                v268.Text = "Blue Flower" .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v265_0.Position).Magnitude / 3) .. " Distance"
                                v268.TextColor3 = Color3.fromRGB(0, 0, 255)
                            end
                            if l_v265_0.Name == "Flower2" then
                                v268.Text = "Red Flower" .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v265_0.Position).Magnitude / 3) .. " Distance"
                                v268.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end
                    elseif l_v265_0:FindFirstChild("NameEsp" .. Number) then
                        l_v265_0:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end
function UpdateRealFruitChams()
    for _, v270 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v270:IsA("Tool") then
            if RealFruitESP then
                if not v270.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v271 = Instance.new("BillboardGui", v270.Handle)
                    v271.Name = "NameEsp" .. Number
                    v271.ExtentsOffset = Vector3.new(0, 1, 0)
                    v271.Size = UDim2.new(1, 200, 1, 30)
                    v271.Adornee = v270.Handle
                    v271.AlwaysOnTop = true
                    local v272 = Instance.new("TextLabel", v271)
                    v272.Font = Enum.Font.GothamSemibold
                    v272.FontSize = "Size14"
                    v272.TextWrapped = true
                    v272.Size = UDim2.new(1, 0, 1, 0)
                    v272.TextYAlignment = "Top"
                    v272.BackgroundTransparency = 1
                    v272.TextStrokeTransparency = 0.5
                    v272.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v272.Text = v270.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v270.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v270.Handle["NameEsp" .. Number].TextLabel.Text = v270.Name .. " " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v270.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v270.Handle:FindFirstChild("NameEsp" .. Number) then
                v270.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v274 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v274:IsA("Tool") then
            if not RealFruitESP then
                if v274.Handle:FindFirstChild("NameEsp" .. Number) then
                    v274.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif not v274.Handle:FindFirstChild("NameEsp" .. Number) then
                local v275 = Instance.new("BillboardGui", v274.Handle)
                v275.Name = "NameEsp" .. Number
                v275.ExtentsOffset = Vector3.new(0, 1, 0)
                v275.Size = UDim2.new(1, 200, 1, 30)
                v275.Adornee = v274.Handle
                v275.AlwaysOnTop = true
                local v276 = Instance.new("TextLabel", v275)
                v276.Font = Enum.Font.GothamSemibold
                v276.FontSize = "Size14"
                v276.TextWrapped = true
                v276.Size = UDim2.new(1, 0, 1, 0)
                v276.TextYAlignment = "Top"
                v276.BackgroundTransparency = 1
                v276.TextStrokeTransparency = 0.5
                v276.TextColor3 = Color3.fromRGB(255, 174, 0)
                v276.Text = v274.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v274.Handle.Position).Magnitude / 3) .. " Distance"
            else
                v274.Handle["NameEsp" .. Number].TextLabel.Text = v274.Name .. " " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v274.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v278 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v278:IsA("Tool") then
            if RealFruitESP then
                if not v278.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v279 = Instance.new("BillboardGui", v278.Handle)
                    v279.Name = "NameEsp" .. Number
                    v279.ExtentsOffset = Vector3.new(0, 1, 0)
                    v279.Size = UDim2.new(1, 200, 1, 30)
                    v279.Adornee = v278.Handle
                    v279.AlwaysOnTop = true
                    local v280 = Instance.new("TextLabel", v279)
                    v280.Font = Enum.Font.GothamSemibold
                    v280.FontSize = "Size14"
                    v280.TextWrapped = true
                    v280.Size = UDim2.new(1, 0, 1, 0)
                    v280.TextYAlignment = "Top"
                    v280.BackgroundTransparency = 1
                    v280.TextStrokeTransparency = 0.5
                    v280.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v280.Text = v278.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v278.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v278.Handle["NameEsp" .. Number].TextLabel.Text = v278.Name .. " " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v278.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v278.Handle:FindFirstChild("NameEsp" .. Number) then
                v278.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
spawn(function()
    while wait() do
        pcall(function()
            if MobESP then
                for _, v282 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v282:FindFirstChild("HumanoidRootPart") then
                        if not v282:FindFirstChild("MobEap") then
                            local l_BillboardGui_0 = Instance.new("BillboardGui")
                            local l_TextLabel_0 = Instance.new("TextLabel")
                            l_BillboardGui_0.Parent = v282
                            l_BillboardGui_0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            l_BillboardGui_0.Active = true
                            l_BillboardGui_0.Name = "MobEap"
                            l_BillboardGui_0.AlwaysOnTop = true
                            l_BillboardGui_0.LightInfluence = 1
                            l_BillboardGui_0.Size = UDim2.new(0, 200, 0, 50)
                            l_BillboardGui_0.StudsOffset = Vector3.new(0, 2.5, 0)
                            l_TextLabel_0.Parent = l_BillboardGui_0
                            l_TextLabel_0.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            l_TextLabel_0.BackgroundTransparency = 1
                            l_TextLabel_0.Size = UDim2.new(0, 200, 0, 50)
                            l_TextLabel_0.Font = Enum.Font.GothamBold
                            l_TextLabel_0.TextColor3 = Color3.fromRGB(7, 236, 240)
                            l_TextLabel_0.Text.Size = 35
                        end
                        local v285 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v282.HumanoidRootPart.Position).Magnitude)
                        v282.MobEap.TextLabel.Text = v282.Name .. " - " .. v285 .. " Distance"
                    end
                end
            else
                for _, v287 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v287:FindFirstChild("MobEap") then
                        v287.MobEap:Destroy()
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if not SeaESP then
                for _, v289 in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v289:FindFirstChild("Seaesps") then
                        v289.Seaesps:Destroy()
                    end
                end
            else
                for _, v291 in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v291:FindFirstChild("HumanoidRootPart") then
                        if not v291:FindFirstChild("Seaesps") then
                            local l_BillboardGui_1 = Instance.new("BillboardGui")
                            local l_TextLabel_1 = Instance.new("TextLabel")
                            l_BillboardGui_1.Parent = v291
                            l_BillboardGui_1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            l_BillboardGui_1.Active = true
                            l_BillboardGui_1.Name = "Seaesps"
                            l_BillboardGui_1.AlwaysOnTop = true
                            l_BillboardGui_1.LightInfluence = 1
                            l_BillboardGui_1.Size = UDim2.new(0, 200, 0, 50)
                            l_BillboardGui_1.StudsOffset = Vector3.new(0, 2.5, 0)
                            l_TextLabel_1.Parent = l_BillboardGui_1
                            l_TextLabel_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            l_TextLabel_1.BackgroundTransparency = 1
                            l_TextLabel_1.Size = UDim2.new(0, 200, 0, 50)
                            l_TextLabel_1.Font = Enum.Font.GothamBold
                            l_TextLabel_1.TextColor3 = Color3.fromRGB(7, 236, 240)
                            l_TextLabel_1.Text.Size = 35
                        end
                        local v294 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v291.HumanoidRootPart.Position).Magnitude)
                        v291.Seaesps.TextLabel.Text = v291.Name .. " - " .. v294 .. " Distance"
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if not NpcESP then
                for _, v296 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v296:FindFirstChild("NpcEspes") then
                        v296.NpcEspes:Destroy()
                    end
                end
            else
                for _, v298 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v298:FindFirstChild("HumanoidRootPart") then
                        if not v298:FindFirstChild("NpcEspes") then
                            local l_BillboardGui_2 = Instance.new("BillboardGui")
                            local l_TextLabel_2 = Instance.new("TextLabel")
                            l_BillboardGui_2.Parent = v298
                            l_BillboardGui_2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            l_BillboardGui_2.Active = true
                            l_BillboardGui_2.Name = "NpcEspes"
                            l_BillboardGui_2.AlwaysOnTop = true
                            l_BillboardGui_2.LightInfluence = 1
                            l_BillboardGui_2.Size = UDim2.new(0, 200, 0, 50)
                            l_BillboardGui_2.StudsOffset = Vector3.new(0, 2.5, 0)
                            l_TextLabel_2.Parent = l_BillboardGui_2
                            l_TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            l_TextLabel_2.BackgroundTransparency = 1
                            l_TextLabel_2.Size = UDim2.new(0, 200, 0, 50)
                            l_TextLabel_2.Font = Enum.Font.GothamBold
                            l_TextLabel_2.TextColor3 = Color3.fromRGB(7, 236, 240)
                            l_TextLabel_2.Text.Size = 35
                        end
                        local v301 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v298.HumanoidRootPart.Position).Magnitude)
                        v298.NpcEspes.TextLabel.Text = v298.Name .. " - " .. v301 .. " Distance"
                    end
                end
            end
        end)
    end
end)
function isnil(v302)
    local v303 = nil
    if v302 ~= v303 then
        local _ = false
    end
    return true
end
local function v306(v305)
    return math.floor(tonumber(v305) + 0.5)
end
Number = math.random(1, 1000000)
function UpdateIslandMirageESP()
    for _, v308 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v308_0 = v308
            pcall(function()
                if not MirageIslandESP then
                    if l_v308_0:FindFirstChild("NameEsp") then
                        l_v308_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v308_0.Name == "Mirage Island" then
                    if l_v308_0:FindFirstChild("NameEsp") then
                        l_v308_0.NameEsp.TextLabel.Text = l_v308_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v308_0.Position).Magnitude / 3) .. " M"
                    else
                        local v310 = Instance.new("BillboardGui", l_v308_0)
                        v310.Name = "NameEsp"
                        v310.ExtentsOffset = Vector3.new(0, 1, 0)
                        v310.Size = UDim2.new(1, 200, 1, 30)
                        v310.Adornee = l_v308_0
                        v310.AlwaysOnTop = true
                        local v311 = Instance.new("TextLabel", v310)
                        v311.Font = "Code"
                        v311.FontSize = "Size14"
                        v311.TextWrapped = true
                        v311.Size = UDim2.new(1, 0, 1, 0)
                        v311.TextYAlignment = "Top"
                        v311.BackgroundTransparency = 1
                        v311.TextStrokeTransparency = 0.5
                        v311.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            end)
        end
    end
end
function UpdatePrehistoricIslandESP()
    for _, v313 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v313_0 = v313
            pcall(function()
                if not PrehistoricIslandESP then
                    if l_v313_0:FindFirstChild("NameEsp") then
                        l_v313_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v313_0.Name == "PrehistoricIsland" then
                    if not l_v313_0:FindFirstChild("NameEsp") then
                        local v315 = Instance.new("BillboardGui", l_v313_0)
                        v315.Name = "NameEsp"
                        v315.ExtentsOffset = Vector3.new(0, 1, 0)
                        v315.Size = UDim2.new(1, 200, 1, 30)
                        v315.Adornee = l_v313_0
                        v315.AlwaysOnTop = true
                        local v316 = Instance.new("TextLabel", v315)
                        v316.Font = "Code"
                        v316.FontSize = "Size14"
                        v316.TextWrapped = true
                        v316.Size = UDim2.new(1, 0, 1, 0)
                        v316.TextYAlignment = "Top"
                        v316.BackgroundTransparency = 1
                        v316.TextStrokeTransparency = 0.5
                        v316.TextColor3 = Color3.fromRGB(80, 245, 245)
                    else
                        l_v313_0.NameEsp.TextLabel.Text = l_v313_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v313_0.Position).Magnitude / 3) .. " M"
                    end
                end
            end)
        end
    end
end
function UpdateAfdESP()
    for _, v318 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        do
            local l_v318_0 = v318
            pcall(function()
                if not AfdESP then
                    if l_v318_0:FindFirstChild("NameEsp") then
                        l_v318_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v318_0.Name == "Advanced Fruit Dealer" then
                    if l_v318_0:FindFirstChild("NameEsp") then
                        l_v318_0.NameEsp.TextLabel.Text = l_v318_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v318_0.Position).Magnitude / 3) .. " M"
                    else
                        local v320 = Instance.new("BillboardGui", l_v318_0)
                        v320.Name = "NameEsp"
                        v320.ExtentsOffset = Vector3.new(0, 1, 0)
                        v320.Size = UDim2.new(1, 200, 1, 30)
                        v320.Adornee = l_v318_0
                        v320.AlwaysOnTop = true
                        local v321 = Instance.new("TextLabel", v320)
                        v321.Font = "Code"
                        v321.FontSize = "Size14"
                        v321.TextWrapped = true
                        v321.Size = UDim2.new(1, 0, 1, 0)
                        v321.TextYAlignment = "Top"
                        v321.BackgroundTransparency = 1
                        v321.TextStrokeTransparency = 0.5
                        v321.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            end)
        end
    end
end
function UpdateAuraESP()
    for _, v323 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        do
            local l_v323_0 = v323
            pcall(function()
                if AuraESP then
                    if l_v323_0.Name == "Master of Enhancement" then
                        if l_v323_0:FindFirstChild("NameEsp") then
                            l_v323_0.NameEsp.TextLabel.Text = l_v323_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v323_0.Position).Magnitude / 3) .. " M"
                        else
                            local v325 = Instance.new("BillboardGui", l_v323_0)
                            v325.Name = "NameEsp"
                            v325.ExtentsOffset = Vector3.new(0, 1, 0)
                            v325.Size = UDim2.new(1, 200, 1, 30)
                            v325.Adornee = l_v323_0
                            v325.AlwaysOnTop = true
                            local v326 = Instance.new("TextLabel", v325)
                            v326.Font = "Code"
                            v326.FontSize = "Size14"
                            v326.TextWrapped = true
                            v326.Size = UDim2.new(1, 0, 1, 0)
                            v326.TextYAlignment = "Top"
                            v326.BackgroundTransparency = 1
                            v326.TextStrokeTransparency = 0.5
                            v326.TextColor3 = Color3.fromRGB(80, 245, 245)
                        end
                    end
                elseif l_v323_0:FindFirstChild("NameEsp") then
                    l_v323_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
function UpdateLSDESP()
    for _, v328 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        do
            local l_v328_0 = v328
            pcall(function()
                if LADESP then
                    if l_v328_0.Name == "Legendary Sword Dealer" then
                        if l_v328_0:FindFirstChild("NameEsp") then
                            l_v328_0.NameEsp.TextLabel.Text = l_v328_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v328_0.Position).Magnitude / 3) .. " M"
                        else
                            local v330 = Instance.new("BillboardGui", l_v328_0)
                            v330.Name = "NameEsp"
                            v330.ExtentsOffset = Vector3.new(0, 1, 0)
                            v330.Size = UDim2.new(1, 200, 1, 30)
                            v330.Adornee = l_v328_0
                            v330.AlwaysOnTop = true
                            local v331 = Instance.new("TextLabel", v330)
                            v331.Font = "Code"
                            v331.FontSize = "Size14"
                            v331.TextWrapped = true
                            v331.Size = UDim2.new(1, 0, 1, 0)
                            v331.TextYAlignment = "Top"
                            v331.BackgroundTransparency = 1
                            v331.TextStrokeTransparency = 0.5
                            v331.TextColor3 = Color3.fromRGB(80, 245, 245)
                        end
                    end
                elseif l_v328_0:FindFirstChild("NameEsp") then
                    l_v328_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end
spawn(function()
    while wait() do
        if InfAbility then
            InfAb()
        end
    end
end)
function InfAb()
    if InfAbility then
        if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
            local l_ParticleEmitter_0 = Instance.new("ParticleEmitter")
            l_ParticleEmitter_0.Acceleration = Vector3.new(0, 0, 0)
            l_ParticleEmitter_0.Archivable = true
            l_ParticleEmitter_0.Drag = 20
            l_ParticleEmitter_0.EmissionDirection = Enum.NormalId.Top
            l_ParticleEmitter_0.Enabled = true
            l_ParticleEmitter_0.Lifetime = NumberRange.new(0, 0)
            l_ParticleEmitter_0.LightInfluence = 0
            l_ParticleEmitter_0.LockedToPart = true
            l_ParticleEmitter_0.Name = "Agility"
            l_ParticleEmitter_0.Rate = 500
            local v333 = {NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 4)}
            l_ParticleEmitter_0.Size = NumberSequence.new(v333)
            l_ParticleEmitter_0.RotSpeed = NumberRange.new(9999, 99999)
            l_ParticleEmitter_0.Rotation = NumberRange.new(0, 0)
            l_ParticleEmitter_0.Speed = NumberRange.new(30, 30)
            l_ParticleEmitter_0.SpreadAngle = Vector2.new(0, 0, 0, 0)
            l_ParticleEmitter_0.Texture = ""
            l_ParticleEmitter_0.VelocityInheritance = 0
            l_ParticleEmitter_0.ZOffset = 2
            l_ParticleEmitter_0.Transparency = NumberSequence.new(0)
            l_ParticleEmitter_0.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0))
            l_ParticleEmitter_0.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        end
    elseif game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
    end
end
function UpdateGeaESP()
    for _, v335 in pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren()) do
        do
            local l_v335_0 = v335
            pcall(function()
                if not GearESP then
                    if l_v335_0:FindFirstChild("NameEsp") then
                        l_v335_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v335_0.Name == "MeshPart" then
                    if not l_v335_0:FindFirstChild("NameEsp") then
                        local v337 = Instance.new("BillboardGui", l_v335_0)
                        v337.Name = "NameEsp"
                        v337.ExtentsOffset = Vector3.new(0, 1, 0)
                        v337.Size = UDim2.new(1, 200, 1, 30)
                        v337.Adornee = l_v335_0
                        v337.AlwaysOnTop = true
                        local v338 = Instance.new("TextLabel", v337)
                        v338.Font = "Code"
                        v338.FontSize = "Size14"
                        v338.TextWrapped = true
                        v338.Size = UDim2.new(1, 0, 1, 0)
                        v338.TextYAlignment = "Top"
                        v338.BackgroundTransparency = 1
                        v338.TextStrokeTransparency = 0.5
                        v338.TextColor3 = Color3.fromRGB(80, 245, 245)
                    else
                        l_v335_0.NameEsp.TextLabel.Text = l_v335_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v335_0.Position).Magnitude / 3) .. " M"
                    end
                end
            end)
        end
    end
end
function UpdateBerriesESP()
    local l_Tagged_0 = game:GetService("CollectionService"):GetTagged("BerryBush")
    for _, v341 in pairs(l_Tagged_0) do
        do
            local l_v341_0 = v341
            pcall(function()
                for _, v344 in pairs(l_v341_0:GetAttributes()) do
                    if not v344 then
                        if l_v341_0.Parent:FindFirstChild("NameEsp") then
                            l_v341_0.Parent:FindFirstChild("NameEsp"):Destroy()
                        end
                    else
                        if not l_v341_0.Parent:FindFirstChild("BerryESP") then
                            local v345 = Instance.new("BillboardGui", l_v341_0.Parent)
                            v345.Name = "BerryESP"
                            v345.ExtentsOffset = Vector3.new(0, 2, 0)
                            v345.Size = UDim2.new(1, 200, 1, 30)
                            v345.Adornee = l_v341_0.Parent
                            v345.AlwaysOnTop = true
                            local v346 = Instance.new("TextLabel", v345)
                            v346.Font = Enum.Font.GothamSemibold
                            v346.TextSize = 14
                            v346.TextWrapped = true
                            v346.Size = UDim2.new(1, 0, 1, 0)
                            v346.TextYAlignment = Enum.TextYAlignment.Top
                            v346.BackgroundTransparency = 1
                            v346.TextStrokeTransparency = 0.5
                            v346.TextColor3 = Color3.fromRGB(255, 255, 0)
                            v346.Text = v344
                        end
                        if l_v341_0.Parent:FindFirstChild("BerryESP") then
                            local l_LocalPlayer_0 = game.Players.LocalPlayer
                            if l_LocalPlayer_0 and l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChild("Head") then
                                local l_Position_0 = l_LocalPlayer_0.Character.Head.Position
                                local l_Magnitude_0 = (l_v341_0.Parent:GetPivot().Position - l_Position_0).Magnitude
                                l_v341_0.Parent.BerryESP.TextLabel.Text = v344 .. "\n" .. math.floor(l_Magnitude_0) .. "m"
                            end
                        end
                    end
                end
            end)
        end
    end
end
function UpdateIslandKisuneESP()
    for _, v351 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v351_0 = v351
            pcall(function()
                if not KitsuneIslandEsp then
                    if l_v351_0:FindFirstChild("NameEsp") then
                        l_v351_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v351_0.Name == "Kitsune Island" then
                    if l_v351_0:FindFirstChild("NameEsp") then
                        l_v351_0.NameEsp.TextLabel.Text = l_v351_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v351_0.Position).Magnitude / 3) .. " M"
                    else
                        local v353 = Instance.new("BillboardGui", l_v351_0)
                        v353.Name = "NameEsp"
                        v353.ExtentsOffset = Vector3.new(0, 1, 0)
                        v353.Size = UDim2.new(1, 200, 1, 30)
                        v353.Adornee = l_v351_0
                        v353.AlwaysOnTop = true
                        local v354 = Instance.new("TextLabel", v353)
                        v354.Font = "Code"
                        v354.FontSize = "Size14"
                        v354.TextWrapped = true
                        v354.Size = UDim2.new(1, 0, 1, 0)
                        v354.TextYAlignment = "Top"
                        v354.BackgroundTransparency = 1
                        v354.TextStrokeTransparency = 0.5
                        v354.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            end)
        end
    end
end
function AutoHaki()
    local l_Character_0 = game:GetService("Players").LocalPlayer.Character
    if l_Character_0 and not l_Character_0:FindFirstChild("HasBuso") then
        local l_CommF__0 = game:GetService("ReplicatedStorage").Remotes.CommF_
        if l_CommF__0 then
            l_CommF__0:InvokeServer("Buso")
        end
    end
end
function UnEquipWeapon(v357)
    if game.Players.LocalPlayer.Character:FindFirstChild(v357) then
        _G.NotAutoEquip = true
        wait(0.5)
        game.Players.LocalPlayer.Character:FindFirstChild(v357).Parent = game.Players.LocalPlayer.Backpack
        wait(0.1)
        _G.NotAutoEquip = false
    end
end
function EquipWeapon(v358)
    if not _G.NotAutoEquip and game.Players.LocalPlayer.Backpack:FindFirstChild(v358) then
        Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(v358)
        wait(0.1)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
    end
end
--Sistema Spawn
spawn(function()
    local metatable = getrawmetatable(game)
    local originalNamecall = metatable.__namecall
    setreadonly(metatable, false)
    
    metatable.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- Verifica se é um FireServer do RemoteEvent e se UseSkill está ativo
        if tostring(method) == "FireServer" 
            and tostring(args[1]) == "RemoteEvent" 
            and tostring(args[2]) ~= "true" 
            and tostring(args[2]) ~= "false" 
            and _G.UseSkill then
            
            -- Substitui o argumento pela posição da skill
            if typeof(args[2]) ~= "Vector3" then
                args[2] = PositionSkillMasteryDevilFruit
            end
            
            return originalNamecall(unpack(args))
        end
        
        return originalNamecall(...)
    end)
    
    setreadonly(metatable, true)
end)

spawn(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    pcall(function()
        while task.wait(0.5) do -- Adicionado delay para otimização
            local backpack = LocalPlayer.Backpack
            
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("RemoteFunctionShoot") then
                    CurrentEquipGun = tool.Name
                    break -- Para no primeiro encontrado
                end
            end
        end
    end)
end)

--Sistema Function #1
function StopTween(shouldStop)
    local Players = game:GetService("Players")
    local character = Players.LocalPlayer.Character
    
    if not character then return end
    
    if not shouldStop then
        _G.StopTween = true
        task.wait(0.2)
        topos(character.HumanoidRootPart.CFrame)
        task.wait(0.2)
        
        -- Remove BodyClip se existir
        local bodyClip = character.HumanoidRootPart:FindFirstChild("BodyClip")
        if bodyClip then
            bodyClip:Destroy()
        end
        
        -- Remove Block se existir
        local block = character:FindFirstChild("Block")
        if block then
            block:Destroy()
        end
        
        _G.StopTween = false
        _G.Clip = false
    end
    
    -- Remove Highlight se existir
    local highlight = character:FindFirstChild("Highlight")
    if highlight then
        highlight:Destroy()
    end
end

function LockTween()
    if _G.LockTween then
        return
    end
    
    _G.LockTween = true
    task.wait()
    
    local Players = game:GetService("Players")
    local character = Players.LocalPlayer.Character
    
    if character and character:IsDescendantOf(workspace) then
        local hrp = character:WaitForChild("HumanoidRootPart", 5)
        if hrp then
            hrp.CFrame = hrp.CFrame
        end
    end
    
    task.wait()
    
    -- Remove BodyClip se existir
    local bodyClip = character:FindFirstChild("BodyClip")
    if bodyClip then
        bodyClip:Destroy()
    end
    
    -- Corrigido: era "PartTele" mas destruía "Block"
    local partTele = character:FindFirstChild("PartTele")
    if partTele then
        partTele:Destroy()
    end
    
    _G.LockTween = false
end

function BringMob(mobName)
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    local plr = Players.LocalPlayer
    
    if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local playerPos = plr.Character.HumanoidRootPart.Position
    
    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
        if mob.Name == mobName 
            and mob.Parent 
            and mob:FindFirstChild("HumanoidRootPart") 
            and mob:FindFirstChild("Humanoid") 
            and mob.Humanoid.Health > 0 then
            
            local distance = (mob.HumanoidRootPart.Position - playerPos).Magnitude
            
            if distance <= 350 then
                -- Teleporta o mob
                mob.HumanoidRootPart.CFrame = BringPos
                
                -- Desabilita movimento
                mob.Humanoid.JumpPower = 0
                mob.Humanoid.WalkSpeed = 0
                
                -- Configurações de colisão
                mob.HumanoidRootPart.Transparency = 1
                mob.HumanoidRootPart.CanCollide = false
                mob.Head.CanCollide = false
                
                -- Remove animator
                local animator = mob.Humanoid:FindFirstChild("Animator")
                if animator then
                    animator:Destroy()
                end
                
                -- Adiciona BodyVelocity se não existir
                if not mob.HumanoidRootPart:FindFirstChild("Lock") then
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Parent = mob.HumanoidRootPart
                    bodyVelocity.Name = "Lock"
                    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
                
                -- Configura simulation radius
                sethiddenproperty(plr, "SimulationRadius", math.huge)
                
                -- Muda estado do Humanoid
                mob.Humanoid:ChangeState(11)
            end
        end
    end
end

function CancelTween23()
    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer
    
    if not plr.Character then return end
    
    -- Remove BodyVelocity da cabeça
    local bodyVelocity = plr.Character.Head:FindFirstChild("BodyVelocity")
    if bodyVelocity then
        bodyVelocity:Destroy()
    end
    
    -- Remove PartTele
    local partTele = plr.Character:FindFirstChild("PartTele")
    if partTele then
        partTele:Destroy()
    end
    
    NoClip = false
    return Tween23(plr.Character.HumanoidRootPart.CFrame)
end

function KillMob(mobName, stopCondition)
    pcall(function()
        local mob = DetectMob2(mobName)
        
        if not mob or not mob:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        if mob.Parent 
            and mob:FindFirstChild("Humanoid") 
            and mob.Humanoid.Health > 0 then
            
            repeat
                task.wait()
                Buso()
                EquipWeapon()
                
                -- Teleporta acima do mob
                Tween23(mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                
                -- Atualiza posição de bring
                BringPos = mob.HumanoidRootPart.CFrame
                BringMob(mobName)
                
                NoClip = true
            until not mob.Parent 
                or not mob:FindFirstChild("Humanoid") 
                or mob.Humanoid.Health <= 0 
                or not mob:FindFirstChild("HumanoidRootPart") 
                or (stopCondition and stopCondition())
            
            NoClip = false
            CancelTween23()
        end
    end)
end

--Sistema Spawm #2
spawn(function()
    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer
    
    while task.wait() do
        pcall(function()
            local character = plr.Character
            if not character or not character:FindFirstChild("Head") then
                return
            end
            
            local head = character.Head
            local bodyVelocity = head:FindFirstChild("BodyClip")
            
            if not NoClip then
                -- Remove BodyVelocity quando NoClip está desativado
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
            else
                -- Adiciona BodyVelocity quando NoClip está ativado
                if not bodyVelocity then
                    local bv = Instance.new("BodyVelocity")
                    bv.Parent = head
                    bv.Name = "BodyClip"
                    bv.P = 1500
                    bv.MaxForce = Vector3.new(0, 100000, 0)
                    bv.Velocity = Vector3.new(0, 0, 0)
                end
                
                -- Desabilita colisão de todas as partes
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

spawn(function()
    local Players = game:GetService("Players")
    
    while task.wait() do
        pcall(function()
            local character = Players.LocalPlayer.Character
            if not character then return end
            
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChild("Humanoid")
            local block = character:FindFirstChild("Block")
            
            -- Remove Block se o personagem morreu ou não tem HumanoidRootPart
            if block and (not humanoid or humanoid.Health <= 0 or not hrp) then
                block:Destroy()
            end
        end)
    end
end)

spawn(function()
    local Players = game:GetService("Players")
    
    while task.wait() do
        pcall(function()
            local character = Players.LocalPlayer.Character
            if not character then return end
            
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local block = character:FindFirstChild("Block")
            
            -- Remove Block se estiver muito longe do personagem
            if block and hrp then
                local distance = (hrp.Position - block.Position).Magnitude
                if distance >= 100 then
                    block:Destroy()
                end
            end
        end)
    end
end)

--Sistema Function #2
-- Funções de Noclip
function enableNoclip()
    local Players = game:GetService("Players")
    local character = Players.LocalPlayer.Character
    
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local hrp = character.HumanoidRootPart
    
    if not hrp:FindFirstChild("BodyClip") then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "BodyClip"
        bodyVelocity.Parent = hrp
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end

function disableNoclip()
    local Players = game:GetService("Players")
    local character = Players.LocalPlayer.Character
    
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local bodyClip = character.HumanoidRootPart:FindFirstChild("BodyClip")
    if bodyClip then
        bodyClip:Destroy()
    end
end

function disableCollisions()
    local Players = game:GetService("Players")
    local character = Players.LocalPlayer.Character
    
    if not character then return end
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- Verifica se o módulo existe
local moduleExists = pcall(function()
    return getgenv().Module
end)

-- Loop de Noclip
spawn(function()
    pcall(function()
        while task.wait(0.2) do
            if getgenv().Module or _G.DefendVolcano or getgenv().AutoFarm then
                enableNoclip()
                disableCollisions()
            else
                disableNoclip()
            end
        end
    end)
end)

-- Equipar todas as armas
function EquipAllWeapon()
    pcall(function()
        local Players = game:GetService("Players")
        local backpack = Players.LocalPlayer.Backpack
        local character = Players.LocalPlayer.Character
        
        if not character or not character:FindFirstChild("Humanoid") then
            return
        end
        
        local excludedTools = {
            ["Summon Sea Beast"] = true,
            ["Water Body"] = true,
            ["Awakening"] = true
        }
        
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and not excludedTools[tool.Name] then
                local toolToEquip = backpack:FindFirstChild(tool.Name)
                if toolToEquip then
                    character.Humanoid:EquipTool(toolToEquip)
                    task.wait(1)
                end
            end
        end
    end)
end

-- Aguarda HumanoidRootPart
function WaitHRP(player)
    if player and player.Character then
        return player.Character:WaitForChild("HumanoidRootPart", 9)
    end
    return nil
end

-- Verifica teleportador mais próximo
function CheckNearestTeleporter(targetCFrame)
    local Players = game:GetService("Players")
    local character = Players.LocalPlayer.Character
    
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local targetPosition = targetCFrame.Position
    local shortestDistance = math.huge
    local nearestTeleporter = nil
    local placeId = game.PlaceId
    
    -- Teleportadores por mundo
    local teleporters = {}
    
    if placeId == 2753915549 then
        -- Primeiro Mar
        teleporters = {
            Sky3 = Vector3.new(-7894, 5547, -380),
            Sky3Exit = Vector3.new(-4607, 874, -1667),
            UnderWater = Vector3.new(61163, 11, 1819),
            ["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            ["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            UnderwaterExit = Vector3.new(4050, -1, -1814)
        }
    elseif placeId == 4442272183 then
        -- Segundo Mar
        teleporters = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    elseif placeId == 7449423635 then
        -- Terceiro Mar
        teleporters = {
            ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
            ["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
            Mansion = Vector3.new(-12462, 375, -7552),
            Castle = Vector3.new(-5036, 315, -3179),
            ["Dimensional Shift"] = Vector3.new(-2097.3447265625, 4776.24462890625, -15013.4990234375),
            ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),
            ["Beautiful Room"] = Vector3.new(5314.58203, 22.5364361, -125.942276, 1, 2.14762768E-8, -1.99111154E-13, -2.14762768E-8, 1, -3.0510602E-8, 1.98455903E-13, 3.0510602E-8, 1),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103)
        }
    end
    
    -- Encontra o teleportador mais próximo
    for _, teleporterPos in pairs(teleporters) do
        local distance = (teleporterPos - targetPosition).Magnitude
        if distance < shortestDistance then
            shortestDistance = distance
            nearestTeleporter = teleporterPos
        end
    end
    
    -- Verifica se o teleportador está mais próximo que o jogador
    local playerDistance = (targetPosition - character.HumanoidRootPart.Position).Magnitude
    
    if shortestDistance <= playerDistance then
        return nearestTeleporter
    end
    
    return nil
end
-- Serviços
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- Variáveis globais
local isTweening = false
local tweenTable = {}

-- Função para requisitar entrada em áreas especiais
function requestEntrance(location)
    ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", location)
    
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
        task.wait(0.5)
    end
end

-- Teleporte instantâneo
function TelePPlayer(targetCFrame)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = targetCFrame
    end
end

-- Teleporte suave principal
function topos(targetCFrame)
    if not targetCFrame then return end
    
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        return
    end
    
    local hrp = character.HumanoidRootPart
    local distance = (targetCFrame.Position - hrp.Position).Magnitude
    
    -- Verifica teleportador mais próximo
    local nearestTeleporter = CheckNearestTeleporter(targetCFrame)
    if nearestTeleporter then
        requestEntrance(nearestTeleporter)
    end
    
    -- Cria parte de teleporte se não existir
    if not character:FindFirstChild("PartTele") then
        local partTele = Instance.new("Part")
        partTele.Size = Vector3.new(10, 1, 10)
        partTele.Name = "PartTele"
        partTele.Anchored = true
        partTele.Transparency = 1
        partTele.CanCollide = true
        partTele.CFrame = hrp.CFrame
        partTele.Parent = character
        
        -- Sincroniza posição do personagem com a parte
        partTele:GetPropertyChangedSignal("CFrame"):Connect(function()
            if not isTweening then return end
            
            task.wait()
            if character and character:FindFirstChild("HumanoidRootPart") then
                hrp.CFrame = partTele.CFrame
            end
        end)
    end
    
    isTweening = true
    
    -- Cria e executa tween
    local tweenInfo = TweenInfo.new(distance / 360, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(character.PartTele, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    
    tween.Completed:Connect(function(playbackState)
        if playbackState == Enum.PlaybackState.Completed then
            local partTele = character:FindFirstChild("PartTele")
            if partTele then
                partTele:Destroy()
            end
            isTweening = false
        end
    end)
end

-- Para teleporte
function stopTeleport()
    isTweening = false
    
    local character = LocalPlayer.Character
    if character then
        local partTele = character:FindFirstChild("PartTele")
        if partTele then
            partTele:Destroy()
        end
    end
end

-- Loop para verificar e parar teleporte quando necessário
spawn(function()
    while task.wait() do
        if not isTweening then
            stopTeleport()
        end
    end
end)

-- Verifica distância e para teleporte se muito longe
spawn(function()
    while task.wait() do
        pcall(function()
            local character = LocalPlayer.Character
            if not character then return end
            
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local partTele = character:FindFirstChild("PartTele")
            
            if hrp and partTele then
                local distance = (hrp.Position - partTele.Position).Magnitude
                if distance >= 100 then
                    stopTeleport()
                end
            end
        end)
    end
end)

-- Para teleporte quando morrer
local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        stopTeleport()
    end)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end

-- Alias para topos
function TP1(targetCFrame)
    topos(targetCFrame)
end

-- Sistema de posição giratória
spawn(function()
    while task.wait() do
        if _G.SpinPos then
            Pos = CFrame.new(0, PosY, -20)
            task.wait(0.1)
            Pos = CFrame.new(-20, PosY, 0)
            task.wait(0.1)
            Pos = CFrame.new(0, PosY, 20)
            task.wait(0.1)
            Pos = CFrame.new(20, PosY, 0)
        else
            Pos = CFrame.new(0, PosY, 0)
        end
    end
end)

-- Noclip automático para múltiplas funções
spawn(function()
    while task.wait() do
        pcall(function()
            local shouldEnableNoclip = _G.FarmBone or _G.AutoFarm or _G.Pray or _G.Trylux or 
                _G.Hallow or _G.FarmCake or _G.AutoBoss or _G.AutoSecondSea or 
                _G.AutoSaber or _G.ThirdSea or _G.AutoFactory or _G.DefendVolcano or 
                _G.Dungeon or _G.AutoLawRaid or _G.AutoFarmFruits or _G.AutoElitehunter or 
                _G.SafeMode or _G.AutoPlayerHunter or _G.AutoFarmLevelNew
            
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                return
            end
            
            local hrp = character.HumanoidRootPart
            local bodyClip = hrp:FindFirstChild("BodyClip")
            
            if shouldEnableNoclip then
                if not bodyClip then
                    local bv = Instance.new("BodyVelocity")
                    bv.Name = "BodyClip"
                    bv.Parent = hrp
                    bv.MaxForce = Vector3.new(100000, 100000, 100000)
                    bv.Velocity = Vector3.new(0, 0, 0)
                end
            elseif bodyClip then
                bodyClip:Destroy()
            end
        end)
    end
end)

-- Desabilita colisões durante movimento
spawn(function()
    pcall(function()
        RunService.Stepped:Connect(function()
            local shouldDisableCollisions = _G.FarmBone or _G.AutoFarm or _G.AutoBoss or 
                _G.AutoSecondSea or _G.AutoSaber or _G.ThirdSea or _G.DefendVolcano or 
                _G.Dungeon or _G.AutoLawRaid or _G.AutoFarmFruits or _G.SafeMode
            
            if shouldDisableCollisions then
                local character = LocalPlayer.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end)
    end)
end)

-- Teleporte rápido
function fastpos(targetCFrame)
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local distance = (targetCFrame.Position - character.HumanoidRootPart.Position).Magnitude
    local speed = 1000
    
    TweenService:Create(
        character.HumanoidRootPart,
        TweenInfo.new(distance / speed, Enum.EasingStyle.Linear),
        {CFrame = targetCFrame}
    ):Play()
end

-- Teleporte lento
function slowpos(targetCFrame)
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local distance = (targetCFrame.Position - character.HumanoidRootPart.Position).Magnitude
    local speed = 150
    
    TweenService:Create(
        character.HumanoidRootPart,
        TweenInfo.new(distance / speed, Enum.EasingStyle.Linear),
        {CFrame = targetCFrame}
    ):Play()
end

-- Bypass teleport (para longas distâncias)
function BTP(targetCFrame)
    pcall(function()
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        local hrp = character.HumanoidRootPart
        local humanoid = character:FindFirstChild("Humanoid")
        
        if not humanoid or humanoid.Health <= 0 then
            return
        end
        
        local distance = (targetCFrame.Position - hrp.Position).Magnitude
        
        if distance >= 1500 and not Auto_Raid then
            repeat
                task.wait()
                hrp.CFrame = targetCFrame
                task.wait(0.05)
                
                local head = character:FindFirstChild("Head")
                if head then
                    head:Destroy()
                end
                
                hrp.CFrame = targetCFrame
            until distance < 1500 or humanoid.Health <= 0
        end
    end)
end

-- Teleporte de barco
function TPB(targetCFrame)
    local boat = Workspace.Boats:FindFirstChild("PirateBrigade")
    if not boat or not boat:FindFirstChild("VehicleSeat") then
        return {Stop = function() end}
    end
    
    local vehicleSeat = boat.VehicleSeat
    local distance = (vehicleSeat.CFrame.Position - targetCFrame.Position).Magnitude
    
    local tweenInfo = TweenInfo.new(distance / 300, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(vehicleSeat, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    
    return {
        Stop = function()
            tween:Cancel()
        end
    }
end

-- Teleporte de jogador com proteção
function TPP(targetCFrame)
    local character = LocalPlayer.Character
    if not character then
        return {Stop = function() end}
    end
    
    local humanoid = character:WaitForChild("Humanoid", 5)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not hrp or humanoid.Health <= 0 then
        return {Stop = function() end}
    end
    
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / 325, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    
    return {
        Stop = function()
            tween:Cancel()
        end
    }
end

-- Para tween e reseta
function StopTween(shouldStop)
    if not shouldStop then
        _G.StopTween = true
        task.wait()
        
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            topos(character.HumanoidRootPart.CFrame)
            task.wait()
            
            local bodyClip = character.HumanoidRootPart:FindFirstChild("BodyClip")
            if bodyClip then
                bodyClip:Destroy()
            end
        end
        
        _G.StopTween = false
        _G.Clip = false
    end
end

-- Detecta arma equipada
spawn(function()
    pcall(function()
        while task.wait() do
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("RemoteFunctionShoot") then
                    _G.SelectWeaponGun = tool.Name
                end
            end
        end
    end)
end)

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    local VirtualUser = game:GetService("VirtualUser")
    VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
end)

-- Verifica cor dos círculos do Rip Indra
function CheckColorRipIndra()
    local colors = {}
    local summoner = Workspace.Map:FindFirstChild("Boat Castle")
    
    if not summoner or not summoner:FindFirstChild("Summoner") then
        return colors
    end
    
    local circle = summoner.Summoner:FindFirstChild("Circle")
    if not circle then return colors end
    
    for _, part in pairs(circle:GetChildren()) do
        if part:IsA("Part") and part:FindFirstChild("Part") then
            if part.Part.BrickColor.Name == "Dark stone grey" then
                colors[part.BrickColor.Name] = part
            end
        end
    end
    
    return colors
end

-- Ativa cor para Rip Indra
function ActivateColor(colorName)
    local colorMap = {
        ["Hot pink"] = "Winter Sky",
        ["Really red"] = "Pure Red",
        ["Oyster"] = "Snow White"
    }
    
    local targetColor = colorMap[colorName]
    if targetColor then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("activateColor", targetColor)
    end
end

-- Auto ativa cores Rip Indra
function AutoActiveColorRip_Indra()
    for colorName, part in pairs(CheckColorRipIndra()) do
        ActivateColor(colorName)
        topos(part.CFrame)
        firetouchinterest(part.TouchInterest.Parent, part.TouchInterest)
    end
end

-- Verifica versão da raça
function CheckRace()
    local wenlocktoad = ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
    local alchemist = ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
    local raceName = LocalPlayer.Data.Race.Value
    
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("RaceTransformed") then
        return raceName .. " V4"
    elseif wenlocktoad == -2 then
        return raceName .. " V3"
    elseif alchemist == -2 then
        return raceName .. " V2"
    else
        return raceName .. " V1"
    end
end

-- Verifica barco pirata
function CheckPirateBoat()
    local boatNames = {"PirateBrigade", "FishBoat"}
    
    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
        if table.find(boatNames, enemy.Name) then
            local health = enemy:FindFirstChild("Health")
            if health and health.Value > 0 then
                return enemy
            end
        end
    end
    
    return nil
end

-- Armazena frutas
function StoreFruit()
    for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
        if item:IsA("Tool") and string.find(item.Name, "Fruit") then
            local originalName = item:GetAttribute("OriginalName")
            if originalName then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", originalName, item)
            end
        end
    end
end

-- Teleporte para entrada
function TpEntrance(location)
    ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", location)
    
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        hrp.CFrame = CFrame.new(hrp.CFrame.X, hrp.CFrame.Y, hrp.CFrame.Z)
        task.wait(0.5)
    end
end

-- Verifica item no personagem ou mochila
function CheckItemBPCRBPCR(itemName)
    local locations = {LocalPlayer.Character, LocalPlayer.Backpack}
    
    for _, location in pairs(locations) do
        if location then
            local item = location:FindFirstChild(itemName)
            if item then
                return item
            end
        end
    end
    
    return nil
end
--Farm Oficial
local WeaponSection = Tabs.Farm:AddSection("Select Melee, Sword, Gun, Fruit")

_G.SelectWeapon = "Melee"

task.spawn(function()
    while task.wait() do
        pcall(function()
            if _G.SelectWeapon ~= "Melee" then
                if _G.SelectWeapon ~= "Sword" then
                    if _G.SelectWeapon == "Gun" then
                        for _, weapon in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if weapon.ToolTip == "Gun" then
                                _G.SelectWeapon = weapon.Name
                            end
                        end
                    elseif _G.SelectWeapon == "Fruit" or _G.SelectWeapon == "Blox Fruit" then
                        for _, weapon in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if weapon.ToolTip == "Blox Fruit" then
                                _G.SelectWeapon = weapon.Name
                            end
                        end
                    end
                else
                    for _, weapon in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if weapon.ToolTip == "Sword" then
                            _G.SelectWeapon = weapon.Name
                        end
                    end
                end
            else
                for _, weapon in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if weapon.ToolTip == "Melee" then
                        _G.SelectWeapon = weapon.Name
                    end
                end
            end
        end)
    end
end)

local WeaponDropdown = Tabs.Farm:AddDropdown("WeaponDropdown", {
    Title = "Select Weapon",
    Values = {"Melee", "Sword", "Gun", "Blox Fruit"},
    Default = 1,
    Multi = false,
    Callback = function(Value)
        _G.SelectWeapon = Value
    end
})

local MainFarmSection = Tabs.Farm:AddSection("Main Farm")

local AutoFarmToggle = Tabs.Farm:AddToggle("AutoFarmToggle", {
    Title = "Auto Farm Level 1-2650",
    Description = "Automatically farm levels",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        StopTween(_G.AutoFarm)
    end
})

spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local questText = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                CheckQuest()
                
                if not string.find(questText, NameMon) then
                    StartBring = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if not string.find(questText, "kissed") then
                            if game:GetService("Workspace").Enemies:FindFirstChild(Mon) then
                                for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy.Name == Mon then
                                        if not string.find(questText, NameMon) then
                                            StartBring = false
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                        else
                                            repeat
                                                task.wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                AutoHaki()
                                                PosMon = enemy.HumanoidRootPart.CFrame
                                                topos(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                                enemy.HumanoidRootPart.CanCollide = false
                                                enemy.Humanoid.WalkSpeed = 0
                                                enemy.Head.CanCollide = false
                                                enemy.HumanoidRootPart.Size = Vector3.new(70, 70, 70)
                                                StartBring = true
                                                MonFarm = enemy.Name
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                            until not _G.AutoFarm or enemy.Humanoid.Health <= 0 or not enemy.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        end
                                    end
                                end
                            else
                                TP1(CFrameMon)
                                StartBring = false
                                if game:GetService("ReplicatedStorage"):FindFirstChild(Mon) then
                                    TP1(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                                end
                            end
                        else
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if string.find(enemy.Name, "kissed Warrior") then
                                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                                        if string.find(questText, NameMon) then
                                            repeat
                                                task.wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                PosMon = enemy.HumanoidRootPart.CFrame
                                                topos(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                                enemy.HumanoidRootPart.CanCollide = false
                                                enemy.Humanoid.WalkSpeed = 0
                                                enemy.Head.CanCollide = false
                                                enemy.HumanoidRootPart.Size = Vector3.new(70, 70, 70)
                                                StartBring = true
                                                MonFarm = enemy.Name
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                            until not _G.AutoFarm or enemy.Humanoid.Health <= 0 or not enemy.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        else
                                            StartBring = false
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                        end
                                    end
                                else
                                    TP1(CFrameMon)
                                    StartBring = false
                                    if game:GetService("ReplicatedStorage"):FindFirstChild(Mon) then
                                        TP1(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                                    end
                                end
                            end
                        end
                    end
                else
                    StartBring = false
                    if BypassTP then
                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 1500 then
                            TP1(CFrameQuest)
                        else
                            TP1(CFrameQuest)
                        end
                    else
                        TP1(CFrameQuest)
                    end
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 20 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                    end
                end
            end)
        end
    end
end)

local AutoFarmNewToggle = Tabs.Farm:AddToggle("AutoFarmNewToggle", {
    Title = "Farm Level New 2650-2750",
    Description = "Farm new level area",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmLevelNew = Value
        StopTween(_G.AutoFarmLevelNew)
    end
})

function CheckQuestNew()
    local playerLevel = game.Players.LocalPlayer.Data.Level.Value
    
    if playerLevel >= 2600 and playerLevel <= 2624 then
        MonNew = "Reef Bandit"
        LevelQuestNew = 1
        NameQuestNew = "SubmergedQuest1"
        NameMonNew = "Reef Bandit"
        CFrameQuestNew = CFrame.new(10882.264, -2086.322, 10034.226)
        CFrameMonNew = CFrame.new(10736.6191, -2087.8439, 9338.4882)
    elseif playerLevel < 2625 or playerLevel > 2649 then
        if playerLevel >= 2650 and playerLevel <= 2674 then
            MonNew = "Sea Chanter"
            LevelQuestNew = 1
            NameQuestNew = "SubmergedQuest2"
            NameMonNew = "Sea Chanter"
            CFrameQuestNew = CFrame.new(10882.264, -2086.322, 10034.226)
            CFrameMonNew = CFrame.new(10621.0342, -2087.844, 10102.0332)
        elseif playerLevel >= 2675 and playerLevel <= 2750 then
            MonNew = "Ocean Prophet"
            LevelQuestNew = 2
            NameQuestNew = "SubmergedQuest2"
            NameMonNew = "Ocean Prophet"
            CFrameQuestNew = CFrame.new(10882.264, -2086.322, 10034.226)
            CFrameMonNew = CFrame.new(11056.1445, -2001.6717, 10117.4493)
        end
    else
        MonNew = "Coral Pirate"
        LevelQuestNew = 2
        NameQuestNew = "SubmergedQuest1"
        NameMonNew = "Coral Pirate"
        CFrameQuestNew = CFrame.new(10882.264, -2086.322, 10034.226)
        CFrameMonNew = CFrame.new(10965.1025, -2158.8842, 9177.2597)
    end
end

spawn(function()
    while task.wait() do
        if _G.AutoFarmLevelNew then
            pcall(function()
                local questUI = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
                CheckQuestNew()
                
                if questUI.Visible == false then
                    StartBring = false
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuestNew.Position).Magnitude > 20 then
                        TP1(CFrameQuestNew)
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuestNew, LevelQuestNew)
                    end
                else
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if enemy.Name == MonNew and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            if not string.find(questUI.Container.QuestTitle.Title.Text, NameMonNew) then
                                StartBring = false
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                            else
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    AutoHaki()
                                    topos(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    enemy.HumanoidRootPart.CanCollide = false
                                    enemy.Humanoid.WalkSpeed = 0
                                    enemy.Head.CanCollide = false
                                    enemy.HumanoidRootPart.Size = Vector3.new(70, 70, 70)
                                    StartBring = true
                                    MonFarmNew = enemy.Name
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                until not _G.AutoFarmLevelNew or enemy.Humanoid.Health <= 0 or not enemy.Parent or questUI.Visible == false
                            end
                        end
                    end
                    if not game:GetService("Workspace").Enemies:FindFirstChild(MonNew) then
                        TP1(CFrameMonNew)
                        StartBring = false
                    end
                end
            end)
        end
    end
end)

local AutoNearToggle = Tabs.Farm:AddToggle("AutoNearToggle", {
    Title = "Auto Kill Near Mob Aura",
    Description = "Kill nearby enemies",
    Default = false,
    Callback = function(Value)
        _G.AutoNear = Value
        StopTween(_G.AutoNear)
    end
})

spawn(function()
    while wait() do
        if _G.AutoNear then
            pcall(function()
                for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude <= 5000 then
                        repeat
                            wait(_G.Fast_Delay)
                            StartBring = true
                            AutoHaki()
                            EquipWeapon(_G.SelectWeapon)
                            topos(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                            enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            enemy.HumanoidRootPart.Transparency = 1
                            enemy.Humanoid.JumpPower = 0
                            enemy.Humanoid.WalkSpeed = 0
                            enemy.HumanoidRootPart.CanCollide = false
                            FarmPos = enemy.HumanoidRootPart.CFrame
                            MonFarm = enemy.Name
                        until not _G.AutoNear or not enemy.Parent or enemy.Humanoid.Health <= 0 or not game.Workspace.Enemies:FindFirstChild(enemy.Name)
                        StartBring = false
                    end
                end
            end)
        end
    end
end)

local SummerSection = Tabs.Farm:AddSection("Farm Summer Token New")

local SummerToggle = Tabs.Farm:AddToggle("SummerToggle", {
    Title = "Auto Farm Summer Token",
    Description = "Automatically teleport to Summer Token location and farm Electrified enemies",
    Default = false,
    Callback = function(Value)
        _G.FarmSummer = Value
        StopTween(_G.FarmSummer)
    end
})

local function TeleportTo(cframe)
    pcall(function()
        if type(topos) ~= "function" then
            local player = game:GetService("Players").LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = cframe
            end
        else
            topos(cframe)
        end
    end)
end

local function GetSummerLocation()
    local placeId = game.PlaceId
    
    if placeId == 2753915549 then
        return CFrame.new(924.405, 6.366, 4476.727)
    elseif placeId == 4442272183 then
        return CFrame.new(-5246.478, 66.381, -6015.48)
    elseif placeId == 7449423635 then
        return CFrame.new(-10334.821, 390.837, -8572.301)
    else
        return nil
    end
end

spawn(function()
    while task.wait() do
        if _G.FarmSummer then
            pcall(function()
                local summerLocation = GetSummerLocation()
                if summerLocation then
                    TeleportTo(summerLocation + Vector3.new(0, 50, 0))
                    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                        local humanoid = enemy:FindFirstChild("Humanoid")
                        local rootPart = enemy:FindFirstChild("HumanoidRootPart")
                        if humanoid and rootPart and humanoid.Health > 0 and humanoid.DisplayName:find("%[Electrified%]") then
                            repeat
                                task.wait()
                                AutoHaki()
                                EquipWeapon(_G.SelectWeapon)
                                rootPart.CanCollide = false
                                humanoid.WalkSpeed = 0
                                if enemy:FindFirstChild("Head") then
                                    enemy.Head.CanCollide = false
                                end
                                TeleportTo(rootPart.CFrame * CFrame.new(0, 30, 0))
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                            until not _G.FarmSummer or not enemy.Parent or humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)

local BossSection = Tabs.Farm:AddSection("Event Boss Pain New")

local bossOptions = {}
if World1 then
    bossOptions = {
        "The Gorilla King",
        "Bobby",
        "Yeti",
        "Mob Leader",
        "Vice Admiral",
        "Warden",
        "Chief Warden",
        "Swan",
        "Magma Admiral",
        "Fishman Lord",
        "Wysper",
        "Thunder God",
        "Cyborg",
        "Saber Expert"
    }
elseif World2 then
    bossOptions = {
        "Diamond",
        "Jeremy",
        "Fajita",
        "Don Swan",
        "Smoke Admiral",
        "Cursed Captain",
        "Darkbeard",
        "Order",
        "Awakened Ice Admiral",
        "Tide Keeper"
    }
elseif World3 then
    bossOptions = {
        "Stone",
        "Island Empress",
        "Hydra Leader",
        "Kilo Admiral",
        "Captain Elephant",
        "Beautiful Pirate",
        "rip_indra True Form",
        "Longma",
        "Soul Reaper",
        "Cake Queen"
    }
end

local BossDropdown = Tabs.Farm:AddDropdown("BossDropdown", {
    Title = "Auto Select Boss",
    Values = bossOptions,
    Default = 1,
    Multi = false,
    Callback = function(Value)
        _G.SelectBoss = Value
    end
})

local BossPainToggle = Tabs.Farm:AddToggle("BossPainToggle", {
    Title = "Farm Boss Pain",
    Description = "Farm selected boss",
    Default = false,
    Callback = function(Value)
        _G.BossPain = Value
        StopTween(_G.BossPain)
    end
})

task.spawn(function()
    while task.wait() do
        if _G.BossPain and _G.SelectBoss then
            pcall(function()
                if not game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                    if game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                    end
                else
                    for _, boss in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if boss.Name == _G.SelectBoss and boss:FindFirstChild("Humanoid") and boss:FindFirstChild("HumanoidRootPart") and boss.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                AutoHaki()
                                EquipWeapon(_G.SelectWeapon)
                                boss.HumanoidRootPart.CanCollide = false
                                boss.Humanoid.WalkSpeed = 0
                                boss.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                                topos(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                            until not _G.BossPain or not boss.Parent or boss.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)
