RegisterServerEvent('ev-death:reviveSV')
AddEventHandler('ev-death:reviveSV', function(t)
	TriggerClientEvent('ev-death:revive', t)
    TriggerClientEvent('ev-hospital:client:RemoveBleed', t) 
    TriggerClientEvent('ev-hospital:client:ResetLimbs', t)
end)

RegisterServerEvent('ev-death:reviveSV2')
AddEventHandler('ev-death:reviveSV2', function()
	TriggerClientEvent('ev-death:revive', source)
end)

RegisterNetEvent('baseevents:onPlayerDied')
AddEventHandler('baseevents:onPlayerDied', function(killerId, data)
    local src = source
    local pSteamName = GetPlayerName(src)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    exports['ev-admin']:addPlayerLog('Player Died', GetPlayerIdentifier(src, 0), pSteamName..' ['..char.first_name..' '..char.last_name..'] died to '..killerId, char.id, 'None')
end)

RegisterNetEvent('baseevents:onPlayerKilled')
AddEventHandler('baseevents:onPlayerKilled', function(killerId, data)
    local src = source
    local pSteamName = GetPlayerName(src)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    print(json.encode(data))
    exports['ev-admin']:addPlayerLog('Player Killed', GetPlayerIdentifier(src, 0), pSteamName..' ['..char.first_name..' '..char.last_name..'] died to '..data.weaponhash, char.id, 'None')
end)