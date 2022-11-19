RPC.register("ev-weed:startCorner", function(pSource, pCoords)
    return true
end)

RPC.register("ev-weed:cornerPed", function(pSource, pCoords, pPed, pVehicle)
    TriggerClientEvent("ev-weed:cornerPed", pSource, pPed, pCoords, pVehicle)
    return true
end)

RPC.register("ev-weed:cornerSyncHandoff", function(pSource, pCoords, pPed)
    TriggerClientEvent("ev-weed:cornerSyncHandoff", pSource, pPed)
    return true
end)

RPC.register("ev-weed:cornerSale", function(pSource, pCoords, pNetId, CurrentCornerZone, baggieInfo)
    local user = exports["ev-base"]:getModule("Player"):GetUser(pSource)
    TriggerClientEvent("inventory:removeItem", -1, "weedbaggie", 1)
        if math.random (1,5) < 3 then
            user:addMoney(math.random(450,2500))
        end
    return true
end)

RPC.register("ev-weed:prepareBaggies", function(pSource, pInfo)
    TriggerClientEvent("inventory:removeItem", -1, "emptybaggies", CornerConfig.BaggiesPerBrick)
    return true
end)

RPC.register("ev-weed:stopCorner", function(pSource)
    TriggerLatentClientEvent('ev-weed:cleanCornerPeds',pSource)
    return false
end)