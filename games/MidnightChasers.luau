-- // Services
local Players=game:GetService("Players")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local RunService=game:GetService("RunService")
local CollectionService=game:GetService("CollectionService")
local UserInputService=game:GetService("UserInputService")
local VirtualUser=game:GetService("VirtualUser")
local Stats=game:GetService("Stats")
local Lighting=game:GetService("Lighting")
local TextService=game:GetService("TextService")
local MarketplaceService=game:GetService("MarketplaceService")
local LocalPlayer=Players.LocalPlayer
local V=Vector3.new
local CF=CFrame.new

-- // safeRequire
local function safeRequire(getPath)
    local ok,mod=pcall(function() return require(getPath()) end)
    return ok and mod or nil
end

-- // Modules
local Network=safeRequire(function() return ReplicatedStorage.Modules.Modules.Network end)
local Races=safeRequire(function() return ReplicatedStorage.Modules.Shared.Races.Races end)
if not Network or not Races then return end
local Data=safeRequire(function() return ReplicatedStorage.Modules.Shared.Data end)
local RewardsDB=safeRequire(function() return ReplicatedStorage.Modules.DB.RewardsDB end)
local ProductUtil=safeRequire(function() return ReplicatedStorage.Modules.Utils.ProductUtil end)
local DailyChallengeDB=safeRequire(function() return ReplicatedStorage.Modules.DB.DailyChallengeDB end)

-- // Worlds
local WORLDS={
    [102132851636996]={raceNumber=12,minDuration=90},
    [121510074321001]={raceNumber=8,minDuration=120},
    [13822562292]={raceName="RaceJ3",minDuration=5},
}
local World=WORLDS[game.PlaceId]
if not World then return end

-- // Client Boost
pcall(function() setsimulationradius(math.huge) end)
pcall(function() LocalPlayer.CameraMaxZoomDistance=math.huge end)
pcall(function() settings().Physics.AllowSleep=false end)

-- // forceMaxStreaming
local function forceMaxStreaming()
    pcall(function() workspace.StreamingEnabled=false end)
    pcall(function()
        LocalPlayer.StreamingMinRadius=math.huge
        LocalPlayer.StreamingTargetRadius=math.huge
    end)
    pcall(function() setfpscap(0) end)
end

task.spawn(function()
    for _=1,20 do
        forceMaxStreaming()
        task.wait(1)
    end
end)

-- // Checkpoint Data
local RACE_CHECKPOINTS={
    [102132851636996]={
        V(173.76004,-20.308296,7695.415039),V(128.775848,-23.694452,7774.004395),V(193.471146,-23.943529,7913.503418),
        V(243.310791,-23.020931,8034.402344),V(291.729919,-20.19508,8131.738281),V(389.827576,-14.413015,8201.525391),
        V(570.254333,-11.787896,8333.554688),V(670.673645,-10.027442,8283.948242),V(779.992859,-5.517848,8123.026855),
        V(899.849243,-8.574461,7924.961426),V(1046.063354,-10.43747,7674.202637),V(1198.960571,-11.382135,7439.550781),
        V(1367.869507,-6.61267,7175.556641),V(1535.569824,-1.191391,6775.428711),V(1689.998901,1.847336,6436.127441),
        V(1822.924561,-2.990816,6180.706055),V(1931.999634,-5.199529,6115.341309),V(2020.414551,-9.456296,6030.384766),
        V(2119.285889,-14.543965,5825.974609),V(2220.25293,-14.965995,5634.487793),V(2268.545898,-14.910167,5392.168945),
        V(2184.398926,-14.960665,5205.79541),V(2050.182129,-14.958158,5074.059082),V(1938.543823,-15.288725,5061.533203),
        V(1822.92004,-17.33243,5082.310547),V(1701.918701,-20.069141,5173.724609),V(1660.795532,-23.740654,5379.668945),
        V(1671.336304,-22.696554,5662.866211),V(1645.658936,-19.594355,5842.910156),V(1562.845825,-17.395803,5945.403809),
        V(1460.731567,-15.737625,6068.02832),V(1352.227783,-10.357578,6128.40625),V(1260.443481,-2.158244,6285.022461),
        V(1141.920898,2.99262,6505.208496),V(996.802979,0.053543,6774.367676),V(847.959534,-5.248921,7043.016602),
        V(784.513428,-7.318715,7143.578613),V(686.466003,-7.36081,7173.394043),V(569.334961,-7.623379,7069.626953),
        V(580.775757,-9.29915,6958.588379),V(530.152466,-10.981903,6844.891602),V(448.866486,-9.054732,6752.268066),
        V(320.693298,-6.716011,6697.594238),V(211.929199,-3.527797,6795.558105),V(221.73143,-5.60397,7039.44873),
        V(316.683105,-13.760017,7271.953613),V(362.17926,-15.291492,7409.901855),V(351.687958,-15.282674,7536.825684),
        V(281.939087,-15.953572,7632.811523),V(171.842972,-20.258821,7688.750488),V(126.580795,-23.798508,7780.306152),
        V(187.877823,-23.904341,7913.095215),V(231.882904,-23.331079,8029.495605),V(293.366974,-19.933865,8142.855957),
        V(399.210297,-13.903749,8207.666992),V(583.231323,-11.765285,8330.430664),V(666.566467,-10.048985,8281.095703),
        V(774.209656,-5.510886,8124.053711),V(902.251648,-8.625645,7922.764648),V(1034.219727,-10.621904,7692.379395),
        V(1175.557251,-11.012191,7462.867676),V(1371.448975,-6.784525,7184.052734),V(1520.818481,-1.559912,6789.483887),
        V(1688.018799,1.943057,6447.133301),V(1821.313843,-2.813803,6195.459473),V(1928.009033,-5.17762,6115.891602),
        V(2020.569092,-9.491205,6029.949219),V(2123.61499,-14.566181,5824.458984),V(2236.025879,-14.94346,5611.208496),
        V(2263.835449,-14.927003,5393.799316),V(2185.759766,-14.936947,5207.091309),V(2077.941162,-14.95892,5089.064453),
        V(1952.029663,-14.896989,4990.510254),V(1796.106323,-12.120432,4918.459961),V(1577.003784,-8.095957,4851.539062),
        V(1248.027954,-7.445224,4764.123047),V(1083.488525,-10.410894,4771.445312),V(929.578857,-14.499675,4926.460938),
        V(908.782166,-19.704782,5152.489258),V(945.167603,-33.19664,5446.954102),V(878.309753,-33.39011,5724.312012),
        V(617.763062,-25.172651,6079.118652),V(282.527557,-10.17964,6554.442383),V(204.32901,-3.248116,6806.694824),
        V(219.410294,-5.615383,7040.124512),V(333.469147,-14.60893,7307.866699),V(366.018311,-15.297704,7419.589844),
        V(337.38266,-15.294538,7552.024902),V(284.357635,-16.003885,7639.629883),
    },
    [13822562292]={
        V(2195.779785,7.045557,3764.153564),V(2403.366211,6.989157,4502.472656),
    },
    [121510074321001]={
        V(-3158,2,5343),V(-2883,2,5613),V(-2655,2,5844),V(-2180,2,6323),V(-1984,2,6397),V(-1829,2,6208),
        V(-1819,2,5785),V(-1763,2,5596),V(-1558,2,5481),V(-1084,2,5358),V(-885,2,5102),V(-904,2,4868),
        V(-1051,2,4683),V(-1437,2,4296),V(-1659,3,4123),V(-1760,2,4174),V(-1766,2,4326),V(-1675,2,4472),
        V(-1425,2,4827),V(-1388,2,4948),V(-1491,2,5051),V(-1644,2,5033),V(-2247,2,4672),V(-2369,2,4742),
        V(-2437,2,4862),V(-2349,2,5094),V(-2129,2,5224),V(-2063,2,5385),V(-2113,2,5581),V(-2226,2,5770),
        V(-2426,2,5790),V(-2597,2,5596),V(-2724,2,5480),V(-2852,2,5537),V(-2679,2,5843),V(-2190,2,6307),
        V(-1986,2,6393),V(-1822,2,6205),V(-1812,2,5763),V(-1745,2,5595),V(-1568,2,5496),V(-1060,2,5353),
        V(-888,2,5123),V(-892,2,4871),V(-1061,2,4670),V(-1450,2,4288),V(-1663,3,4122),V(-1739,2,4166),
        V(-1776,2,4327),V(-1692,2,4448),V(-1416,2,4836),V(-1399,2,4942),V(-1489,2,5065),V(-1653,2,5035),
        V(-2236,2,4593),V(-2315,2,4382),V(-2236,2,4214),V(-2141,2,4026),V(-2237,2,3874),V(-2197,2,3671),
        V(-2350,2,3460),V(-2570,2,3282),V(-2776,2,3323),V(-3009,2,3561),V(-3292,2,3887),V(-3337,2,4079),
        V(-3262,2,4307),V(-3335,2,4496),V(-3477,2,4491),V(-3748,2,4494),V(-3816,3,4604),V(-3735,2,4753),
        V(-3472,2,5041),V(-3169,2,5261),V(-3019,2,5243),V(-2806,2,5143),V(-2802,2,5031),V(-2927,2,4865),
        V(-3062,2,4543),V(-3039,2,4439),V(-2933,2,4276),V(-2889,2,4104),V(-2996,2,3946),V(-3005,2,3824),
        V(-2887,2,3778),V(-2633,2,3753),V(-2521,2,3813),V(-2522,2,3944),V(-2746,2,4378),V(-2760,2,4500),
        V(-2623,2,4571),V(-2455,2,4485),V(-2239,2,4229),V(-2161,2,4043),V(-2226,2,3865),V(-2199,2,3670),
        V(-2365,2,3469),V(-2578,2,3274),V(-2767,2,3343),V(-2990,2,3540),V(-3300,2,3890),V(-3344,2,4077),
        V(-3251,2,4316),V(-3323,2,4485),V(-3466,2,4507),V(-3750,2,4489),V(-3826,2,4606),V(-3723,2,4772),
        V(-3440,2,5053),V(-3281,2,5221),
    },
}

