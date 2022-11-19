-- Stash --

local Uwu_Cafe_Stash = false

RegisterNetEvent('ev-polyzone:enter')
AddEventHandler('ev-polyzone:enter', function(name)
    if name == "Uwu_Cafe_Stash" then
        Uwu_Cafe_Stash = true
        UwuStash()
        local isEmployed = exports["ev-business"]:IsEmployedAt("uwu_cafe")
        if isEmployed then
            exports['ev-interface']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('ev-polyzone:exit')
AddEventHandler('ev-polyzone:exit', function(name)
    if name == "Uwu_Cafe_Stash" then
        Uwu_Cafe_Stash = false
        exports['ev-interface']:hideInteraction()
    end
end)

function UwuStash()
	Citizen.CreateThread(function()
        while Uwu_Cafe_Stash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["ev-business"]:IsEmployedAt("uwu_cafe")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '1', 'uwu-cafe-stash')
                end
			end
		end
	end)
end

Citizen.CreateThread(function()
    exports["ev-polyzone"]:AddBoxZone("Uwu_Cafe_Stash", vector3(-585.62, -1055.82, 22.34), 1, 2.4, {
        name="Uwu_Cafe_Stash",
        heading=0,
        minZ=19.54,
        maxZ=23.54
    })
end)

-- Trays --

exports["ev-polytarget"]:AddCircleZone("uwu_cafe_tray_1", vector3(-583.97, -1059.3, 22.34), 0.4, {
    useZ=true,
})

