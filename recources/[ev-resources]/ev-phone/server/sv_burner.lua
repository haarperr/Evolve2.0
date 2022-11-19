recentCalls = {}

RegisterNetEvent("ev-phone:sendRecentCalls", function(pRecentCalls, pCid)
    recentCalls[pCid] = pRecentCalls
end)

RPC.register("ev-phone:getRecentCallsByCid", function(pSource, pCid)
    return recentCalls[pCid]
end)

RPC.register("ev-phone:getRecentCallsByNumber", function(pSource, pNum)
    for k,v in pairs(recentCalls) do
        -- todo
    end
end)

RPC.register('ev-phone:getTextsFromNumber', function(pSource, pCid)
    local src = source
    local myNumber = getNumber(pCid)
    return getSMS(myNumber), myNumber
end)