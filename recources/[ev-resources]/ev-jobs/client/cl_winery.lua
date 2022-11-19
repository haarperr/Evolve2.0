exports["ev-polytarget"]:AddBoxZone("wash_money_bags",  vector3(-1869.77, 2065.76, 135.55), 2, 2, {
    name="wash_money_bags",
    heading=0,
    --debugPoly=false,
    minZ=132.75,
    maxZ=136.75
})

RegisterNetEvent('ev-winery:cleanBags')
AddEventHandler('ev-winery:cleanBags', function()
    if exports['ev-business']:IsEmployedAt('winery') then
        exports['ev-interface']:openApplication('textbox', {
            callbackUrl = 'ev-winery:Input',
            key = 1,
            items = {
            {
                icon = "link",
                label = "How many bags.",
                name = "pBagAmt",
            },
            },
            show = true,
        })
    end
end)

RegisterNetEvent('ev-winery:cleanNotes')
AddEventHandler('ev-winery:cleanNotes', function()
    if exports['ev-business']:IsEmployedAt('winery') then
        exports['ev-interface']:openApplication('textbox', {
            callbackUrl = 'ev-winery:InputNotes',
            key = 1,
            items = {
            {
                icon = "link",
                label = "How many rolls.",
                name = "pBagAmt",
            },
            },
            show = true,
        })
    end
end)

RegisterInterfaceCallback('ev-winery:Input', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-business']:IsEmployedAt('winery') then
        if exports['ev-inventory']:hasEnoughOfItem('inkset', data.values.pBagAmt) then
            TriggerEvent('inventory:removeItem', 'inkset', data.values.pBagAmt)
            TriggerServerEvent('ev-jobs:givePayout', data.values.pBagAmt*math.random(180, 250), 'cash', 'Winery Cleaning '..data.values.pBagAmt..'x Inked Money Bags.')
        end
    end
end)

RegisterInterfaceCallback('ev-winery:InputNotes', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['ev-business']:IsEmployedAt('winery') then
        if exports['ev-inventory']:hasEnoughOfItem('rollcash', data.values.pBagAmt) then
            TriggerEvent('inventory:removeItem', 'rollcash', data.values.pBagAmt)
            TriggerServerEvent('ev-jobs:givePayout', data.values.pBagAmt*math.random(120, 200), 'cash', 'Winery Cleaning '..data.values.pBagAmt..'x Rolls Of Cash.')
        end
    end
end)

exports["ev-interact"]:AddPeekEntryByPolyTarget("wash_money_bags", {{
    event = "ev-winery:cleanBags",
    id = "wash_money_bags",
    icon = "circle",
    label = "Wash Bags",
    parameters = {},
}}, {
    distance = { radius = 5 },
});

exports["ev-interact"]:AddPeekEntryByPolyTarget("wash_money_bags", {{
    event = "ev-winery:cleanNotes",
    id = "wash_money_notes",
    icon = "circle",
    label = "Wash Notes",
    parameters = {},
}}, {
    distance = { radius = 5 },
});

-- // Stash // --

exports["ev-polytarget"]:AddBoxZone("mmmm", vector3(-1871.03, 2059.12, 135.44), 2, 1.2, {
    heading=0,
    minZ=132.04,
    maxZ=136.04
})

 exports["ev-interact"]:AddPeekEntryByPolyTarget("mmmm", {{
    event = "ev-jobs:wineryStash",
    id = "mmmm",
    icon = "box",
    label = "Stash",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('ev-jobs:wineryStash')
AddEventHandler('ev-jobs:wineryStash', function()
    TriggerEvent('server-inventory-open', '1', 'stash-winery')

end)