-- // Config
local Cfg={
    enabled=true,touchInterval=0.015,confirmTimeout=2.2,hopDelay=0.02,hopDistance=600,
    cpAbove=2,cpSize=V(120,60,120),snapDistance=20,retryLift=40,maxRetries=8,
    cpWaitTimeout=12,cpFirstWait=25,raceStartTimeout=20,finishTimeout=20,lobbyCooldown=3,
    postStartWait=10,mapSettleTime=1,stateGrace=5,maxRestarts=5,scanInterval=0.05,
    hintAltitude=25,hintRefresh=0.2,hintMaxFails=4,hintBadRadius=40,cpDetectRadius=2500,
    probeAltitude=30,probeRadii={0,150,400,800,1400},probeAngles=8,probeStepWait=0.3,
    idleRadius=900,idleSpeed=0.9,idleGrowth=250,spawnTimeout=15,spawnRetry=4,seatTimeout=3,
    claimCooldown=1.5,antiAfkInterval=60,
    boost={
        enabled=true,shadows=true,textures=true,effects=true,particles=true,lights=true,
        characters=true,terrain=true,quality=true,
    },
}

local BLOCKED_NAMES={"exhaust","backfire","effect","smoke","trail","skid","nitro","boost","flame","fire","particle","wheel","tire"}

-- // State
local St={
    inRace=false,lastFire=0,lastSpawn=0,raceClock=nil,playerData=nil,
    holding=false,holdCF=nil,flyModel=nil,flySeat=nil,flyParts={},welds={},
    holdConn=nil,charRef=nil,charParts={},badHints={},
    raceCount=0,failed=0,cash=0,claims=0,cpTotal=0,retries=0,bestTime=nil,durSum=0,orig={},constraints={},
    state="Starting",reason="-",car="-",cp="0/0",place="-",last="-",streak="-",daily="-",weekly="-",
}

-- // logError
local lastErr={}
local function logError(name,err)
    local msg=tostring(err)
    if lastErr[name]==msg then return end
    lastErr[name]=msg
    warn("[codywas]["..name.."] "..msg)
end

-- // traceHandler
local function traceHandler(e)
    return tostring(e).."\n"..debug.traceback()
end

-- // guard
local function guard(name,fn)
    return function(...)
        local ok,err=xpcall(fn,traceHandler,...)
        if not ok then logError(name,err) end
    end
end

