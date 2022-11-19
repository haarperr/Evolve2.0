RegisterCommand("record", function(source , args)
    local source = src
    StartRecording(1)
    TriggerClientEvent("DoLongHudText", src, "Started Recording")
end)

RegisterCommand("clip", function(source , args)
    local source = src
    StartRecording(0)
end)

RegisterCommand("saveclip", function(source , args)
    local source = src
    StopRecordingAndSaveClip()
    TriggerClientEvent("DoLongHudText", src, "Saved Recording")
end)

RegisterCommand("delclip", function(source , args)
    local source = src
    StopRecordingAndDiscardClip()
    TriggerClientEvent("DoLongHudText", src, "Deleted Recording!")
end)

RegisterCommand("editor", function(source , args)
    local source = src
    NetworkSessionLeaveSinglePlayer()
    ActivateRockstarEditor()
    TriggerClientEvent("DoLongHudText", src, "Have Fun Editing!")
end)