RegisterServerEvent("utk_oh:openvault")
AddEventHandler("utk_oh:openvault", function(method)
    TriggerClientEvent("utk_oh:openvault_c", -1, method)
end)

local pLootLowerVault = false

RegisterServerEvent('ev-heists:loot_tray')
AddEventHandler('ev-heists:loot_tray', function()
    local src = source
    if not pLootLowerVault then
        pLootLowerVault = true
        TriggerClientEvent('ev-vault:grab', src)
        Citizen.Wait(40000)
        pLootLowerVault = false
    end
end)

RegisterServerEvent('ev-heists:cash_tray')
AddEventHandler('ev-heists:cash_tray', function()
    local src = source
    if not Loot then
        Loot = true
        TriggerClientEvent('ev-heists:grab_from_tray', src)
        Citizen.Wait(40000)
        Loot = false
    end
end)

RegisterServerEvent('ev-heists:vaultRobberyLog')
AddEventHandler('ev-heists:vaultRobberyLog', function()
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** DesireRP [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing The Vault",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1033202846230913075/DLkymfP-SoN9JeQAq3GhRc0eeU7d0YoDB6wJaKGCIMHmzc8q2S3tPzSIsfg_3gDARe4C", function(err, text, headers) end, 'POST', json.encode({username = "DesireRP | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)