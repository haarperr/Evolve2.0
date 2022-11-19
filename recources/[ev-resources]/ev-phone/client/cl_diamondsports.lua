RegisterNUICallback('getDiamondSportsEvents', function(data,cb)
    local returnEvents = RPC.execute("ev-phone:getDiamondSportsEvents")
    SendNUIMessage({
        openSection = "diamondSportsAppend",
        diamondSports = returnEvents,
        canMakeDiamondEvents = exports['ev-business']:IsEmployedAt('the_diamond')
    })
end)

RegisterNUICallback('submitNewEventDiamondSports', function(data, cb)
    RPC.execute("ev-phone:submitNewEventDiamondSports", data.pEventName, data.pEventLocation, data.pTimeZone, data.pEventTimeHr, data.pEventTimeMin, data.pEventDate)
end)

RegisterNUICallback('deleteDiamondEvent', function(data, cb)
    RPC.execute("ev-phone:deleteDiamondEvent", data.diamondEventID)
end)