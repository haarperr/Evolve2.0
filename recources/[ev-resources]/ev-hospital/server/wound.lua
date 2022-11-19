local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('ev-hospital:server:SyncInjuries')
AddEventHandler('ev-hospital:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)