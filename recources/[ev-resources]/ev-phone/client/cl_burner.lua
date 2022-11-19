RegisterCommand("openBurner", function()
    openGui(true, "868")
end)

RegisterNUICallback("getRecentCallsByCid", function(data, cb)
    local recentCalls = RPC.execute("ev-phone:getRecentCallsByCid", tonumber(data.cid))
    SendNUIMessage({
        openSection = "callHistory",
        callHistory = recentCalls
      })
end)

RegisterNUICallback("getTextsByCid", function(data, cb)
    loadSMS(tonumber(data.cid))
end)