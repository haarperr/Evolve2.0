RegisterServerEvent("ev-dirtymoney:attemptDirtyMoneyDrops")
AddEventHandler("ev-dirtymoney:attemptDirtyMoneyDrops", function()
	local src = source
	local user = exports["ev-base"]:getModule("Player"):GetUser(src)
	local DirtyMoney = user:getDirtyMoney()

	if DirtyMoney > 500 then
		TriggerClientEvent("ev-dirtymoney:attemptDirtyMoneyDrops",source)
		DirtyMoney = DirtyMoney - 500
		user:alterDirtyMoney(DirtyMoney)

		TriggerClientEvent('UPV',src,500)
	else
		TriggerClientEvent("DoLongHudText",source,"You need $500 in Marked Bills.",2)
	end

end)

RegisterServerEvent("ev-dirtymoney:alterDirtyMoney")
AddEventHandler("ev-dirtymoney:alterDirtyMoney", function(reason, amount)
	local src = source
	local user = exports["ev-base"]:getModule("Player"):GetUser(src)
	local DirtyMoney = user:getDirtyMoney()

	if reason == "ItemDrop" then
		TriggerClientEvent("ev-dirtymoney:attemptDirtyMoneyDrops",source)
		DirtyMoney = DirtyMoney - amount
		user:alterDirtyMoney(DirtyMoney)

		TriggerClientEvent('UPV',src,amount)
	else
		DirtyMoney = DirtyMoney + amount
		user:alterDirtyMoney(DirtyMoney)
	end

end)

RegisterServerEvent("ev-dirtymoney:moneyPickup")
AddEventHandler("ev-dirtymoney:moneyPickup", function(amount)
	local src = source
	local user = exports["ev-base"]:getModule("Player"):GetUser(src)
	user:addMoney((amount))
end)