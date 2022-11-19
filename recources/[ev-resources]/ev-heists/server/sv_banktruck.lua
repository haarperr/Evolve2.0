local license = 0

local licenseArray = {}

RegisterServerEvent('ev-heists:check_if_robbed')
AddEventHandler('ev-heists:check_if_robbed', function(license)

local _source = source

if licenseArray[#licenseArray] ~= nil then
    for k, v in pairs(licenseArray) do
        if v == license then
        return
        end
    end
end

licenseArray[#licenseArray+1] = license

    TriggerClientEvent('sec:AllowHeist', _source)
end)

RegisterServerEvent('ev-heists:bankTruckLog')
AddEventHandler('ev-heists:bankTruckLog', function()
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** DesireRP [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing a Bank Truck",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1033202846230913075/DLkymfP-SoN9JeQAq3GhRc0eeU7d0YoDB6wJaKGCIMHmzc8q2S3tPzSIsfg_3gDARe4C", function(err, text, headers) end, 'POST', json.encode({username = "DesireRP | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)