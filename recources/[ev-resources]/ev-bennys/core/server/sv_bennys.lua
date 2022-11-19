local hmm = vehicleBaseRepairCost

RegisterServerEvent('ev-bennys:attemptPurchase')
AddEventHandler('ev-bennys:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    if type == "repair" then
        if user:getCash() >= hmm then
            user:removeMoney(hmm)
            TriggerClientEvent('ev-bennys:purchaseSuccessful', src)

            exports["ev-log"]:AddLog("Bennys", 
                src, 
                "Repair", 
                { amount = tostring(hmm) })
        else
            TriggerClientEvent('ev-bennys:purchaseFailed', src)
        end
    elseif type == "performance" then
        if user:getCash() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('ev-bennys:purchaseSuccessful', src)
            user:removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])

            exports["ev-log"]:AddLog("Bennys", 
                src, 
                "Performance", 
                { amount = tostring(vehicleCustomisationPrices[type].prices[upgradeLevel]) })
        else
            TriggerClientEvent('ev-bennys:purchaseFailed', src)
        end
    else
        if user:getCash() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('ev-bennys:purchaseSuccessful', src)
            user:removeMoney(vehicleCustomisationPrices[type].price)

            exports["ev-log"]:AddLog("Bennys", 
                src, 
                "Other", 
                { type = tostring(type), amount = tostring(vehicleCustomisationPrices[type].price) })
        else
            TriggerClientEvent('ev-bennys:purchaseFailed', src)
        end
    end
end)

RegisterServerEvent('ev-bennys:updateRepairCost')
AddEventHandler('ev-bennys:updateRepairCost', function(cost)
    hmm = cost
end)

RegisterServerEvent('ev-bennys:repairciv')
AddEventHandler('ev-bennys:repairciv', function(amount)
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    if (user:getCash() >= amount) then
        user:removeMoney(amount)
        TriggerClientEvent("bennys:civ:repair:cl", src)

        exports["ev-log"]:AddLog("Bennys", 
            src, 
            "Repair Civ", 
            { amount = tostring(amount) })
    end
end)

RegisterServerEvent('ev-bennys:payPublicBennys')
AddEventHandler('ev-bennys:payPublicBennys', function()
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)

    if user:getCash() >= 250 then
        user:removeMoney(250)
        TriggerClientEvent('ev-bennys:repairVeh', src)
        TriggerEvent('DoLongHudText', "You Have Been Charged For: $750!", 2)
    else
        TriggerClientEvent('DoLongHudText', src, 'You need $750', 2)
    end
end)