exports["ev-polytarget"]:AddCircleZone("uwu_cafe_tray_2", vector3(-583.97, -1062.08, 22.34), 0.4, {
    useZ=true,
})

 -- Tray 1
 exports["ev-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_tray_1", {{
    event = "ev-jobs:UwuCafeTray1",
    id = "uwu_cafe_tray_1",
    icon = "hand-holding",
    label = "Open",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

-- Tray 2
exports["ev-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_tray_2", {{
    event = "ev-jobs:UwuCafeTray2",
    id = "uwu_cafe_tray_2",
    icon = "hand-holding",
    label = "Open",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('ev-jobs:UwuCafeTray1')
AddEventHandler('ev-jobs:UwuCafeTray1', function()
    TriggerEvent("server-inventory-open", "1", "traysz-Uwu Cafe Tray")
end)

RegisterNetEvent('ev-jobs:UwuCafeTray2')
AddEventHandler('ev-jobs:UwuCafeTray2', function()
    TriggerEvent("server-inventory-open", "1", "trays-Uwu Cafe Tray")
end)

-- Food Warmer --

exports["ev-polytarget"]:AddBoxZone("uwu_cafe_food_warmer", vector3(-587.08, -1059.68, 22.34), 1, 2.8, {
    heading=270,
    --debugPoly=false,
    minZ=19.94,
    maxZ=23.94
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_food_warmer", {{
    event = "ev-jobs:UwuFoodWarmer",
    id = "uwu_cafe_food_warmer",
    icon = "hand-holding",
    label = "Food Warmer",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

exports["ev-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_food_warmer", {{
    event = "ev-dispatch:uwuAlarm",
    id = "uwu_cafe_food_warmer1",
    icon = "bell",
    label = "Alert Police",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('ev-dispatch:uwuAlarm')
AddEventHandler('ev-dispatch:uwuAlarm', function()
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        exports["ev-dispatch"]:policedead('10-13A', "UwU Cafe Panic Alarm", "59", true)
    end
end)

RegisterNetEvent('ev-jobs:UwuFoodWarmer')
AddEventHandler('ev-jobs:UwuFoodWarmer', function()
    TriggerEvent("server-inventory-open", "1", "uwuw-food-warmer")
end)

exports["ev-polytarget"]:AddBoxZone("ev_uwu_make_food", vector3(-588.25, -1059.68, 22.36), 1, 2.4, {
    heading=270,
    --debugPoly=false,
    minZ=18.76,
    maxZ=22.76
})

 -- Food Shtuff
 exports["ev-interact"]:AddPeekEntryByPolyTarget("ev_uwu_make_food", {{
    event = "ev-jobs:uwuCafeFood",
    id = "ev_uwu_make_food",
    icon = "hand-holding",
    label = "Prepare Food",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

-- Drinks --

-- Coffee
-- Booba Milk Tea

-- Bento Boxes

RegisterNetEvent('ev-jobs:uwuCafeFood')
AddEventHandler('ev-jobs:uwuCafeFood', function()
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        local pFoodMaker = {
            {
                title = "Main Dishes",
                description = "Here you can find a list of the main dishes.",
                children = {
                    {
                        title = "Rice Balls",
                        description = "Required Ingridients: 1x Nori | 1x Rice",
                        action = "ev-jobs:uwuMakeRiceBalls"
                    },
                    {
                        title = "Chicken Noodle Soup",
                        description = "Required Ingridients: 1x Noodles | 1x Chicken Breast",
                        action = "ev-jobs:uwuMakeNoodleSoup"
                    },
                    {
                        title = "Doki Doki Pancakes",
                        description = "Required Ingridients: 1x Strawberries | 1x Whipped Cream",
                        action = "ev-jobs:uwuMakePancakes"
                    },
                }
            },
            {
                title = "Deserts",
                description = "Here you can find a list of the deserts.",
                children = {
                    {
                        title = "Chocolate Cake", 
                        description = "Required Ingridients: 1x Chocolate Chips | 1x Flour",
                        action = "ev-jobs:uwuMakeCake"  
                    },
                    {
                        title = "Strawberry Shortcake",
                        description = "Required Ingridients: 1x Strawberries | 1x Flour",
                        action = "ev-jobs:uwuMakeShortcake"  
                    },
                }
            },
            {
                title = "Bento Box",
                description = "Grab a bento box to put the customers food in.",
                action = "ev-jobs:uwuGrabBentoBox"
            },
        }
        exports["ev-interface"]:showContextMenu(pFoodMaker)
    end
end)

RegisterInterfaceCallback('ev-jobs:uwuGrabBentoBox', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('player:receiveItem', 'bentobox', 1)
end)

RegisterInterfaceCallback('ev-jobs:uwuMakeRiceBalls', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        if exports['ev-inventory']:hasEnoughOfItem('rice', 1) and exports['ev-inventory']:hasEnoughOfItem('nori', 1) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'cokecut')
            local finished = exports['ev-taskbar']:taskBar(5000, 'Preparing Rice Balls...')
            if finished == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('inventory:removeItem', 'nori', 1)
                TriggerEvent('inventory:removeItem', 'rice', 1)
                TriggerEvent('player:receiveItem', 'rice_balls', 1)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

RegisterInterfaceCallback('ev-jobs:uwuMakeNoodleSoup', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        if exports['ev-inventory']:hasEnoughOfItem('chicken_breast', 1) and exports['ev-inventory']:hasEnoughOfItem('noodles', 1) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'cokecut')
            local chickenb = exports['ev-taskbar']:taskBar(2500, 'Preparing Chicken Breast...')
            if chickenb == 100 then
                Citizen.Wait(100)
                TriggerEvent('animation:PlayAnimation', 'cokecut')
                local noodles = exports['ev-taskbar']:taskBar(2500, 'Preparing Noodles')
                if noodles == 100 then
                    Citizen.Wait(100)
                    TriggerEvent('animation:PlayAnimation', 'cokecut')
                    local dish = exports['ev-taskbar']:taskBar(5000, 'Preparing Final Dish...')
                    if dish == 100 then
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerEvent('inventory:removeItem', 'chicken_breast', 1)
                        TriggerEvent('inventory:removeItem', 'noodles', 1)
                        TriggerEvent('player:receiveItem', 'chicken_noodle_soup', 1)
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                end
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

RegisterInterfaceCallback('ev-jobs:uwuMakePancakes', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        if exports['ev-inventory']:hasEnoughOfItem('whipped_cream', 1) and exports['ev-inventory']:hasEnoughOfItem('strawberries', 1) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'cokecut')
            local dish = exports['ev-taskbar']:taskBar(5000, 'Preparing Pancakes...')
            if dish == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('inventory:removeItem', 'whipped_cream', 1)
                TriggerEvent('inventory:removeItem', 'strawberries', 1)
                TriggerEvent('player:receiveItem', 'doki_doki_pancakes', 1)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

--// Deserts //--

RegisterInterfaceCallback('ev-jobs:uwuMakeCake', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        if exports['ev-inventory']:hasEnoughOfItem('chocolate_chips', 1) and exports['ev-inventory']:hasEnoughOfItem('flour', 1) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'cokecut')
            local dish = exports['ev-taskbar']:taskBar(5000, 'Preparing Chocolate Cake...')
            if dish == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('inventory:removeItem', 'chocolate_chips', 1)
                TriggerEvent('inventory:removeItem', 'flour', 1)
                TriggerEvent('player:receiveItem', 'chocolate_cake', 1)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

RegisterInterfaceCallback('ev-jobs:uwuMakeShortcake', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        if exports['ev-inventory']:hasEnoughOfItem('strawberries', 1) and exports['ev-inventory']:hasEnoughOfItem('flour', 1) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'cokecut')
            local dish = exports['ev-taskbar']:taskBar(5000, 'Preparing Short Cake...')
            if dish == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('inventory:removeItem', 'strawberries', 1)
                TriggerEvent('inventory:removeItem', 'flour', 1)
                TriggerEvent('player:receiveItem', 'strawberry_shortcake', 1)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

RegisterNetEvent('ev-jobs:uwuCafeFridge', function()
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        TriggerEvent("server-inventory-open", "999", "Shop")
    end
end)

exports["ev-polytarget"]:AddBoxZone("ev_uwu_fridge", vector3(-590.96, -1058.51, 22.34), 1, 1, {
    heading=0,
    --debugPoly=false,
    minZ=19.54,
    maxZ=23.54
})

 -- Food Shtuff
 exports["ev-interact"]:AddPeekEntryByPolyTarget("ev_uwu_fridge", {{
    event = "ev-jobs:uwuCafeFridge",
    id = "ev_uwu_fridge",
    icon = "circle",
    label = "Fridge",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

-- Drinks --

exports["ev-polytarget"]:AddCircleZone("ev_uwu_drinks", vector3(-586.95, -1061.92, 22.39), 0.5, {
    useZ=true,
})

 exports["ev-interact"]:AddPeekEntryByPolyTarget("ev_uwu_drinks", {{
    event = "ev-jobs:uwuCafeDrinks",
    id = "ev_uwu_drinks",
    icon = "circle",
    label = "Drinks",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('ev-jobs:uwuCafeDrinks')
AddEventHandler('ev-jobs:uwuCafeDrinks', function()
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        local pDrinkMachine = {
            {
                title = "Drinks",
                description = "Make a nice refreshing drink for the customer\'s.",
                children = {
                    {
                        title = "Make Bubble Tea",
                        action = "ev-jobs:MakeBubbleTea"
                    },
                    {
                        title = "Make Coffee",
                        action = "ev-jobs:MakeCoffee"
                    },
                    {
                        title = "Make Water",
                        action = "ev-jobs:MakeWater"
                    },
                }
            },
        }
        exports["ev-interface"]:showContextMenu(pDrinkMachine)
    end
end)

RegisterInterfaceCallback('ev-jobs:MakeBubbleTea', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        FreezeEntityPosition(PlayerPedId(), true)
        TriggerEvent('animation:PlayAnimation', 'cokecut')
        local finished = exports['ev-taskbar']:taskBar(5000, 'Pouring Bubble Tea')
        if finished == 100 then
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('player:receiveItem', 'bubbletea', 1)
        end
    end
end)

RegisterInterfaceCallback('ev-jobs:MakeCoffee', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        FreezeEntityPosition(PlayerPedId(), true)
        TriggerEvent('animation:PlayAnimation', 'cokecut')
        local finished = exports['ev-taskbar']:taskBar(5000, 'Pouring Coffee')
        if finished == 100 then
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('player:receiveItem', 'coffee', 1)
        end
    end
end)

RegisterInterfaceCallback('ev-jobs:MakeWater', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-business']:IsEmployedAt('uwu_cafe') then
        FreezeEntityPosition(PlayerPedId(), true)
        TriggerEvent('animation:PlayAnimation', 'cokecut')
        local finished = exports['ev-taskbar']:taskBar(5000, 'Pouring Water')
        if finished == 100 then
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('player:receiveItem', 'water', 1)
        end
    end
end)