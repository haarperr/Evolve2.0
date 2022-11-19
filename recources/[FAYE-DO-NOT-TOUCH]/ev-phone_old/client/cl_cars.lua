local LastSpawnAttempt, LastRespawn, SpawnDrawing = nil, nil, false

local function getVehicleClassification(pVehicleModel)
  local vehicleClass = GetVehicleClassFromName(pVehicleModel)
  if vehicleClass == 13 then
    return "bicycle"
  elseif vehicleClass == 14 then
    return "ship"
  else
    return "car"
  end
end

RegisterNUICallback("ev-ui:getCars", function(data, cb)
  local data = RPC.execute("fayzie:vehicles:getPlayerVehiclesWithCoordinates")
  local playerCoords = GetEntityCoords(PlayerPedId())
  for _, car in pairs(data) do
    if car.location then

      local location = json.decode(car.location)

      local vehicleCoords = vector3(location.x, location.y, location.z)

      if car.vehicle_state == 'Out' and #(vehicleCoords - playerCoords) < 5.0 then
        car.spawnable = true
        car.sellable = true
      else
        car.spawnable = true
        car.sellable = false
      end
    else
      print('ERROR GETTING THE LOCATION OF THE VEHICLE', car.current_garage, car.plate, car.location)
    end

    car.type = getVehicleClassification(car.model)
  end
  print(json.encode(data))
  cb({ data = data, meta = { ok = true, message = 'done' } })
end)

RegisterNUICallback("ev-ui:carActionTrack", function(data, cb)
  local vehicleCoords = json.decode(data.car.location)
  if not vehicleCoords then return end
  SetNewWaypoint(vehicleCoords.x, vehicleCoords.y)

  local plyCoords = GetEntityCoords(PlayerPedId())
  if not SpawnDrawing and #(plyCoords - vector3(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z)) < 200.0 then
    SpawnDrawing = true
    SetTimeout(30000, function()
      SpawnDrawing = false
    end)
    Citizen.CreateThread(function()
      while SpawnDrawing do
        DrawMarker(36, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 0, 0, 0, 0, 0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, true, true, 0, false, nil, nil, false)
        Wait(0)
      end
    end)
  end

  TriggerEvent('DoLongHudText',"GPS updated.")
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterNUICallback("ev-ui:carActionSpawn", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' }})

  local vehicle_plate = data.car

  local timer = GetGameTimer()

  if LastSpawnAttempt and (timer - LastSpawnAttempt) < 1000 or LastRespawn and (timer - LastRespawn) < 60000 then return end

  LastSpawnAttempt = timer

  if not canCarSpawn(vehicle_plate.plate) then return end

  local success, message = RPC.execute('fayzie:vehicles:respawnVehicle', vehicle_plate)

  if success then
    SpawnDrawing = false
    LastRespawn = timer

    if message then
        local veh = NetworkGetEntityFromNetworkId(message)
        exports["ev-vehicles"]:SetVehicleAppearance(veh, json.decode(vehicle_plate.appearance))
        exports["ev-vehicles"]:SetVehicleMods(veh, json.decode(vehicle_plate.mods))
        exports["ev-vehicles"]:RestoreVehicleDamage(veh, json.decode(vehicle_plate.damage))
      end
  
    else
      exports['ev-phone']:SendAlert('error', message, 3000)
    end
  end)
  
  function canCarSpawn(pLicensePlate)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      return
    end
  
    local DoesVehExistInProximity = nil
    DoesVehExistInProximity = CheckExistenceOfVehWithPlate(pLicensePlate)
  
    return not DoesVehExistInProximity
  end
  
  function CheckExistenceOfVehWithPlate(pLicensePlate)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local vehicleHandle, scannedVehicle = FindFirstVehicle()
    local success
    repeat
        local pos = GetEntityCoords(scannedVehicle)
        local distance = #(playerCoords - pos)
          if distance < 50.0 then
            local targetVehiclePlate = GetVehicleNumberPlateText(scannedVehicle)
            if targetVehiclePlate == pLicensePlate then
              return true
            end
          end
        success, scannedVehicle = FindNextVehicle(vehicleHandle)
    until not success
    EndFindVehicle(vehicleHandle)
    return false
  end
  
  Citizen.CreateThread(function()
    local invehicle = false
    local plateupdate = "None"
    local vehobj = 0
    while true do
        Wait(1000)
        if not invehicle and IsPedInAnyVehicle(PlayerPedId(), false) then
          local playerPed = PlayerPedId()
          local veh = GetVehiclePedIsIn(playerPed, false)
            if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
              vehobj = veh
              local checkplate = GetVehicleNumberPlateText(veh)
              invehicle = true
              plateupdate = checkplate
              local coords = GetEntityCoords(vehobj)
              local heading = GetEntityHeading(vehobj)
              RPC.execute("vehicle:coords",plateupdate,coords,heading)
            end
        end
        if invehicle and not IsPedInAnyVehicle(PlayerPedId(), false) then
          local coords = GetEntityCoords(vehobj)
          local heading = GetEntityHeading(vehobj)
          RPC.execute("vehicle:coords",plateupdate,coords,heading)
          invehicle = false
          plateupdate = "None"
          vehobj = 0
        end
    end
  end)