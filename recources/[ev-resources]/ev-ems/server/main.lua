RegisterServerEvent('admin:revivePlayer')
AddEventHandler('admin:revivePlayer', function(target)
	if target ~= nil then
		TriggerClientEvent('admin:revivePlayerClient', target)
		TriggerClientEvent('ev-hospital:client:RemoveBleed', target) 
        TriggerClientEvent('ev-hospital:client:ResetLimbs', target)
	end
end)

RegisterServerEvent('ev-ems:heal')
AddEventHandler('ev-ems:heal', function(target)
	TriggerClientEvent('ev-ems:heal', target) 	
end)

RegisterServerEvent('ev-ems:heal2')
AddEventHandler('ev-ems:heal2', function(target)
	TriggerClientEvent('ev-ems:big', target)
end)