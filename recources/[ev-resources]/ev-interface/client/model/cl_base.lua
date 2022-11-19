-- CLOSE APP
function SetInterfaceFocus(hasKeyboard, hasMouse)
  SetNuiFocus(hasKeyboard, hasMouse)
end

exports('SetInterfaceFocus', SetInterfaceFocus)

RegisterNUICallback("ev-interface:closeApp", function(data, cb)
    SetInterfaceFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    Wait(800)
    TriggerEvent("attachedItems:block",false)
end)

RegisterNUICallback("ev-interface:applicationClosed", function(data, cb)
    TriggerEvent("ev-interface:application-closed", data.name, data)
    cb({data = {}, meta = {ok = true, message = 'done'}})
end)

-- FORCE CLOSE
RegisterCommand("ev-interface:force-close", function()
    SendInterfaceMessage({source = "ev-nui", app = "", show = false});
    SetInterfaceFocus(false, false)
end, false)

-- SMALL MAP
RegisterCommand("ev-interface:small-map", function()
  SetRadarBigmapEnabled(false, false)
end, false)

local function restartUI(withMsg)
  SendInterfaceMessage({ source = "ev-nui", app = "main", action = "restart" });
  if withMsg then
    TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
  end
  Wait(5000)
  TriggerEvent("ev-interface:restarted")
  SendInterfaceMessage({ app = "hud", data = { display = true }, source = "ev-nui" })
  local cj = exports["police"]:getCurrentJob()
end
RegisterCommand("ev-interface:restart", function() restartUI(true) end, false)
RegisterCommand("ui-r", function() restartUI() end, false)
RegisterNetEvent("ev-interface:server-restart")
AddEventHandler("ev-interface:server-restart", restartUI)

RegisterCommand("ev-interface:debug:show", function()
    SendInterfaceMessage({ source = "ev-nui", app = "debuglogs", data = { display = true } });
end, false)

RegisterCommand("ev-interface:debug:hide", function()
    SendInterfaceMessage({ source = "ev-nui", app = "debuglogs", data = { display = false } });
end, false)

RegisterNUICallback("ev-interface:resetApp", function(data, cb)
    SetInterfaceFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    --sendCharacterData()
end)

RegisterNetEvent("ev-interface:server-relay")
AddEventHandler("ev-interface:server-relay", function(data)
    SendInterfaceMessage(data)
end)