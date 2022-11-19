RegisterServerEvent("ev-baycity:getGetDoorStateSV")
AddEventHandler("ev-baycity:getGetDoorStateSV", function()
    TriggerClientEvent('ev-baycity:getDoorCheckCL', -1, doorCheckbaycity)
end)

RegisterServerEvent("ev-particleserverbaycity")
AddEventHandler("ev-particleserverbaycity", function(method)
    TriggerClientEvent("ev-ptfxparticlebaycity", -1, method)
end)

RegisterServerEvent("ev-particleserverbaycity1")
AddEventHandler("ev-particleserverbaycity1", function(method)
    TriggerClientEvent("ev-ptfxparticlebaycity1", -1, method)
end)
