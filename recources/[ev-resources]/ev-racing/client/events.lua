previewEnabled = false
local usedItemId, usedItemSlot, usedItemMetadata

RegisterNetEvent("ev-racing:addedActiveRace")
AddEventHandler("ev-racing:addedActiveRace", function(race)
    print("ADDING ACTIVE RACE")
    activeRaces[race.id] = race

    if not config.nui.hudOnly then
        SendNUIMessage({
            activeRaces = activeRaces
        })
    end

    TriggerEvent("ev-racing:api:addedActiveRace", race, activeRaces)
    TriggerEvent("ev-racing:api:updatedState", { activeRaces = activeRaces })
end)

RegisterNetEvent("ev-racing:removedActiveRace")
AddEventHandler("ev-racing:removedActiveRace", function(id)
    print("REMOVE ACTIVE RACE")
    activeRaces[id] = nil

    if not config.nui.hudOnly then
        SendNUIMessage({
            activeRaces = activeRaces
        })
    end

    TriggerEvent("ev-racing:api:removedActiveRace", activeRaces)
    TriggerEvent("ev-racing:api:updatedState", { activeRaces = activeRaces })
end)

RegisterNetEvent("ev-racing:updatedActiveRace")
AddEventHandler("ev-racing:updatedActiveRace", function(race)
    if activeRaces[race.id] then
        activeRaces[race.id] = race
    end

    if not config.nui.hudOnly then
        SendNUIMessage({
            activeRaces = activeRaces
        })
    end

    TriggerEvent("ev-racing:api:updatedActiveRace", activeRaces)
    TriggerEvent("ev-racing:api:updatedState", { activeRaces = activeRaces })
end)

RegisterNetEvent("ev-racing:endRace")
AddEventHandler("ev-racing:endRace", function(race)
    print("RACE FUCKING END")
    SendNUIMessage({
        showHUD = false
    })

    TriggerEvent("ev-racing:api:raceEnded", race)
    TriggerEvent('ev-racing:ev-racing:api:updatedStat')
    cleanupRace()
end)

