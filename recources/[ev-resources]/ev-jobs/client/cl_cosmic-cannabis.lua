local nearPicking = false

Citizen.CreateThread(function()
    exports["ev-polyzone"]:AddBoxZone("cosmic_picking", vector3(164.48, -238.71, 50.06), 4.6, 4.8,  {
		name="cosmic_picking",
        heading=340,
        minZ=48.26,
        maxZ=52.26
    })
    
    exports["ev-polyzone"]:AddBoxZone("cosmic_roof_lower", vector3(196.9, -268.35, 50.02), 5, 5.4, {
		name="cosmic_roof_lower",
        heading=250,
        minZ=49.02,
        maxZ=53.02
    })

    exports["ev-polyzone"]:AddBoxZone("cosmic_roof_upper", vector3(184.98, -263.91, 63.15), 5, 7.0, {
		name="cosmic_roof_upper",
        heading=250,
        minZ=60.75,
        maxZ=64.75
    })

    exports["ev-polyzone"]:AddBoxZone("cosmic_inside_upper", vector3(185.6, -236.04, 54.07), 1, 1.4, {
		name="cosmic_inside_upper",
        heading=340,
        minZ=51.47,
        maxZ=55.47
    })
    
    exports["ev-polyzone"]:AddBoxZone("cosmic_inside_down", vector3(201.78, -241.1, 65.74), 1, 1.2, {
		name="cosmic_inside_down",
        heading=295,
        minZ=63.14,
        maxZ=67.14
    })
end)

RegisterNetEvent('ev-polyzone:enter')
AddEventHandler('ev-polyzone:enter', function(name)
    if name == "cosmic_picking" then
        local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
        local HasPermission = exports["ev-business"]:HasPermission('cosmic_cannabis',"craft_access")
        if isEmployed and HasPermission then
            nearPicking = true
            StartHarvisting()
			exports['ev-interface']:showInteraction(("[E] %s"):format("Start Harvisting"))
        end
    elseif name == "cosmic_roof_lower" then
        local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
        if isEmployed then
            canGoUpper = true
            TeleportCarpark()
        end
    elseif name == "cosmic_roof_upper" then
        local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
        if isEmployed then
            canGoLower = true
            TeleportDown()
        end
    elseif name == "cosmic_inside_upper" then
        local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
        if isEmployed then
            canGoInsideUpper = true
            TeleportUp()
        end
    elseif name == "cosmic_inside_down" then
        local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
        if isEmployed then
            canGoInsideLower = true
            TeleportDownInside()
        end
    end
end)

RegisterNetEvent('ev-polyzone:exit')
AddEventHandler('ev-polyzone:exit', function(name)
    if name == "cosmic_picking" then
        nearPicking = false
    elseif name == "cosmic_roof_lower" then
        canGoUpper = false
    elseif name == "cosmic_roof_upper" then
        canGoLower = false
    elseif name == "cosmic_inside_upper" then
        canGoInsideUpper = false
    elseif name == "cosmic_inside_down" then
        canGoInsideLower = false
    end
    exports['ev-interface']:hideInteraction()
end)

