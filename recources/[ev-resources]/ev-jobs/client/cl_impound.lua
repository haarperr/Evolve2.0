local pPlate = nil

RegisterNetEvent('ev-jobs:impound')
AddEventHandler('ev-jobs:impound', function()
    local ImpoundMenu = {
		{
      title = "Release Vehicle",
      description = "Release a vehicle from the impound lot",
      key = "ReleaseVehicle",
      children = {
          {
            title = "Browse by Plate",
            description = "Release a vehicle from impound by plate",
            action = "ev-jobs:browse_plate",
          },
        },
      }
    }
    exports["ev-interface"]:showContextMenu(ImpoundMenu)
end)

RegisterInterfaceCallback('ev-jobs:browse_plate', function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
    exports['ev-interface']:openApplication('textbox', {
        callbackUrl = 'ev-jobs:pPlateBrowse',
        key = 1,
        items = {
          {
            icon = "car",
            label = "Vehicle Plate.",
            name = "pVehPlate",
          },
        },
      show = true,
    })
end)

RegisterInterfaceCallback('ev-jobs:pPlateBrowse', function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  pPlate = data.values.pVehPlate
  
  TriggerServerEvent('ev-impound:select_plate', pPlate)
end)

RegisterNetEvent('ev-impound:show_car')
AddEventHandler('ev-impound:show_car', function(pVehicleModel, pVehiclePlate, pState)
    local pVehicle = {
		  {
        title = "Vehicle Model: "..pVehicleModel,
        description = "Vehicle Plate: "..pVehiclePlate,
      },
      {
        title = "Release Vehicle",
        disabled = pState,
        action= "ev-jobs:release_vehicle",
      }
    }
    exports["ev-interface"]:showContextMenu(pVehicle)
end)

RegisterInterfaceCallback('ev-jobs:release_vehicle', function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  print(pPlate)
  TriggerServerEvent('ev-impound:release_car', pPlate)
end)

-- Police --

RegisterNetEvent('ev-jobs:normal-impound')
AddEventHandler('ev-jobs:normal-impound', function()
	playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
   	targetVehicle = getVehicleInDirection(coordA, coordB)
	licensePlate = GetVehicleNumberPlateText(targetVehicle)
  FreezeEntityPosition(PlayerPedId(), true)
  local finished = exports['ev-taskbar']:taskBar(5000, "Impounding Vehicle...")
  if finished == 100 then
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent("ev-imp:NormalImpound",licensePlate)
    TriggerEvent('DoLongHudText', 'Impounded with retrieval price of $1000', 1)
    deleteVeh(targetVehicle)
  end
end)

RegisterNetEvent('ev-jobs:scuff_impound')
AddEventHandler('ev-jobs:scuff_impound', function()
	playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
	licensePlate = GetVehicleNumberPlateText(targetVehicle)
  FreezeEntityPosition(PlayerPedId(), true)
  local finished = exports['ev-taskbar']:taskBar(5000, "Impounding Vehicle...")
  if finished == 100 then
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent("ev-imp:ScuffImpound",licensePlate)
    deleteVeh(targetVehicle)
  end
end)

RegisterNetEvent('ev-jobs:full_impound')
AddEventHandler('ev-jobs:full_impound', function()
	playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
   	targetVehicle = getVehicleInDirection(coordA, coordB)
	licensePlate = GetVehicleNumberPlateText(targetVehicle)
  FreezeEntityPosition(PlayerPedId(), true)
  local finished = exports['ev-taskbar']:taskBar(5000, "Impounding Vehicle...")
  if finished == 100 then
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent("ev-imp:FullImpound",licensePlate)
    TriggerEvent('DoLongHudText', 'Impounded with retrieval price of $5000', 1)
    deleteVeh(targetVehicle)
  end
end)

RegisterNetEvent('ev-jobs:police_impound_menu')
AddEventHandler('ev-jobs:police_impound_menu', function()
    local ImpoundMenu = {
		{
            title = "Full Impound",
            description = "A full impound will cost the owner $5000 to retrieve the vehicle at any time from the impound lot.",
            action = "ev-jobs:full-impound",
        },
        {
            title = "Normal Impound",
            description = "A full impound will cost the owner $1000 to retrieve the vehicle at any time from the impound lot.",
            action = "ev-jobs:normal-impound",
        },
        {
            title = "Scuff Impound",
            description = "A scuff impound will put the owners vehicle back into the last garage it was in.",
            action = "ev-jobs:scuff-impound",
        },
      }
    exports["ev-interface"]:showContextMenu(ImpoundMenu)
end)

RegisterInterfaceCallback('ev-jobs:full-impound', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-jobs:full_impound')
end)

RegisterInterfaceCallback('ev-jobs:normal-impound', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-jobs:normal-impound')
end)

RegisterInterfaceCallback('ev-jobs:scuff-impound', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-jobs:scuff_impound')
end)

-- Functions --

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function deleteVeh(ent)
	SetVehicleHasBeenOwnedByPlayer(ent, true)
	NetworkRequestControlOfEntity(ent)
	local finished = exports["ev-taskbar"]:taskBar(1000,"Impounding",false,true)	
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(ent))
	DeleteEntity(ent)
	DeleteVehicle(ent)
	SetEntityAsNoLongerNeeded(ent)
end

-- Polyzone Shit --

exports["ev-polytarget"]:AddCircleZone("ev_impound_retrieve",  vector3(-192.43, -1161.93, 23.52), 0.25, {
    useZ = true
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("ev_impound_retrieve", {{
    event = "ev-jobs:impound",
    id = "ev_impound_retrieve",
    icon = "car",
    label = "View Personal Impounded Vehicles !",
    parameters = {},
}}, {
    distance = { radius = 1.5 },
});