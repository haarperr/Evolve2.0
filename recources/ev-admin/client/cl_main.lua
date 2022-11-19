function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

RegisterNetEvent('desirerp:admin/client/fling-player', function()
    local Ped = PlayerPedId()
    if GetVehiclePedIsUsing(Ped) ~= 0 then
        ApplyForceToEntity(GetVehiclePedIsUsing(Ped), 1, 0.0, 0.0, 100000.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
    else
        ApplyForceToEntity(Ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
    end
end)

RegisterNetEvent("desirerp:admin/client/select-spawn", function()
  exports['ev-adminUI']:hideMenu()
  exports['ev-adminUI']:exitNUI()
  TransitionToBlurred(500)
  DoScreenFadeOut(500)
  Citizen.Wait(1000)
  TriggerServerEvent("jobssystem:jobs", "unemployed")
  exports["ev-build"]:getModule("func").CleanUpArea()
  local cid = exports["isPed"]:isPed("cid")
  TriggerServerEvent("ev-jobmanager:onCharSwap", cid)
  Citizen.Wait(1000)   
  TriggerEvent("ev-base:clearStates")
  exports["ev-ui"]:sendAppEvent("hud", { display = false })
  TriggerServerEvent("apartments:cleanUpRoom")
  exports["ev-base"]:getModule("SpawnManager"):Initialize()
  TriggerEvent("hud:saveCurrentMeta")
  Citizen.Wait(1000)
end)

RegisterNetEvent("desirerp:admin:ReviveInDistance")
AddEventHandler("desirerp:admin:ReviveInDistance", function()
    local playerList = {}

    local players = GetPlayers()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)


    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
        local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
        if(distance < 50) then
            TriggerServerEvent('desirerp:admin:revive_in_distance')
            playerList[index] = GetPlayerServerId(value)
        end
    end

    if playerList ~= {} and playerList ~= nil then

        for k,v in pairs(playerList) do
            TriggerServerEvent("ev-death:reviveSV", v)
            TriggerServerEvent("reviveGranted", v)
             TriggerEvent("Hospital:HealInjuries",true) 
             TriggerServerEvent("ems:healplayer", v)
             TriggerEvent("heal")
        end
    end
end)

local pReuslt = {}

RegisterNetEvent("oneMoreTryAdmin", function(pTable)
  pReuslt = pTable
end)

function getBanListCL()
  local banlist = RPC.execute("getBanList")
  return json.encode(banlist)
end

exports('getBanListCL',getBanListCL)

local noClipEnabled = false
local noClipCam = nil

local speed = 1.0
local maxSpeed = 32.0
local minY, maxY = -89.0, 89.0

local inputRotEnabled = false

function toggleNoclip()
  CreateThread(function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local inVehicle = false

    Citizen.Wait(100)
    if veh ~= 0 then
      inVehicle = true
      ent = veh
    else
      ent = ped
    end

    local pos = GetEntityCoords(ent)
    local rot = GetEntityRotation(ent)

    noClipCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos, 0.0, 0.0, rot.z, 75.0, true, 2)
    AttachCamToEntity(noClipCam, ent, 0.0, 0.0, 0.0, true)
    RenderScriptCams(true, false, 3000, true, false)

    FreezeEntityPosition(ent, true)
    SetEntityCollision(ent, false, false)
    SetEntityAlpha(ent, 0)
    SetPedCanRagdoll(ped, false)
    SetEntityVisible(ent, false)
    ClearPedTasksImmediately(ped)

    if inVehicle then
      FreezeEntityPosition(ped, true)
      SetEntityCollision(ped, false, false)
      SetEntityAlpha(ped, 0)
      SetEntityVisible(ped, false)
    end

    while noClipEnabled do

      local rv, fv, uv, campos = GetCamMatrix(noClipCam)

      if IsDisabledControlPressed(2, 17) then -- MWheelUp
        speed = math.min(speed + 0.1, maxSpeed)
      elseif IsDisabledControlPressed(2, 16) then -- MWheelDown
        speed = math.max(0.1, speed - 0.1)
      end

      local multiplier = 1.0;

      if IsDisabledControlPressed(2, 209) then
        multiplier = 2.0
      elseif IsDisabledControlPressed(2, 19) then
        multiplier = 4.0
      elseif IsDisabledControlPressed(2, 36) then
        multiplier = 0.25
      end

      -- Forward and Backward
      if IsDisabledControlPressed(2, 32) then -- W
        local setpos = GetEntityCoords(ent) + fv * (speed * multiplier)
        SetEntityCoordsNoOffset(ent, setpos)
        if inVehicle then
          SetEntityCoordsNoOffset(ped, setpos)
        end
      elseif IsDisabledControlPressed(2, 33) then -- S
        local setpos = GetEntityCoords(ent) - fv * (speed * multiplier)
        SetEntityCoordsNoOffset(ent, setpos)
        if inVehicle then
          SetEntityCoordsNoOffset(ped, setpos)
        end
      end

      -- Left and Right
      if IsDisabledControlPressed(2, 34) then -- A
        local setpos = GetOffsetFromEntityInWorldCoords(ent, -speed * multiplier, 0.0, 0.0)
        SetEntityCoordsNoOffset(ent, setpos.x, setpos.y, GetEntityCoords(ent).z)
        if inVehicle then
          SetEntityCoordsNoOffset(ped, setpos.x, setpos.y, GetEntityCoords(ent).z)
        end
      elseif IsDisabledControlPressed(2, 35) then -- D
        local setpos = GetOffsetFromEntityInWorldCoords(ent, speed * multiplier, 0.0, 0.0)
        SetEntityCoordsNoOffset(ent, setpos.x, setpos.y, GetEntityCoords(ent).z)
        if inVehicle then
          SetEntityCoordsNoOffset(ped, setpos.x, setpos.y, GetEntityCoords(ent).z)
        end
      end

      -- Up and Down
      if IsDisabledControlPressed(2, 51) then -- E
        local setpos = GetOffsetFromEntityInWorldCoords(ent, 0.0, 0.0, multiplier * speed / 2)
        SetEntityCoordsNoOffset(ent, setpos)
        if inVehicle then
          SetEntityCoordsNoOffset(ped, setpos)
        end
      elseif IsDisabledControlPressed(2, 52) then
        local setpos = GetOffsetFromEntityInWorldCoords(ent, 0.0, 0.0, multiplier * -speed / 2) -- Q
        SetEntityCoordsNoOffset(ent, setpos)
        if inVehicle then
          SetEntityCoordsNoOffset(ped, setpos)
        end
      end

      local camrot = GetCamRot(noClipCam, 2)
      SetEntityHeading(ent, (360 + camrot.z) % 360.0)

      SetEntityVisible(ent, false)
      if inVehicle then
        SetEntityVisible(ped, false)
      end

      DisableControlAction(2, 32, true)
      DisableControlAction(2, 33, true)
      DisableControlAction(2, 34, true)
      DisableControlAction(2, 35, true)
      DisableControlAction(2, 36, true)
      DisableControlAction(2, 12, true)
      DisableControlAction(2, 13, true)
      DisableControlAction(2, 14, true)
      DisableControlAction(2, 15, true)
      DisableControlAction(2, 16, true)
      DisableControlAction(2, 17, true)

      DisablePlayerFiring(PlayerId(), true)
      Wait(0)
    end

    DestroyCam(noClipCam, false)
    noClipCam = nil
    RenderScriptCams(false, false, 3000, true, false)
    FreezeEntityPosition(ent, false)
    SetEntityCollision(ent, true, true)
    SetEntityAlpha(ent, 255)
    SetPedCanRagdoll(ped, true)
    SetEntityVisible(ent, true)
    ClearPedTasksImmediately(ped)

    if inVehicle then
      FreezeEntityPosition(ped, false)
      SetEntityCollision(ped, true, true)
      SetEntityAlpha(ped, 255)
      SetEntityVisible(ped, true)
      SetPedIntoVehicle(ped, ent, -1)
    end
  end)
