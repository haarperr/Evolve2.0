RegisterCommand("callsignveh", function(source,args,user)
    if exports["isPed"]:GroupRank("police") or exports["isPed"]:GroupRank("ems") then
        setVehicleCallsign(args[1], args[2], args[3])
    else
        print("NO")
    end
end)



function setVehicleCallsign(pCallsign1, pCallsign2, pCallsign3)
    local plyVeh = GetVehiclePedIsIn(PlayerPedId(),false)

    local elements = {
        { name = 'cso', label = 'Callsign', icon = 'time', _type = 'number' },
        { name = 'ppo', label = 'Division (0 = patrol)', icon = 'time', _type = 'number' },
        { name = 'tto', label = 'Rank', icon = 'time', _type = 'number' },
      }

    local prompt = exports['ev-interface']:OpenInputMenu(elements)

    if not prompt then 
        ClearPedTasks(PlayerPedId())
        return
    end

    local cso = tonumber(prompt.cso) or 0
    if cso >= 999 then
        return TriggerEvent('DoLongHudText', 'Three Digits Only', 2)
    end

    local ppo = tonumber(prompt.ppo) or 0
    if ppo >= 10 then
        return TriggerEvent('DoLongHudText', 'One Digits Only', 2)
    end

    local tto = tonumber(prompt.tto) or 0
    if tto >= 10 then
        return TriggerEvent('DoLongHudText', 'One Digits Only', 2)
    end

    local progress = exports['ev-taskbar']:taskBar(2500, 'Call sign being set...', true)

    if progress == 100 then 
        local str = "".. cso ..""
        local fields = { str:match( (str:gsub(".", "(.)")) ) }

        SetVehicleMod(plyVeh, 42, tonumber(fields[1]))
        SetVehicleMod(plyVeh, 44, tonumber(fields[2]))
        SetVehicleMod(plyVeh, 45, tonumber(fields[3]))

        SetVehicleMod(plyVeh, 8, tonumber(ppo))
        SetVehicleMod(plyVeh, 9, tonumber(tto))


    end
end