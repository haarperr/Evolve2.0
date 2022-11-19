local pDodoHQ = {x = -424.33847045898, y = -2789.8154296875, z = 6.5157470703125}
local possibility = 0

local pDodoPoints = {
    [1] = {name = "", x = -324.29, y = -1356.19, z = 31.29},
    [2] = {name = "", x = -42.39, y = -664.43, z = 33.47},
    [3] = {name = "", x = -245.79, y = -677.92, z = 37.74},
    [4] = {name = "", x = 402.29, y = -338.80, z = 46.97},
    [5] = {name = "", x = 352.89, y = -142.58, z = 66.68},
    [6] = {name = "", x = 581.00, y = 139.25, z = 99.47},
    [7] = {name = "", x = 367.17, y = 351.38, z = 103.32},
    [8] = {name = "", x = 190.20, y = 291.91, z = 105.53},
    [9] = {name = "", x = -536.59, y = -45.93, z = 42.57},
    [10] = {name = "", x = -783.62, y = -390.65, z = 37.33},
}

local pisInDodoJob = false
local coordinates = 0
local isToDropLocation = false
local pOnWayDodo = false
local multiplicador_De_dinero = 0.05
local pVeh = nil

local px = 0
local py = 0
local pz = 0

-------------------------------
-------------BLIPS-------------
-------------------------------

function CreateJob(pDodoPoints,coordinates)
    pDeliveryLoc = AddBlipForCoord(pDodoPoints[coordinates].x,pDodoPoints[coordinates].y, pDodoPoints[coordinates].z)
    SetBlipSprite(pDeliveryLoc, 457)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Delivery Location")
    EndTextCommandSetBlipName(pDeliveryLoc)
    SetBlipRoute(pDeliveryLoc, 2)
    SetBlipRouteColour(pDeliveryLoc, 3)
    SetBlipColour(pDeliveryLoc, 3)
end

RegisterNetEvent('ev-jobs:passed')
AddEventHandler('ev-jobs:passed', function()
    pisInDodoJob = true
    isToDropLocation = true
    coordinates = math.random(7)
    px = pDodoPoints[coordinates].x
    py = pDodoPoints[coordinates].y
    pz = pDodoPoints[coordinates].z
    distance = round(GetDistanceBetweenCoords(pDodoHQ.x, pDodoHQ.y, pDodoHQ.z, px,py,pz))
    CreateJob(pDodoPoints,coordinates)
    TriggerEvent('ev-phone:goToLocation')
end)

RegisterNetEvent('ev-jobs:startDodoLogistics')
AddEventHandler('ev-jobs:startDodoLogistics', function()
    TriggerEvent('ev-phone:signInDodo')
    TriggerEvent("DoLongHudText", "Wait for a notification on your phone for work.. Check the jobcenter app", 1)
    Citizen.Wait(math.random(60000, 120000))
    TriggerEvent('ev-phone:dodoJobOffer')
end)

RegisterNetEvent('ev-jobs:dodoLogisticsPayout')
AddEventHandler('ev-jobs:dodoLogisticsPayout', function()
    if pOnWayDodo == true then
        if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("pounder"))  then
            if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("pounder")) then
                TriggerServerEvent('ev-jobs:dodoLogisticsPayout')
                exports['ev-interface']:hideInteraction()
                isToDropLocation = false
                pOnWayDodo = false
                pisInDodoJob = false
                px = 0
                py = 0
                pz = 0
                local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isToDropLocation == true then
            destinol = pDodoPoints[coordinates].name
            if GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(GetPlayerPed(-1),true)) < 2.5 then
                if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("pounder")) then
                    exports['ev-interface']:showInteraction('[E] Drop Off Package')
                    if IsControlJustPressed(1,38) then
                        TriggerEvent('ev-phone:goBackDepo')
                        exports['ev-interface']:hideInteraction()
                        possibility = math.random(1, 100)
                        isToDropLocation = false
                        pOnWayDodo = true
                        RemoveBlip(pDeliveryLoc)
                        
                        pReturnBack = AddBlipForCoord(-448.30, -2787.41, 6.07)
                        SetBlipSprite(pReturnBack, 457)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString("Delivery Location")
                        EndTextCommandSetBlipName(pReturnBack)
                        SetBlipRoute(pReturnBack, 2)
                        SetBlipRouteColour(pReturnBack, 3)
                        SetBlipColour(pReturnBack, 3)

                        local setCoords = vector3(-448.30, -2787.41, 6.07)
                        Citizen.CreateThread(function()
                        while pOnWayDodo do
                            Citizen.Wait(1000)
                            local plped = PlayerPedId()
                            local coordA = GetEntityCoords(plped)
                            local aDist = GetDistanceBetweenCoords(setCoords, coordA)
                                if aDist < 15.0 then
                                    pOnWayDodo = false
                                    RemoveBlip(pReturnBack)
                                    DeleteEntity(pVeh)
                                    if exports['ev-hud']:MoneyBuff() then
                                        TriggerServerEvent('ev-jobs:givePayout', math.random(878, 927), "bank", '[Dodo Logistics | With Buff]')
                                    else
                                        TriggerServerEvent('ev-jobs:givePayout', math.random(650, 778), "bank", '[Dodo Logistics | Without Buff]')
                                    end
                                end
                            end
                        end)
                    end
                end
            else
                exports['ev-interface']:hideInteraction()
            end
        end
        if IsEntityDead(GetPlayerPed(-1)) then
            pisInDodoJob = false
            coordinates = 0
            isToDropLocation = false
            pOnWayDodo = false
            px = 0
            py = 0
            pz = 0
            RemoveBlip(blip_casa)
        end
    end
end)

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

--// Spawn vehicle

RegisterNetEvent("ev-jobs:spawn-truck")
AddEventHandler("ev-jobs:spawn-truck", function()
	Citizen.CreateThread(function()
        local hash = GetHashKey("pounder")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findclosestspawn(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, -448.30, -2787.41, 6.07, 46.68, true, false)
        pVeh = vehicle

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        TriggerEvent('ev-jobs:passed')
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
    end)
end)

function findclosestspawn(pCurrentPosition)
	local coords = vector3(-448.30, -2787.41, 6.07)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end

-- Ped Shit --

exports["ev-polytarget"]:AddCircleZone("dodo_sign_in", vector3(-437.91, -2795.5, 7.39), 0.6, {
    useZ=true,
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("dodo_sign_in", {{
    event = "ev-jobs:startDodoLogistics",
    id = "dodo_sign_in",
    icon = "circle",
    label = "Sign In",
    parameters = {},
}}, {
    distance = { radius = 5 },
});