RegisterServerEvent('ev-vehicles:ApplyNitrous')
AddEventHandler('ev-vehicles:ApplyNitrous', function()
     TriggerClientEvent("ev-nitro:client:placeNitro", source)
end) 

RegisterServerEvent('ev-nitro:server:particlefx')
AddEventHandler('ev-nitro:server:particlefx', function(veh)
     TriggerClientEvent('ev-nitro:client:particlefx', -1, veh)
end)

RegisterServerEvent('ev-nitro:server:particlefisfis')
AddEventHandler('ev-nitro:server:particlefisfis', function(type, veh)
     if type == 'fisfisacc' then
          TriggerClientEvent('ev-nitro:client:particlefisfis', -1, 'fisfisac', veh)
     elseif type == 'fisfiskapatt' then
          TriggerClientEvent('ev-nitro:client:particlefisfis', -1, 'fisfiskapat', veh)
     end
end)