-- Desire RP --

-- Made By -- Aspect…#0999

--------------[COORDINATES]---------------
-- Store 1 | -48.35, -1757.79, 29.42-----
-- Store 2 | -709.44, -913.99, 19.20-----
-- Store 3 | 373.83, 326.04, 103.56------
-- Store 4 | -1223.61, -906.75, 12.32----
-- Store 5 | -2968.22, 389.77, 15.03----
-- Ped Coord | 919.82, -1256.61, 25.51---
---- Spawn Car | 913.6, -1258, 25.54-----
------------------------------------------

local pDeliveryJob = false

local onWay1 = false
local onWay2 = false
local onWay3 = false
local onWay4 = false
local onWay5 = false

local hasGoods = false

local pVeh = nil

RegisterNetEvent('ev-jobs:deliverySignIn')
AddEventHandler('ev-jobs:deliverySignIn', function()
    if not inJob then
        TriggerEvent('ev-phone:signInInfoDelivery')
        print('[24/7 DELIVERIES] AWAITING JOB')
        inJob = true
        Citizen.Wait(math.random(60000, 120000))
        print('[24/7 DELIVERIES] SENDING JOB')
        TriggerEvent('ev-phone:delivery_offer')
    end
end)

RegisterNetEvent('ev-jobs:deliveries:getCar')
AddEventHandler('ev-jobs:deliveries:getCar', function()
    local model = "benson"
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    SetModelAsNoLongerNeeded(model)

    local veh = CreateVehicle(model, vector3(915.42, -1257.60, 25.55), true, false)
    SetEntityHeading(veh, 33.88)

    local vehplate = "247"..math.random(10000, 99999) 
    SetVehicleNumberPlateText(veh, vehplate)
    Citizen.Wait(100)
    TriggerEvent("keys:addNew", veh, vehplate)
    SetModelAsNoLongerNeeded(model)
    pVeh = veh

    TriggerEvent('ev-jobs:getDeliveryJob')
end)

RegisterNetEvent('ev-jobs:deleteDeliveryVehicle')
AddEventHandler('ev-jobs:deleteDeliveryVehicle', function()
    DeleteEntity(pVeh)
    pVeh = nil
end)

RegisterNetEvent('ev-jobs:getDeliveryJob')
AddEventHandler('ev-jobs:getDeliveryJob', function()
    local job = math.random(1, 5)
    if not pDeliveryJob then
        if job == 1 then
            canDeliverThread1(true)
            onWay1 = true
            pDeliveryJob = true
            pDelivery1Blip = AddBlipForCoord(-48.35, -1757.79, 29.42)
            SetBlipSprite(pDelivery1Blip, 615)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Delivery Location")
            EndTextCommandSetBlipName(pDelivery1Blip)
            SetBlipRoute(pDelivery1Blip, 2)
            SetBlipRouteColour(pDelivery1Blip, 2)
            SetBlipColour(pDelivery1Blip, 2)
            canDeliverThread1(true)
        elseif job == 2 then
            onWay2 = true
            pDeliveryJob = true
            pDelivery2Blip = AddBlipForCoord(-709.44, -913.99, 19.20)
            SetBlipSprite(pDelivery2Blip, 615)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Delivery Location")
            EndTextCommandSetBlipName(pDelivery2Blip)
            SetBlipRoute(pDelivery2Blip, true)
            SetBlipRouteColour(pDelivery2Blip, 2)
            SetBlipColour(pDelivery2Blip, 2)
            canDeliverThread2(true)
        elseif job == 3 then
            onWay3 = true
            pDeliveryJob = true
            pDelivery3Blip = AddBlipForCoord(373.83, 326.04, 103.56)
            SetBlipSprite(pDelivery3Blip, 615)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Delivery Location")
            EndTextCommandSetBlipName(pDelivery3Blip)
            SetBlipRoute(pDelivery3Blip, true)
            SetBlipRouteColour(pDelivery3Blip, 2)
            SetBlipColour(pDelivery3Blip, 2)
            canDeliverThread3(true)
        elseif job == 4 then
            onWay4 = true
            pDeliveryJob = true
            pDelivery4Blip = AddBlipForCoord(-1223.61, -906.75, 12.32)
            SetBlipSprite(pDelivery4Blip, 615)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Delivery Location")
            EndTextCommandSetBlipName(pDelivery4Blip)
            SetBlipRoute(pDelivery4Blip, true)
            SetBlipRouteColour(pDelivery4Blip, 2)
            SetBlipColour(pDelivery4Blip, 2)
            canDeliverThread4(true)
        elseif job == 5 then
            onWay5 = true
            pDeliveryJob = true
            pDelivery5Blip = AddBlipForCoord(-2968.22, 389.77, 15.03)
            SetBlipSprite(pDelivery5Blip, 615)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Delivery Location")
            EndTextCommandSetBlipName(pDelivery5Blip)
            SetBlipRoute(pDelivery5Blip, true)
            SetBlipRouteColour(pDelivery5Blip, 2)
            SetBlipColour(pDelivery5Blip, 2)
            canDeliverThread5(true)
        end
    end
end)

