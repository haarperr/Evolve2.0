RegisterNetEvent('ev-jobs:burgershot-warmer')
AddEventHandler('ev-jobs:burgershot-warmer', function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        TriggerEvent("server-inventory-open", "1", "storage-burger_warmer")
        Wait(1000)
    else
        TriggerEvent('DoLongHudText', 'You do not work here !',2)
    end
end)

RegisterNetEvent("ev-burgershot:startfryer")
AddEventHandler("ev-burgershot:startfryer", function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['ev-inventory']:hasEnoughOfItem('potato', 1) then
            local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
            local finished = exports['ev-taskbar']:taskBar(10000, 'Dropping Fries')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'fries', 1)
                TriggerEvent('inventory:removeItem', 'potato', 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', "You need more patato's (Required Amount: x1)", 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent("ev-burgershot:makeshake")
AddEventHandler("ev-burgershot:makeshake", function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['ev-inventory']:hasEnoughOfItem('milk', 1) then
        SetEntityHeading(GetPlayerPed(-1), 121.88976287842)
        TriggerEvent("animation:PlayAnimation","browse")
        FreezeEntityPosition(GetPlayerPed(-1),true)
        local finished = exports['ev-taskbar']:taskBar(10000, 'Making Shake')
        if (finished == 100) then
            TriggerEvent('inventory:removeItem', 'milk', 1)
            TriggerEvent('player:receiveItem', 'mshake', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
            TriggerEvent("animation:PlayAnimation","layspike")
            Citizen.Wait(1000)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        TriggerEvent('DoLongHudText',"You need milk (Required Amount: x1)",2)
    end
else
    TriggerEvent('DoLongHudText', 'You dont work here', 2)
end
end)


RegisterNetEvent("ev-burgershot:soft-drink")
AddEventHandler("ev-burgershot:soft-drink", function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then   
        if exports['ev-inventory']:hasEnoughOfItem('burgershot_cup', 1) then
        SetEntityHeading(GetPlayerPed(-1), 121.88976287842)
        TriggerEvent("animation:PlayAnimation","browse")
        FreezeEntityPosition(GetPlayerPed(-1),true)
        local finished = exports['ev-taskbar']:taskBar(10000, 'Making Soft Drink')
        if (finished == 100) then
            TriggerEvent('player:receiveItem', 'softdrink', 1)
            TriggerEvent('inventory:removeItem', 'burgershot_cup', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        TriggerEvent('DoLongHudText',"Required Ingridients: 1x Sugar | 1x Empty Burgershot Cup",2)
    end
else
    TriggerEvent('DoLongHudText', 'You dont work here', 2)
end
end)

RegisterNetEvent("ev-burgershot:getcola")
AddEventHandler("ev-burgershot:getcola", function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then  
        if exports['ev-inventory']:hasEnoughOfItem('sugarbs', 1) then  
        SetEntityHeading(GetPlayerPed(-1), 121.88976287842)
        TriggerEvent("animation:PlayAnimation","browse")
        FreezeEntityPosition(GetPlayerPed(-1),true)
        local finished = exports['ev-taskbar']:taskBar(10000, 'Pouring Cola')
        if (finished == 100) then
            TriggerEvent('player:receiveItem', 'cola', 1)
            TriggerEvent('inventory:removeItem', 'sugarbs', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
            TriggerEvent("animation:PlayAnimation","layspike")
            Citizen.Wait(1000)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        TriggerEvent('DoLongHudText',"You need more sugar (Required Amount: x1)",2)
    end
else
    TriggerEvent('DoLongHudText', 'You dont work here', 2)
end
end)

RegisterNetEvent('ev-burgershot:get_water')
AddEventHandler('ev-burgershot:get_water', function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        SetEntityHeading(GetPlayerPed(-1), 121.88976287842)
        TriggerEvent("animation:PlayAnimation","browse")
        FreezeEntityPosition(GetPlayerPed(-1),true)
        local finished = exports['ev-taskbar']:taskBar(10000, 'Pouring Water')
        if (finished == 100) then
            TriggerEvent('player:receiveItem', 'water', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
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

--// Counter

RegisterNetEvent('ev-burgershot:counter')
AddEventHandler('ev-burgershot:counter', function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
		TriggerEvent("server-inventory-open", "1", "counter-burger_shot")
		Wait(1000)
else
    TriggerEvent('DoLongHudText', 'You do not work here !',2)
    end
end)

--// Store

RegisterNetEvent('ev-burgershot:store')
AddEventHandler('ev-burgershot:store', function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        TriggerEvent("server-inventory-open", "45", "Shop")
		Wait(1000)
    else
        TriggerEvent('DoLongHudText', 'You do not work here !',2)
        end
    end)

--// Make Burgers

RegisterNetEvent('ev-civjobs:burgershot-heartstopper')
AddEventHandler('ev-civjobs:burgershot-heartstopper', function()
    local ped = PlayerPedId()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['ev-inventory']:hasEnoughOfItem('burgershotpatty', 2) and exports['ev-inventory']:hasEnoughOfItem('lettuce', 1) and exports['ev-inventory']:hasEnoughOfItem('hamburgerbuns', 1) and exports['ev-inventory']:hasEnoughOfItem('tomato', 1) and exports['ev-inventory']:hasEnoughOfItem('cheese', 1) then
            FreezeEntityPosition(ped, true)
            ExecuteCommand('e cokecut')
            local heartstopper = exports['ev-taskbar']:taskBar(5000, 'Cooking Heartstopper')
            if (heartstopper == 100) then
                FreezeEntityPosition(ped, false)
                TriggerEvent('inventory:removeItem', 'hamburgerbuns', 1) 
                TriggerEvent('inventory:removeItem', 'burgershotpatty', 2) 
                TriggerEvent('inventory:removeItem', 'lettuce', 1) 
                TriggerEvent('inventory:removeItem', 'tomato', 1)
                TriggerEvent('inventory:removeItem', 'cheese', 1)
                TriggerEvent('player:receiveItem', 'heartstopper', 1)
                TriggerEvent('DoLongHudText', 'Cooked Heartstopper', 1)
            else
                FreezeEntityPosition(ped, false)
            end
        else
            TriggerEvent('DoLongHudText', 'Requires: 1x Burger Buns | 2x Cooked Burger Pattys | 1x Lettuce | 1x Tomato | 1x Cheese', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent('ev-civjobs:burgershot-moneyshot')
AddEventHandler('ev-civjobs:burgershot-moneyshot', function()
    local ped = PlayerPedId()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['ev-inventory']:hasEnoughOfItem('hamburgerbuns', 1) and exports['ev-inventory']:hasEnoughOfItem('burgershotpatty', 1) and exports['ev-inventory']:hasEnoughOfItem('lettuce', 1) and exports['ev-inventory']:hasEnoughOfItem('tomato', 1) and exports['ev-inventory']:hasEnoughOfItem('cheese', 1) then
            FreezeEntityPosition(ped, true)
            ExecuteCommand('e cokecut')
            local moneyshot = exports['ev-taskbar']:taskBar(5000, 'Cooking Moneyshot')
            if (moneyshot == 100) then
                FreezeEntityPosition(ped, false)
                TriggerEvent('inventory:removeItem', 'hamburgerbuns', 1)
                TriggerEvent('inventory:removeItem', 'burgershotpatty', 1)
                TriggerEvent('inventory:removeItem', 'lettuce', 1)
                TriggerEvent('inventory:removeItem', 'tomato', 1)
                TriggerEvent('inventory:removeItem', 'cheese', 1)
                TriggerEvent('player:receiveItem', 'moneyshot', 1)
                TriggerEvent('DoLongHudText', 'Cooked Moneyshot', 1)
            else
                FreezeEntityPosition(ped, false)
            end
        else
            TriggerEvent('DoLongHudText', 'Requires: 1x Burger Buns | 1x Cooked Burger Patty | 1x Cheese | 1x Lettuce | 1x Tomato', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent('ev-civjobs:burgershot-meatfree')
AddEventHandler('ev-civjobs:burgershot-meatfree', function()
    local ped = PlayerPedId()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['ev-inventory']:hasEnoughOfItem('burgershotpatty2', 1) and exports['ev-inventory']:hasEnoughOfItem('lettuce', 1) and exports['ev-inventory']:hasEnoughOfItem('hamburgerbuns', 1) then
            FreezeEntityPosition(ped, true)
            ExecuteCommand('e cokecut')
            local meatfree = exports['ev-taskbar']:taskBar(5000, 'Cooking Meat Free')
            if (meatfree == 100) then
                FreezeEntityPosition(ped, false)
                TriggerEvent('inventory:removeItem', 'lettuce', 1)
                TriggerEvent('inventory:removeItem', 'hamburgerbuns', 1)
                TriggerEvent('inventory:removeItem', 'burgershotpatty2', 1)
                TriggerEvent('player:receiveItem', 'meatfree', 1)
            else
                FreezeEntityPosition(ped, false)
            end
        else
            TriggerEvent('DoLongHudText', 'Requires: 1x Burger Buns | 1x Lettuce | 1x Cooked Meat Free Patty', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)  

RegisterNetEvent('ev-civjobs:burgershot-bleeder')
AddEventHandler('ev-civjobs:burgershot-bleeder', function()
    local ped = PlayerPedId()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['ev-inventory']:hasEnoughOfItem('hamburgerbuns', 1) and exports['ev-inventory']:hasEnoughOfItem('lettuce', 1) and exports['ev-inventory']:hasEnoughOfItem('burgershotpatty', 1) and exports['ev-inventory']:hasEnoughOfItem('cheese', 1) and exports['ev-inventory']:hasEnoughOfItem('tomato', 1) then
            FreezeEntityPosition(ped, true)
            ExecuteCommand('e cokecut')
            local meatfree = exports['ev-taskbar']:taskBar(5000, 'Cooking Bleeder Burger')
            if (meatfree == 100) then
                FreezeEntityPosition(ped, false)
                TriggerEvent('inventory:removeItem', 'lettuce', 1)
                TriggerEvent('inventory:removeItem', 'hamburgerbuns', 1)
                TriggerEvent('inventory:removeItem', 'burgershotpatty', 1)
                TriggerEvent('inventory:removeItem', 'tomato', 1)
                TriggerEvent('inventory:removeItem', 'cheese', 1)
                TriggerEvent('player:receiveItem', 'bleederburger', 1)
            else
                FreezeEntityPosition(ped, false)
            end
        else
            TriggerEvent('DoLongHudText', 'Requires: 1x Lettuce | 1x Patty | 1x Burger Buns', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)  

-- // Drink Machine Start // --

RegisterNetEvent('ev-jobs:burgershot-drinks')
AddEventHandler('ev-jobs:burgershot-drinks', function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        local BurgershotDrinks = {
            {
                title = 'Burger Shot Drinks',
                icon = "glass-whiskey"
            },
            {
                title = "Pour Cola",
                description = "Pour a nice refreshing Cola",
                icon = "beer",
                action = 'ev-burgershot:cola',
            },
            {
                title = "Pour Milkshake",
                description = "Pour a Ice Cold Milkshake",
                icon = "beer",
                action = 'ev-burgershot:shake',
            },
            {
                title = "Pour Soft Drink",
                description = "Pour a monsterous sweet Soft Drink",
                icon = "beer",
                action = 'ev-burgershot:drink',
            },
            {
                title = "Pour Cup Of Water",
                description = "Pour a Cup Of Water",
                icon = "beer",
                action = 'ev-burgershot:water',
            },
        }
        exports["ev-interface"]:showContextMenu(BurgershotDrinks)
    else
        TriggerEvent('DoLongHudText', 'Fuck off POLITELY', 2)
    end
end)

RegisterInterfaceCallback('ev-burgershot:cola', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-burgershot:getcola')
end)

RegisterInterfaceCallback('ev-burgershot:shake', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-burgershot:makeshake')
end)

RegisterInterfaceCallback('ev-burgershot:drink', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-burgershot:soft-drink')
end)

RegisterInterfaceCallback('ev-burgershot:water', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-burgershot:get_water')
end)

-- // Drink Machine End // --

-- // Start Of Burgers // --

RegisterNetEvent('ev-civjobs:burgershot-make-burgers')
AddEventHandler('ev-civjobs:burgershot-make-burgers', function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        local BurgershotBurgers = {
            {
                title = 'Burger Shot Burgers',
                icon = "utensils"
            },
            {
                title = "Assemble Heartstopper",
                icon = "hamburger", 
                action = 'ev-burgershot:hs',
            },
            {
                title = "Assemble Moneyshot",
                icon = "hamburger", 
                action = 'ev-burgershot:ms',
            },
            {
                title = "Assemble Meat Free Burger",
                icon = "hamburger", 
                action = 'ev-burgershot:mf',
            },
            {
                title = "Assemble Bleeder Burger",
                icon = "hamburger", 
                action = 'ev-burgershot:bb',
            },
        }
        exports["ev-interface"]:showContextMenu(BurgershotBurgers)
    else
        TriggerEvent('DoLongHudText', 'Fuck off POLITELY', 2)
    end
end)

RegisterInterfaceCallback('ev-burgershot:hs', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-civjobs:burgershot-heartstopper')
end)

RegisterInterfaceCallback('ev-burgershot:ms', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-civjobs:burgershot-moneyshot')
end)

RegisterInterfaceCallback('ev-burgershot:mf', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-civjobs:burgershot-meatfree')
end)

RegisterInterfaceCallback('ev-burgershot:bb', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-civjobs:burgershot-bleeder')
end)

--// Meat No Meat?

RegisterNetEvent('ev-civjobs:burgershot-make-pattys')
AddEventHandler('ev-civjobs:burgershot-make-pattys', function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        local BurgershotPattys = {
            {
                title = 'Burger Shot Pattys',
            },
            {
                title = "Cook Patty (Contains Meat)",
                description = "Requires: 1x Raw Patty (Contains Meat)",
                key = "CP.M",
                action = 'ev-burgershot:cm',
            },
            {
                title = "Cook Patty (Doesnt Contain Meat)",
                description = "Requires: 1x Raw Patty (Doesnt Contain Meat)",
                key = "CP.NM",
                action = 'ev-burgershot:dcm',
            },
        }
        exports["ev-interface"]:showContextMenu(BurgershotPattys)
    else
        TriggerEvent('DoLongHudText', 'Fuck off POLITELY', 2)
    end
end)

RegisterInterfaceCallback('ev-burgershot:cm', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-burgershot:contains-meat')
end)

RegisterInterfaceCallback('ev-burgershot:dcm', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('ev-burgershot:doesnt-contains-meat')
end)

RegisterNetEvent("ev-burgershot:contains-meat")
AddEventHandler("ev-burgershot:contains-meat", function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports["ev-inventory"]:hasEnoughOfItem("rawpatty", 1) then 
            local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
            local finished = exports['ev-taskbar']:taskBar(7500, 'Cooking Patty')
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "rawpatty", 1)
                TriggerEvent('player:receiveItem', 'burgershotpatty', 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You need more Raw Pattys to cook! (Required Amount: 1)', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent("ev-burgershot:doesnt-contains-meat")
AddEventHandler("ev-burgershot:doesnt-contains-meat", function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then   
        if exports["ev-inventory"]:hasEnoughOfItem("rawpatty2", 1) then 
            local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
            local finished = exports['ev-taskbar']:taskBar(7500, 'Cooking Patty')
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "rawpatty2", 1)
                TriggerEvent('player:receiveItem', 'burgershotpatty2', 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You need more Raw Pattys to cook! (Required Amount: 1)', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent('ev-burgershot:gettoy')
AddEventHandler('ev-burgershot:gettoy', function()
    local BurgershotToy = math.random(10)
    if BurgershotToy == 1 then
        TriggerEvent('player:receiveItem', 'larrybirdtoy', 1)
    elseif BurgershotToy == 2 then
        TriggerEvent('player:receiveItem', 'tatumtoy', 1)
    elseif BurgershotToy == 3 then
        TriggerEvent('player:receiveItem', 'klaytoy', 1)
    elseif BurgershotToy == 4 then
        TriggerEvent('player:receiveItem', 'currytoy', 1)
    elseif BurgershotToy == 5 then
        TriggerEvent('player:receiveItem', 'strangetoy', 1)
    elseif BurgershotToy == 6 then
        TriggerEvent('player:receiveItem', 'woodytoy', 1)
    elseif BurgershotToy == 7 then
        TriggerEvent('player:receiveItem', 'joinwicktoy', 1)
    elseif BurgershotToy == 8 then
        TriggerEvent('player:receiveItem', 'eletoy', 1)
    elseif BurgershotToy == 9 then
        TriggerEvent('player:receiveItem', 'captoy', 1)
    elseif BurgershotToy == 10 then
        TriggerEvent('player:receiveItem', 'supermantoy', 1)
    end
end)

RegisterNetEvent("ev-icecream")
AddEventHandler("ev-icecream", function()
    local isEmployed = exports["ev-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports["ev-inventory"]:hasEnoughOfItem("icecreamcone", 1) then 
            local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 302.72439575195)
            local finished = exports['ev-taskbar']:taskBar(7500, 'Scooping')
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "icecreamcone", 1)
                TriggerEvent('player:receiveItem', 'vanillaicecream', 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You need more Ice Cream Cone!', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent('grabtoybs')
AddEventHandler('grabtoybs', function()
    TriggerEvent('player:receiveItem', 'bstoy', 1)
end)

 -- Interact --
 
 exports["ev-polytarget"]:AddBoxZone("burgershot_assemble", vector3(-1198.33, -898.61, 13.98), 1, 1.8, {
    heading=35,
    minZ=10.38,
    maxZ=14.38
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("burgershot_assemble", {{
    event = "ev-civjobs:burgershot-make-burgers",
    id = "burgershot_assemble",
    icon = "hand-holding",
    label = "Assemble Burger",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

exports["ev-polytarget"]:AddBoxZone("burgershot_stash", vector3(-1203.65, -895.86, 13.98), 1, 1.6, {
    heading=305,
    --debugPoly=false,
    minZ=11.38,
    maxZ=15.38
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("burgershot_stash", {
    {
        event = "ev-burgershot:store",
        id = "burgershot_stash",
        icon = "circle",
        label = "Get Ingridients",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

exports["ev-polytarget"]:AddBoxZone("ev_burgershot_make_drinks", vector3(-1199.87, -895.3, 13.98), 2, 1, {
    heading=35,
    minZ=10.98,
    maxZ=14.98
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("ev_burgershot_make_drinks", {{
    event = "ev-jobs:burgershot-drinks",
    id = "ev_burgershot_make_drinks",
    icon = "circle",
    label = "Drink Machine",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

exports["ev-polytarget"]:AddBoxZone("burgershot_warmer",  vector3(-1197.84, -893.96, 13.98), 3.0, 1, {
    minZ=13.58,
    maxZ=14.78
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("burgershot_warmer", {
    {
        event = "ev-jobs:burgershot-warmer",
        id = "void_burgershot_warmer",
        icon = "circle",
        label = "Food Warmer",
        parameters = {},
    },
    {
        event = "ev-dispatch:burgershotAlarm",
        id = "Panic",
        icon = "bell",
        label = "Panic Button",
        parameters = {},
    },
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('ev-dispatch:burgershotAlarm')
AddEventHandler('ev-dispatch:burgershotAlarm', function()
    if exports['ev-business']:IsEmployedAt('burger_shot') then
        exports["ev-dispatch"]:policedead('10-13A', "Burgershot Panic Alarm", "59", true)
    end
end)

exports["ev-polytarget"]:AddCircleZone("burgershot_fryer",  vector3(-1201.79, -898.58, 13.98), 0.65, {
    useZ = true
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("burgershot_fryer", {{
    event = "ev-burgershot:startfryer",
    id = "burgershot_fryer",
    icon = "circle",
    label = "Make Fries",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

exports["ev-polytarget"]:AddBoxZone("burgershot_stash", vector3(-1203.65, -895.86, 13.98), 1, 1.6, {
    heading=305,
    --debugPoly=false,
    minZ=11.38,
    maxZ=15.38
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("burgershot_stash", {
    {
        event = "ev-burgershot:store",
        id = "burgershot_stash",
        icon = "circle",
        label = "Get Ingridients",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

exports["ev-polytarget"]:AddCircleZone("burgershot_stuffs_4",  vector3(-1202.89, -897.28, 14.0), 0.93, {
    useZ = true
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("burgershot_stuffs_4", {{
    event = "ev-civjobs:burgershot-make-pattys",
    id = "burgershot_stuffs_4",
    icon = "hamburger",
    label = "Grill Patty",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

exports["ev-polytarget"]:AddCircleZone("gettoybs",  vector3(-1196.27, -905.06, 13.98), 0.4, {
    useZ = true
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("gettoybs", {
    {
        event = "grabtoybs",
        id = "gettoybs",
        icon = "circle",
        label = "Grab Toy!",
        parameters = {},
    },
}, {
    distance = { radius = 2.5 },
});

exports["ev-polytarget"]:AddBoxZone("icecreamspot",  vector3(-1193.03, -895.87, 13.98), 1, 2.0, {
    heading=305,
    --debugPoly=false,
    minZ=10.58,
    maxZ=14.58
})

exports["ev-interact"]:AddPeekEntryByPolyTarget("icecreamspot", {
    {
        event = "ev-icecream",
        id = "icecreamspot",
        icon = "circle",
        label = "Scoop Ice Cream!",
        parameters = {},
    },
}, {
    distance = { radius = 5 },
});

-- Trays --

exports["ev-polytarget"]:AddBoxZone("burger_shot_tray_1", vector3(-1193.83, -894.44, 13.98), 1, 0.8, {
    heading=305,
    minZ=10.78,
    maxZ=14.78
})

exports["ev-polytarget"]:AddBoxZone("burger_shot_tray_2", vector3(-1194.92, -892.86, 13.98), 1, 0.8, {
    heading=305,
    minZ=10.78,
    maxZ=14.78
})

 -- Tray 1
 exports["ev-interact"]:AddPeekEntryByPolyTarget("burger_shot_tray_1", {{
    event = "ev-jobs:BurgerShotTray-1",
    id = "burger_shot_tray_1",
    icon = "hand-holding",
    label = "Open",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

-- Tray 2
exports["ev-interact"]:AddPeekEntryByPolyTarget("burger_shot_tray_2", {{
    event = "ev-jobs:BurgerShotTray-2",
    id = "burger_shot_tray_2",
    icon = "hand-holding",
    label = "Open",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('ev-jobs:BurgerShotTray-1')
AddEventHandler('ev-jobs:BurgerShotTray-1', function()
    TriggerEvent("server-inventory-open", "1", "traysz-Burgershot Tray")
end)

RegisterNetEvent('ev-jobs:BurgerShotTray-2')
AddEventHandler('ev-jobs:BurgerShotTray-2', function()
    TriggerEvent("server-inventory-open", "1", "trays-Burgershot Tray")
end)