RPC.register("ev-pets:getClosestPlayer", function(src, pPosition, pIgnore)
    local players = GetPlayers()
    local closest = 500.0
    local player = false

    for i, v in ipairs(players) do
        if not pIgnore[v] then
            local coords = GetEntityCoords(GetPlayerPed(v))
            local distance = #(pPosition - coords)

            if distance < closest then
                player = {
                    sid = v,
                    coords = coords,
                }
            end
        end
    end

    return player
end)

RPC.register("ev-pets:sniffTarget", function(src, pType, pId)
    local hasContraband = false
    local user = exports["ev-base"]:getModule("Player"):GetUser(src) 
    
    if pType == "ped" then
        local cid = user:getCurrentCharacter().id

        hasContraband = exports["ev-inventory"]:K9Sniff(cid)
    else
        hasContraband = exports["ev-inventory"]:K9SniffVehicle(pId)
    end

    return hasContraband
end)