local sesduzey = 1
local ping
local dogalgaz, db, wind, ampul, dollar, yuzme, gym = false, 0, 0, 0, 0, 0, 0
local health2, armor2, oxy2, hunger2, thirst2 = false, false, false, false, false
local developer, debug = false, false
local pursuitmode = 0
local lastDamageTrigger = 0
local nuke, gps, gpu = 0, 0, 0

local isLoggedIn = false
local HudActive = false
local harness = 0
local oxygenLevel = 25
local oxyOn = false
local hasChanged = false
local inVehicle = false
local inveh = false
local engineOn = false
local weaponFireRate = 0
local showWeaponFireRate = false
local showOutLine = false
local buffCountMoney = false
local pStress = 0
local stresstime = 0

local currentValues = {
	["health"] = 100,
	["armor"] = 100,
	["hunger"] = 100,
	["thirst"] = 100,
	["oxy"] = 2,
	["stress"] = 100,
	["voice"] = 2,
	["devmode"] = false,
	["devdebug"] = false,
  ["hasregen"] = false,
	["is_talking"] = false
}

RegisterNetEvent("ev-hud:EnableHud", function(status)
    isLoggedIn = status
    if status == true then
        exports['ev-interface']:showInteraction('[F] To pay respects')
        HudActive = false
    end
end)

RegisterNetEvent("ev-hud:changeRange", function(pRange)
    voice = pRange or 2
end)

RegisterNetEvent('desirerp:admin:currentDevmode', function(status)
    developer = status
end)

RegisterNetEvent('desirerp:admin:currentDebug', function(status)
    debug = status
end)

RegisterNetEvent('ev-weapons:client:setWeaponFireRate', function (pAmount)
--    weaponFireRate = pAmount
end)

RegisterNetEvent("ev-weapons:client:showWeaponFireRate", function (pBool)
    weaponFireRate = pBool
end)

RegisterNetEvent("ev-hud:harness_values", function(cinturon)
	harness = cinturon
end)

function lerp(min, max, amt)
	return (1 - amt) * min + amt * max
end

function rangePercent(min, max, amt)
	return (((amt - min) * 100) / (max - min)) / 100
end

function attachProp2(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp2()
    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    attachedProp2 = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp2, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    SetModelAsNoLongerNeeded(attachModel)
end

function attachProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp()
    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)

    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    SetModelAsNoLongerNeeded(attachModel)
end

RegisterNetEvent("UseOxygenTank",function()
	oxygenLevel = 100.0
	TriggerEvent('menu:hasOxygenTank', true)
end)

