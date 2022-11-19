function IsPlayerActive(pServerId)
    return exports['ev-infinity']:IsPlayerActive(pServerId)
end

function DoesPlayerExist(pServerId)
    return exports['ev-infinity']:DoesPlayerExist(pServerId)
end

function GetPlayerCoords(pServerId)
    return exports['ev-infinity']:GetPlayerCoords(pServerId)
end

function GetNetworkedCoords(pType, pNetId)
    return exports['ev-infinity']:GetNetworkedCoords(pType, pNetId)
end

function GetLocalEntity(pType, pNetId)
    return exports['ev-infinity']:GetLocalEntity(pType, pNetId)
end