-- Polyzones --

Citizen.CreateThread(function()
    exports["ev-polyzone"]:AddBoxZone("delivery_store_1", vector3(-48.17, -1751.95, 29.42), 12.6, 15, {
        name="delivery_store_1",
        heading=320,
        debugPoly=false,
        minZ=27.22,
        maxZ=31.22
	})

    exports["ev-polyzone"]:AddBoxZone("delivery_store_2", vector3(-712.37, -911.54, 19.01), 15, 10.2, {
        name="delivery_store_2",
        heading=270,
        debugPoly=false,
        minZ=17.61,
        maxZ=21.61
	})

    exports["ev-polyzone"]:AddBoxZone("delivery_store_3", vector3(378.01, 329.12, 103.45), 12, 11.0, {
        name="delivery_store_3",
        heading=345,
        debugPoly=false,
        minZ=102.45,
        maxZ=106.45
	})

    exports["ev-polyzone"]:AddBoxZone("delivery_store_4", vector3(-1224.38, -905.82, 12.31), 7, 7, {
        name="delivery_store_4",
        heading=35,
        debugPoly=false,
        minZ=11.31,
        maxZ=15.31
	})

    exports["ev-polyzone"]:AddBoxZone("delivery_store_5", vector3(-2968.34, 390.36, 15.04), 7, 7, {
        name="delivery_store_5",
        heading=355,
        debugPoly=false,
        minZ=14.04,
        maxZ=18.04
	})
end)

RegisterNetEvent('ev-polyzone:enter')
AddEventHandler('ev-polyzone:enter', function(name)
    if name == "delivery_store_1" then
        delivery_store_1 = true
        if onWay1 and hasGoods then
            pDropGoods()
            exports['ev-interface']:showInteraction('[E] Drop Goods [Delivery Job]')
            canDropGoods = true     
        end
    elseif name == "delivery_store_2" then
        delivery_store_2 = true
        if onWay2 and hasGoods then
            pDropGoods()
            exports['ev-interface']:showInteraction('[E] Drop Goods [Delivery Job]')
            canDropGoods = true
        end
    elseif name == "delivery_store_3" then
        delivery_store_3 = true
        if onWay3 and hasGoods then
            pDropGoods()
            exports['ev-interface']:showInteraction('[E] Drop Goods [Delivery Job]')
            canDropGoods = true
        end
    elseif name == "delivery_store_4" then
        delivery_store_4 = true
        if onWay4 and hasGoods then
            pDropGoods()
            exports['ev-interface']:showInteraction('[E] Drop Goods [Delivery Job]')
            canDropGoods = true
        end
    elseif name == "delivery_store_5" then
        delivery_store_5 = true
        if onWay5 and hasGoods then
            pDropGoods()
            exports['ev-interface']:showInteraction('[E] Drop Goods [Delivery Job]')
            canDropGoods = true
        end
    end
end)

