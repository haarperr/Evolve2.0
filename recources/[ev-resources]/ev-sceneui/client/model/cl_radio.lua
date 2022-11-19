--[[RegisterNUICallback("ev-ui:hudUpdateRadioSettings", function(data, cb)
    exports["ev-base"]:getModule("SettingsData"):setSettingsTableGlobal({ ["tokovoip"] = data.settings }, true)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
end)

RegisterNUICallback("ev-ui:hudUpdateKeybindSettings", function(data, cb)
    exports["ev-base"]:getModule("DataControls"):encodeSetBindTable(data.controls)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
end)]]