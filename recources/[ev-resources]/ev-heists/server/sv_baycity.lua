local pCanDo2NDDoor = false

RegisterServerEvent('ev-heists:first_door:cl')
AddEventHandler('ev-heists:first_door:cl', function()
    TriggerClientEvent('ev-heists:bay_city:first_door', source)
end)

RegisterServerEvent('ev-heists:second_door:cl')
AddEventHandler('ev-heists:second_door:cl', function()
    if pCanDo2NDDoor then
        TriggerClientEvent('ev-heists:bay_city:second_door', source)
    end
end)

RegisterServerEvent('pSendSecondDoor')
AddEventHandler('pSendSecondDoor', function()
    pCanDo2NDDoor = true
end)

RegisterServerEvent('pStopSecondDoor')
AddEventHandler('pStopSecondDoor', function()
    pCanDo2NDDoor = false
end)

RegisterServerEvent('ev-heists:bayCityLog')
AddEventHandler('ev-heists:bayCityLog', function()
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** DesireRP [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing Bay City Bank",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1033202846230913075/DLkymfP-SoN9JeQAq3GhRc0eeU7d0YoDB6wJaKGCIMHmzc8q2S3tPzSIsfg_3gDARe4C", function(err, text, headers) end, 'POST', json.encode({username = "DesireRP | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)