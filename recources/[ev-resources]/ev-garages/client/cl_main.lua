pPlate = nil

RegisterNetEvent("ev-garages:open")
AddEventHandler("ev-garages:open", function()
    local house = exports["ev-menu"]:NearHouseGarage()
    exports['ev-garages']:DeleteViewedCar()
    if house then
        RPC.execute("ev-garages:select", exports['ev-menu']:currentGarage())
    end
end)

RegisterNetEvent("ev-garages:open2")
AddEventHandler("ev-garages:open2", function()
    local house2 = exports["ev-menu"]:NearHouseGarage2()
    exports['ev-garages']:DeleteViewedCar()
    if house2 then
        RPC.execute("ev-garages:selectShared", exports['ev-menu']:currentGarage())
    end
end)

RegisterNetEvent("ev-garages:attempt:spawn", function(data, pRealSpawn)
    for ind, value in pairs(data) do
        if pRealSpawn then
        local house = exports["ev-menu"]:NearHouseGarage()
            if house then
                RPC.execute("ev-garages:attempt:sv", value.id)
                SpawnVehicle(value.model, exports['ev-menu']:currentGarage(), value.fuel, value.data, value.license_plate, true)
                pPlate = value.license_plate
                SetFitment = true
                TriggerEvent('ev-garages:fitmentSet')
            end
        else
            SpawnVehicle(value.model, exports['ev-menu']:currentGarage(), value.fuel, value.data, value.license_plate, false)
        end
    end
end)

RegisterNetEvent("ev-garages:attempt:spawn2", function(data, pRealSpawn)
    for ind, value in pairs(data) do
        if pRealSpawn then
        local house2 = exports["ev-menu"]:NearHouseGarage2()
            if house2 then
                RPC.execute("ev-garages:attempt:sv2", value.id)
                TriggerServerEvent('ev-wheelfitment:GetVehicleStatus', GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)), GetVehiclePedIsIn(PlayerPedId(), false))
                SpawnVehicle(value.model, exports['ev-menu']:currentGarage(), value.fuel, value.data, value.license_plate, true)
                pPlate = value.license_plate
                SetFitment = true
                TriggerEvent('ev-garages:fitmentSet')
            end
        else
            SpawnVehicle(value.model, exports['ev-menu']:currentGarage(), value.fuel, value.data, value.license_plate, false)
        end
    end
end)

RegisterNetEvent("ev-garages:takeout", function(pData)
    local house = exports["ev-menu"]:NearHouseGarage()
    if house then
        RPC.execute("ev-garages:spawned:get", pData)
    end
end)

RegisterNetEvent("ev-garages:takeout2", function(pData)
    local house2 = exports["ev-menu"]:NearHouseGarage2()
    if house2 then
        RPC.execute("ev-garages:spawned:getShared", pData)
    end
end)

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
    }
  
    local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end
  
function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end
  
function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end
  
function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
  
function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

RegisterNetEvent("ev-garages:resetcartoimpound", function(plate)
    local found = false
    for vehicle in EnumerateVehicles() do
        if plate == GetVehicleNumberPlateText(vehicle) then
            found = true
        end

        if not found then
            TriggerServerEvent("ev-garages:resetcartoimpound",plate)
        end
    end
end)


RegisterNetEvent("ev-garages:store", function()
    local pos = GetEntityCoords(PlayerPedId())
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local curVeh = exports['ev-garages']:getVehicleInDirection(coordA, coordB)
    if (curVeh ~= 0) then
        local Stored = RPC.execute("ev-garages:states", "In", exports["ev-garages"]:NearVehicle("plate"), exports['ev-menu']:currentGarage(), exports["ev-garages"]:NearVehicle("Fuel"))
        if Stored then
            DeleteVehicle(curVeh)
            DeleteEntity(curVeh)
            TriggerEvent('keys:remove', exports["ev-garages"]:NearVehicle("plate"))
            TriggerEvent("DoLongHudText", "Vehicle stored in garage: " ..exports['ev-menu']:currentGarage())
        else
            TriggerEvent("DoLongHudText", "You cant store local cars!", 2)
        end
    else
        TriggerEvent("DoLongHudText", "You need to look at the vehicle in order to store it!", 2)
    end
end)

