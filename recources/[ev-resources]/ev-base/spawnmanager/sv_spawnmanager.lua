DPX.SpawnManager = {}

RegisterServerEvent('ev-base:spawnInitialized')
AddEventHandler('ev-base:spawnInitialized', function()
    local src = source
    TriggerClientEvent('ev-base:spawnInitialized', src)
end)