RegisterNetEvent("ev-racing:raceHistory")
AddEventHandler("ev-racing:raceHistory", function(race)
    finishedRaces[#finishedRaces + 1] = race

    if race then
        if not config.nui.hudOnly then
            SendNUIMessage({
                leaderboardData = race
            })
        end
    end

    TriggerEvent("ev-racing:api:raceHistory", race)
    TriggerEvent("ev-racing:api:updatedState", { finishedRaces = finishedRaces })
end)

RegisterNetEvent("ev-racing:startRace")
AddEventHandler("ev-racing:startRace", function(race, startTime)
    TriggerEvent("ev-racing:api:startingRace", startTime)
    -- Wait for race countdown
    Citizen.Wait(startTime - 3000)

    SendNUIMessage({
        type = "countdown",
        start = 3,
    })

    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET")

    if not curRace then
        initRace(race)
        TriggerEvent("ev-racing:api:raceStarted", race)
    end
end)

RegisterNetEvent("ev-racing:updatePosition")
AddEventHandler("ev-racing:updatePosition", function(position)
    -- print("Position is now: " .. position)
    SendNUIMessage({
        HUD = { position = position }
    })
end)

RegisterNetEvent("ev-racing:dnfRace")
AddEventHandler("ev-racing:dnfRace", function()
    SendNUIMessage({
        HUD = { dnf = true }
    })

    TriggerEvent("ev-racing:api:dnfRace", race)
end)

RegisterNetEvent("ev-racing:startDNFCountdown")
AddEventHandler("ev-racing:startDNFCountdown", function(dnfTime)
    SendNUIMessage({
        HUD = { dnfTime = dnfTime }
    })
end)

function round(x, n) 
    return tonumber(string.format("%." .. n .. "f", x))
end

RegisterNetEvent("ev-racing:finishedRace")
AddEventHandler("ev-racing:finishedRace", function(position, time, pEnterAmt)
    if position == 1 then
        RPC.execute('ev-racing:awardPlayer', math.random(40, 50) + round(pEnterAmt / 6, 0))
    elseif position == 2 then
        RPC.execute('ev-racing:awardPlayer', math.random(20, 30))
    elseif position == 3 then
        RPC.execute('ev-racing:awardPlayer', math.random(10))
    end
    SendNUIMessage({
        HUD = {
            position = position,
            finished = time,
        }
    })
end)

RegisterNetEvent("ev-racing:joinedRace")
AddEventHandler("ev-racing:joinedRace", function(race)
    race.start.pos = tableToVector3(race.start.pos)
    spawnCheckpointObjects(race.start, config.startObjectHash)
end)

RegisterNetEvent("ev-racing:leftRace")
AddEventHandler("ev-racing:leftRace", function()
    cleanupProps()
    TriggerEvent('ev-racing:api:updatedState')
end)

RegisterNetEvent("ev-racing:playerJoinedYourRace")
AddEventHandler("ev-racing:playerJoinedYourRace", function(characterId, name)
    if characterId == getCharacterId() then return end

    TriggerEvent("ev-racing:api:playerJoinedYourRace", characterId, name)
end)

RegisterNetEvent("ev-racing:playerLeftYourRace")
AddEventHandler("ev-racing:playerLeftYourRace", function(characterId, name)
    if characterId == getCharacterId() then return end

    TriggerEvent("ev-racing:api:playerLeftYourRace", characterId, name)
end)

RegisterNetEvent("ev-racing:addedPendingRace")
AddEventHandler("ev-racing:addedPendingRace", function(race)
    pendingRaces[race.id] = race
    if not config.nui.hudOnly then
        SendNUIMessage({
            pendingRaces = pendingRaces
        })
    end

    TriggerEvent("ev-racing:api:addedPendingRace", race, pendingRaces)
    TriggerEvent("ev-racing:api:updatedState", { pendingRaces = pendingRaces })
end)

RegisterNetEvent("ev-racing:removedPendingRace")
AddEventHandler("ev-racing:removedPendingRace", function(id)
    pendingRaces[id] = nil

    SendNUIMessage({ pendingRaces = pendingRaces })

    TriggerEvent("ev-racing:api:removedPendingRace", pendingRaces)
    TriggerEvent("ev-racing:api:updatedState", {pendingRaces=pendingRaces})
end)

RegisterNetEvent("ev-racing:startCreation")
AddEventHandler("ev-racing:startCreation", function()
    startRaceCreation()
end)

RegisterNetEvent("ev-racing:addedRace")
AddEventHandler("ev-racing:addedRace", function(newRace, newRaces)
    if not races then return end
    races = newRaces

    SendNUIMessage({
        races = newRaces
    })

    TriggerEvent("ev-racing:api:addedRace")
    TriggerEvent("ev-racing:api:updatedState", {races=races})
end)

local function openAliasTextbox()
  exports['ev-interface']:openApplication('textbox', {
    callbackUrl = 'ev-interface:racing:input:alias',
    key = 1,
    items = {{icon = "pencil-alt", label = "Alias", name = "alias"}},
    show = true
  })
end

AddEventHandler("ev-inventory:itemUsed", function(item, metadata, inventoryName, slot)
  if item ~= "racingusb2" then return end
  usedItemId = item
  usedItemSlot = slot
  usedItemMetadata = json.decode(metadata)

  local characterId = exports["isPed"]:isPed("cid")
  if characterId ~= usedItemMetadata.characterId then
    TriggerEvent("DoLongHudText", "You don't own this usb!", 2)
    return
  end

  if usedItemMetadata.Alias then
    TriggerEvent("DoLongHudText", "Alias can't be changed for this usb!", 2)
    return
  end

  openAliasTextbox()
end)

RegisterInterfaceCallback("ev-interface:racing:input:alias", function(data, cb)
  cb({data = {}, meta = {ok = true, message = ''}})
  exports['ev-interface']:closeApplication('textbox')
  local alias = data.values.alias

  if usedItemMetadata.Alias then return end

  if not alias then
    TriggerEvent("DoLongHudText", "No alias entered!", 2)
    return
  end

  local success, msg = RPC.execute("ev-racing:setAlias", usedItemId, usedItemSlot, usedItemMetadata, alias)
  if success then
    exports["ev-phone"]:phoneNotification("racen", "Welcome to the underground, " .. alias .. ".", "From the PM", 5000)
  else
    TriggerEvent("DoLongHudText", msg or "Alias could not be set.", 2)
    if msg == "Alias already taken!" then
      openAliasTextbox()
    end
  end
end)

-- RegisterCommand("ev-racing:giveRacingUSB", function()
--     RPC.execute("ev-racing:giveRacingUSB")
-- end)

AddEventHandler("onResourceStop", function (resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    cleanupProps()
    clearBlips()
    ClearGpsMultiRoute()
end)

RegisterNetEvent('ev-racing:api:currentRace')
AddEventHandler("ev-racing:api:currentRace", function(currentRace)
    print(json.encode(currentRace))
    -- print("FUCK THIS SHIT HERE******************************************************")
    isRacing = currentRace ~= nil
    if isRacing then
        startBubblePopper(currentRace)
    end
end)