RegisterNetEvent("RemoveOxyTank",function()
	if oxygenLevel > 25.0 then
		oxygenLevel = 25.0
        removeAttachedProp()
        removeAttachedProp2()
		TriggerEvent('menu:hasOxygenTank', false)
	end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    local plyPed = PlayerPedId()

    if IsPedSwimmingUnderWater(plyPed) then
      if oxygenLevel > 0 then
        SetPedDiesInWater(plyPed, false)
        if not hasChanged then
          SetAudioSubmixEffectParamInt(0, 0, `enabled`, 1)
          hasChanged = true
        end
        if oxygenLevel > 25.0 then
          oxygenLevel = oxygenLevel - 0.003125
        else
          oxygenLevel = oxygenLevel - (swimSpeedIncreased and 0.33 or 0.5)
        end
      else
        SetPedDiesInWater(plyPed, true)
      end
    end

    if (not IsPedSwimmingUnderWater(plyPed)) and hasChanged then
      SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)
      hasChanged = false
    end

    if not IsPedSwimmingUnderWater( plyPed ) and oxygenLevel < 25.0 then
      if GetGameTimer() - lastDamageTrigger > 3000 then
        oxygenLevel = oxygenLevel + 1
        if oxygenLevel > 25.0 then
          oxygenLevel = 25.0
        end
      else
        if oxygenLevel <= 0 then

          if exports['ragdoll']:GetDeathStatus() then
            lastDamageTrigger = -7000
            oxygenLevel = 25.0
          else
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 20)
          end
        end
      end
    end

    if oxygenLevel > 25.0 and (not oxyOn) and (useBlackOxy) then
      oxyOn = true
      attachProp("p_s_scuba_tank_s_black", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
      attachProp2("p_s_scuba_mask_s_black", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
    elseif oxygenLevel > 25.0 and not oxyOn then
      oxyOn = true
      attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
      attachProp2("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
    elseif oxyOn and oxygenLevel <= 25.0 then
      oxyOn = false
      removeAttachedProp()
      removeAttachedProp2()
      useBlackOxy = false
    end
    if not oxyOn then
      if IsPedSwimming(plyPed) then
        ResetPlayerStamina(plyPed)
      end
      Wait(200)
    else
      if (IsPedRunning(plyPed) or IsPedSprinting(plyPed)) and not IsPedSwimming(plyPed) then
        DisableControlAction(0, 21, true)
      end
    end
  end
end)

Citizen.CreateThread(function ()
    local isTalkingToggle = false
    local isTalkingOnRadio = false

	while true do

        local isTalking = NetworkIsPlayerTalking(PlayerId())
        local pRadioActive = exports['ev-voice']:pRadioActive()

        if (isTalking and not isTalkingToggle) then
            isTalkingToggle = true
            SendNUIMessage({
                action = "update", 
                talking = isTalking and not pRadioActive,
                radioPush = pRadioActive,
            })
        elseif (not isTalking and isTalkingToggle) then
            isTalkingToggle = false
            SendNUIMessage({
                action = "update", 
                talking = isTalking and not pRadioActive,
                radioPush = pRadioActive,
            })
        end
		Citizen.Wait(100)
	end
end)


Citizen.CreateThread(function()
    voice = 2
    while true do 
        Citizen.Wait(500)

        if isLoggedIn then
        
            local playerPed = PlayerPedId()
            speed = GetEntitySpeed(GetVehiclePedIsIn(playerPed, false)) * 3.6
            local playerVeh = GetVehiclePedIsIn(playerPed, false)
            local pRadio = exports['radio']:pChannel()

            armed = false

            armorLevel = GetPedArmour(playerPed)
            healthLevel = GetEntityHealth(playerPed) - 100


            if pStress < 0 then 
                pStress = 0
            end

            if currentValues["hunger"] < 0 then
                currentValues["hunger"] = 0
            end

            if currentValues["thirst"] < 0 then
                currentValues["thirst"] = 0
            end

            if pStress > 100 then pStress = 100 end
            if currentValues["hunger"] > 100 then currentValues["hunger"] = 100 end
            if currentValues["thirst"] > 100 then currentValues["thirst"] = 100 end
            if healthLevel < 1 then healthLevel = 100 end
            if armorLevel > 100 then armorLevel = 100 end
            
            TriggerServerEvent("hud-getping:sv") 

            if IsPauseMenuActive() then
                if HudActive then
                    HudActive = false
                    SendNUIMessage({ action = 'show', show = false, }) 
                end
            elseif not IsPauseMenuActive() and isLoggedIn then
                if not HudActive then
                    HudActive = true
                    SendNUIMessage({action = 'show', show = true, }) 
                    exports['ev-interface']:hideInteraction()
                end
            end

            SendNUIMessage({
                action = "update",
                health = healthLevel,
                armor = armorLevel,
                hunger = currentValues["hunger"],
                thirst = currentValues["thirst"],
                stress = pStress,
                oxy = oxygenLevel,
                dogalgaz = dogalgaz,
                db = db,
                wind = wind,
                ping = ping,
                ampul = ampul, --lightbulp
                dollar = dollar,
                yuzme = yuzme, -- swim buff
                gym = gym,
                harness = harness,
                cruise = pursuitmode,
                nuke = nuke,
                gps = gps,
                gpu = gpu,
                nos = exports['ev-vehicles']:nitroLevel(),
                dev = developer,
                debug = debug,
                armed = weaponFireRate,
                health2 = health2,
                armor2 = armor2,
                hunger2 = hunger2,
                thirst2 = thirst2,
                oxy2 = oxy2,
                voice = voice,
                radio = pRadio
            })
        else
            SendNUIMessage({ action = 'show', show = false, })
        end
    end
end)



-- functs

function OpenMenu() SetNuiFocus(true, true) SendNUIMessage({action = "open"})end

RegisterNUICallback('close', function(data, cb) SetNuiFocus(false, false) end)

RegisterNetEvent("hud-getping:cl") AddEventHandler("hud-getping:cl", function(ping1) ping = tonumber(ping1) end)

function dobuffthing(name, value)
    if name == "db" then
        db = tonumber(value)
    elseif name == "wind" then
        wind = tonumber(value)
    elseif name == "lightbulp" then
        ampul = tonumber(value)
    elseif name == "dollar" then
        dollar = tonumber(value)
    elseif name == "swimming" then
        yuzme = tonumber(value)
    elseif name == "gym" then
        gym = tonumber(value)
    elseif name == "dev" then 
        dev = not dev
    elseif name == "debug" then 
        debug = not debug
    elseif name == "health" then
        health2 = value
    elseif name == "armor" then
        armor2 = value
    elseif name == "hunger" then
        hunger2 = value
    elseif name == "thirst" then
        thirst2 = value
    elseif name == "oxy" then
        oxy2 = value
    elseif name == 'nuke' then
        nuke = value
    elseif name == 'pursuitmode' then -- Pursuit
        pursuitmode = value
    elseif name == 'boostingtracker' then
        gpu = value
    end
end

RegisterNetEvent('ev-hud:pursuitModeHUD')
AddEventHandler('ev-hud:pursuitModeHUD', function(value)
    dobuffthing('pursuitmode', value)
end)

RegisterNetEvent("client:updateStress")
AddEventHandler("client:updateStress",function(newStress)
    pStress = newStress
end)

RegisterNetEvent("client:blockShake")
AddEventHandler("client:blockShake",function(isBlockedInfo)
    isBlocked = isBlockedInfo
end)


RegisterNetEvent("ev-admin:currentDevmode")
AddEventHandler("ev-admin:currentDevmode", function(devmode)
    isBlocked = devmode
end)
--- CARHUD ---

local area = ""
local street = ""
local dist = 0
local sleep = 50
local osurcam = 50
local carhudfps = 500

RegisterNUICallback("compass", function(data)
    sleep = data.fps 
    osurcam = data.fps
    print(sleep)
end)

RegisterNUICallback("carhud", function(data)
    carhudfps = data.fps 
    TriggerEvent("alahiyedik", data.fps)
end)

Citizen.CreateThread(function()
    while true do
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local eon = IsVehicleEngineOn(veh)
        if eon and not engineOn then
            roundedRadar()
            engineOn = true

            local hour = GetClockHours()
            if hour < 10 then 
                hour = "0" .. hour
            end
            local minute = GetClockMinutes()
            if minute < 10 then 
                minute = "0" .. minute
            end
            local time = hour .. ":" .. minute

            if IsWaypointActive() then
                dist = (#(GetEntityCoords(PlayerPedId()) - GetBlipCoords(GetFirstBlipInfoId(8))) / 1000) * 0.715 -- quick conversion maff
            else
                dist = 0
            end

            if not IsPauseMenuActive() then 
                SendNUIMessage({
                    action = "carhud",
                    show = true,
                    direction = math.floor(calcHeading(-GetEntityHeading(player) % 360)),
                    area = area,
                    street = street,
                    mil = dist,
                    time = time
                })
            end
        elseif not eon and engineOn then
            engineOn = false
            Citizen.Wait(32)
            DisplayRadar(0)
        elseif IsPedOnFoot(PlayerPedId()) then
            Citizen.Wait(32)
            DisplayRadar(0)
            SendNUIMessage({action = "carhud", show = false})
            SendNUIMessage({action = "carhud", bar5 = false})
        end

        Citizen.Wait(250)
    end
end)

local imageWidth = 100 -- leave this variable, related to pixel size of the directions
local containerWidth = 100 -- width of the image container

-- local width =  (imageWidth / containerWidth) * 100; -- used to convert image width if changed
local width =  0;
local south = (-imageWidth) + width
local west = (-imageWidth * 2) + width
local north = (-imageWidth * 3) + width
local east = (-imageWidth * 4) + width
local south2 = (-imageWidth * 5) + width

function calcHeading(direction)
    if (direction < 90) then
        return lerp(north, east, direction / 90)
    elseif (direction < 180) then
        return lerp(east, south2, rangePercent(90, 180, direction))
    elseif (direction < 270) then
        return lerp(south, west, rangePercent(180, 270, direction))
    elseif (direction <= 360) then
        return lerp(west, north, rangePercent(270, 360, direction))
    end
end

function rangePercent(min, max, amt)
    return (((amt - min) * 100) / (max - min)) / 100
end

function lerp(min, max, amt)
   return (1 - amt) * min + amt * max
end

---- OVALMAP -----

local minimapEnabled = true
local inVehicle = false
local forceShowMinimap = false
local useDefaultMinimap = false
local appliedTextureChange = false
local sa = false

RegisterNUICallback("minimap", function(data)
    if data.action == "close" then
        minimapEnabled = false
        SendNUIMessage({action = "carhud", bar5 = false})
        roundedRadar()
    elseif data.action == "open" then
        minimapEnabled = true
        DisplayRadar(1)
        SendNUIMessage({action = "carhud", bar5 = true})
        roundedRadar()
    elseif data.action == "default" then
        useDefaultMinimap = true
        roundedRadar()

        Wait(500)
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)

        TriggerEvent("carhud:getmap", "default")
    elseif data.action == "ovalmap" then
        useDefaultMinimap = false
        roundedRadar()

        Wait(500)
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)
        TriggerEvent("carhud:getmap", "ovalmap")
    elseif data.action == "outline-close" then
        DisplayRadar(1)
        showOutLine = false
        SendNUIMessage({action = "carhud", bar5 = false})
    elseif data.action == "outline-open" then
        DisplayRadar(1)
        showOutLine = true
        SendNUIMessage({action = "carhud", bar5 = true})   
    end
end)

function roundedRadar()
    if wasMinimapEnabled == false then
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false) 
        return
    end
    Citizen.CreateThread(function()
        if not appliedTextureChange and not useDefaultMinimap then
          RequestStreamedTextureDict("circlemap", false)
          while not HasStreamedTextureDictLoaded("circlemap") do
              Citizen.Wait(0)
          end
          AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasklg")
          AddReplaceTexture("platform:/textures/graphics", "radarmasklg", "circlemap", "radarmasklg")
          appliedTextureChange = true
        elseif appliedTextureChange and useDefaultMinimap then
          appliedTextureChange = false
          RemoveReplaceTexture("platform:/textures/graphics", "radarmasksm")
          RemoveReplaceTexture("platform:/textures/graphics", "radarmasklg")
        end

        SetBlipAlpha(GetNorthRadarBlip(), 0.0)

        local screenX, screenY = GetScreenResolution()
        local modifier = screenY / screenX

        local baseXOffset = 0.0046875
        local baseYOffset = 0.74

        local baseSize    = 0.20 -- 20% of screen

        local baseXWidth  = 0.1313 -- baseSize * modifier -- %
        local baseYHeight = baseSize -- %

        local baseXNumber = screenX * baseSize  -- 256
        local baseYNumber = screenY * baseSize  -- 144

        local radiusX     = baseXNumber / 2     -- 128
        local radiusY     = baseYNumber / 2     -- 72

        local innerSquareSideSizeX = math.sqrt(radiusX * radiusX * 2) -- 181.0193
        local innerSquareSideSizeY = math.sqrt(radiusY * radiusY * 2) -- 101.8233

        local innerSizeX = ((innerSquareSideSizeX / screenX) - 0.01) * modifier
        local innerSizeY = innerSquareSideSizeY / screenY

        local innerOffsetX = (baseXWidth - innerSizeX) / 2
        local innerOffsetY = (baseYHeight - innerSizeY) / 2

        local innerMaskOffsetPercentX = (innerSquareSideSizeX / baseXNumber) * modifier

        local function setPos(type, posX, posY, sizeX, sizeY)
            SetMinimapComponentPosition(type, "I", "I", posX, posY, sizeX, sizeY)
        end
        if not useDefaultMinimap then
            setPos("minimap",       baseXOffset - (0.025 * modifier), baseYOffset - 0.025, baseXWidth + (0.05 * modifier), baseYHeight + 0.05)
            setPos("minimap_blur",  baseXOffset, baseYOffset, baseXWidth + 0.001, baseYHeight)
            setPos("minimap_mask", 0.1, 0.95, 0.09, 0.15)

            if showOutLine then
                SendNUIMessage({action = "carhud", bar5 = true})
            else
                SendNUIMessage({action = "carhud", bar5 = false})
            end
        else
            local function setPosLB(type, posX, posY, sizeX, sizeY)
                SetMinimapComponentPosition(type, "L", "B", posX, posY, sizeX, sizeY)
            end
            local offsetX = -0.018
            local offsetY = 0.025
  
            local defaultX = -0.0045
            local defaultY = 0.002
  
            local maskDiffX = 0.020 - defaultX
            local maskDiffY = 0.032 - defaultY
            local blurDiffX = -0.03 - defaultX
            local blurDiffY = 0.022 - defaultY
  
            local defaultMaskDiffX = 0.0245
            local defaultMaskDiffY = 0.03
  
            local defaultBlurDiffX = 0.0255
            local defaultBlurDiffY = 0.02
  
            setPosLB("minimap",       -0.0045,  -0.0245,  0.150, 0.18888)
            setPosLB("minimap_mask",  0.020,    0.022,  0.111, 0.159)
            setPosLB("minimap_blur",  -0.03,    0.002,  0.266, 0.237)

            if not showOutLine then
                SendNUIMessage({action = "carhud", bar5 = false})
            else
                SendNUIMessage({action = "carhud", bar5 = true})
            end
        end
        if not useDefaultMinimap then
          SetMinimapClipType(1)
        else
          SetMinimapClipType(0)
        end
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)
    end)
