-- CLOSE APP
function SetUIFocus(hasKeyboard, hasMouse)
  HasNuiFocus = hasKeyboard or hasMouse
  SetNuiFocus(hasKeyboard, hasMouse)
end

exports('SetUIFocus', SetUIFocus)

RegisterNUICallback("ev-ui:closeApp", function(data, cb)
    SetUIFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    Wait(800)
    TriggerEvent("attachedItems:block",false)
end)

RegisterNUICallback("ev-ui:applicationClosed", function(data, cb)
    TriggerEvent("ev-ui:application-closed", data.name, data)
    SendUIMessage({source = "ev-nui", app = "", show = false});
    cb({data = {}, meta = {ok = true, message = 'done'}})
end)

-- FORCE CLOSE
RegisterCommand("ev-ui:force-close", function()
    SendUIMessage({source = "ev-nui", app = "", show = false});
    SetUIFocus(false, false)
end, false)

-- SMALL MAP
RegisterCommand("ev-ui:small-map", function()
  SetRadarBigmapEnabled(false, false)
end, false)

local function restartUI(withMsg)
  SendUIMessage({ source = "ev-nui", app = "main", action = "restart" });
  if withMsg then
    TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
  end
  Wait(5000)
  TriggerEvent("ev-ui:restarted")
  SendUIMessage({ app = "hud", data = { display = true }, source = "ev-nui" })
  local cj = exports["police"]:getCurrentJob()
end
RegisterCommand("ev-ui:restart", function() restartUI(true) end, false)
RegisterCommand("ui-r", function() restartUI() end, false)
RegisterNetEvent("ev-ui:server-restart")
AddEventHandler("ev-ui:server-restart", restartUI)

RegisterCommand("ev-ui:debug:show", function()
    SendUIMessage({ source = "ev-nui", app = "debuglogs", data = { display = true } });
end, false)

RegisterCommand("ev-ui:debug:hide", function()
    SendUIMessage({ source = "ev-nui", app = "debuglogs", data = { display = false } });
end, false)

RegisterNUICallback("ev-ui:resetApp", function(data, cb)
    SetUIFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    --sendCharacterData()
end)

RegisterNetEvent("ev-ui:server-relay")
AddEventHandler("ev-ui:server-relay", function(data)
    SendUIMessage(data)
end)

RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
  sendAppEvent("character", { job = "judge" })
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
  sendAppEvent("character", { job = "unemployed" })
end)

RegisterNetEvent("ev-jobmanager:playerBecameJob")
AddEventHandler("ev-jobmanager:playerBecameJob", function(job)
  sendAppEvent("character", { job = job })
end)
