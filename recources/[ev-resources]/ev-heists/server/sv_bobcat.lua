-- pCanBlow = false
-- canloot = false

-- RegisterServerEvent("ev-bobcat:effect")
-- AddEventHandler("ev-bobcat:effect", function(method)
--     TriggerClientEvent("lumo:effectoutside", -1, method)
-- end)

-- RegisterServerEvent("ev-bobcat:effect2")
-- AddEventHandler("ev-bobcat:effect2", function(method)
--     TriggerClientEvent("lumo:effectinside", -1, method)
-- end)

-- RegisterServerEvent("ev-bobcat:bubbles")
-- AddEventHandler("ev-bobcat:bubbles", function()
--     canloot = true
--     TriggerClientEvent("ev-bobcat:bubbles", -1)
-- end)

-- local searched1 = false
-- local searched2 = false
-- local searched3 = false

-- RegisterServerEvent("ev-bobcat:search_crate_1")
-- AddEventHandler("ev-bobcat:search_crate_1", function()
--     local source = source
    
--     if searched1 then
--         TriggerClientEvent("DoLongHudText", source, "Already Searched")
--     elseif canloot then
--         TriggerClientEvent("ev-bobcat:search_crate_1", source)
--         searched1 = true
--     end
-- end)

-- RegisterServerEvent("ev-bobcat:search_crate_2")
-- AddEventHandler("ev-bobcat:search_crate_2", function()
--     local source = source
    
--     if searched2 then
--         TriggerClientEvent("DoLongHudText", source, "Already Searched")
--     elseif canloot then
--         TriggerClientEvent("ev-bobcat:search_crate_2", source)
--         searched2 = true
--     end
-- end)

-- RegisterServerEvent("ev-bobcat:search_crate_3")
-- AddEventHandler("ev-bobcat:search_crate_3", function()
--     local source = source
    
--     if searched3 then
--         TriggerClientEvent("DoLongHudText", source, "Already Searched")
--     elseif canloot then
--         TriggerClientEvent("ev-bobcat:search_crate_3", source)
--         searched3 = true
--     end
-- end)

-- RegisterServerEvent("aspect:particleserver")
-- AddEventHandler("aspect:particleserver", function(method)
--     TriggerClientEvent("aspect:ptfxparticle", -1, method)
-- end)

-- RegisterServerEvent('ev-bobcat:blow_door')
-- AddEventHandler('ev-bobcat:blow_door', function()
--     if not pCanBlow then
--         pCanBlow = true
--         TriggerClientEvent('ev-heists:explosion_ped_walk', source)
--     end
-- end)

-- RegisterServerEvent('ev-heists:bobcatLog')
-- AddEventHandler('ev-heists:bobcatLog', function()
--     local src = source
--     local user = exports["ev-base"]:getModule("Player"):GetUser(src)
--     local charInfo = user:getCurrentCharacter()
--     local pName = GetPlayerName(source)

--     local connect = {
--         {
--           ["color"] = color,
--           ["title"] = "** DesireRP [Heists] **",
--           ["description"] = "Steam Name: "..pName.." | Started Robbing Bobcat Security",
--         }
--       }
--       PerformHttpRequest("https://discord.com/api/webhooks/1006560926180311172/YX78VTHU_0k0KCFqQ9Pn0wFWSJBS0HSyEqni7_vmNjXI6l3djMKedInF7xFzMSuGxAmE", function(err, text, headers) end, 'POST', json.encode({username = "DesireRP | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
-- end)