end

RegisterNetEvent('ev-hud:ChangeThirst', function(amount)
    if isLoggedIn == true then
		currentValues["thirst"] = currentValues["thirst"] + amount

		if currentValues["thirst"] < 0 then
			currentValues["thirst"] = 0
		end

		if currentValues["thirst"] > 100 then
			currentValues["thirst"] = 100
		end
        TriggerEvent("hud:saveCurrentMeta")

	end
end)

RegisterNetEvent('ev-hud:ChangeHunger', function(amount)
	if isLoggedIn == true then

        currentValues["hunger"] = currentValues["hunger"] + amount

		if currentValues["hunger"] < 0 then
            currentValues["hunger"] = 0
		end

		if currentValues["hunger"] > 100 then
            currentValues["hunger"] = 100
		end
        TriggerEvent("hud:saveCurrentMeta")
	end
end)

RegisterNetEvent('hud:saveCurrentMeta')
AddEventHandler('hud:saveCurrentMeta', function()
	TriggerServerEvent("police:update:hud",GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"],currentValues["armor"])
end)

RegisterNetEvent("police:setClientMeta")
AddEventHandler("police:setClientMeta",function(meta)
	if meta == nil then return end
	if meta.thirst == nil then currentValues["thirst"] = 100 else currentValues["thirst"] = meta.thirst end
	if meta.hunger == nil then currentValues["hunger"] = 100 else currentValues["hunger"] = meta.hunger end
	if meta.health == nil then
		return
	end

	if meta.health < 10.0 then
		SetEntityHealth(PlayerPedId(),10.0)
	else
		SetEntityHealth(PlayerPedId(),meta.health)
	end

	
	SetPlayerMaxArmour(PlayerPedId(), 60 )
	SetPedArmour(PlayerPedId(),meta.armour)
end)

RegisterNetEvent("client:newStress", function(status, amount)
    local actualamount = amount/10

    if status == true then
        pStress = pStress + actualamount
        TriggerEvent("DoShortHudText",'Stress Gained',6)
        Wait(1000)
        TriggerServerEvent('ev-hud:UpdateStress_SV', pStress)
    elseif status == false then
        pStress = pStress - actualamount
        Wait(1000)
        TriggerServerEvent('ev-hud:UpdateStress_SV', pStress)
    end
end)

Citizen.CreateThread(function()
    while true do
        if not isBlocked then
            if pStress >= 100 then
                TriggerScreenblurFadeIn(1000.0)
                Wait(3000)
                TriggerScreenblurFadeOut(1000.0)
            elseif pStress <= 99 and pStress >=45 then
                TriggerScreenblurFadeIn(1000.0)
                Wait(100)
                TriggerScreenblurFadeOut(1000.0)
            end
        end 
        Citizen.Wait(2000)
    end
end)

RegisterNetEvent('desirerp:admin:maxstats', function()
    currentValues["thirst"] = 100
	currentValues["hunger"] = 100 
    TriggerEvent("heal", PlayerPedId())
    TriggerEvent("Hospital:HealInjuries", PlayerPedId(),true) 
    TriggerServerEvent("ev-death:reviveSV", source)
    TriggerServerEvent("reviveGranted", source)
    TriggerServerEvent("ems:healplayer", source)
    SetPlayerMaxArmour(PlayerPedId(), 100)
    SetPedArmour(PlayerPedId(), 60)
    TriggerEvent("hud:saveCurrentMeta")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isLoggedIn then

            if currentValues["hunger"] > 0 then
                currentValues["hunger"] = currentValues["hunger"] - math.random(3)
            end

            if currentValues["thirst"] > 0 then
                currentValues["thirst"] = currentValues["thirst"] - math.random(3)
            end	

            if currentValues["thirst"] < 20 or currentValues["hunger"] < 20 then
                local newhealth = GetEntityHealth(PlayerPedId()) - math.random(10)
                SetEntityHealth(PlayerPedId(), newhealth)
            end
            TriggerEvent("hud:saveCurrentMeta")

            Citizen.Wait(300000)
        end
	end
end)

RegisterNUICallback("time", function(data)
    exports['ev-carhud']:SetTimeEnabled(data.time)
end)

RegisterNUICallback("SaveSettings", function(data)
    local pInfo = exports["ev-base"]:getModule("LocalPlayer")
    local cid = exports['isPed']:isPed('cid')
    local model = data.pModel
    local bg = data.pBg
    local twatNotify = data.pTwatNotify
    local callNotify = data.pCallNotify
    print(callNotify, twatNotify, bg, model)

    SetResourceKvpInt(cid..'-healthValue', tonumber(data.healthValue))
    SetResourceKvpInt(cid..'-armorValue', tonumber(data.armorValue))
    SetResourceKvpInt(cid..'-hungerValue', tonumber(data.hungerValue))
    SetResourceKvpInt(cid..'-thirstValue', tonumber(data.thirstValue))
    SetResourceKvpInt(cid..'-healthToggled', data.healthToggled)
    SetResourceKvpInt(cid..'-armorToggled', data.armorToggled)
    SetResourceKvpInt(cid..'-hungerToggled', data.hungerToggled)
    SetResourceKvpInt(cid..'-thirstToggled', data.thirstToggled)
    SetResourceKvpInt(cid..'-speedFPSValue', tonumber(data.speedFPSValue))
    SetResourceKvpInt(cid..'-compassFPSValue', tonumber(data.compassFPSValue))
    SetResourceKvpInt(cid..'-defaultMapToggled', data.defaultMapToggled)
    SetResourceKvpInt(cid..'-outlineToggled', data.outlineToggled)
    SetResourceKvpInt(cid..'-timeToggled', data.timeToggled)
    SetResourceKvpInt(cid..'-circleTaskbar', data.pCircleTaskbar)
    exports['ev-carhud']:SetCompassFPS(tonumber(data.compassFPSValue))
    exports['ev-carhud']:SetSpeedFPS(tonumber(data.speedFPSValue))
    TriggerEvent('setModel', model)
    TriggerEvent('ev-phone:grabBackground', bg)
    TriggerEvent('changeBG', bg)
    TriggerEvent("ev-phone:setSomeShit",bg,model,twatNotify,callNotify)
    local circleTaskbar = GetResourceKvpInt(cid..'-circleTaskbar')
    if circleTaskbar == 1 then
        TriggerEvent("ev-preferences:setPreferences", true)
    elseif circleTaskbar == 0 then
        TriggerEvent("ev-preferences:setPreferences", false)
    end
    

    TriggerEvent('DoShortHudText', 'Setting Saved!', 1)
end)

AddEventHandler('ev-preferences:setPreferences', function(bool)
    local data = {
        ["hud.misc.circle.taskbar.enabled"] = bool
    }
    exports["ev-interface"]:sendAppEvent('preferences', data)
end)

RegisterNetEvent("ev-hud:SetValues", function()
    local pInfo = exports["ev-base"]:getModule("LocalPlayer")
    local cid = exports['isPed']:isPed('cid')

    local SetAmour = GetResourceKvpInt(cid..'-armour')
    local SetStress = GetResourceKvpInt(cid..'-stress')
    local SetThirst = GetResourceKvpInt(cid..'-thirst')
    local SetHunger = GetResourceKvpInt(cid..'-hunger')
    local SetHealth = GetResourceKvpInt(cid..'-health')

    local SetHealthValue = GetResourceKvpInt(cid..'-healthValue')
    local SetArmorValue = GetResourceKvpInt(cid..'-armorValue')
    local SetHungerValue = GetResourceKvpInt(cid..'-hungerValue')
    local SetThirstValue = GetResourceKvpInt(cid..'-thirstValue')

    local SetHealthToggled = GetResourceKvpInt(cid..'-healthToggled')
    local SetArmorToggled = GetResourceKvpInt(cid..'-armorToggled')
    local SetHungerToggled = GetResourceKvpInt(cid..'-hungerToggled')
    local SetThirstToggled = GetResourceKvpInt(cid..'-thirstToggled')

    local SetSpeedFPSValue = GetResourceKvpInt(cid..'-speedFPSValue')
    local SetCompassFPSValue = GetResourceKvpInt(cid..'-compassFPSValue')

    local SetDefaultMapToggled = GetResourceKvpInt(cid..'-defaultMapToggled')
    local SetOutlineToggled = GetResourceKvpInt(cid..'-outlineToggled')
    local SetTimeToggled = GetResourceKvpInt(cid..'-timeToggled')
    local circleTaskbar = GetResourceKvpInt(cid..'-circleTaskbar')

    local model = exports['ev-phone']:getModelForHud()
    local background = exports['ev-phone']:getBackgroundForHud()
    local twat = exports['ev-phone']:getTwatForHud()
    local call = exports['ev-phone']:getCallForHud()



    SendNUIMessage({ 
        action = 'SetSettings',
        SetHealthValue = SetHealthValue,
        SetArmorValue = SetArmorValue,
        SetHungerValue = SetHungerValue,  
        SetThirstValue = SetThirstValue,
        SetHealthToggled = SetHealthToggled,
        SetArmorToggled = SetArmorToggled,
        SetHungerToggled = SetHungerToggled,
        SetThirstToggled = SetThirstToggled,
        SetSpeedFPSValue = SetSpeedFPSValue,
        SetCompassFPSValue = SetCompassFPSValue,
        SetDefaultMapToggled = SetDefaultMapToggled,
        SetOutlineToggled = SetOutlineToggled,
        SetTimeToggled = SetTimeToggled,
        SetModelValue = model,
        SetBackgroundValue = background,
        SetTwatValue = twat,
        SetCircleTaskbar = circleTaskbar,
        SetCallValue = call
    })


    exports['ev-carhud']:SetCompassFPS(SetCompassFPSValue)
    exports['ev-carhud']:SetSpeedFPS(SetSpeedFPSValue)

    if SetDefaultMapToggled == 1 then 
        useDefaultMinimap = true
        appliedTextureChange = false
        roundedRadar()
        Wait(500)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
    elseif SetDefaultMapToggled == 0 then 
        useDefaultMinimap = false
        Wait(500)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
    end

    if SetTimeToggled == 1 then
        exports['ev-carhud']:SetTimeEnabled(true)
    elseif SetTimeToggled == 0 then
        exports['ev-carhud']:SetTimeEnabled(false)
    end

    print(circleTaskbar)

    if circleTaskbar == 1 then
        TriggerEvent("ev-preferences:setPreferences", true)
    elseif circleTaskbar == 0 then
        TriggerEvent("ev-preferences:setPreferences", false)
    end
    

    if SetOutlineToggled == 1 then 
        showOutLine = true
    elseif SetOutlineToggled == 0 then 
        showOutLine = false
    end

    Wait(1000)

    if SetHealth ~= nil then
        if SetHealth < 10.0 then
            SetEntityHealth(PlayerPedId(), 10.0)
        else
            SetEntityHealth(PlayerPedId(), SetHealth)
        end
    else
        SetEntityHealth(PlayerPedId(),100.0)
    end

    if SetAmour == nil then 
        SetPlayerMaxArmour(PlayerPedId(), 100)
        SetPedArmour(PlayerPedId(), 100)
        SetResourceKvpInt(cid..'-armour', 100)
    else
        SetPlayerMaxArmour(PlayerPedId(), 100)
        SetPedArmour(PlayerPedId(), SetAmour)
    end
end)

RegisterCommand('ui-r', function()
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'closeMenu'})
    TriggerEvent('ev-hud:EnableHud', false)
    TriggerEvent('closeInventoryGui')
    TriggerEvent('ev-banking:ResetUI')
    TriggerEvent('ev-radio:ResetUI')
    TriggerEvent('ev-menu:ResetUI')
    TriggerEvent('ev-interact:ResetUI')
    TriggerEvent('ev-mdt:ResetUI')
    TriggerEvent('phone:reset')
    TriggerEvent('clothing:close')
    exports['ev-interface']:showInteraction("Restarting UI .")
    Wait(1000)
    exports['ev-interface']:showInteraction("Restarting UI ..")
    Wait(1000)
    exports['ev-interface']:showInteraction("Restarting UI ...")
    Wait(1000)
    exports['ev-interface']:showInteraction("UI Successfully Restarted")
    Wait(1000)
    exports['ev-interface']:hideInteraction()
    TriggerEvent('ev-hud:EnableHud', true)