end

function checkInputRotation()
  CreateThread(function()
    while inputRotEnabled do
      while noClipCam == nil do
        Wait(0)
      end

      local rightAxisX = GetDisabledControlNormal(0, 220)
      local rightAxisY = GetDisabledControlNormal(0, 221)

      if (math.abs(rightAxisX) > 0) and (math.abs(rightAxisY) > 0) then
        local rotation = GetCamRot(noClipCam, 2)
        rotz = rotation.z + rightAxisX * -10.0

        local yValue = rightAxisY * -5.0

        rotx = rotation.x

        if rotx + yValue > minY and rotx + yValue < maxY then
          rotx = rotation.x + yValue
        end

        SetCamRot(noClipCam, rotx, rotation.y, rotz, 2)
      end

      Wait(0)
    end
  end)
end

AddEventHandler("desirerp:admin:noClipToggle", function(pIsEnabled)
  noClipEnabled = pIsEnabled
  inputRotEnabled = pIsEnabled

  if noClipEnabled and inputRotEnabled then
    toggleNoclip()
    checkInputRotation()
  end
end)


-- Dev Debug --

local DebugMode = false
local debugmodeToggle = false

function devDebugToggle()
  if not DebugMode then
    DebugMode = true
    TriggerEvent('DoLongHudText', 'Dev Debug Enabled!', 1)
    debugmodeToggle = true
  else
    DebugMode = false
    TriggerEvent('DoLongHudText', 'Dev Debug Disabled!', 1)
    debugmodeToggle = false
  end
