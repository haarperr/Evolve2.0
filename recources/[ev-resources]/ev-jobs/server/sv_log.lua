RegisterServerEvent('ev-civjobs:errorlog')
AddEventHandler('ev-civjobs:errorlog', function(pErrorCode)
    local timeout = os.time()
    if (os.time() - timeout) < 5 then
        print(("[TIMEOUT] %s is spamming the event (%s)"):format(source, "ev-civjobs:errorlog"))
        timeout = os.time()
        return
    end
    if pErrorCode == 0x66 then
        exports["ev-log"]:AddLog("Civ Jobs", 
            source, 
            "Pressed Alt (KEY-19) while in Inventory trying to open menu", 
            { message = tostring(message) })
    end

    timeout = os.time()
    return
end)

RegisterServerEvent('ev-jobs:givePayout')
AddEventHandler('ev-jobs:givePayout', function(amount, pType, text)
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()

    TriggerClientEvent('ev-phone:paymentNoti', src, amount, pType)
    if pType == "cash" then
        user:addMoney(amount)
    elseif pType == "bank" then
        user:addBank(amount)
    end

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** ev [Jobs] | Payout Log **",
          ["description"] = "Job Payout Log | Amount: $"..amount.." | Type: "..pType.." | Job Type (Buff / No Buff): "..text.." | Character Name: "..charInfo.first_name.." "..charInfo.last_name.." | State ID: "..charInfo.id,
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012082382305771651/q6uYSjA5DWDyGVFSc6BixKv6xB8GmEMKXLGcPfTcRC3ImAQNqPlXHvCaDKC0DyUEYaST", function(err, text, headers) end, 'POST', json.encode({username = "ev | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)