RegisterServerEvent("ev-base:sv:player_control_set")
AddEventHandler("ev-base:sv:player_control_set", function(controlsTable)
    local src = source
    DPX.DB:UpdateControls(src, controlsTable, function(UpdateControls, err)
            if UpdateControls then
                -- we are good here.
            end
    end)
end)

RegisterServerEvent("ev-base:sv:player_controls")
AddEventHandler("ev-base:sv:player_controls", function()
    local src = source
    DPX.DB:GetControls(src, function(loadedControls, err)
        if loadedControls ~= nil then 
            TriggerClientEvent("ev-base:cl:player_control", src, loadedControls) 
        else 
            TriggerClientEvent("ev-base:cl:player_control",src, nil) print('controls fucked') 
        end
    end)
end)
