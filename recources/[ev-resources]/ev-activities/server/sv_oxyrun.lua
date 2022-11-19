RegisterServerEvent('spawn-car', function()
    TriggerClientEvent('spawn-car-client', source)
end)

RegisterNetEvent('car-found', function()
    TriggerClientEvent('generate-ped-loc', source)
end)

RegisterServerEvent('started-job', function()
    -- local message = 'Find and steal a vehicle to use as transport.'
    -- exports['destiny-phone']:SendMailToPlayer(source, 'OxyRun', 'Unknown User', message)
    TriggerClientEvent('start-job', source)
end)

RegisterServerEvent('started-job', function()
    -- local message = 'Go to the supplier and ask for the goods.'
    -- exports['destiny-phone']:SendMailToPlayer(source, 'OxyRun', 'Unknown User', message)
    TriggerClientEvent('generate-ped-loc', source)
end)

RegisterServerEvent('all-collected', function()
    -- local message = 'Drive to the handoff location with the transport vehicle, wait for the customers and handoff the goods.'
    -- exports['destiny-phone']:SendMailToPlayer(source, 'OxyRun', 'Unknown User', message)
    TriggerClientEvent('generate-corner-loc', source)
end)

RegisterServerEvent('handoff-limit', function()
    -- local message = 'Go to the another handoff location with the transport vehicle, wait for the customers and handoff the goods.'
    -- exports['destiny-phone']:SendMailToPlayer(source, 'OxyRun', 'Unknown User', message)
    TriggerClientEvent('generate-new-corner-loc', source)
end)