end

exports('devDebugToggle', devDebugToggle)

RegisterCommand("pensifuck", function()
  TriggerServerEvent("pensifuck")

end)

Citizen.CreateThread( function()
    local accel = 0
    local braking = 0
    local sixty = 0
    local hundred = 0
    local thirty = 0
    local hundredtwenty = 0
    local timestart = 0
    local timestartbraking = 0
    local airtime = 0
    local lastairtime = 0
    local airTimeStart = 0
    local vehicleAir = false
    local vehicleSuspensionStress = false
    local vehicleSuspensionStressRear = false
    local suspensionTimeStart = 0
    local suspensionTimeStartRear = 0
    local susTime = 0
    local susRearTime = 0
    
    while true do 
        
        Citizen.Wait(1)
        
        if debugmodeToggle then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped,false)
            local pos = GetEntityCoords(ped)
  
            local forPos = GetOffsetFromEntityInWorldCoords(ped, 0, 1.0, 0.0)
            local backPos = GetOffsetFromEntityInWorldCoords(ped, 0, -1.0, 0.0)
            local LPos = GetOffsetFromEntityInWorldCoords(ped, 1.0, 0.0, 0.0)
            local RPos = GetOffsetFromEntityInWorldCoords(ped, -1.0, 0.0, 0.0) 
  
            local forPos2 = GetOffsetFromEntityInWorldCoords(ped, 0, 2.0, 0.0)
            local backPos2 = GetOffsetFromEntityInWorldCoords(ped, 0, -2.0, 0.0)
            local LPos2 = GetOffsetFromEntityInWorldCoords(ped, 2.0, 0.0, 0.0)
            local RPos2 = GetOffsetFromEntityInWorldCoords(ped, -2.0, 0.0, 0.0)    
  
            local x, y, z = table.unpack(GetEntityCoords(ped, true))
            local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
            currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
  
            local zone = tostring(GetNameOfZone(x, y, z))
            if not zone then
                zone = "UNKNOWN"
            else
                zone = GetLabelText(zone)
            end
  
            drawTxt(0.8, 0.50, 0.4,0.4,0.30, "Heading: " .. GetEntityHeading(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.52, 0.4,0.4,0.30, "Coords: " .. pos, 55, 155, 55, 255)
            drawTxt(0.8, 0.54, 0.4,0.4,0.30, "Attached Ent: " .. GetEntityAttachedTo(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.56, 0.4,0.4,0.30, "Health: " .. GetEntityHealth(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.58, 0.4,0.4,0.30, "H a G: " .. GetEntityHeightAboveGround(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.60, 0.4,0.4,0.30, "Model: " .. GetEntityModel(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.62, 0.4,0.4,0.30, "Speed: " .. GetEntitySpeed(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.64, 0.4,0.4,0.30, "Frame Time: " .. GetFrameTime(), 55, 155, 55, 255)
            drawTxt(0.8, 0.66, 0.4,0.4,0.30, "Street: " .. currentStreetName, 55, 155, 55, 255)
            drawTxt(0.8, 0.68, 0.4,0.4,0.30, "Hood: " .. zone, 55, 155, 55, 255)
  
  
  
            -- car debugging
            -- s 8
            -- w 32
  
  
            if IsDisabledControlPressed(0, 37) then
                accel = 0
                braking = 0
                sixty = 0
                hundred = 0
                thirty = 0
                hundredtwenty = 0
                timestart = 0
                timestartbraking = 0
                airtime = 0
                lastairtime = 0
                airTimeStart = 0
                vehicleAir = false
                vehicleSuspensionStress = false
                vehicleSuspensionStressRear = false
                suspensionTimeStart = 0
                suspensionTimeStartRear = 0
                susTime = 0
                susRearTime = 0
                timestart = GetGameTimer()
            end
  
            if veh ~= 0 and veh ~= nil then
                local mph = math.ceil(GetEntitySpeed(ped) * 2.236936)
  
                if (IsControlJustPressed(0, 32) and not IsControlPressed(0, 18)) or IsControlJustReleased(0, 18) then
                    thirty = 0
                    sixty = 0
                    hundred = 0
                    hundredtwenty = 0
                    accel = 0
                    vehicleAir = false
                    timestart = GetGameTimer()
                end
  
                if IsControlPressed(0, 32) then
                    accel = GetGameTimer() - timestart
                end
  
                if IsControlJustPressed(0, 8) and GetEntitySpeed(ped) > 0.0 then
                    braking = 0
                    timestartbraking = GetGameTimer()
                end
  
                if IsControlPressed(0, 8) and GetEntitySpeed(ped) > 5 then
                    braking = GetGameTimer() - timestartbraking
                end     
  
                if mph == 30 and IsControlPressed(0, 32) and thirty == 0 then
                    thirty = accel / 1000
                end
                if mph == 60 and IsControlPressed(0, 32) and sixty == 0 then
                    sixty = accel / 1000
                end
                if mph == 90 and IsControlPressed(0, 32) and hundred == 0 then
                    hundred = accel / 1000
                end
                if mph == 100 and IsControlPressed(0, 32) and hundredtwenty == 0 then
                    hundredtwenty = accel / 1000
                end
  
                if IsEntityInAir(veh) and mph > 0 and not vehicleAir then
                    vehicleAir = true
                    airTimeStart = GetGameTimer()
                elseif vehicleAir and not IsEntityInAir(veh) and mph > 0 then
                    airtime = airtime + (GetGameTimer() - airTimeStart)
                    vehicleAir = false
                end
  
                local frontSusLost = (GetVehicleWheelSuspensionCompression(veh,0) < 0.1 or GetVehicleWheelSuspensionCompression(veh,1) < 0.1)
                local rearSusLost = (GetVehicleWheelSuspensionCompression(veh,2) < 0.1 or GetVehicleWheelSuspensionCompression(veh,3) < 0.1)
  
                if mph > 0 and not vehicleSuspensionStress and frontSusLost then
                    vehicleSuspensionStress = true
                    suspensionTimeStart = GetGameTimer()
                elseif vehicleSuspensionStress and mph > 0 and not frontSusLost then
                    susTime = susTime + (GetGameTimer() - suspensionTimeStart)
                    vehicleSuspensionStress = false
                end
            --  print(GetVehicleWheelSuspensionCompression(veh,0),GetVehicleWheelSuspensionCompression(veh,1),GetVehicleWheelSuspensionCompression(veh,2),GetVehicleWheelSuspensionCompression(veh,3))
  
                if mph > 0 and not vehicleSuspensionStressRear and rearSusLost then
                    vehicleSuspensionStressRear = true
                    suspensionTimeStartRear = GetGameTimer()
                elseif vehicleSuspensionStressRear and mph > 0 and not rearSusLost then
                    susRearTime = susRearTime + (GetGameTimer() - suspensionTimeStartRear)
                    vehicleSuspensionStressRear = false
                end
            end
  
            --airtime
            -- math.floor(GetVehicleWheelSuspensionCompression(veh,0)*100) / 100 .." | ".. math.floor(GetVehicleWheelSuspensionCompression(veh,1)*100) / 100 .." | ".. math.floor(GetVehicleWheelSuspensionCompression(veh,2)*100) / 100 .." | ".. math.floor(GetVehicleWheelSuspensionCompression(veh,3)*100) / 100
  
            drawTxt(1.0, 0.80, 0.4,0.4,0.80, "Time Accelerating: " .. accel / 1000, 55, 155, 55, 255)
            drawTxt(1.0, 0.82, 0.4,0.4,0.80, "Time Braking: " .. braking / 1000, 155, 55, 55, 255)
  
            drawTxt(1.0, 0.84, 0.4,0.4,0.80, "30mph: " .. thirty, 155, 155, 155, 255)
            drawTxt(1.0, 0.86, 0.4,0.4,0.80, "60mph: " .. sixty, 155, 155, 155, 255)
            drawTxt(1.0, 0.88, 0.4,0.4,0.80, "90mph: " .. hundred, 155, 155, 155, 255)
            drawTxt(1.0, 0.90, 0.4,0.4,0.80, "120mph: " .. hundredtwenty, 155, 155, 155, 255)
  
            drawTxt(1.0, 0.92, 0.4,0.4,0.80, "Air Time: " .. airtime/1000, 155, 155, 155, 255)
            drawTxt(1.0, 0.96, 0.4,0.4,0.80, "Suspension F Stress " .. susTime/1000 , 155, 155, 155, 255)
            drawTxt(1.0, 0.98, 0.4,0.4,0.80, "Suspension R Stress " .. susRearTime/1000 , 155, 155, 155, 255)
            
  
            -- car debugging end
  
  
            DrawLine(pos,forPos, 255,0,0,115)
            DrawLine(pos,backPos, 255,0,0,115)
  
            DrawLine(pos,LPos, 255,255,0,115)
            DrawLine(pos,RPos, 255,255,0,115)           
  
            DrawLine(forPos,forPos2, 255,0,255,115)
            DrawLine(backPos,backPos2, 255,0,255,115)
  
            DrawLine(LPos,LPos2, 255,255,255,115)
            DrawLine(RPos,RPos2, 255,255,255,115)     
  
            local nearped = getNPC()
  
            local veh = GetVehicle()
  
            local nearobj = GetObject()
  
            if IsControlJustReleased(0, 38) then
                if inFreeze then
                    inFreeze = false
                    TriggerEvent("DoShortHudText",'Freeze Disabled',3)          
                else
                    inFreeze = true             
                    TriggerEvent("DoShortHudText",'Freeze Enabled',3)               
                end
            end
  
            if IsControlJustReleased(0, 47) then
                if lowGrav then
                    lowGrav = false
                    TriggerEvent("DoShortHudText",'Low Grav Disabled',3)            
                else
                    lowGrav = true              
                    TriggerEvent("DoShortHudText",'Low Grav Enabled',3)                 
                end
            end
  
        else
            Citizen.Wait(5000)
        end
    end
  end)
  
  function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
  end
  
  
  function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
  
        if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
          DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. " IN CONTACT" )
        else
          DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) )
        end
  
            FreezeEntityPosition(ped, inFreeze)
            if lowGrav then
              SetPedToRagdoll(ped, 511, 511, 0, 0, 0, 0)
              SetEntityCoords(ped,pos["x"],pos["y"],pos["z"]+0.1)
            end
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
  end
  
  function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
  end
  
  function GetVehicle()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
           -- FreezeEntityPosition(ped, inFreeze)
        if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
          DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
        else
          DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
        end
            if lowGrav then
              SetEntityCoords(ped,pos["x"],pos["y"],pos["z"]+5.0)
            end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
  end
  
  
  function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
  end
  
  
  function GetObject()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 10.0 then
            distanceFrom = distance
            rped = ped
            --FreezeEntityPosition(ped, inFreeze)
        if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
          DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
        else
          DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
        end
  
            if lowGrav then
              --ActivatePhysics(ped)
              SetEntityCoords(ped,pos["x"],pos["y"],pos["z"]+0.1)
              FreezeEntityPosition(ped, false)
            end
        end
  
        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
  end




  function getVehiclesCombined() 
    local designatedVehicleTable = {}
    local vehicleTable = exports['ev-admin']:getVehicles()
    local addonVehicleTable = exports['ev-admin']:getAddonVehicles()
    for k,v in pairs(vehicleTable) do
      designatedVehicleTable[#designatedVehicleTable+1] = {
        model = v.model,
        name = GetDisplayNameFromVehicleModel(GetHashKey(v.model))
      }
    end
    for j,s in pairs(addonVehicleTable) do
      designatedVehicleTable[#designatedVehicleTable+1] = {
        model = s.model,
        name = s.name
      }
    end
    return designatedVehicleTable
  end

  exports('getVehiclesCombined',getVehiclesCombined)

  RegisterNetEvent('ev-admin:InsertPrioCL')
  AddEventHandler('ev-admin:InsertPrioCL', function()
    TriggerServerEvent('ev-admin:insertPrio')
  end)

  RegisterNetEvent('ev-admin:setMods')
  AddEventHandler('ev-admin:setMods', function(pVehicle)
    local veh = pVehicle
    SetVehicleModKit(veh, 0)
    for modType = 0, 10, 1 do 
        local bestMod = GetNumVehicleMods(veh, modType)-1
        SetVehicleMod(veh, modType, bestMod, false)
    end

    local ourSelection = {
        ["Engine"] = "EMS Upgrade, Level 4",
        ["Transmission"] = "Race Transmission",
        ["Suspension"] = "Competition Suspension",
        ["Horns"] = "Sadtrombone Horn",
        ["Brakes"] = "Race Brakes",
        ["Lights"] = "Xenon Lights",
        ["Turbo"] = "Turbo Tuning"
    }
    SetVehicleModKit(veh, 0) -- this has to be called before setting vehicle mods
    for k, v in pairs(ourSelection) do
        local modType = upgrades[k].type
        local mod = upgrades[k].types[v].index
        ApplyVehicleMod(veh, modType, mod)
    end
    ToggleVehicleMod(veh, upgrades["Lights"].type, true)
  end)

  upgrades = {
    ["Suspension"] = {
        type = 13,
        types = {
            ["Stock Suspension"] = {index = -1},
            ["Lowered Suspension"] = {index = false},
            ["Street Suspension"] = {index = 1},
            ["Sport Suspension"] = {index = 2},
            ["Competition Suspension"] = {index = 3}
        }
    },
    ["Transmission"] = {
        type = 13,
        types = {
            ["Stock Transmission"] = {index = -1},
            ["Street Transmission"] = {index = false},
            ["Sports Transmission"] = {index = 1},
            ["Race Transmission"] = {index = 2}
        }
    },
    ["Turbo"] = {
        type = 18,
        types = {
            ["None"] = {index = false},
            ["Turbo Tuning"] = {index = true}
        }
    },
    ["Lights"] = {
        type = 22,
        types = {
            ["Stock Lights"] = {index = false},
            ["Xenon Lights"] = {index = true}
        },
        xenonHeadlightColors = {
            ["Default"] = {index = -1},
            ["White"] = {index = 0},
            ["Blue"] = {index = 1},
            ["Electric_Blue"] = {index = 2},
            ["Mint_Green"] = {index = 3},
            ["Lime_Green"] = {index = 4},
            ["Yellow"] = {index = 5},
            ["Golden_Shower"] = {index = 6},
            ["Orange"] = {index = 7},
            ["Red"] = {index = 8},
            ["Pony_Pink"] = {index = 9},
            ["Hot_Pink"] = {index = 10},
            ["Purple"] = {index = 11},
            ["Blacklight"] = {index = 12}
        }
    },
    ["Engine"] = {
        type = 11,
        types = {
            ["EMS Upgrade, Level 1"] = {index = -1},
            ["EMS Upgrade, Level 2"] = {index = false},
            ["EMS Upgrade, Level 3"] = {index = 1},
            ["EMS Upgrade, Level 4"] = {index = 2}
        }
    },
    ["Brakes"] = {
        type = 12,
        types = {
            ["Stock Brakes"] = {index = -1},
            ["Street Brakes"] = {index = false},
            ["Sport Brakes"] = {index = 1},
            ["Race Brakes"] = {index = 2}
        }
    },
    ["Horns"] = {
        type = 14,
        types = {
            ["Stock Horn"] = {index = -1},
            ["Truck Horn"] = {index = false},
            ["Police Horn"] = {index = 1},
            ["Clown Horn"] = {index = 2},
            ["Musical Horn 1"] = {index = 3},
            ["Musical Horn 2"] = {index = 4},
            ["Musical Horn 3"] = {index = 5},
            ["Musical Horn 4"] = {index = 6},
            ["Musical Horn 5"] = {index = 7},
            ["Sadtrombone Horn"] = {index = 8},
            ["Calssical Horn 1"] = {index = 9},
            ["Calssical Horn 2"] = {index = 10},
            ["Calssical Horn 3"] = {index = 11},
            ["Calssical Horn 4"] = {index = 12},
            ["Calssical Horn 5"] = {index = 13},
            ["Calssical Horn 6"] = {index = 14},
            ["Calssical Horn 7"] = {index = 15},
            ["Scaledo Horn"] = {index = 16},
            ["Scalere Horn"] = {index = 17},
            ["Scalemi Horn"] = {index = 18},
            ["Scalefa Horn"] = {index = 19},
            ["Scalesol Horn"] = {index = 20},
            ["Scalela Horn"] = {index = 21},
            ["Scaleti Horn"] = {index = 22},
            ["Scaledo Horn High"] = {index = 23},
            ["Jazz Horn 1"] = {index = 25},
            ["Jazz Horn 2"] = {index = 26},
            ["Jazz Horn 3"] = {index = 27},
            ["Jazzloop Horn"] = {index = 28},
            ["Starspangban Horn 1"] = {index = 29},
            ["Starspangban Horn 2"] = {index = 30},
            ["Starspangban Horn 3"] = {index = 31},
            ["Starspangban Horn 4"] = {index = 32},
            ["Classicalloop Horn 1"] = {index = 33},
            ["Classical Horn 8"] = {index = 34},
            ["Classicalloop Horn 2"] = {index = 35}
        }
    },
    ["Wheels"] = {
        type = 23,
        ["suv"] = {
            type = 3,
            types = {
                ["Stock"] = {index = -1},
                ["Vip"] = {index = false},
                ["Benefactor"] = {index = 1},
                ["Cosmo"] = {index = 2},
                ["Bippu"] = {index = 3},
                ["Royalsix"] = {index = 4},
                ["Fagorme"] = {index = 5},
                ["Deluxe"] = {index = 6},
                ["Icedout"] = {index = 7},
                ["Cognscenti"] = {index = 8},
                ["Lozspeedten"] = {index = 9},
                ["Supernova"] = {index = 10},
                ["Obeyrs"] = {index = 11},
                ["Lozspeedballer"] = {index = 12},
                ["Extra vaganzo"] = {index = 13},
                ["Splitsix"] = {index = 14},
                ["Empowered"] = {index = 15},
                ["Sunrise"] = {index = 16},
                ["Dashvip"] = {index = 17},
                ["Cutter"] = {index = 18}
            }
        },
        ["sport"] = {
            type = false,
            types = {
                ["Stock"] = {index = -1},
                ["Inferno"] = {index = false},
                ["Deepfive"] = {index = 1},
                ["Lozspeed"] = {index = 2},
                ["Diamondcut"] = {index = 3},
                ["Chrono"] = {index = 4},
                ["Feroccirr"] = {index = 5},
                ["Fiftynine"] = {index = 6},
                ["Mercie"] = {index = 7},
                ["Syntheticz"] = {index = 8},
                ["Organictyped"] = {index = 9},
                ["Endov1"] = {index = 10},
                ["Duper7"] = {index = 11},
                ["Uzer"] = {index = 12},
                ["Groundride"] = {index = 13},
                ["Spacer"] = {index = 14},
                ["Venum"] = {index = 15},
                ["Cosmo"] = {index = 16},
                ["Dashvip"] = {index = 17},
                ["Icekid"] = {index = 18},
                ["Ruffeld"] = {index = 19},
                ["Wangenmaster"] = {index = 20},
                ["Superfive"] = {index = 21},
                ["Endov2"] = {index = 22},
                ["Slitsix"] = {index = 23}
            }
        },
        ["offroad"] = {
            type = 4,
            types = {
                ["Stock"] = {index = -1},
                ["Raider"] = {index = false},
                ["Mudslinger"] = {index = 1},
                ["Nevis"] = {index = 2},
                ["Cairngorm"] = {index = 3},
                ["Amazon"] = {index = 4},
                ["Challenger"] = {index = 5},
                ["Dunebasher"] = {index = 6},
                ["Fivestar"] = {index = 7},
                ["Rockcrawler"] = {index = 8},
                ["Milspecsteelie"] = {index = 9}
            }
        },
        ["tuner"] = {
            type = 5,
            types = {
                ["Stock"] = {index = -1},
                ["Cosmo"] = {index = false},
                ["Supermesh"] = {index = 1},
                ["Outsider"] = {index = 2},
                ["Rollas"] = {index = 3},
                ["Driffmeister"] = {index = 4},
                ["Slicer"] = {index = 5},
                ["Elquatro"] = {index = 6},
                ["Dubbed"] = {index = 7},
                ["Fivestar"] = {index = 8},
                ["Slideways"] = {index = 9},
                ["Apex"] = {index = 10},
                ["Stancedeg"] = {index = 11},
                ["Countersteer"] = {index = 12},
                ["Endov1"] = {index = 13},
                ["Endov2dish"] = {index = 14},
                ["Guppez"] = {index = 15},
                ["Chokadori"] = {index = 16},
                ["Chicane"] = {index = 17},
                ["Saisoku"] = {index = 18},
                ["Dishedeight"] = {index = 19},
                ["Fujiwara"] = {index = 20},
                ["Zokusha"] = {index = 21},
                ["Battlevill"] = {index = 22},
                ["Rallymaster"] = {index = 23}
            }
        },
        ["highend"] = {
            type = 7,
            types = {
                ["Stock"] = {index = -1},
                ["Shadow"] = {index = false},
                ["Hyper"] = {index = 1},
                ["Blade"] = {index = 2},
                ["Diamond"] = {index = 3},
                ["Supagee"] = {index = 4},
                ["Chromaticz"] = {index = 5},
                ["Merciechlip"] = {index = 6},
                ["Obeyrs"] = {index = 7},
                ["Gtchrome"] = {index = 8},
                ["Cheetahr"] = {index = 9},
                ["Solar"] = {index = 10},
                ["Splitten"] = {index = 11},
                ["Dashvip"] = {index = 12},
                ["Lozspeedten"] = {index = 13},
                ["Carboninferno"] = {index = 14},
                ["Carbonshadow"] = {index = 15},
                ["Carbonz"] = {index = 16},
                ["Carbonsolar"] = {index = 17},
                ["Carboncheetahr"] = {index = 18},
                ["Carbonsracer"] = {index = 19}
            }
        },
        ["lowrider"] = {
            type = 2,
            types = {
                ["Stock"] = {index = -1},
                ["Flare"] = {index = false},
                ["Wired"] = {index = 1},
                ["Triplegolds"] = {index = 2},
                ["Bigworm"] = {index = 3},
                ["Sevenfives"] = {index = 4},
                ["Splitsix"] = {index = 5},
                ["Freshmesh"] = {index = 6},
                ["Leadsled"] = {index = 7},
                ["Turbine"] = {index = 8},
                ["Superfin"] = {index = 9},
                ["Classicrod"] = {index = 10},
                ["Dollar"] = {index = 11},
                ["Dukes"] = {index = 12},
                ["Lowfive"] = {index = 13},
                ["Gooch"] = {index = 14}
            }
        },
        ["muscle"] = {
            type = 1,
            types = {
                ["Stock"] = {index = -1},
                ["Classicfive"] = {index = false},
                ["Dukes"] = {index = 1},
                ["Musclefreak"] = {index = 2},
                ["Kracka"] = {index = 3},
                ["Azrea"] = {index = 4},
                ["Mecha"] = {index = 5},
                ["Blacktop"] = {index = 6},
                ["Dragspl"] = {index = 7},
                ["Revolver"] = {index = 8},
                ["Classicrod"] = {index = 9},
                ["Spooner"] = {index = 10},
                ["Fivestar"] = {index = 11},
                ["Oldschool"] = {index = 12},
                ["Eljefe"] = {index = 13},
                ["Dodman"] = {index = 14},
                ["Sixgun"] = {index = 15},
                ["Mercenary"] = {index = 16}
            }
        }
    }
}

function ApplyVehicleMod(vehicle, modType, mod)
  if type(mod) == "boolean" then
      ToggleVehicleMod(vehicle, modType, mod)
  else
      SetVehicleMod(vehicle, modType, mod, false)
  end
end