RegisterNetEvent('ev-polyzone:exit')
AddEventHandler('ev-polyzone:exit', function(name)
    if name == "delivery_store_1" then
        delivery_store_1 = false
        canDropGoods = false
        exports['ev-interface']:hideInteraction()
    elseif name == "delivery_store_2" then
        delivery_store_2 = false
        canDropGoods = false
        exports['ev-interface']:hideInteraction()
    elseif name == "delivery_store_3" then
        delivery_store_3 = false
        canDropGoods = false
        exports['ev-interface']:hideInteraction()
    elseif name == "delivery_store_4" then
        delivery_store_4 = false
        canDropGoods = false
        exports['ev-interface']:hideInteraction()
    elseif name == "delivery_store_5" then
        delivery_store_5 = false
        canDropGoods = false
        exports['ev-interface']:hideInteraction()
    end
end)

function canDeliverThread1(IsInWay)
    local setCoords = vector3(-48.35, -1757.79, 29.42)
    Citizen.CreateThread(function()
      while IsInWay do
        Citizen.Wait(1000)
        local plped = PlayerPedId()
        local coordA = GetEntityCoords(plped)
        if onWay1 and pDeliveryJob then
            local aDist = GetDistanceBetweenCoords(setCoords, coordA)
            if aDist < 25.0 then
                canGrabGoods = true
            else
                canGrabGoods = false
            end 
          end
        end
    end)
  end

  function canDeliverThread2(IsInWay)
    local setCoords = vector3(-709.44, -913.99, 19.20)
    Citizen.CreateThread(function()
      while IsInWay do
        Citizen.Wait(1000)
        local plped = PlayerPedId()
        local coordA = GetEntityCoords(plped)
        if onWay2 and pDeliveryJob then
            local aDist = GetDistanceBetweenCoords(setCoords, coordA)
            if aDist < 25.0 then
                canGrabGoods = true
            else
                canGrabGoods = false
            end
          end
        end
    end)
  end

  function canDeliverThread3(IsInWay)
    local setCoords = vector3(373.83, 326.04, 103.56)
    Citizen.CreateThread(function()
      while IsInWay do
        Citizen.Wait(1000)
        local plped = PlayerPedId()
        local coordA = GetEntityCoords(plped)
        if onWay3 and pDeliveryJob then
            local aDist = GetDistanceBetweenCoords(setCoords, coordA)
            if aDist < 25.0 then
                canGrabGoods = true
            else
                canGrabGoods = false
            end 
          end
        end
    end)
  end

  function canDeliverThread4(IsInWay)
    local setCoords = vector3(-1223.61, -906.75, 12.32)
    Citizen.CreateThread(function()
      while IsInWay do
        Citizen.Wait(1000)
        local plped = PlayerPedId()
        local coordA = GetEntityCoords(plped)
        if onWay4 and pDeliveryJob then
            local aDist = GetDistanceBetweenCoords(setCoords, coordA)
            if aDist < 25.0 then
                canGrabGoods = true
            else
                canGrabGoods = false
            end
          end
        end
    end)
  end

  function canDeliverThread5(IsInWay)
    local setCoords = vector3(-2968.22, 389.77, 15.03)
    Citizen.CreateThread(function()
      while IsInWay do
        Citizen.Wait(1000)
        local plped = PlayerPedId()
        local coordA = GetEntityCoords(plped)
        if onWay5 and pDeliveryJob then
            local aDist = GetDistanceBetweenCoords(setCoords, coordA)
            if aDist < 25.0 then
                canGrabGoods = true
            else
                canGrabGoods = false
            end 
          end
        end
    end)
  end

  -- Grab Goods --

  RegisterNetEvent('deisrep-jobs:deliveryGrabGoods')
  AddEventHandler('deisrep-jobs:deliveryGrabGoods', function()
    if canGrabGoods then
        TriggerEvent("attach:box")
        canGrabGoods = false
        hasGoods = true
    end
  end)

  