function StartHarvisting()
	Citizen.CreateThread(function()
        while nearPicking do
            Citizen.Wait(5)
            local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
            local HasPermission = exports["ev-business"]:HasPermission('cosmic_cannabis',"craft_access")
            if isEmployed and HasPermission then
                if IsControlJustReleased(0, 38) then
                    local lPed = PlayerPedId()
                    LoadAnim('amb@world_human_gardener_plant@male@base')
                    FreezeEntityPosition(lPed,true)
                    Citizen.Wait(500)
                    ClearPedTasksImmediately(lPed)
                    TaskPlayAnim(lPed, "amb@world_human_gardener_plant@male@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
                    local finished = exports['ev-taskbar']:taskBar(math.random(45000, 60000), 'Picking Weed')
                    if (finished == 100) then
                        local pWeed = math.random(5, 10)
                        TriggerEvent('player:receiveItem', 'weedq', pWeed)
                        FreezeEntityPosition(lPed,false)
                    else
                        FreezeEntityPosition(GetPlayerPed(-1),false)
                    end
                end
            end
        end
    end)
end

function TeleportCarpark()
	Citizen.CreateThread(function()
        while canGoUpper do
            Citizen.Wait(5)
            local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
            if isEmployed then
                if IsControlJustReleased(0, 38) then
                    SetPedCoordsKeepVehicle(PlayerPedId(), vector3(180.48361, -261.8265, 61.946601))
                    SetEntityHeading(PlayerPedId(), 71.000274)
                end
            end
        end
    end)
end

function TeleportDown()
	Citizen.CreateThread(function()
        while canGoLower do
            Citizen.Wait(5)
            local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
            if isEmployed then
                if IsControlJustReleased(0, 38) then
                    SetPedCoordsKeepVehicle(PlayerPedId(), vector3(199.17579, -269.455, 49.401466))
                    SetEntityHeading(PlayerPedId(), 254.93222)
                end
            end
        end
    end)
end

function TeleportUp()
	Citizen.CreateThread(function()
        while canGoInsideUpper do
            Citizen.Wait(5)
            local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
            if isEmployed then
                if IsControlJustReleased(0, 38) then
                    SetEntityCoords(PlayerPedId(), vector3(201.44665, -241.1262, 65.73526))
                    SetEntityHeading(PlayerPedId(), 113.09328)
                end
            end
        end
    end)
end

function TeleportDownInside()
	Citizen.CreateThread(function()
        while canGoInsideLower do
            Citizen.Wait(5)
            local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
            if isEmployed then
                if IsControlJustReleased(0, 38) then
                    SetEntityCoords(PlayerPedId(), vector3(185.52442, -236.0173, 54.069725))
                    SetEntityHeading(PlayerPedId(), 163.30961)
                end
            end
        end
    end)
end

function LoadAnim(animDict)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

RegisterNetEvent('ev-jobs:CraftJointsMenu')
AddEventHandler('ev-jobs:CraftJointsMenu', function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
    local HasPermission = exports["ev-business"]:HasPermission('cosmic_cannabis',"craft_access")
    if isEmployed and HasPermission then
        local CCJoint = {
            {
                title = "LS Confidential",
                description = "Roll 2g LS Confidential Joint",
                key = "LS.CF",
                action = 'ev-jobs:ls_cf',
            },
            {
                title = "Alaskan Thunder Fuck",
                description = "Roll 2g Alaskan Thunder Fuck Joint",
                key = "AS.FF",
                action = 'ev-jobs:af',
            },
            {
                title = "Chiliad Kush",
                description = "Roll 2g Chiliad Kush Joint",
                key = "CK.J",
                action = 'ev-jobs:ck_j',
            },
        }
        exports["ev-interface"]:showContextMenu(CCJoint)
    else
        TriggerEvent('DoLongHudText', 'You are not employed at this business', 2)
    end
end)

RegisterInterfaceCallback('ev-jobs:ls_cf', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-inventory']:hasEnoughOfItem('weedq', 1) then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent("animation:PlayAnimation","cokecut")
        local finished = exports['ev-taskbar']:taskBar(math.random(20000, 30000), 'Crafting LS Confidential')
        if (finished == 100) then
            TriggerEvent("inventory:removeItem","weedq", 1)
            Wait(1000)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerEvent('player:receiveItem', 'lsconfidentialjoint', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    end
end)

RegisterInterfaceCallback('ev-jobs:af', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-inventory']:hasEnoughOfItem('weedq', 1) then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent("animation:PlayAnimation","cokecut")
        local finished = exports['ev-taskbar']:taskBar(math.random(20000, 30000), 'Alaskan Thunder Fuck')
        if (finished == 100) then
            TriggerEvent("inventory:removeItem","weedq", 1)
            Wait(1000)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerEvent('player:receiveItem', 'alaskanthunderfuckjoint', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    end
end)

RegisterInterfaceCallback('ev-jobs:ck_j', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-inventory']:hasEnoughOfItem('weedq', 1) then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent("animation:PlayAnimation","cokecut")
        local finished = exports['ev-taskbar']:taskBar(math.random(20000, 30000), 'Chiliad Kush')
        if (finished == 100) then
            TriggerEvent("inventory:removeItem","weedq", 1)
            Wait(1000)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerEvent('player:receiveItem', 'chiliadkushjoint', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    end
end)

RegisterNetEvent('ev-jobs:EdiblesMenu')
AddEventHandler('ev-jobs:EdiblesMenu', function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("cosmic_cannabis")
    local HasPermission = exports["ev-business"]:HasPermission('cosmic_cannabis',"craft_access")
    if isEmployed and HasPermission then
        local CCE = {
            {
                title = "Cannabis Brownies",
                description = "Make a batch of brownies",
                key = "CB",
                action = 'ev-jobs:brownies',
            },
            {
                title = "Cannabis Absinthe",
                description = "Make some cannabis absinthe",
                key = "CA",
                action = 'ev-jobs:absinthe',
            },
            {
                title = "Cannabis Gummies",
                description = "Make a batch of gummies",
                key = "CG",
                action = 'ev-jobs:gummies',
            },
            {
                title = "420 Bar",
                description = "Make some chocolate",
                key = "420",
                action = 'ev-jobs:420',
            },
        }
        exports["ev-interface"]:showContextMenu(CCE)
    else
        TriggerEvent('DoLongHudText', 'You are not employed at this business', 2)
    end
end)

RegisterInterfaceCallback('ev-jobs:brownies', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-inventory']:hasEnoughOfItem('weedq', 1) then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent("animation:PlayAnimation","cokecut")
        local finished = exports['ev-taskbar']:taskBar(math.random(10000, 15000), 'Making Cannabis Brownies')
        if (finished == 100) then
            TriggerEvent("inventory:removeItem","weedq", 1)
            Wait(1000)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerEvent('player:receiveItem', 'cbrownie', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    end
end)

RegisterInterfaceCallback('ev-jobs:absinthe', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-inventory']:hasEnoughOfItem('weedq', 1) then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent("animation:PlayAnimation","cokecut")
        local finished = exports['ev-taskbar']:taskBar(math.random(10000, 15000), 'Making Cannabis Absinthe')
        if (finished == 100) then
            TriggerEvent("inventory:removeItem","weedq", 1)
            Wait(1000)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerEvent('player:receiveItem', 'cabsinthe', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    end
end)

RegisterInterfaceCallback('ev-jobs:gummies', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-inventory']:hasEnoughOfItem('weedq', 1) then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent("animation:PlayAnimation","cokecut")
        local finished = exports['ev-taskbar']:taskBar(math.random(10000, 15000), 'Making Cannabis Gummies')
        if (finished == 100) then
            TriggerEvent("inventory:removeItem","weedq", 1)
            Wait(1000)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerEvent('player:receiveItem', 'cgummies', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    end
end)

RegisterInterfaceCallback('ev-jobs:420', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-inventory']:hasEnoughOfItem('weedq', 1) then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent("animation:PlayAnimation","cokecut")
        local finished = exports['ev-taskbar']:taskBar(math.random(10000, 15000), 'Making 420 Bar')
        if (finished == 100) then
            TriggerEvent("inventory:removeItem","weedq", 1)
            Wait(1000)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerEvent('player:receiveItem', '420bar', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    end
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

RegisterNetEvent("cosmic_cannabis:pay")
AddEventHandler("cosmic_cannabis:pay", function(amount)
    TriggerServerEvent("server:GroupPayment","cosmic_cannabis", amount) 
end)

RegisterNetEvent("cosmic_cannabis:get:receipt")
AddEventHandler("cosmic_cannabis:get:receipt", function(registerid)
    TriggerServerEvent('cosmic_cannabis:retreive:receipt', registerid)
end)

RegisterNetEvent('cosmic_cannabis:openCounter')
AddEventHandler('cosmic_cannabis:openCounter', function()
    TriggerEvent("server-inventory-open", "1", "cosmic_counter")
end)

-- Trays

RegisterNetEvent("ev-cosmic:tray_1")
AddEventHandler("ev-cosmic:tray_1", function()
    TriggerEvent("server-inventory-open", "1", "cosmic-table-1");
end)

RegisterNetEvent("ev-cosmic:tray_2")
AddEventHandler("ev-cosmic:tray_2", function()
    TriggerEvent("server-inventory-open", "1", "cosmic-table-2");
end)

exports["ev-polytarget"]:AddBoxZone("cosmic_cannabis_roll_joint", vector3(164.45, -233.44, 50.06), 1, 2.6, {
    heading=70,
    minZ=46.46,
    maxZ=50.46
})
exports["ev-polytarget"]:AddBoxZone("cosmic_cannabis_box_weed", vector3(166.92, -232.68, 50.06), 1, 2.0, {
    heading=340,
    minZ=46.66,
    maxZ=50.66
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("cosmic_cannabis_tray_1", {
    {
        event = "ev-cosmic:tray_1",
        id = "cosmic_cannabis_tray_1",
        icon = "boxes",
        label = "Tray",
        parameters = {},
    },
}, {
    distance = { radius = 2.5 },
});

exports["ev-interact"]:AddPeekEntryByPolyTarget("cosmic_cannabis_tray_2", {
    {
        event = "ev-cosmic:tray_2",
        id = "cosmic_cannabis_tray_2",
        icon = "boxes",
        label = "Tray",
        parameters = {},
    },
}, {
    distance = { radius = 2.5 },
});


 exports["ev-interact"]:AddPeekEntryByPolyTarget("cosmic_counter", {
     {
         event = "cosmic_cannabis:openCounter",
         id = "cosmic_counter",
         icon = "circle",
         label = "Cosmic Cannabis Pickup",
         parameters = {},
     },
 }, {
     distance = { radius = 2.5 },
 });