end)

exports("setFuel", function(veh, amt)
	DecorSetInt(veh, "GetVehicleCurrentFuel", amt)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) then
            if IsPedUsingActionMode(ped) then
                SetPedUsingActionMode(ped, -1, -1, 1)
            end
        else
            Citizen.Wait(3000)
        end
    end
end)

RegisterNetEvent('ev-hud:boosting_value')
AddEventHandler('ev-hud:boosting_value', function(pValue)
    dobuffthing('boostingtracker', pValue)
end)

-- // Stretched Res Blocker // --

-- local IsWide = false

-- Citizen.CreateThread(function()	
-- 	while true do
-- 		Citizen.Wait(1000)
--         local res = GetIsWidescreen()
--         if not res and not IsWide then
--             startTimer()
--             IsWide = true
--         elseif res and IsWide then
--             IsWide = false
--         end
-- 	end
-- end)

-- function startTimer()
-- 	local timer = 600000

-- 	Citizen.CreateThread(function()
-- 		while timer > 0 and IsWide do
-- 			Citizen.Wait(1000)

-- 			if timer > 0 then
--                 timer = timer - 1
--                 if timer == 0 then
--                     TriggerServerEvent("dwb_res:Bye")
--                 end
-- 			end
-- 		end
-- 	end)

-- 	Citizen.CreateThread(function()
-- 		while IsWide do
-- 			Citizen.Wait(2000)
-- 			draw(string.format("You will get kicked in %s seconds, change your resoultion to 16:9", timer))
-- 		end
-- 	end)
-- end