-- // collectParts
local function collectParts(root)
    local list={}
    if not root then return list end
    for _,v in ipairs(root:GetDescendants()) do
        if v:IsA("BasePart") then list[#list+1]=v end
    end
    return list
end

-- // toBasePart
local function toBasePart(inst)
    if inst:IsA("BasePart") then return inst end
    if inst:IsA("Model") then return inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart",true) end
    return nil
end

-- // positionFromValue
local function positionFromValue(v)
    local t=typeof(v)
    if t=="Vector3" then return v end
    if t=="CFrame" then return v.Position end
    if t~="Instance" then return nil end
    if v:IsA("BasePart") then return v.Position end
    if v:IsA("Attachment") then return v.WorldPosition end
    if v:IsA("Model") then local p=toBasePart(v); return p and p.Position end
    if v:IsA("ObjectValue") and v.Value then return positionFromValue(v.Value) end
    if v:IsA("Vector3Value") then return v.Value end
    if v:IsA("CFrameValue") then return v.Value.Position end
    return nil
end

-- // isVehicleOrPlayerRelated
local function isVehicleOrPlayerRelated(inst)
    if not inst then return true end
    if St.flyModel and inst:IsDescendantOf(St.flyModel) then return true end
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr.Character and inst:IsDescendantOf(plr.Character) then return true end
    end
    local a=inst
    while a and a~=workspace do
        if a:GetAttribute("Owner")~=nil or a:GetAttribute("VehicleUUID")~=nil then return true end
        if CollectionService:HasTag(a,"PlayerCar") then return true end
        if a:IsA("Model") and a:FindFirstChild("DriveSeat",true) then return true end
        local n=a.Name:lower()
        for _,b in ipairs(BLOCKED_NAMES) do
            if n:find(b,1,true) then return true end
        end
        a=a.Parent
    end
    return false
end

-- // isBadHint
local function isBadHint(pos)
    for _,bad in ipairs(St.badHints) do
        if (pos-bad).Magnitude<Cfg.hintBadRadius then return true end
    end
    return false
end

-- // markBadHint
local function markBadHint(pos)
    St.badHints[#St.badHints+1]=pos
end

-- // offState
local function offState(sv)
    return sv~=nil and sv.Value~="Racing" and sv.Value~="Starting"
end

-- // getCharacterParts
local function getCharacterParts()
    local char=LocalPlayer.Character
    return char,char and char:FindFirstChildOfClass("Humanoid"),char and char:FindFirstChild("HumanoidRootPart")
end

-- // getDriveSeat
local function getDriveSeat()
    local _,hum=getCharacterParts()
    local seat=hum and hum.SeatPart
    return (seat and seat.Name=="DriveSeat") and seat or nil
end

-- // isInVehicle
local function isInVehicle()
    return getDriveSeat()~=nil
end

-- // findPlayerCar
local function findPlayerCar()
    for _,v in CollectionService:GetTagged("PlayerCar") do
        if workspace:IsAncestorOf(v) and v:GetAttribute("Owner")==LocalPlayer.Name then return v end
    end
    return nil
end

-- // resolveModel
local function resolveModel(racerObj)
    local ref=racerObj and racerObj:FindFirstChild("Vehicle")
    local model=ref and ref.Value
    if model and model.Parent then return model end
    local seat=getDriveSeat()
    model=seat and seat:FindFirstAncestorOfClass("Model")
    return model or findPlayerCar()
end

-- // Sistema: Fly

-- // clearWelds
local function clearWelds()
    for _,w in St.welds do pcall(w.Destroy,w) end
    table.clear(St.welds)
end

-- // zeroVelocity
local function zeroVelocity(model)
    if not model then return end
    local list=(model==St.flyModel) and St.flyParts or collectParts(model)
    for _,p in ipairs(list) do
        p.AssemblyLinearVelocity=Vector3.zero
        p.AssemblyAngularVelocity=Vector3.zero
    end
end

-- // lockConstraints
local function lockConstraints(model)
    table.clear(St.constraints)
    for _,v in ipairs(model:GetDescendants()) do
        if v:IsA("Constraint") and v.Enabled then
            v.Enabled=false
            St.constraints[#St.constraints+1]=v
        end
    end
end

-- // unlockConstraints
local function unlockConstraints()
    for _,c in ipairs(St.constraints) do
        if c.Parent then c.Enabled=true end
    end
    table.clear(St.constraints)
end

-- // stopLoops
local function stopLoops()
    if St.holdConn then St.holdConn:Disconnect(); St.holdConn=nil end
end

-- // startLoops
local function startLoops(seat)
    stopLoops()
    St.holdConn=RunService.PreSimulation:Connect(function()
        if St.holding and seat.Parent and St.holdCF then
            seat.Anchored=true
            seat.CFrame=St.holdCF
            seat.AssemblyLinearVelocity=Vector3.zero
            seat.AssemblyAngularVelocity=Vector3.zero
        end
        local char=LocalPlayer.Character
        if char~=St.charRef then
            St.charRef=char
            St.charParts=collectParts(char)
        end
        for _,p in ipairs(St.charParts) do p.CanCollide=false end
        if St.flyModel and St.flyModel.Parent then
            for _,p in ipairs(St.flyParts) do p.CanCollide=false end
        end
    end)
end

-- // flyOff
local function flyOff()
    St.holding=false
    stopLoops()
    local model,seat=St.flyModel,St.flySeat
    St.flyModel=nil
    St.flySeat=nil
    St.holdCF=nil
    St.flyParts={}
    if model and model.Parent and seat and seat.Parent then
        local cf=seat.CFrame
        local look=cf.LookVector
        local flat=Vector3.new(look.X,0,look.Z)
        if flat.Magnitude>0.01 then
            seat.CFrame=CFrame.lookAt(cf.Position,cf.Position+flat)
        end
    end
    for part,state in pairs(St.orig) do
        if part.Parent then
            part.CanCollide=state[1]
            part.Anchored=state[2]
            part.AssemblyLinearVelocity=Vector3.zero
            part.AssemblyAngularVelocity=Vector3.zero
        end
    end
    table.clear(St.orig)
    clearWelds()
    unlockConstraints()
end

-- // flyOn
local function flyOn(model)
    local seat=model and model:FindFirstChild("DriveSeat",true)
    if not seat then return nil end
    if St.flyModel then flyOff() end
    clearWelds()
    lockConstraints(model)
    local parts=collectParts(model)
    table.clear(St.orig)
    for _,v in ipairs(parts) do
        St.orig[v]={v.CanCollide,v.Anchored}
        v.CanCollide=false
        if v~=seat then
            v.Anchored=false
            local w=Instance.new("WeldConstraint")
            w.Part0=seat
            w.Part1=v
            w.Parent=seat
            St.welds[#St.welds+1]=w
        end
    end
    St.flyModel=model
    St.flySeat=seat
    St.flyParts=parts
    St.holdCF=seat.CFrame
    St.holding=true
    zeroVelocity(model)
    seat.Anchored=true
    startLoops(seat)
    return seat
end

-- // holdAt
local function holdAt(cf)
    St.holdCF=cf
    St.holding=true
    local seat=St.flySeat
    if seat and seat.Parent then
        seat.Anchored=true
        seat.CFrame=cf
    end
end

-- // releaseCar
local function releaseCar()
    St.holding=false
    if not St.flyModel or not St.flyModel.Parent then return end
    for _,p in ipairs(St.flyParts) do
        p.Anchored=false
        p.CanCollide=false
    end
    zeroVelocity(St.flyModel)
end

-- // seatCharacter
local function seatCharacter(seat)
    local _,hum,hrp=getCharacterParts()
    if not hum or not hrp then return nil end
    if hum.SeatPart~=seat then
        hrp.CFrame=seat.CFrame*CF(0,2,0)
        pcall(seat.Sit,seat,hum)
    end
    return hrp
end

-- // moveCar
local function moveCar(seat,pos,sideways)
    if not seat.Parent or not St.flyModel then return false end
    local cf=CF(pos)
    if sideways then cf=cf*CFrame.Angles(0,math.rad(90),0) end
    holdAt(cf)
    zeroVelocity(St.flyModel)
    seatCharacter(seat)
    return true
end

-- // travelTo
local function travelTo(seat,targetPos)
    local current=seat.Position
    local delta=targetPos-current
    local dist=delta.Magnitude
    if dist<=Cfg.hopDistance then
        moveCar(seat,targetPos,true)
        return
    end
    local steps=math.ceil(dist/Cfg.hopDistance)
    for i=1,steps do
        if not moveCar(seat,current+delta*(i/steps),true) then return end
        task.wait(Cfg.hopDelay)
    end
end

-- // Sistema: Checkpoint

-- // GetCheckpointsContainer
local function GetCheckpointsContainer(raceFolder)
    local folder=raceFolder:FindFirstChild("Checkpoints")
    if not folder then return nil,0 end
    local total=0
    local ok,val=pcall(function() return folder.Value end)
    if ok and type(val)=="number" and val>0 then
        total=val
    else
        for _,child in ipairs(folder:GetChildren()) do
            if child:IsA("ValueBase") and type(child.Value)=="number" then
                total=child.Value
                break
            end
        end
    end
    return folder,total
end

-- // GetCheckpointPart
local function GetCheckpointPart(folder,nextNum,total)
    if not folder or not folder.Parent then return nil end
    local inst=folder:FindFirstChild((nextNum==total) and "Finish" or tostring(nextNum))
    return inst and toBasePart(inst)
end

-- // IsCheckpointConfirmed
local function IsCheckpointConfirmed(racerObj,prevDone)
    return (racerObj:GetAttribute("Checkpoint") or 0)>prevDone or racerObj:GetAttribute("Finished")==true
end

-- // fti
local function fti(a,b)
    if not a or not b or not a.Parent or not b.Parent then return end
    pcall(firetouchinterest,a,b,true)
    pcall(firetouchinterest,a,b,false)
    pcall(firetouchinterest,b,a,true)
    pcall(firetouchinterest,b,a,false)
end

-- // FireAllTouches
local function FireAllTouches(seat,hrp,cpPart,sendNetwork)
    fti(seat,cpPart)
    if hrp then fti(hrp,cpPart) end
    pcall(function()
        if cansignalreplicate(cpPart.Touched) then
            replicatesignal(cpPart.Touched,seat)
            if hrp then replicatesignal(cpPart.Touched,hrp) end
        end
    end)
    if sendNetwork then Network.FireServer("TeleportCheckpoint") end
end

-- // CollectCheckpoint
local function CollectCheckpoint(cpPart,seat,racerObj,prevDone,attempt)
    local origSize=cpPart.Size
    pcall(function()
        cpPart.Size=V(math.max(origSize.X,Cfg.cpSize.X),math.max(origSize.Y,Cfg.cpSize.Y),math.max(origSize.Z,Cfg.cpSize.Z))
    end)
    local targetPos=cpPart.Position+V(0,Cfg.cpAbove,0)
    local targetCF=CF(targetPos)*CFrame.Angles(0,math.rad(90),0)
    if attempt>1 then
        local jitter=attempt%4
        local lift=(attempt%2==0) and Cfg.retryLift or (Cfg.retryLift*0.5)
        local side=V(jitter==1 and 15 or jitter==3 and -15 or 0,0,jitter==2 and 15 or jitter==3 and -15 or 0)
        moveCar(seat,targetPos+V(0,lift,0)+side,true)
        task.wait(Cfg.hopDelay)
    end
    travelTo(seat,targetPos)
    holdAt(targetCF)
    seat.CFrame=targetCF
    seatCharacter(seat)
    releaseCar()
    seat.CFrame=targetCF
    local confirmed=false
    local fast=false
    local deadline=os.clock()+Cfg.confirmTimeout
    local nextNet=0
    local cpConn=racerObj:GetAttributeChangedSignal("Checkpoint"):Connect(function() fast=true end)
    local finConn=racerObj:GetAttributeChangedSignal("Finished"):Connect(function()
        if racerObj:GetAttribute("Finished") then fast=true end
    end)
    while os.clock()<deadline do
        if not seat.Parent then break end
        if (seat.Position-targetPos).Magnitude>Cfg.snapDistance then
            holdAt(targetCF)
            seat.CFrame=targetCF
        end
        local hrp=seatCharacter(seat)
        local now=os.clock()
        local sendNet=now>=nextNet
        if sendNet then nextNet=now+0.2 end
        FireAllTouches(seat,hrp,cpPart,sendNet)
        if fast and IsCheckpointConfirmed(racerObj,prevDone) then confirmed=true; break end
        task.wait(Cfg.touchInterval)
        if IsCheckpointConfirmed(racerObj,prevDone) then confirmed=true; break end
    end
    cpConn:Disconnect()
    finConn:Disconnect()
    pcall(function() cpPart.Size=origSize end)
    if seat.Parent then
        holdAt(seat.CFrame)
        zeroVelocity(St.flyModel)
    end
    return confirmed,cpPart.Position
end

-- // WaitForState
local function WaitForState(raceFolder,target,timeout)
    local sv=raceFolder:FindFirstChild("State")
    if not sv then return false end
    if sv.Value==target then return true end
    local done=false
    local c=sv.Changed:Connect(function(s) if s==target then done=true end end)
    local t=0
    while not done and t<timeout do
        task.wait(0.1)
        t+=0.1
    end
    c:Disconnect()
    return done
end

-- // WaitForFinish
local function WaitForFinish(racerObj,raceFolder,timeout)
    if racerObj:GetAttribute("Finished") or racerObj:GetAttribute("DNF") then return true end
    local done=false
    local conns={
        racerObj:GetAttributeChangedSignal("Finished"):Connect(function()
            if racerObj:GetAttribute("Finished") then done=true end
        end),
        racerObj:GetAttributeChangedSignal("DNF"):Connect(function()
            if racerObj:GetAttribute("DNF") then done=true end
        end),
    }
    local sv=raceFolder and raceFolder:FindFirstChild("State")
    if sv then
        conns[#conns+1]=sv.Changed:Connect(function(s)
            if s~="Racing" and s~="Starting" and s~="Finished" then done=true end
        end)
    end
    local t=0
    while not done and t<timeout do
        task.wait(0.1)
        t+=0.1
    end
    for _,c in ipairs(conns) do c:Disconnect() end
    return done
end

-- // Sistema: Deteccao de Checkpoint

-- // FromGui
local function FromGui()
    local gui=LocalPlayer:FindFirstChild("PlayerGui")
    if not gui then return nil end
    for _,inst in ipairs(gui:GetDescendants()) do
        if inst:IsA("BillboardGui") and inst.Adornee then
            local n=inst.Name:lower()
            if n:find("checkpoint") or n:find("waypoint") or n:find("marker") or n:find("arrow") or n:find("target") then
                if not isVehicleOrPlayerRelated(inst.Adornee) then
                    local pos=positionFromValue(inst.Adornee)
                    if pos then return pos end
                end
            end
        end
    end
    return nil
end

-- // FromProximity
local function FromProximity(folder,seat,radius)
    if not folder or not seat then return nil end
    local origin=seat.Position
    local best,bestDist=nil,radius
    for _,inst in ipairs(folder:GetDescendants()) do
        if inst:IsA("BasePart") or inst:IsA("Model") then
            local part=toBasePart(inst)
            if part then
                local d=(part.Position-origin).Magnitude
                if d<bestDist then bestDist=d; best=part end
            end
        end
    end
    return best
end

-- // FromWorldScan
local function FromWorldScan(seat,radius)
    local origin=seat.Position
    local best,bestDist=nil,radius
    for _,inst in ipairs(workspace:GetDescendants()) do
        if inst:IsA("BasePart") or inst:IsA("Model") then
            local n=inst.Name:lower()
            if (n:find("checkpoint") or n:find("waypoint")) and not isVehicleOrPlayerRelated(inst) then
                local part=toBasePart(inst)
                if part then
                    local d=(part.Position-origin).Magnitude
                    if d<bestDist then bestDist=d; best=part end
                end
            end
        end
    end
    return best
end

-- // FindStartAnchor
local function FindStartAnchor(raceFolder)
    local names={"StartLine","Start","StartPoint","Spawn","Grid","Starting","Line","SeparationLine"}
    local scopes={raceFolder}
    local root=raceFolder:FindFirstAncestor("Races")
    if root then scopes[2]=root end
    for _,scope in ipairs(scopes) do
        for _,name in ipairs(names) do
            local found=scope:FindFirstChild(name,true)
            local part=found and toBasePart(found)
            if part then return part.Position end
        end
    end
    return nil
end

-- // idleDrift
local function idleDrift(seat,center,t)
    local angle=t*Cfg.idleSpeed
    local base=Cfg.idleRadius+t*Cfg.idleGrowth
    local radius=base*(0.6+0.4*math.abs(math.sin(t*0.15)))
    moveCar(seat,center+V(math.cos(angle)*radius,Cfg.probeAltitude,math.sin(angle)*radius),true)
end

-- // ProbeForCheckpoints
local function ProbeForCheckpoints(seat,raceFolder,cpFolder,timeout,onUpdate)
    local origin=FindStartAnchor(raceFolder) or seat.Position
    local deadline=os.clock()+timeout
    for _,radius in ipairs(Cfg.probeRadii) do
        local count=radius==0 and 1 or Cfg.probeAngles
        for i=1,count do
            if os.clock()>deadline or not seat.Parent or not St.flyModel then return false end
            local hint=FromGui()
            if hint then return true,hint end
            local angle=(i/count)*math.pi*2
            local point=origin+V(math.cos(angle)*radius,Cfg.probeAltitude,math.sin(angle)*radius)
            travelTo(seat,point)
            moveCar(seat,point,true)
            pcall(Network.FireServer,"TeleportCheckpoint")
            task.wait(Cfg.probeStepWait)
            onUpdate()
            if cpFolder:FindFirstChild("Finish") or #cpFolder:GetChildren()>0 then return true end
        end
    end
    return false
end

-- // getFallbackPos
local function getFallbackPos(n)
    local map=RACE_CHECKPOINTS[game.PlaceId]
    return map and map[n]
end

-- // makeFakePart
local function makeFakePart(pos)
    local part=Instance.new("Part")
    part.Size=Cfg.cpSize
    part.Position=pos
    part.Anchored=true
    part.CanCollide=false
    part.Transparency=1
    part.Parent=workspace
    return part
end

-- // Sistema: Veiculo

-- // loadPlayerData
local function loadPlayerData()
    if St.playerData then return St.playerData end
    if not Data then return nil end
    local ok,result=pcall(Data.WaitForData,LocalPlayer)
    if ok and result then St.playerData=result end
    return St.playerData
end

-- // getOwnedVehicleIds
local function getOwnedVehicleIds()
    local pdata=loadPlayerData()
    local vehicles=pdata and pdata.Data and pdata.Data.Vehicles
    local ids={}
    if type(vehicles)~="table" then return ids end
    for uuid in pairs(vehicles) do ids[#ids+1]=uuid end
    table.sort(ids,function(a,b) return tostring(a)<tostring(b) end)
    return ids
end

-- // findSpawnedVehicle
local function findSpawnedVehicle()
    for _,model in ipairs(workspace:GetDescendants()) do
        if model:IsA("Model") and model:GetAttribute("VehicleUUID")~=nil then
            local owner=model:GetAttribute("Owner")
            if (owner==nil or owner==LocalPlayer.Name) and model:FindFirstChild("DriveSeat",true) then
                return model
            end
        end
    end
    return findPlayerCar()
end

-- // requestSpawn
local function requestSpawn()
    local now=os.clock()
    if now-St.lastSpawn<Cfg.spawnRetry then return false end
    local ids=getOwnedVehicleIds()
    if #ids==0 then return false end
    St.lastSpawn=now
    Network.FireServer("SpawnCar",ids[1],false,nil)
    return true
end

-- // waitForDriveSeatReady
local function waitForDriveSeatReady(model,timeout)
    local seat=model:FindFirstChild("DriveSeat",true)
    if not seat then return nil end
    local deadline=os.clock()+timeout
    while os.clock()<deadline do
        if seat.Parent and seat:IsDescendantOf(workspace) and pcall(function() return seat.CFrame end) then
            return seat
        end
        task.wait(0.1)
    end
    return nil
end

-- // enterVehicle
local function enterVehicle(model)
    local seat=waitForDriveSeatReady(model,5)
    if not seat then return false end
    local _,hum,hrp=getCharacterParts()
    if not hum or not hrp then return false end
    hrp.CFrame=seat.CFrame*CF(0,4,0)
    task.wait(0.3)
    pcall(seat.Sit,seat,hum)
    local deadline=os.clock()+Cfg.seatTimeout
    while os.clock()<deadline do
        task.wait(0.1)
        if isInVehicle() then return true end
    end
    return false
end

-- // spawnAndEnterVehicle
local function spawnAndEnterVehicle()
    if isInVehicle() then return true end
    local existing=findSpawnedVehicle()
    if existing then return enterVehicle(existing) end
    local deadline=os.clock()+Cfg.spawnTimeout
    while os.clock()<deadline do
        requestSpawn()
        task.wait(0.3)
        local car=findSpawnedVehicle()
        if car then
            task.wait(0.5)
            return enterVehicle(car)
        end
    end
    return false
end

-- // Sistema: Corrida

-- // RunCheckpoints
local function RunCheckpoints(race,racerObj,raceClock)
    local raceFolder=race.Folder
    table.clear(St.badHints)
    local cpFolder
    for _=1,100 do
        cpFolder=GetCheckpointsContainer(raceFolder)
        if cpFolder then break end
        task.wait(0.1)
    end
    if not cpFolder then return "no_container" end

    local total=0
    local function refreshTotal()
        total=select(2,GetCheckpointsContainer(raceFolder))
        return total
    end

    local settle=os.clock()+Cfg.mapSettleTime
    while os.clock()<settle do
        if refreshTotal()>0 and cpFolder:FindFirstChild("1") then break end
        task.wait(0.1)
    end
    refreshTotal()

    local model=resolveModel(racerObj)
    if not model then return "no_car" end
    local seat=flyOn(model)
    if not seat then return "no_seat" end
    seatCharacter(seat)

    local sv=raceFolder:FindFirstChild("State")
    local cpCache,rebuildConn={},nil
    local fakeParts={}
    local lastServer,lastPos=-1,nil
    local hintFails,retries,offSince=0,0,nil
    local reason="unknown"

    local function buildCache()
        local cache={}
        refreshTotal()
        for _,inst in ipairs(cpFolder:GetChildren()) do
            if inst:IsA("BasePart") or inst:IsA("Model") then
                local part=toBasePart(inst)
                if part then
                    if inst.Name=="Finish" then
                        if total>0 then cache[total]=part end
                    else
                        local n=tonumber(inst.Name)
                        if n then cache[n]=part end
                    end
                end
            end
        end
        return cache
    end

    local function bindFolder(folder)
        if rebuildConn then rebuildConn:Disconnect() end
        cpFolder=folder
        cpCache=buildCache()
        rebuildConn=cpFolder.ChildAdded:Connect(function() cpCache=buildCache() end)
    end

    local function clearFakes()
        for _,p in ipairs(fakeParts) do pcall(p.Destroy,p) end
        table.clear(fakeParts)
    end

    local function cleanup()
        if rebuildConn then rebuildConn:Disconnect(); rebuildConn=nil end
        clearFakes()
    end

    local function getReal(n)
        return cpCache[n] or GetCheckpointPart(cpFolder,n,total)
    end

    local function getFallback(n)
        local pos=getFallbackPos(n)
        if not pos then return nil end
        local part=makeFakePart(pos)
        fakeParts[#fakeParts+1]=part
        return part
    end

    local function waitForPart(nextNum,serverDone)
        local limit=serverDone==0 and Cfg.cpFirstWait or Cfg.cpWaitTimeout
        local cpPart
        if serverDone==0 and hintFails==0 then
            ProbeForCheckpoints(seat,raceFolder,cpFolder,math.min(limit*0.5,10),function()
                cpCache=buildCache()
            end)
            cpPart=cpCache[nextNum]
        end
        local t,lastHintTry,hintPos=0,0,nil
        local center=seat.Position
        while not cpPart and t<limit do
            task.wait(Cfg.scanInterval)
            t+=Cfg.scanInterval
            cpCache=buildCache()
            cpPart=getReal(nextNum) or getFallback(nextNum)
            if cpPart then break end
            if racerObj:GetAttribute("Finished") then break end
            if (racerObj:GetAttribute("Checkpoint") or 0)~=serverDone then break end
            if offState(sv) then break end
            if hintFails<Cfg.hintMaxFails and t-lastHintTry>=Cfg.hintRefresh then
                lastHintTry=t
                hintPos=FromGui()
                if not hintPos then
                    local near=FromProximity(cpFolder,seat,Cfg.cpDetectRadius) or FromWorldScan(seat,Cfg.cpDetectRadius)
                    hintPos=near and near.Position
                end
            end
            if hintPos and not isBadHint(hintPos) then
                local target=hintPos+V(0,Cfg.hintAltitude,0)
                travelTo(seat,target)
                holdAt(CF(target))
                task.wait(0.2)
                cpCache=buildCache()
                cpPart=getReal(nextNum)
                if not cpPart then
                    markBadHint(hintPos)
                    hintFails+=1
                end
                hintPos=nil
            else
                idleDrift(seat,lastPos or center,t)
            end
        end
        return cpPart
    end

    bindFolder(cpFolder)

    while Cfg.enabled do
        if racerObj:GetAttribute("Finished") then reason="finished"; break end
        if racerObj:GetAttribute("DNF") then reason="dnf"; break end
        if offState(sv) then
            offSince=offSince or os.clock()
            if os.clock()-offSince>Cfg.stateGrace then reason="state="..tostring(sv.Value); break end
            task.wait(0.1)
            continue
        end
        offSince=nil
        if not seat.Parent then reason="seat removed"; break end

        refreshTotal()
        local serverDone=racerObj:GetAttribute("Checkpoint") or 0
        local nextNum=serverDone+1
        local isFinal=total>0 and nextNum==total
        St.cp=serverDone.."/"..(total>0 and total or "?")
        if total>0 and serverDone>=total then reason="all collected "..serverDone.."/"..total; break end

        if serverDone~=lastServer then
            lastServer=serverDone
            retries=0
            hintFails=0
            table.clear(St.badHints)
            clearFakes()
        end

        local cpPart=getReal(nextNum)
        if not cpPart then
            local newFolder=GetCheckpointsContainer(raceFolder)
            if newFolder and newFolder~=cpFolder then
                bindFolder(newFolder)
                cpPart=getReal(nextNum)
            end
        end
        cpPart=cpPart or getFallback(nextNum)
        if not cpPart then
            cpPart=waitForPart(nextNum,serverDone)
            if racerObj:GetAttribute("Finished") then reason="finished"; break end
            if (racerObj:GetAttribute("Checkpoint") or 0)~=serverDone then continue end
            if offState(sv) then continue end
            if not cpPart then reason="cp"..nextNum.." missing"; break end
        end

        if isFinal then
            local targetPos=cpPart.Position+V(0,Cfg.cpAbove,0)
            local targetCF=CF(targetPos)*CFrame.Angles(0,math.rad(90),0)
            travelTo(seat,targetPos)
            holdAt(targetCF)
            seat.CFrame=targetCF
            seatCharacter(seat)
            while Cfg.enabled and seat.Parent do
                if os.clock()-raceClock>=World.minDuration then break end
                if racerObj:GetAttribute("Finished") then break end
                if offState(sv) then break end
                if (seat.Position-targetPos).Magnitude>Cfg.snapDistance then
                    holdAt(targetCF)
                    seat.CFrame=targetCF
                end
                seatCharacter(seat)
                task.wait(0.1)
            end
        end

        local confirmed,usedPos=CollectCheckpoint(cpPart,seat,racerObj,serverDone,retries+1)
        if confirmed then
            lastPos=usedPos
            retries=0
            St.retries=0
            St.cpTotal+=1
        else
            retries+=1
            St.retries=retries
            if retries>=Cfg.maxRetries then reason="cp failed "..retries.."x"; break end
            task.wait(0.1)
        end
    end

    cleanup()
    return reason
end

-- // findWorldRace
local function findWorldRace(racesFolder)
    for _,folder in ipairs(racesFolder:GetChildren()) do
        if folder:FindFirstChild("Config") then
            if World.raceNumber then
                if tonumber(folder.Name:match("(%d+)%s*$"))==World.raceNumber then return folder.Name end
            elseif folder.Name==World.raceName then
                return folder.Name
            end
        end
    end
    return nil
end

-- // getLobbyId
local function getLobbyId()
    local racesFolder=workspace:FindFirstChild("Races")
    return racesFolder and findWorldRace(racesFolder)
end

-- // playRace
local function playRace(race,racerObj)
    St.inRace=true
    St.lastFire=0
    St.raceClock=nil
    St.state="Waiting for start"
    St.cp="0/0"
    St.place="-"
    local startModel=resolveModel(racerObj)
    St.car=startModel and startModel.Name or "-"

    local placeConn=racerObj:GetAttributeChangedSignal("Place"):Connect(function()
        local p=racerObj:GetAttribute("Place")
        St.place=p and ("#"..tostring(p)) or "-"
    end)
    local pubConn=racerObj:GetAttributeChangedSignal("PublicPlace"):Connect(function()
        local p=racerObj:GetAttribute("PublicPlace")
        if p then St.place="#"..tostring(p) end
    end)

    if not WaitForState(race.Folder,"Racing",Cfg.raceStartTimeout) then
        St.state="Start failed"
        placeConn:Disconnect()
        pubConn:Disconnect()
        St.inRace=false
        St.lastFire=0
        return
    end

    St.raceClock=os.clock()
    St.state="Racing"
    local restarts=0
    while Cfg.enabled do
        St.reason=RunCheckpoints(race,racerObj,St.raceClock)
        if racerObj:GetAttribute("Finished") or racerObj:GetAttribute("DNF") then break end
        local sv=race.Folder:FindFirstChild("State")
        if not sv or offState(sv) then break end
        if not racerObj.Parent then break end
        St.failed+=1
        restarts+=1
        St.state="Racing (retry "..restarts..")"
        flyOff()
        if restarts>Cfg.maxRestarts then
            task.wait(1)
            flyOn(resolveModel(racerObj))
            break
        end
        task.wait(0.5)
    end

    placeConn:Disconnect()
    pubConn:Disconnect()
    St.state="Waiting for finish"
    WaitForFinish(racerObj,race.Folder,Cfg.finishTimeout)
    flyOff()

    local duration=St.raceClock and (os.clock()-St.raceClock) or 0
    if duration>=World.minDuration then
        St.raceCount+=1
        St.durSum+=duration
        if not St.bestTime or duration<St.bestTime then St.bestTime=duration end
        St.last=string.format("#%d (%.1fs)",St.raceCount,duration)
    else
        St.last=string.format("invalid (%.1fs)",duration)
    end
    St.raceClock=nil
    St.state="Searching race"
    St.inRace=false
    St.lastFire=0
end

-- // Sistema: Recompensas

local lastClaim={}

-- // canClaim
local function canClaim(key)
    local now=os.clock()
    if now-(lastClaim[key] or 0)<Cfg.claimCooldown then return false end
    if not lastClaim[key] then St.claims+=1 end
    lastClaim[key]=now
    return true
end

-- // tryClaimDailyReward
local function tryClaimDailyReward(pdata,now)
    if not RewardsDB then return end
    local floor=math.floor(now/RewardsDB.DailyRewardRefresh)
    local ready=floor>(pdata.Data.LastClaimedDailyReward or -1)
    St.daily=ready and "YES" or "no"
    if ready and canClaim("daily:"..floor) then
        Network.FireServer("DailyRewardEvent","ClaimDaily")
    end
end

-- // tryClaimWeeklyReward
local function tryClaimWeeklyReward(pdata,now)
    if not RewardsDB or not ProductUtil then return end
    if not ProductUtil.OwnsSubscription(pdata,"Luxury") then
        St.weekly="no sub"
        return
    end
    local floor=math.floor(now/RewardsDB.WeeklyRewardRefresh)
    local ready=floor>(pdata.Data.LastClaimedWeeklyReward or -1)
    St.weekly=ready and "YES" or "no"
    if ready and canClaim("weekly:"..floor) then
        Network.FireServer("DailyRewardEvent","ClaimWeekly")
    end
end

-- // tryClaimQuests
local function tryClaimQuests(pdata)
    local quests=pdata.Data.DailyChallenges and pdata.Data.DailyChallenges.Quests
    if not quests then return end
    for slotId,quest in pairs(quests) do
        if not quest.Claimed and (quest.Progress or 0)>=(quest.Goal or math.huge) then
            if canClaim("quest:"..tostring(slotId)) then
                Network.FireServer("ClaimDailyChallenge",slotId)
            end
        end
    end
end

-- // tryClaimStreakReward
local function tryClaimStreakReward(pdata)
    if not DailyChallengeDB then return end
    local ch=pdata.Data.DailyChallenges
    if not ch then return end
    local streak=ch.Streak or 0
    local claimed=ch.ClaimedRewards or {}
    local rewards=DailyChallengeDB.Rewards
    for idx,reward in ipairs(rewards) do
        if idx==#rewards then
            if streak>=reward.Streak and not ch.ClaimedRepeatingReward and (ch.RepeatingReward or 0)<streak then
                if canClaim("streakrepeat:"..streak) then
                    Network.FireServer("ClaimDailyChallengeReward",reward.Id)
                end
            end
        elseif not claimed[reward.Id] and streak>=reward.Streak then
            if canClaim("streak:"..tostring(reward.Id)) then
                Network.FireServer("ClaimDailyChallengeReward",reward.Id)
            end
        end
    end
end

-- // tryClaimPlaytimeRewards
local function tryClaimPlaytimeRewards(pdata,now)
    if not RewardsDB or not RewardsDB.PlaytimeRewards then return end
    local pr=pdata.Data.PlaytimeRewards
    if not pr then return end
    local elapsed=now-(pr.StartTime or now)+(pr.Playtime or 0)
    local claimed=pr.Claimed or {}
    for tier,cfg in pairs(RewardsDB.PlaytimeRewards) do
        if not claimed[tier] and elapsed>=cfg.Time and canClaim("playtime:"..tostring(tier)) then
            Network.FireServer("ClaimPlaytimeReward",tier)
        end
    end
end

-- // Sistema: Ocultar Resultado

local Results={frame=nil,conn=nil}

-- // hideResults
local function hideResults()
    local f=Results.frame
    if f and f.Parent and f.Visible then f.Visible=false end
end

-- // closeResults
local function closeResults()
    local f=Results.frame
    if not f or not f.Parent then return end
    hideResults()
    local exit=f:FindFirstChild("Exit")
    if exit then
        pcall(function()
            for _,c in ipairs(getconnections(exit.Activated)) do c:Fire() end
        end)
    end
    hideResults()
end

-- // bindResults
local function bindResults()
    local gui=LocalPlayer:FindFirstChild("PlayerGui")
    local races=gui and gui:FindFirstChild("Races")
    local f=races and races:FindFirstChild("Results")
    if f==Results.frame then return end
    if Results.conn then Results.conn:Disconnect(); Results.conn=nil end
    Results.frame=f
    if not f then return end
    Results.conn=f:GetPropertyChangedSignal("Visible"):Connect(hideResults)
    hideResults()
end

task.spawn(function()
    local step=guard("results",function()
        bindResults()
        hideResults()
    end)
    while true do
        step()
        task.wait(0.5)
    end
end)

-- // Sistema: Loops e Eventos

task.spawn(loadPlayerData)

task.spawn(function()
    local step=guard("claims",function()
        local pdata=loadPlayerData()
        if not pdata or not pdata.Data then return end
        local ch=pdata.Data.DailyChallenges
        if ch then St.streak=tostring(ch.Streak or 0) end
        local now=workspace:GetServerTimeNow()
        guard("claim-daily",tryClaimDailyReward)(pdata,now)
        guard("claim-weekly",tryClaimWeeklyReward)(pdata,now)
        guard("claim-quests",tryClaimQuests)(pdata)
        guard("claim-streak",tryClaimStreakReward)(pdata)
        guard("claim-playtime",tryClaimPlaytimeRewards)(pdata,now)
    end)
    while true do
        task.wait(2)
        step()
    end
end)

pcall(function()
    Network.Connect("ShowRaceResults",guard("results-event",function(result)
        if type(result)=="table" and type(result.Total)=="number" and result.Total>0 then
            St.cash+=result.Total
        end
        task.delay(0.2,closeResults)
    end))
end)

Races.PlayerAddedToRace:Connect(function(race,player,racerObj)
    if player~=LocalPlayer or not Cfg.enabled then return end
    local ok,err=xpcall(playRace,traceHandler,race,racerObj)
    if not ok then
        logError("playRace",err)
        flyOff()
        St.inRace=false
        St.lastFire=0
        St.raceClock=nil
        St.state="Searching race"
    end
end)

Races.PlayerRemovedFromRace:Connect(function(_,player)
    if player~=LocalPlayer or not St.inRace then return end
    flyOff()
    St.inRace=false
    St.lastFire=0
    St.state="Searching race"
end)

LocalPlayer.CharacterAdded:Connect(function()
    if St.inRace then return end
    flyOff()
    St.lastFire=0
    St.lastSpawn=0
end)

-- // lobbyLoop
task.spawn(function()
    local step=guard("lobby",function()
        if St.inRace then return end
        if not isInVehicle() then
            St.state="Getting vehicle"
            if not spawnAndEnterVehicle() then task.wait(2) end
            return
        end
        local now=os.clock()
        if now-St.lastFire<Cfg.lobbyCooldown then return end
        St.state="Searching race"
        local lobbyId=getLobbyId()
        if not lobbyId then task.wait(3); return end
        St.lastFire=now
        Network.FireServer("StartSoloRace",lobbyId)
        task.wait(Cfg.postStartWait)
        if not St.inRace then St.lastFire=0 end
    end)
    while Cfg.enabled do
        task.wait(0.5)
        step()
    end
end)

-- // Sistema: Anti AFK

-- // antiAfk
local function antiAfk()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0,0))
    end)
end

LocalPlayer.Idled:Connect(antiAfk)
task.spawn(function()
    while true do
        task.wait(Cfg.antiAfkInterval)
        antiAfk()
    end
end)

-- // Sistema: Otimizar Jogo

local PARTICLE_CLASSES={ParticleEmitter=true,Trail=true,Beam=true,Smoke=true,Fire=true,Sparkles=true,Highlight=true}
local CHAR_JUNK={Accessory=true,Shirt=true,Pants=true,ShirtGraphic=true,CharacterMesh=true}

-- // optimizeInstance
local function optimizeInstance(inst)
    local b=Cfg.boost
    local class=inst.ClassName
    if inst:IsA("BasePart") then
        if class=="Terrain" then return end
        if b.shadows then inst.CastShadow=false end
        if b.textures then
            inst.Reflectance=0
            if class=="MeshPart" then inst.RenderFidelity=Enum.RenderFidelity.Performance end
        end
        return
    end
    if b.textures then
        if class=="Decal" or class=="Texture" then inst.Transparency=1; return end
        if class=="SurfaceAppearance" then inst:Destroy(); return end
    end
    if b.particles then
        if PARTICLE_CLASSES[class] then inst.Enabled=false; return end
        if class=="Explosion" then inst.Visible=false; return end
    end
    if b.lights and inst:IsA("Light") then inst.Enabled=false; return end
    if b.effects then
        if inst:IsA("PostEffect") or class=="Clouds" then inst.Enabled=false; return end
        if class=="Atmosphere" then
            inst.Density=0
            inst.Haze=0
            inst.Glare=0
            return
        end
    end
    if b.characters then
        if CHAR_JUNK[class] then inst:Destroy(); return end
        if class=="Humanoid" then
            inst.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None
            inst.HealthDisplayType=Enum.HumanoidHealthDisplayType.AlwaysOff
        end
    end
end

-- // optimizeGame
local function optimizeGame()
    local b=Cfg.boost
    if b.quality then
        pcall(function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end)
        pcall(function() settings().Rendering.MeshPartDetailLevel=Enum.MeshPartDetailLevel.Level01 end)
        pcall(function() sethiddenproperty(Lighting,"Technology",Enum.Technology.Compatibility) end)
    end
    if b.shadows then
        pcall(function() Lighting.GlobalShadows=false end)
        pcall(function() Lighting.ShadowSoftness=0 end)
    end
    if b.effects then
        for _,v in ipairs(Lighting:GetDescendants()) do pcall(optimizeInstance,v) end
    end
    if b.terrain then
        local terrain=workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            pcall(function()
                terrain.WaterWaveSize=0
                terrain.WaterWaveSpeed=0
                terrain.WaterReflectance=0
            end)
            pcall(function() sethiddenproperty(terrain,"Decoration",false) end)
        end
    end
end

-- // optimizeWorld
local function optimizeWorld()
    local list=workspace:GetDescendants()
    for i=1,#list do
        pcall(optimizeInstance,list[i])
        if i%500==0 then task.wait() end
    end
end

if Cfg.boost.enabled then
    pcall(optimizeGame)
    task.spawn(guard("optimize",optimizeWorld))
end

-- // Sistema: GUI

local Theme={
    Panel=Color3.fromRGB(20,20,20),
    Text=Color3.fromRGB(255,255,255),
    Muted=Color3.fromRGB(105,105,115),
    Header=Color3.fromRGB(130,130,140),
    Line=Color3.fromRGB(45,45,45),
    Accent=Color3.fromRGB(255,45,45),
    Bad=Color3.fromRGB(255,75,75),
    Good=Color3.fromRGB(80,200,80),
}

local Fonts={
    Title=Enum.Font.GothamBold,
    Header=Enum.Font.GothamBold,
    Caption=Enum.Font.Arcade,
    Value=Enum.Font.Arcade,
    Number=Enum.Font.Arcade,
}

local isTouch=UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local PANEL_W,PANEL_H,TOPBAR_H,HEADER_H,ROW_H,LABEL_GAP=200,198,24,22,13,4
local ICON_SIZE,ICON_GAP=11,5
local BTN_SIZE=isTouch and 40 or 34
local SPINNER_FRAMES={"|","/","—","\\"}

local FIELD_ICONS={
    State="rbxassetid://10709752035",
    Race="rbxassetid://10723375890",
    CP="rbxassetid://10734886004",
    Car="rbxassetid://10709789810",
    Place="rbxassetid://10747363809",
    Time="rbxassetid://10709805144",
    Collect="rbxassetid://10734984606",
    Last="rbxassetid://10723407335",
    Reason="rbxassetid://10723415903",
    Done="rbxassetid://10709790387",
    Failed="rbxassetid://10747383819",
    Retry="rbxassetid://10734933222",
    CPs="rbxassetid://10734977012",
    Best="rbxassetid://10734887072",
    Avg="rbxassetid://10709770317",
    Cash="rbxassetid://10709811110",
    Balance="rbxassetid://10747376205",
    ["Cash/h"]="rbxassetid://10747363465",
    ["Races/h"]="rbxassetid://10723395708",
    Claims="rbxassetid://10723396402",
    Daily="rbxassetid://10709783474",
    Weekly="rbxassetid://10709783673",
    Game="rbxassetid://10723395215",
    PlaceId="rbxassetid://10723405975",
    Player="rbxassetid://10747373176",
    Alias="rbxassetid://10709811834",
    Region="rbxassetid://10723404337",
    Ping="rbxassetid://10747382504",
    FPS="rbxassetid://10734896881",
    Memory="rbxassetid://10723405749",
    Executor="rbxassetid://10709813383",
    Uptime="rbxassetid://10723407498",
    Status="rbxassetid://10734961133",
    Streak="rbxassetid://10723376114",
}

local NUMERIC={
    CP=true,Time=true,Collect=true,Done=true,Failed=true,Retry=true,CPs=true,Best=true,Avg=true,
    Cash=true,Balance=true,["Cash/h"]=true,["Races/h"]=true,Claims=true,PlaceId=true,Ping=true,
    FPS=true,Memory=true,Uptime=true,Streak=true,
}

local RACE_FIELDS={"State","Race","CP","Car","Place","Time","Collect","Last","Reason","Done","Failed","Retry","CPs","Best","Avg","Cash","Balance","Cash/h","Races/h","Claims","Daily","Weekly"}
local PLAYER_FIELDS={"Game","PlaceId","Player","Alias","Region","Ping","FPS","Memory","Executor","Uptime","Status","Streak"}

local spinnerIdx=1
local loadDone=false
task.delay(3,function() loadDone=true end)
task.spawn(function()
    while not loadDone do
        task.wait(0.1)
        spinnerIdx=spinnerIdx%#SPINNER_FRAMES+1
    end
end)

local fps,frames,fpsClock=0,0,os.clock()
RunService.Heartbeat:Connect(function()
    frames+=1
    local now=os.clock()
    if now-fpsClock>=1 then
        fps=math.floor(frames/(now-fpsClock)+0.5)
        frames=0
        fpsClock=now
    end
end)

-- // newInst
local function newInst(class,props,parent)
    local i=Instance.new(class)
    for k,v in pairs(props) do i[k]=v end
    i.Parent=parent
    return i
end

-- // decorate
local function decorate(panel)
    newInst("UIStroke",{Color=Theme.Line,Thickness=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},panel)
end

-- // newLabel
local function newLabel(parent,text,size,font,color,align)
    return newInst("TextLabel",{
        BackgroundTransparency=1,Text=text,TextSize=size,Font=font,TextColor3=color,
        TextXAlignment=align or Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,
    },parent)
end

-- // twid
local function twid(text,font,size)
    local ok,b=pcall(TextService.GetTextSize,TextService,text,size,font,Vector2.new(1000,100))
    return ok and b.X or #text*size*0.6
end

-- // getViewport
local function getViewport()
    local cam=workspace.CurrentCamera
    return cam and cam.ViewportSize or Vector2.new(1280,720)
end

-- // clampToScreen
local function clampToScreen(target,scale)
    local vp=getViewport()
    local pos,size=target.AbsolutePosition,target.AbsoluteSize
    local dx=math.clamp(pos.X,0,math.max(vp.X-size.X,0))-pos.X
    local dy=math.clamp(pos.Y,0,math.max(vp.Y-size.Y,0))-pos.Y
    if dx~=0 or dy~=0 then
        local p=target.Position
        target.Position=UDim2.new(p.X.Scale,p.X.Offset+dx/scale,p.Y.Scale,p.Y.Offset+dy/scale)
    end
end

-- // makeDraggable
local function makeDraggable(handle,target,threshold,onClick,scaleObj)
    local drag,moved,origin,startPos=false,false,Vector2.zero,target.Position
    local function isPtr(i) return i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch end
    local function isMove(i) return i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch end
    handle.InputBegan:Connect(function(i)
        if isPtr(i) then
            drag=true
            moved=false
            origin=Vector2.new(i.Position.X,i.Position.Y)
            startPos=target.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if not drag or not isMove(i) then return end
        local d=Vector2.new(i.Position.X,i.Position.Y)-origin
        if d.Magnitude>threshold then moved=true end
        if moved then
            local s=scaleObj and scaleObj.Scale or 1
            target.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X/s,startPos.Y.Scale,startPos.Y.Offset+d.Y/s)
            clampToScreen(target,s)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if not isPtr(i) then return end
        if drag and not moved and onClick then onClick() end
        drag=false
        moved=false
    end)
end

-- // fmtTime
local function fmtTime(s)
    s=math.max(0,s)
    return string.format("%02d:%02d.%d",math.floor(s/60),math.floor(s%60),math.floor((s%1)*10))
end

-- // fmtUptime
local function fmtUptime(s)
    s=math.floor(s)
    local d,h,m=math.floor(s/86400),math.floor(s/3600)%24,math.floor(s/60)%60
    local out=""
    if d>0 then out=d.."d " end
    if d>0 or h>0 then out=out..h.."h " end
    return out..m.."m "..(s%60).."s"
end

-- // fmtCommas
local function fmtCommas(n)
    local s=tostring(math.floor(n or 0))
    local out=s:reverse():gsub("(%d%d%d)","%1,"):reverse()
    return (out:gsub("^,",""))
end

-- // trunc
local function trunc(s,max)
    s=tostring(s or "-")
    return #s>max and s:sub(1,max-3).."..." or s
end

-- // getPing
local function getPing()
    local ok,v=pcall(function() return Stats.Network.ServerStatsItem["Data Ping"]:GetValue() end)
    return (ok and v) and (math.floor(v).."ms") or "N/A"
end

-- // getMemory
local function getMemory()
    local ok,v=pcall(Stats.GetTotalMemoryUsageMb,Stats)
    return ok and (math.floor(v).."MB") or "N/A"
end

-- // getServerRegion
local function getServerRegion()
    local ok,jobId=pcall(function() return game.JobId end)
    local id=(ok and jobId and jobId~="") and jobId:sub(1,6) or "?"
    return #Players:GetPlayers().." players | "..id
end

-- // getPlayerAlias
local function getPlayerAlias()
    local ok,dn=pcall(function() return LocalPlayer.DisplayName end)
    return (ok and dn and dn~=LocalPlayer.Name) and dn or LocalPlayer.Name
end

local playerGui=LocalPlayer:WaitForChild("PlayerGui")
for _,n in ipairs({"codywas","codywas_toggle"}) do
    local old=playerGui:FindFirstChild(n)
    if old then old:Destroy() end
end

local totalW=PANEL_W*2+4
local rootH=PANEL_H+TOPBAR_H+4

local sGui=newInst("ScreenGui",{Name="codywas",ResetOnSpawn=false,DisplayOrder=999,IgnoreGuiInset=true},playerGui)
local root=newInst("Frame",{
    Name="Root",
    Size=UDim2.fromOffset(totalW,rootH),
    Position=UDim2.new(0.5,-totalW/2,0,8),
    BackgroundTransparency=1,
},sGui)
local uiScale=newInst("UIScale",{},root)

-- // applyLayout
local function applyLayout()
    local vp=getViewport()
    local s=math.clamp(math.min(vp.X/(totalW+24),vp.Y/(rootH+24)),0.5,1)
    if isTouch then s=math.min(s,0.85) end
    uiScale.Scale=s
    clampToScreen(root,s)
end

local body=newInst("Frame",{Size=UDim2.fromOffset(totalW,PANEL_H),BackgroundTransparency=1},root)
newInst("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,4)},body)

local topbar=newInst("Frame",{
    Name="Topbar",
    Size=UDim2.new(1,0,0,TOPBAR_H),
    Position=UDim2.new(0,0,0,PANEL_H+4),
    BackgroundColor3=Theme.Panel,BorderSizePixel=0,
},root)
local topTitle=newLabel(topbar,"Codywas",12,Fonts.Title,Theme.Text)
topTitle.Size=UDim2.new(1,-16,1,0)
topTitle.Position=UDim2.new(0,12,0,0)
makeDraggable(topbar,root,6,nil,uiScale)

local iconOf={}

-- // buildSection
local function buildSection(name,title,order,fields)
    local panel=newInst("Frame",{
        Name=name,
        Size=UDim2.fromOffset(PANEL_W,PANEL_H),
        BackgroundColor3=Theme.Panel,BorderSizePixel=0,
        LayoutOrder=order,ClipsDescendants=true,
    },body)
    decorate(panel)

    local hdr=newInst("Frame",{Size=UDim2.new(1,0,0,HEADER_H),BackgroundTransparency=1},panel)
    local ht=newLabel(hdr,title,10,Fonts.Header,Theme.Header)
    ht.Size=UDim2.new(1,-20,1,0)
    ht.Position=UDim2.new(0,10,0,0)
    newInst("Frame",{Size=UDim2.new(1,-12,0,1),Position=UDim2.new(0,6,1,-1),BackgroundColor3=Theme.Line,BorderSizePixel=0},hdr)

    local list=newInst("ScrollingFrame",{
        Size=UDim2.new(1,0,1,-HEADER_H-4),
        Position=UDim2.new(0,0,0,HEADER_H+2),
        BackgroundTransparency=1,BorderSizePixel=0,
        ScrollBarThickness=isTouch and 4 or 3,ScrollBarImageColor3=Theme.Muted,
        ScrollingDirection=Enum.ScrollingDirection.Y,
        CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,
        ElasticBehavior=Enum.ElasticBehavior.Never,
    },panel)
    newInst("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder},list)
    newInst("UIPadding",{PaddingLeft=UDim.new(0,10),PaddingRight=UDim.new(0,8),PaddingTop=UDim.new(0,2),PaddingBottom=UDim.new(0,2)},list)

    local values={}
    for idx,label in ipairs(fields) do
        local caption=label..":"
        local iconId=FIELD_ICONS[label]
        local iconW=iconId and ICON_SIZE or 0
        local iconGap=iconId and ICON_GAP or 0
        local capW=math.ceil(twid(caption,Fonts.Caption,10))
        local row=newInst("Frame",{Size=UDim2.new(1,0,0,ROW_H),BackgroundTransparency=1,LayoutOrder=idx},list)
        local icon
        if iconId then
            icon=newInst("ImageLabel",{
                BackgroundTransparency=1,Image=iconId,ImageColor3=Theme.Muted,
                Size=UDim2.fromOffset(iconW,iconW),Position=UDim2.new(0,0,0.5,-iconW/2),
            },row)
        end
        local nl=newLabel(row,caption,10,Fonts.Caption,Theme.Muted)
        nl.Size=UDim2.new(0,capW,1,0)
        nl.Position=UDim2.new(0,iconW+iconGap,0,0)
        local vl=newLabel(row,"-",11,NUMERIC[label] and Fonts.Number or Fonts.Value,Theme.Muted)
        vl.Size=UDim2.new(1,-capW-LABEL_GAP-iconW-iconGap,1,0)
        vl.Position=UDim2.new(0,iconW+iconGap+capW+LABEL_GAP,0,0)
        values[label]=vl
        iconOf[vl]=icon
    end
    return values
end

local raceUI=buildSection("Race","RACE STATUS",1,RACE_FIELDS)
local playerUI=buildSection("Player","PLAYER & SERVIDOR",2,PLAYER_FIELDS)

local tGui=newInst("ScreenGui",{Name="codywas_toggle",ResetOnSpawn=false,DisplayOrder=1000,IgnoreGuiInset=true},playerGui)
local toggleBtn=newInst("ImageButton",{
    Size=UDim2.fromOffset(BTN_SIZE,BTN_SIZE),Position=UDim2.new(0,16,0.5,-BTN_SIZE/2),
    BackgroundColor3=Theme.Accent,
    Image="rbxassetid://88779617285504",ScaleType=Enum.ScaleType.Crop,
},tGui)
newInst("UICorner",{CornerRadius=UDim.new(1,0)},toggleBtn)
newInst("UIStroke",{Color=Theme.Line,Thickness=1.5,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},toggleBtn)

local guiVisible=true
makeDraggable(toggleBtn,toggleBtn,isTouch and 10 or 7,function()
    guiVisible=not guiVisible
    root.Visible=guiVisible
end)

applyLayout()
local function bindCamera()
    local cam=workspace.CurrentCamera
    if cam then cam:GetPropertyChangedSignal("ViewportSize"):Connect(applyLayout) end
end
bindCamera()
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    bindCamera()
    applyLayout()
end)

local EMPTY={["no"]=true,["no sub"]=true,["-"]=true,["N/A"]=true,["?"]=true,["$0"]=true,["0/0"]=true}
local cache={}

-- // setVal
local function setVal(lbl,text,color)
    color=color or Theme.Text
    if not loadDone and EMPTY[text] then
        text=SPINNER_FRAMES[spinnerIdx]
        color=Theme.Muted
    end
    local e=cache[lbl]
    if not e then
        e={}
        cache[lbl]=e
    end
    if e.t==text and e.c==color then return end
    e.t=text
    e.c=color
    lbl.Text=text
    lbl.TextColor3=color
    local icon=iconOf[lbl]
    if icon then
        icon.ImageColor3=(color==Theme.Text or color==Theme.Muted) and Theme.Muted or color
    end
end

local gameName="..."
task.spawn(function()
    local ok,info=pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId,Enum.InfoType.Asset) end)
    gameName=(ok and info and info.Name) or game.Name
end)

local execName="?"
pcall(function() execName=identifyexecutor() end)
local scriptStart=os.clock()
local raceLabel=tostring(World.raceNumber or World.raceName or "?")

setVal(playerUI.PlaceId,tostring(game.PlaceId))
setVal(playerUI.Player,LocalPlayer.Name)
setVal(playerUI.Alias,getPlayerAlias(),Theme.Muted)
setVal(playerUI.Executor,trunc(execName,22))

-- // updateGui
task.spawn(function()
    local tick=0
    local step=guard("updateGui",function()
        tick+=1
        local elapsed=(St.inRace and St.raceClock) and (os.clock()-St.raceClock) or 0
        local minDur=World.minDuration
        local canCollect=elapsed>=minDur

        setVal(raceUI.State,St.state,St.inRace and Theme.Text or Theme.Muted)
        setVal(raceUI.Race,raceLabel)
        setVal(raceUI.CP,St.cp)
        setVal(raceUI.Car,trunc(St.car,18))
        setVal(raceUI.Place,St.place,St.place~="-" and Theme.Text or Theme.Muted)
        setVal(raceUI.Time,fmtTime(elapsed),canCollect and Theme.Text or Theme.Bad)
        setVal(raceUI.Collect,canCollect and "CAN COLLECT" or fmtTime(minDur-elapsed),canCollect and Theme.Good or Theme.Bad)
        setVal(raceUI.Last,trunc(St.last,20))
        setVal(raceUI.Reason,trunc(St.reason,20),Theme.Muted)
        setVal(raceUI.Done,tostring(St.raceCount))
        setVal(raceUI.Failed,tostring(St.failed),St.failed>0 and Theme.Bad or Theme.Text)
        setVal(raceUI.Retry,tostring(St.retries),St.retries>0 and Theme.Bad or Theme.Text)
        setVal(raceUI.CPs,tostring(St.cpTotal))
        setVal(raceUI.Best,St.bestTime and fmtTime(St.bestTime) or "-")
        setVal(raceUI.Cash,"$"..fmtCommas(St.cash),Theme.Good)
        setVal(raceUI.Claims,tostring(St.claims))
        setVal(raceUI.Daily,St.daily,St.daily=="YES" and Theme.Good or Theme.Muted)
        setVal(raceUI.Weekly,St.weekly,St.weekly=="YES" and Theme.Good or Theme.Muted)

        setVal(playerUI.Game,trunc(gameName,20))
        setVal(playerUI.Uptime,fmtUptime(os.clock()-scriptStart))
        setVal(playerUI.Status,St.inRace and "In race" or "In lobby",St.inRace and Theme.Text or Theme.Muted)
        setVal(playerUI.Streak,St.streak)

        if tick%10==1 then
            local hours=math.max((os.clock()-scriptStart)/3600,0.0003)
            local pd=St.playerData
            local bal=pd and pd.Data and pd.Data.Cash
            setVal(raceUI.Avg,St.raceCount>0 and fmtTime(St.durSum/St.raceCount) or "-")
            setVal(raceUI.Balance,bal and ("$"..fmtCommas(bal)) or "-",Theme.Good)
            setVal(raceUI["Cash/h"],"$"..fmtCommas(St.cash/hours),Theme.Good)
            setVal(raceUI["Races/h"],string.format("%.1f",St.raceCount/hours))
            setVal(playerUI.Ping,getPing(),Theme.Muted)
            setVal(playerUI.Region,getServerRegion(),Theme.Muted)
            setVal(playerUI.FPS,tostring(fps),fps<30 and Theme.Bad or Theme.Text)
            setVal(playerUI.Memory,getMemory(),Theme.Muted)
        end
    end)
    while true do
        task.wait(0.1)
        if guiVisible then step() end
    end
end)