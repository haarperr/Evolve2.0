local carBombTable = {}

RegisterNetEvent("ev-miscscripts:carbombs:removeBomb", function(pNetId)
    carBombTable[pNetId] = nil
end)

RegisterNetEvent("ev-usableprops:defusePhoneBomb", function(pNetId)
    carBombTable[pNetId] = nil
end)

RegisterNetEvent("ev-miscscripts:carbombs:foundBomb", function(pNetId, pMetaData)
    TriggerClientEvent("ev-miscscripts:carbombs:foundBombAll", -1, carBombTable[pMetaData.netId])
end)

RPC.register("ev-miscscripts:carbombs:addCarBomb", function(pSource, netId, minSpeed, ticksBeforeExplode, ticksForRemoval, gridSize, coloredSquares, timeToComplete)
    print(netId, minSpeed, ticksBeforeExplode, ticksForRemoval, gridSize, coloredSquares, timeToComplete)
    carBombTable[netId] = {
        carBombData = {
            minSpeed = minSpeed, 
            ticksBeforeExplode = ticksBeforeExplode, 
            ticksForRemoval = ticksForRemoval, 
            gridSize = gridSize, 
            coloredSquares = coloredSquares, 
            timeToComplete = timeToComplete,
            netId = netId,
            hasCarBomb = true,
        }
    }
end)

RPC.register("ev-miscscripts:carbombs:getCarBombDataFromNetID", function(pSource, netId)
    return carBombTable[netId]
end)

--[[ RPC.register("ev-usableprops:hasPhoneBomb", function(pSource, pNetId)
    print(pNetId)
    if carBombTable[pNetId] then
        return true
    end
    return false
end) ]]