-- function draw(text) 
-- 	BeginTextCommandThefeedPost("STRING")
-- 	AddTextComponentSubstringPlayerName(text)
-- 	ThefeedNextPostBackgroundColor(184)
-- 	PlaySound(-1, "SELECT", 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1);
-- 	ThefeedSetAnimpostfxCount(1)
-- 	ThefeedSetAnimpostfxColor(34, 138, 21, 255)
-- 	EndTextCommandThefeedPostTicker(true, true)
-- end

-- Buffs --

-- Intelegence / Heist Hacks --

RegisterNetEvent('aspect-buffs:bulb_buff')
AddEventHandler('aspect-buffs:bulb_buff', function()
    local time = math.random(7, 25)
    dobuffthing("lightbulp", time)
    intelegenceTime = time
    isIntelegent = 1
    while intelegenceTime > 0 do
        Citizen.Wait(30000)
        intelegenceTime = intelegenceTime - 1
        dobuffthing("lightbulp", intelegenceTime)
    end
    isIntelegent = 0
    dobuffthing("lightbulp", 0)
end)

function IntelegenceBuff()
    if isIntelegent == 1 then
        isIntelegent = true
    elseif isIntelegent == 0 then
        isIntelegent = false
    end
    return isIntelegent
  end

  -- Swimming Buff --