function pDropGoods()
	Citizen.CreateThread(function()
        while delivery_store_1 or delivery_store_2 or delivery_store_3 or delivery_store_4 or delivery_store_5 do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) and hasGoods then
                RemoveBlip(pDelivery1Blip)
                RemoveBlip(pDelivery2Blip)
                RemoveBlip(pDelivery3Blip)
                RemoveBlip(pDelivery4Blip)
                RemoveBlip(pDelivery5Blip)

                hasGoods = false
                canGrabGoods = false
                TriggerEvent('propattach:destroyCurrent')
                exports['ev-interface']:hideInteraction()
                TriggerEvent('ev-jobs:deliveryReturnToDepo')
			end
		end
	end)
end

RegisterNetEvent('ev-jobs:deliveryReturnToDepo')
AddEventHandler('ev-jobs:deliveryReturnToDepo', function()
    pDeliveryJob = false
    onWay1 = false
    onWay2 = false
    onWay3 = false
    onWay4 = false
    onWay5 = false
    pReturning = true

    TriggerEvent('phone:addnotification', '24/7 Delivery Job', 'Return to the depo.')

    pReturnDepo = AddBlipForCoord(914.87, -1259.54, 25.56)
    SetBlipSprite(pReturnDepo, 50)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Depo")
    EndTextCommandSetBlipName(pReturnDepo)
    SetBlipRoute(pReturnDepo, 2)
    SetBlipRouteColour(pReturnDepo, 2)
    SetBlipColour(pReturnDepo, 2)

    local setCoords = vector3(916.00, -1260.38, 25.56)
    Citizen.CreateThread(function()
      while pReturning do
        Citizen.Wait(1000)
        local plped = PlayerPedId()
        local coordA = GetEntityCoords(plped)
        local aDist = GetDistanceBetweenCoords(setCoords, coordA)
            if aDist < 15.0 then
                pReturning = false
                RemoveBlip(pReturnDepo)
                inJob = false
                if exports['ev-hud']:MoneyBuff() then
                    TriggerServerEvent('ev-jobs:givePayout', math.random(650, 727), "cash", '[24/7 Delivery Job | With Buff]')
                else
                    TriggerServerEvent('ev-jobs:givePayout', math.random(500, 678), "cash", '[24/7 Delivery Job | Without Buff]')
                end
                TriggerEvent('ev-jobs:deleteDeliveryVehicle')
            end
        end
    end)
end)

-- Start/Stop Delivery Job --

exports["ev-polytarget"]:AddCircleZone("delivery_start_stop",  vector3(919.82, -1256.64, 25.51), 0.8, {
    useZ = true
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("delivery_start_stop", {{
    event = "ev-jobs:deliverySignIn",
    id = "delivery_start_stop",
    icon = "circle",
    label = "Sign In",
    parameters = {},
}}, {
    distance = { radius = 5 },
});

function canGrabGoods()
    if canGrabGoods then
        canGrabGoods = true
    elseif not canGrabGoods then
        canGrabGoods = false
    end
    return canGrabGoods
end

-- Ped Shit -- (IGNORE THIS IS FOR ev-ACTIVITIES HOUSE ROBBERIES)

exports["ev-polytarget"]:AddCircleZone("start_house_robbery",  vector3(206.81, -1851.14, 27.76), 0.85, {
    useZ = true
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("start_house_robbery", {{
    event = "ev-houserobbery:getJob",
    id = "start_house_robbery",
    icon = "circle",
    label = "Sign In",
    parameters = {},
}}, {
    distance = { radius = 5 },
});