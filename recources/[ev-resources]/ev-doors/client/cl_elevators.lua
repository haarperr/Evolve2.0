local Elevators = {}
local currentFloorId = nil
local currentElevator = nil

Citizen.CreateThread(function()
    Elevators = RPC.execute('ev-doors:elevators:fetch')

    setSecuredAccesses(Elevators, 'elevator')

    for _, elevator in ipairs(Elevators) do
        local floors = elevator.floors

        for floorId, floor in ipairs(floors) do
            local zone = floor.zone

            if not zone.options.data then zone.options.data = {} end

            local data, lib = zone.options.data or {}, zone.target and 'ev-polytarget' or 'ev-polyzone'

            data.floorId = floorId
            data.elevatorId = elevator.id

            exports[lib]:AddBoxZone("ev-doors:elevator", zone.center, zone.width, zone.length, zone.options)
        end
    end

    exports['ev-interact']:AddPeekEntryByPolyTarget('ev-doors:elevator', {
        {
            id = "elevatorPrompt",
            event = "ev-doors:elevator:prompt",
            icon = "chevron-circle-up",
            label = "Elevator"
        }}, { distance = { radius = 1.5 } })
end)

AddEventHandler('ev-doors:elevator:prompt', function(pParameters, pEntity, pContext)
    local data = pContext.zones and pContext.zones['ev-doors:elevator']

    if not data or not Elevators[data.elevatorId] then return end

    local hasHackingDevice = exports["ev-inventory"]:hasEnoughOfItem('elevatorhackingdevice', 1, false, true)

    OpenElevatorMenu(data.elevatorId, data.floorId, hasHackingDevice)
end)

function OpenElevatorMenu(pElevator, pCurrentFloor, pBreachingDevice)
    local elevator = Elevators[pElevator]

    if not elevator then return end

    currentElevator = elevator

    local elements, access, hasAccess = {}, {}, hasSecuredAccess(pElevator, 'elevator')

    for floorId, floor in ipairs(elevator.floors) do
        local isCurrentFloor = floorId == pCurrentFloor
        local isRestricted = floor.locked and not hasAccess

        local status = ''

        if isCurrentFloor then
            currentFloorId = floorId
            status = status .. ' | Current'
        end

        if isRestricted then
            status = status .. ' | Restricted'
        end

        elements[#elements+1] = {
            title = floor.name .. status,
            description = floor.description,
            action = (not isCurrentFloor and not isRestricted) and 'ev-doors:elevator:teleport' or '',
            key = floor.teleport,
            disabled = isCurrentFloor or isRestricted
        }

        if hasAccess then
            access[#access+1] = {
                title = floor.name .. (floor.locked and ' | Restricted' or ' | Unrestricted'),
                action = 'ev-doors:elevator:access',
                key = { elevatorId = pElevator, floorId = floorId, locked = floor.locked}
            }
        end
    end

    if hasAccess then
        elements[#elements+1] = {
            title = 'Access Control',
            children = access
        }
    end

    if not hasAccess and pBreachingDevice then
        elements[#elements+1] = {
            title = 'Hack Control Panel',
            action = 'ev-doors:elevator:hackControlPanel',
            key = { type = "elevator", id = pElevator }
        }
    end

    exports['ev-interface']:showContextMenu(reverse(elements))
end

function TeleportPlayer(pCoords, pHeading, pOnArriveEvent, pOnLeaveEvent)
    local heading = pHeading * 1.0
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local teleportCoords = vector3(pCoords.x, pCoords.y, pCoords.z)

    local time = math.floor((#(teleportCoords - playerCoords) / 50) * 100)
    local entity = IsPedInAnyVehicle(playerPed) and GetVehiclePedIsIn(playerPed) or playerPed

    DoScreenFadeOut(400)

    SetEntityInvincible(playerPed, true)

    for floorId, floor in ipairs(currentElevator.floors) do
        if floorId == currentFloorId then
          if floor.teleport and floor.teleport.onLeaveEvent then
            TriggerEvent(floor.teleport.onLeaveEvent)
          end
        end
    end

    while IsScreenFadingOut() do
        Citizen.Wait(0)
    end

    NetworkFadeOutEntity(playerPed, true, true)

    SetPedCoordsKeepVehicle(playerPed, teleportCoords)

    SetEntityHeading(entity, heading)

    SetGameplayCamRelativeHeading(0.0)

    Citizen.Wait(time)

    if pOnArriveEvent then
        TriggerEvent(pOnArriveEvent)
    end

    NetworkFadeInEntity(playerPed, true)

    DoScreenFadeIn(400)


    CreateThread(function ()
        local timeout = 0
        while timeout < 6000 and not IsPedShooting(playerPed) do
            Citizen.Wait(10)
            timeout = timeout + 10
        end
        SetEntityInvincible(playerPed, false)
    end)
end

RegisterNetEvent('ev-doors:elevators:updateState')
AddEventHandler('ev-doors:elevators:updateState', function (pElevatorId, pFloorId, pRestricted, pForceUnlock)
    local elevator = Elevators[pElevatorId]

    if not elevator then return end

    elevator['forceUnlocked'] = pForceUnlock
    elevator['floors'][pFloorId]['locked'] = pRestricted
end)

RegisterInterfaceCallback('ev-doors:elevator:teleport', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local taskActive, coords, heading, onArriveEvent, onLeaveEvent =
      true, data.key.coords, data.key.heading, data.key.onArriveEvent, data.key.onLeaveEvent

    Citizen.CreateThread(function ()
        local playerPed = PlayerPedId()
        local startingCoords = GetEntityCoords(playerPed)

        while taskActive do
            local playerCoords = GetEntityCoords(playerPed)

            if #(startingCoords - playerCoords) >= 1.6 or IsPedRagdoll(playerPed) or IsPedBeingStunned(playerPed) then
                exports['ev-taskbar']:taskCancel()
            end

            Citizen.Wait(100)
        end
    end)

    local time = math.random(4000, 12000)
    local finished = exports["ev-taskbar"]:taskBar(time, "Waiting for the Elevator", false)

    taskActive = false

    if finished ~= 100 then return end

    TeleportPlayer(coords, heading, onArriveEvent, onLeaveEvent)
end)

RegisterInterfaceCallback('ev-doors:elevator:access', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local elevatorId, floorId, locked = data.key.elevatorId, data.key.floorId, data.key.locked

    if not hasSecuredAccess(elevatorId, 'elevator') then return end

    TriggerServerEvent('ev-doors:change-elevator-state', elevatorId, floorId, not locked)
end)

RegisterInterfaceCallback('ev-doors:elevator:hackControlPanel', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local id = data.key.id
    local accessType = data.key.type

    local hackId = RPC.execute('ev-doors:startAccessHack', accessType, id)

    if not hackId then return TriggerEvent('DoLongHudText', 'Unable to establish connection', 2) end

    exports['ev-interface']:openApplication('memorygame', {
        gameFinishedEndpoint = 'ev-doors:elevator:completeHacking',
        gameTimeoutDuration = 14000,
        coloredSquares =  10,
        gridSize = 5,
        parameters = {
            hackId = hackId,
        },
    })
end)

RegisterInterfaceCallback('ev-doors:elevator:completeHacking', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local success = data.success
    local hackId = data.parameters.hackId

    RPC.execute('ev-doors:completeAccessHack', success, hackId)

    clearAccessCache()

    Citizen.Wait(3000)

    exports['ev-interface']:closeApplication('memorygame')
end)