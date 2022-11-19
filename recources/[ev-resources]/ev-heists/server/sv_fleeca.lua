cooldownglobal = 0
Available = true

RegisterServerEvent("ev-fleeca:startcheck")
AddEventHandler("ev-fleeca:startcheck", function(bank)
    local _source = source
    globalonaction = true
    TriggerClientEvent('inventory:removeItem', _source, 'hacklaptop', 1)
    TriggerClientEvent("ev-fleeca:outcome", _source, true, bank)
end)

RegisterServerEvent("ev-fleeca:TimePoggers")
AddEventHandler("ev-fleeca:TimePoggers", function()
    local _source = source
    TriggerClientEvent("ev-fleeca:outcome", _source, false, "A bank as been recently robbed. You need to wait "..math.floor((fleeca.cooldown - (os.time() - cooldownglobal)) / 60)..":"..math.fmod((fleeca.cooldown - (os.time() - cooldownglobal)), 60))
end)

RegisterServerEvent("ev-fleeca:DoorAccessPoggers")
AddEventHandler("ev-fleeca:DoorAccessPoggers", function()
    local _source = source
    TriggerClientEvent("ev-fleeca:outcome", _source, false, "There is a bank currently being robbed.")
end)

RegisterServerEvent("ev-fleeca:lootup")
AddEventHandler("ev-fleeca:lootup", function(var, var2)
    TriggerClientEvent("ev-fleeca:lootup_c", -1, var, var2)
end)

RegisterServerEvent("ev-fleeca:openDoor")
AddEventHandler("ev-fleeca:openDoor", function(coords, method)
    TriggerClientEvent("ev-fleeca:openDoor_c", -1, coords, method)
end)

RegisterServerEvent("ev-fleeca:startLoot")
AddEventHandler("ev-fleeca:startLoot", function(data, name)
    TriggerClientEvent("ev-fleeca:startLoot_c", -1, data, name)
end)

RegisterServerEvent("ev-fleeca:stopHeist")
AddEventHandler("ev-fleeca:stopHeist", function(name)
    TriggerClientEvent("ev-fleeca:stopHeist_c", -1, name)
end)

RegisterServerEvent("ev-fleeca:rewardCash")
AddEventHandler("ev-fleeca:rewardCash", function()
    local reward = math.random(1, 2)
    local mathfunc = math.random(200)
    local rare = math.random(1,1)
    
    if mathfunc == 15 then
      TriggerClientEvent('ev-user:receiveItem', source, 'heistusb4', 1)
    end
    TriggerClientEvent("ev-user:receiveItem", source, "band", reward)
end)

RegisterServerEvent("ev-fleeca:setCooldown")
AddEventHandler("ev-fleeca:setCooldown", function(name)
    cooldownglobal = os.time()
    globalonaction = false
    TriggerClientEvent("ev-fleeca:resetDoorState", -1, name)
end)

RegisterServerEvent("ev-fleeca:getBanksSV")
AddEventHandler("ev-fleeca:getBanksSV", function()
    local banks = fleeca.Banks
    TriggerClientEvent('ev-fleeca:getBanks', -1, fleeca.Banks)
end)

local cooldownAttempts = 5

RegisterServerEvent("ev-fleeca:getHitSV")
AddEventHandler("ev-fleeca:getHitSV", function()
    TriggerClientEvent('ev-fleeca:getHit', -1, cooldownAttempts)
end)

RegisterServerEvent("ev-fleeca:getHitSVSV")
AddEventHandler("ev-fleeca:getHitSVSV", function(fleecaBanksTimes)
    cooldownAttempts = fleecaBanksTimes
end)

local doorCheckFleeca = false

RegisterServerEvent("ev-fleeca:getGetDoorStateSV")
AddEventHandler("ev-fleeca:getGetDoorStateSV", function()
    TriggerClientEvent('ev-fleeca:getDoorCheckCL', -1, doorCheckFleeca)
end)

RegisterServerEvent("ev-fleeca:getGetDoorStateSVSV")
AddEventHandler("ev-fleeca:getGetDoorStateSVSV", function(fleecaBanksDoors)
    doorCheckFleeca = fleecaBanksDoors
end)


RegisterServerEvent("ev-fleeca:getTimeSV")
AddEventHandler("ev-fleeca:getTimeSV", function()
    TriggerClientEvent('ev-fleeca:GetTimeCL', -1, cooldownglobal)
end)

RegisterServerEvent("ev-fleeca:getTime2SV")
AddEventHandler("ev-fleeca:getTime2SV", function()
    TriggerClientEvent('ev-fleeca:GetTime2CL', -1, (os.time() - fleeca.cooldown))
end)

RegisterServerEvent("ev-fleeca:getDoorAccessSV")
AddEventHandler("ev-fleeca:getDoorAccessSV", function()
    TriggerClientEvent('ev-fleeca:GetDoorAccessCL', -1, globalonaction)
end)

RegisterServerEvent('charge:fleeca')
AddEventHandler('charge:fleeca', function(amount, bankname)
  local _source = source
  local user = exports["ev-base"]:getModule("Player"):GetUser(source)

    if user:getCash() >= amount then
        user:removeMoney(amount)
        TriggerClientEvent('aspect:bankemail', source, bankname)
    else
        TriggerClientEvent('DoLongHudText', source, 'You dont have enough money!', 2)
    end
end)

RegisterServerEvent('ev-robbery:server:setBankState')
AddEventHandler('ev-robbery:server:setBankState', function(bankId, state)
    if bankId == "pacific" then
       print('[QUEER]')
    else
        if not robberyBusy then
            Config.SmallBanks[bankId]["isOpened"] = state
            TriggerClientEvent('ev-robbery:client:setBankState', -1, bankId, state)
            TriggerEvent('ev-robbery:server:SetSmallbankTimeout', bankId)
            TriggerEvent('aspect:bankstore', bankId, state)
        end
    end
    robberyBusy = true
end)

RegisterServerEvent('ev-robbery:server:SetSmallbankTimeout')
 AddEventHandler('ev-robbery:server:SetSmallbankTimeout', function(BankId)
     if not robberyBusy then
        Citizen.Wait(3600000)
        Config.SmallBanks[BankId]["isOpened"] = false
        timeOut = false
        robberyBusy = false
        TriggerClientEvent('ev-robbery:client:ResetFleecaLockers', -1, BankId)
        TriggerEvent('lh-banking:server:SetBankClosed', BankId, false)
     end
 end)


local Loot = false

RegisterServerEvent('ev-fleeca:tut_tut')
AddEventHandler('ev-fleeca:tut_tut', function()
    local src = source
    if not Loot then
        Loot = true
        TriggerClientEvent('ev-fleeca:grab', src)
        Citizen.Wait(40000)
        Loot = false
    end
end)

RegisterServerEvent('voidrp-heists:fleeca_availability')
AddEventHandler('voidrp-heists:fleeca_availability', function()
    local src = source
    
    if Available then
        TriggerClientEvent('ev-heists:fleeca_available', src)
    else
        TriggerClientEvent('ev-heists:fleeca_unavailable', src)
    end
end)

RegisterServerEvent('ev-heists:fleecaBankLog')
AddEventHandler('ev-heists:fleecaBankLog', function()
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** DesireRP [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing a Fleeca Bank",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1033202846230913075/DLkymfP-SoN9JeQAq3GhRc0eeU7d0YoDB6wJaKGCIMHmzc8q2S3tPzSIsfg_3gDARe4C", function(err, text, headers) end, 'POST', json.encode({username = "DesireRP | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)