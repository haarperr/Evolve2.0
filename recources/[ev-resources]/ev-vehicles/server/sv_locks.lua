RegisterServerEvent('ev-keys:attemptLockSV')
AddEventHandler('ev-keys:attemptLockSV', function(targetVehicle, plate)
    TriggerClientEvent('ev-keys:attemptLock', source, targetVehicle, plate)
end)