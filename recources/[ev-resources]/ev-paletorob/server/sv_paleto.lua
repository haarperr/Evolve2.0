Doors = {
    ["P1"] = {{loc = vector3(-105.41538238525, 6471.6791992188, 31.621948242188), txtloc = vector3(-105.41538238525, 6471.6791992188, 31.621948242188), state = nil, locked = true}},
}

RegisterServerEvent("ev-paleto:startcheck")
AddEventHandler("ev-paleto:startcheck", function(bank)
    local src = source

    if not Paleto.Banks[bank].onaction == true then
        if (os.time() - Paleto.cooldown) > Paleto.Banks[bank].lastrobbed then
            Paleto.Banks[bank].onaction = true
            TriggerClientEvent("ev-paleto:outcome", src, true, bank)
            TriggerClientEvent("ev-paleto:policenotify", -1, bank)
        else
            TriggerClientEvent("ev-paleto:outcome", src, false, "This bank recently robbed. You need to wait "..math.floor((Paleto.cooldown - (os.time() - Paleto.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((Paleto.cooldown - (os.time() - Paleto.Banks[bank].lastrobbed)), 60))
        end
    else
        TriggerClientEvent("ev-paleto:outcome", src, false, "This bank is currently being robbed.")
    end
end)

RegisterCommand("testy", function()
    local src = source
    local reward = math.random(Paleto.mincash, Paleto.maxcash)
	
	if Paleto.blackmoney then
        TriggerClientEvent("player:receiveItem", src, "markedbills", 1)
        -- Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(4500, 7000)})
    else
        if Paleto.blackmoney then
            TriggerClientEvent("player:receiveItem", src, "markedbills", 1)
            -- Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(4500, 7000)})
        end
    end
end)

RegisterServerEvent("ev-paleto:lootup")
AddEventHandler("ev-paleto:lootup", function(var, var2)
    TriggerClientEvent("ev-paleto:lootup_c", -1, var, var2)
end)

RegisterServerEvent("ev-paleto:toggleVault")
AddEventHandler("ev-paleto:toggleVault", function(key, state)
    Doors[key][1].locked = state
    TriggerClientEvent("ev-paleto:toggleVault", -1, key, state)
end)

RegisterServerEvent("ev-paleto:updateVaultState")
AddEventHandler("ev-paleto:updateVaultState", function(key, state)
    Doors[key][1].state = state
end)

RegisterServerEvent("ev-paleto:startLoot")
AddEventHandler("ev-paleto:startLoot", function(data, name, players)
    local src = source

    for i = 10, #players, 10 do
        TriggerClientEvent("ev-paleto:startLoot_c", players[i], data, name)
    end
    TriggerClientEvent("ev-paleto:startLoot_c", src, data, name)
end)

RegisterServerEvent("ev-paleto:stopHeist")
AddEventHandler("ev-paleto:stopHeist", function(name)
    TriggerClientEvent("ev-paleto:stopHeist_c", -1, name)
end)

RegisterServerEvent("ev-paleto:rewardCash")
AddEventHandler("ev-paleto:rewardCash", function()
    local src = source
    local reward = math.random(Paleto.mincash, Paleto.maxcash)
	
	if Paleto.blackmoney then
        TriggerClientEvent("player:receiveItem", src, "markedbills", 250)
    else
        TriggerClientEvent("player:receiveItem", src, "markedbills", 425)
    end
end)

RegisterServerEvent("ev-paleto:setCooldown")
AddEventHandler("ev-paleto:setCooldown", function(name)
    Paleto.Banks[name].lastrobbed = os.time()
    Paleto.Banks[name].onaction = false
    TriggerClientEvent("ev-paleto:resetDoorState", -1, name)
end)

RPC.register("ev-paleto:getBanks", function(source)
    return Paleto.Banks, Doors
end)

 RegisterCommand("aan", function()
     TriggerClientEvent('ev-paleto:UseGreenLapTop', source)
 end)

-- RegisterServerEvent('rick:removeLaptop')
-- AddEventHandler('rick:removeLaptop', function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     Player.Functions.RemoveItem('green-laptop', 1)
-- end)


local doorCheckPaleto = false

RegisterServerEvent("ev-paleto:getGetDoorStateSV")
AddEventHandler("ev-paleto:getGetDoorStateSV", function()
    TriggerClientEvent('ev-paleto:getDoorCheckCL', -1, doorCheckPaleto)
end)

RegisterServerEvent("ev-paleto:getGetDoorStateSVSV")
AddEventHandler("ev-paleto:getGetDoorStateSVSV", function(paletoBanksDoors)
    doorCheckPaleto = paletoBanksDoors
end)

RegisterServerEvent("ev-paleto:openDoor")
AddEventHandler("ev-paleto:openDoor", function(coords, method)
    TriggerClientEvent("ev-paleto:OpenPaletoDoor", -1)
end)

RegisterServerEvent("ev-paleto:closeDoor")
AddEventHandler("ev-paleto:closeDoor", function(coords, method)
    TriggerClientEvent("ev-paleto:ClosePaletoDoor", -1)
end)