RegisterNetEvent('aspect-buffs:swim_buff')
AddEventHandler('aspect-buffs:swim_buff', function()
    local buffTime = math.random(10, 50)
    dobuffthing("swimming", buffTime)
    SetSwimMultiplierForPlayer(PlayerPedId(), 2.0)
    buffSwimming = buffTime
    while buffSwimming > 0 do
        Citizen.Wait(30000)
        buffSwimming = buffSwimming - 1
        dobuffthing("swimming", buffSwimming)
    end
    buffSwimming = 0
    dobuffthing("swimming", 0)
    SetSwimMultiplierForPlayer(PlayerPedId(), 1.0)
end)

function SwimmingBuff()
    if buffSwimming == 1 then
        buffSwimming = true
    elseif buffSwimming == 0 then
        buffSwimming = false
    end
    return buffSwimming
  end

    -- Strength Buff --
    
RegisterNetEvent('aspect-buffs:strength_buff')
AddEventHandler('aspect-buffs:strength_buff', function()
    local buffTimeStrength = math.random(15, 35)
    dobuffthing("gym", buffTimeStrength)
    SetPlayerMeleeWeaponDamageModifier(PlayerPedId(), 1.25)
    SetPlayerMeleeWeaponDefenseModifier(PlayerPedId(), 1.25)
    buffStrength = buffTimeStrength
    while buffStrength > 0 do
        Citizen.Wait(60000)
        buffStrength = buffStrength - 1
        dobuffthing("gym", buffStrength)
    end
    buffStrength = 0
    dobuffthing("gym", 0)
    SetPlayerMeleeWeaponDamageModifier(PlayerPedId(), 1.0)
    SetPlayerMeleeWeaponDefenseModifier(PlayerPedId(), 1.0)
end)

function StrengthBuff()
    if buffStrength == 1 then
        buffStrength = true
    elseif buffStrength == 0 then
        buffStrength = false
    end
    return buffStrength
  end

      -- Money Buff --
    
RegisterNetEvent('aspect-buffs:money_boost_buff')
AddEventHandler('aspect-buffs:money_boost_buff', function()
    local buffTimeMoney = math.random(5, 10)
    dobuffthing("dollar", buffTimeMoney)
    buffMoney = buffTimeMoney
    buffCountMoney = true
    while buffMoney > 0 do
        Citizen.Wait(30000)
        buffMoney = buffMoney - 1
        dobuffthing("dollar", buffMoney)
    end
    buffCountMoney = false
    buffMoney = 0
    dobuffthing("dollar", 0)
    SetPlayerMeleeWeaponDamageModifier(PlayerPedId(), 1.0)
    SetPlayerMeleeWeaponDefenseModifier(PlayerPedId(), 1.0)
end)

function MoneyBuff()
    if buffCountMoney == 1 then
        buffCountMoney = true
    elseif buffCountMoney == 0 then
        buffCountMoney = false
    end
    return buffCountMoney
  end