RegisterNetEvent("ev-garages:resetpdgarage", function()
    local myJob = exports["isPed"]:isPed("myJob")
    if myJob == "police" then
        TriggerServerEvent("ev-garages:resetpdgarage")
    else
        TriggerEvent("DoLongHudText", "Only for police officers!", 2)
    end
end)

Citizen.CreateThread(function()
    for _, item in pairs(Garages) do
        if item.blip ~= nil then
            Garage = AddBlipForCoord(item.blip.x, item.blip.y, item.blip.z)

            SetBlipSprite (Garage, 357)
            SetBlipDisplay(Garage, 4)
            SetBlipScale  (Garage, 0.5)
            SetBlipAsShortRange(Garage, true)
            SetBlipColour(Garage, 3)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(item.name)
            EndTextCommandSetBlipName(Garage)
        end
    end
end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(10000)
--         TriggerServerEvent("garages:carisout")
--     end
-- end)

exports("NearVehicle", function(pType)
    if pType == "Distance" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return true
        else
            return false
        end
    elseif pType == "plate" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return GetVehicleNumberPlateText(vehicle)
        else
            return false
        end
    elseif pType == "Fuel" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return  GetVehicleFuelLevel(vehicle)
        else
            return false
        end
    elseif pType == "sittingplate" then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            return GetVehicleNumberPlateText(vehicle)
        else
            return false
        end
    end
end)

exports("getVehicleInDirection", function(coordA, coordB)
    return getVehicleInDirection(coordA, coordB)
end)

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

-- PolyZone stuff
AddEventHandler("ev-polyzone:enter", function(zone, data)
    if zone ~= "Police Shared" then return end
    local plyPed = PlayerPedId()
    local job = exports["isPed"]:isPed("myJob")

    if plyPed then
        if job == "police" or job == "doc" or job == "judge" or job == "ems" then
            exports["ev-interface"]:showInteraction("Parking")
        end
    end
end)

AddEventHandler("ev-polyzone:exit", function(zone)
    if zone ~= "Police Shared" then return end
    exports["ev-interface"]:hideInteraction()
end)

RegisterNetEvent('ev-garages:fitmentSet')
AddEventHandler('ev-garages:fitmentSet', function()
    Citizen.CreateThread(function()
        while SetFitment do
            Citizen.Wait(1000)
            if SetFitment then
                if GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())) == pPlate then
                    if IsPedInAnyVehicle(PlayerPedId()) then
                        SetFitment = false
                        TriggerServerEvent('ev-wheelfitment:GetVehicleStatus', GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)),  GetVehiclePedIsIn(PlayerPedId()))
                    end
                end
            end
        end
    end)
end)

-- PD Heli --

RegisterNetEvent('ev-garages:pd_heli')
AddEventHandler('ev-garages:pd_heli', function()
    local PDHeliGarage = {
        {
            title = "Helicopter Garage",
            description = "Pull out a PD Heli",
            children = {
                title = "Polas 350",
                description = "Police Issued Helicopter",
                children = {
                    title = "Take Out",
                    action = "ev-garages:spawn_heli"
                }
            }
        },
    }
    exports["ev-interface"]:showContextMenu(PDHeliGarage)
end)

RegisterInterfaceCallback('ev-garages:spawn_heli', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local vehicle = GetHashKey('polas350')
	RequestModel(vehicle)
	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	local plate = "PDK " .. GetRandomIntInRange(1000, 9000)
	local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 2.0, 0)

	local veh = CreateVehicle(vehicle, 449.31, -981.07, 44.06, 87.21, true, false)

	SetModelAsNoLongerNeeded(vehicle)
	SetVehicleOnGroundProperly(veh)
	SetVehicleNumberPlateText(veh, plate)
	TriggerEvent("keys:addNew",veh,plate)
end)