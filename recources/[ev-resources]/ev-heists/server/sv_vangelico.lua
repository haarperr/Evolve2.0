
local CooldownTimer = true

local pIsAvailable = true

RegisterServerEvent('ev-heists:start_hitting_upper_vangelico')
AddEventHandler('ev-heists:start_hitting_upper_vangelico', function()
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    if CooldownTimer then
        print('[ev-heists] Someone Robbing Vangelico')
        CooldownTimer = false
        pIsAvailable = false
        TriggerClientEvent('ev-jewelry:open_doors', src)
        print('^3[ev-heists]: ^2Cooldown started^0')
        Citizen.Wait(3600000)
        print('[ev-heists] Vangelico No Longer On Cooldown')
        TriggerClientEvent('ev-heists:lock_vangelico_doors_cooldown', src)
        CooldownTimer = true
        pIsAvailable = true
    else
        print('[ev-heists] Someone Trying to Rob Vangelico But Already Been Robbed')
        TriggerClientEvent('DoLongHudText', src, 'This Jewelry Store was recently robbed.', 2)
    end
end)

RegisterServerEvent('ev-heists:vangelico_loot')
AddEventHandler('ev-heists:vangelico_loot', function()
    local src = source
    local EvanVangelicoLoot = math.random(1, 3)

    if EvanVangelicoLoot == 1 then
        TriggerClientEvent('player:receiveItem', src,'valuablegoods', math.random(5, 10))
        TriggerClientEvent('player:receiveItem', src,'goldbar', math.random(1, 5))
        TriggerClientEvent('player:receiveItem', src,'rolexwatch', math.random(10, 20))
    elseif EvanVangelicoLoot == 2 then
        TriggerClientEvent('player:receiveItem', src,'goldcoin', math.random(15, 30))
        TriggerClientEvent('player:receiveItem', src,'stolen8ctchain', math.random(3, 10))
    elseif EvanVangelicoLoot == 3 then
        TriggerClientEvent('player:receiveItem', src,'valuablegoods', math.random(5, 14))
        TriggerClientEvent('player:receiveItem', src,'goldcoin', math.random(15, 50))
        TriggerClientEvent('player:receiveItem', src,'rolexwatch', math.random(15, 30))
    end
end)

RegisterServerEvent('ev-heists:get_vangelico_availability')
AddEventHandler('ev-heists:get_vangelico_availability', function()
    local src = source

    if pIsAvailable then
        TriggerClientEvent('ev-heists:vangelico_available', src)
    else
        TriggerClientEvent('ev-heists:vangelico_unavailable', src)
    end
end)

RegisterServerEvent('ev-heists:vangelicoRobberyLog')
AddEventHandler('ev-heists:vangelicoRobberyLog', function()
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** DesireRP [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing Jewelry Store",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1033202846230913075/DLkymfP-SoN9JeQAq3GhRc0eeU7d0YoDB6wJaKGCIMHmzc8q2S3tPzSIsfg_3gDARe4C", function(err, text, headers) end, 'POST', json.encode({username = "DesireRP | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)