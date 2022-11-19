local currentActiveBuffs = {}
local baseBuffDuration = ((60 * 60000) * 3) -- 3 hours
local isIntelBuff = false

local BIKE_STATS = { "MP0_STAMINA", "MP0_WHEELIE_ABILITY", "MP0_FLYING_ABILITY" }

local isDead = false
AddEventHandler("pd:deathcheck", function()
  isDead = not isDead
end)

local buffMapUI = {}
AddEventHandler("ev-buffs:addUIBuff", function(pValues)
  for k, v in pairs(pValues) do
    buffMapUI[k] = v
  end
  -- print("ev-buffs:addUIBuff", json.encode(buffMapUI))
  exports["ev-hud"]:sendAppEvent("buffs", buffMapUI)
  --exports["np-ui"]:sendAppEvent("hud", buffMapUI)
end)
AddEventHandler("np-ui:restarted", function()
  exports["np-ui"]:sendAppEvent("hud", buffMapUI)
end)

local buffFunctions = {
  ["stressblock"] = {
    onStart = function()
      TriggerEvent("client:disableStress", true)
      TriggerEvent("ev-buffs:addUIBuff", { buffedStress = true })
    end,
    onEnd = function()
      TriggerEvent("client:disableStress", false)
      TriggerEvent("ev-buffs:addUIBuff", { buffedStress = false })
    end,
    data = function(percent, timeOverride)
      return {
        duration = timeOverride or ((60 * 60000) * percent),
        startTime = GetGameTimer(),
      }
    end,
  },
  ["stressgain"] = {
    onStart = function(percent)
      TriggerEvent("client:stressMultiplier", percent)
      TriggerEvent("ev-buffs:addUIBuff", { buffedStress = true })
    end,
    onUpdate = function(percent)
      TriggerEvent("client:stressMultiplier", percent)
    end,
    onEnd = function()
      TriggerEvent("client:stressMultiplier", 0.0)
      TriggerEvent("ev-buffs:addUIBuff", { buffedStress = false })
    end,
    data = function(percent, timeOverride)
      return {
        duration = timeOverride or (baseBuffDuration * percent),
        startTime = GetGameTimer(),
      }
    end,
  },
  ["fullness"] = {
    onStart = function(percent)
      -- print("fullness", percent)
      TriggerEvent("carhud:slowHunger", percent)
      TriggerEvent("ev-buffs:addUIBuff", { buffedHunger = true })
    end,
    onUpdate = function(percent)
      -- print("fullness update", percent)
      TriggerEvent("carhud:slowHunger", percent)
    end,
    onEnd = function()
      -- print("fullness end")
      TriggerEvent("carhud:slowHunger", 0.0)
      TriggerEvent("ev-buffs:addUIBuff", { buffedHunger = false })
    end,
    data = function(percent, timeOverride)
      return {
        duration = timeOverride or (baseBuffDuration * percent),
        startTime = GetGameTimer(),
      }
    end,
  },
  ["jobluck"] = {
    onStart = function(percent)
      TriggerEvent("ev-buffs:setJobLuckMultiplier", percent)
      TriggerEvent("ev-buffs:addUIBuff", { buffedJobpay = true })
    end,
    onUpdate = function(percent)
      TriggerEvent("ev-buffs:setJobLuckMultiplier", percent)
    end,
    onEnd = function()
      TriggerEvent("ev-buffs:setJobLuckMultiplier", 0.0)
      TriggerEvent("ev-buffs:addUIBuff", { buffedJobpay = false })
    end,
    data = function(percent, timeOverride)
      return {
        duration = timeOverride or (baseBuffDuration * percent),
        startTime = GetGameTimer(),
      }
    end,
  },
  ["alert"] = {
    onStart = function(percent)
      TriggerEvent("ev-buffs:setAlertLevelMultiplier", percent)
      TriggerEvent("ev-buffs:addUIBuff", { buffedAlertness = true })
    end,
    onUpdate = function(percent)
      TriggerEvent("ev-buffs:setAlertLevelMultiplier", percent)
    end,
    onEnd = function()
      TriggerEvent("ev-buffs:setAlertLevelMultiplier", 0.0)
      TriggerEvent("ev-buffs:addUIBuff", { buffedAlertness = false })
    end,
    data = function(percent, timeOverride)
      return {
        duration = timeOverride or (baseBuffDuration * percent),
        startTime = GetGameTimer(),
      }
    end,
  },
  ["swimming"] = {
    onStart = function(percent)
      TriggerEvent("carhud:increaseSwimSpeed", true)
      TriggerEvent("ev-buffs:addUIBuff", { buffedOxygen = true })
    end,
    onEnd = function()
      TriggerEvent("carhud:increaseSwimSpeed", false)
      TriggerEvent("ev-buffs:addUIBuff", { buffedOxygen = false })
    end,
    data = function(percent)
      return {
        duration = (60 * 60000) * percent,
        startTime = GetGameTimer(),
      }
    end,
  },
  ["stamina"] = {
    onStart = function(percent)
      TriggerEvent("ev-buffs:stamina", true, percent)
      TriggerEvent("ev-buffs:addUIBuff", { buffedStamina = percent * 100 })
    end,
    onUpdate = function(percent)
      TriggerEvent("ev-buffs:stamina", true, percent)
      TriggerEvent("ev-buffs:addUIBuff", { buffedStamina = percent * 100 })
    end,
    onEnd = function()
      TriggerEvent("ev-buffs:stamina", false, percent)
      TriggerEvent("ev-buffs:addUIBuff", { buffedStamina = false })
    end,
    data = function(percent, timeOverride)
      return {
        duration = timeOverride or (baseBuffDuration * percent),
        startTime = GetGameTimer(),
      }
    end,
  },
  ["strength"] = {
    onStart = function(percent, timeOverride)
      --RPC.execute("ev-skills:server:adjustSkill", "strength", math.floor(100 * percent), 'add')
      TriggerEvent("ev-buffs:addUIBuff", { buffedStrength = percent * 100 })
    end,
    onUpdate = function(newPercent, oldPercent)
      -- if newPercent > oldPercent then
        --RPC.execute("ev-skills:server:adjustSkill", "strength", math.floor(100 * (newPercent - oldPercent)), 'add')
      -- else
        --RPC.execute("ev-skills:server:adjustSkill", "strength", math.floor(100 * (oldPercent - newPercent)), 'remove')
      -- end
      TriggerEvent("ev-buffs:addUIBuff", { buffedStrength = newPercent * 100 })
    end,
    onEnd = function()
      TriggerEvent("ev-buffs:addUIBuff", { buffedStrength = false })
    end,
    data = function(percent, timeOverride)
      return {
        duration = timeOverride or (baseBuffDuration * percent),
        startTime = GetGameTimer(),
      }
    end,
  },
  ["int"] = {
    onStart = function(percent)
      isIntelBuff = true
      --RPC.execute("ev-skills:server:adjustSkill", "intelligence", math.floor(100 * percent), 'add')
      TriggerEvent("ev-buffs:addUIBuff", { buffedInt = percent * 100 })
    end,
    onUpdate = function(newPercent, oldPercent)
      --if newPercent > oldPercent then
        --RPC.execute("ev-skills:server:adjustSkill", "intelligence", math.floor(100 * (newPercent - oldPercent)), 'add')
      --else
        --RPC.execute("ev-skills:server:adjustSkill", "intelligence", math.floor(100 * (oldPercent - newPercent)), 'remove')
      --end
      TriggerEvent("ev-buffs:addUIBuff", { buffedInt = newPercent * 100 })
    end,
    onEnd = function()
      isIntelBuff = false
      TriggerEvent("ev-buffs:addUIBuff", { buffedInt = false })
    end,
    data = function(percent, timeOverride)
      return {
        duration = timeOverride or (baseBuffDuration * percent),
        startTime = GetGameTimer(),
      }
    end,
  },
  ["double"] = {
    onStart = function(percent)
      TriggerEvent("ev-buffs:addUIBuff", { buffedDouble = percent * 100 })
    end,
    onUpdate = function(percent)
      TriggerEvent("ev-buffs:addUIBuff", { buffedDouble = percent * 100 })
    end,
    onEnd = function()
      TriggerEvent("ev-buffs:addUIBuff", { buffedDouble = false })
    end,
    data = function(percent, timeOverride)
      return {
        duration = timeOverride or (baseBuffDuration * percent),
        startTime = GetGameTimer(),
      }
    end,
  },
  ["bikeStats"] = {
    onStart = function(percent)
      TriggerEvent("ev-buffs:addUIBuff", { buffedBikeStats = percent * 100 })
    end,
    onUpdate = function(percent)
      for _, stat in ipairs(BIKE_STATS) do
          StatSetInt(stat, math.floor((percent * 100) + 0.5), true)
      end
      TriggerEvent("ev-buffs:addUIBuff", { buffedBikeStats = math.floor((percent * 100) + 0.5) })
    end,
    onEnd = function()
      for _, stat in ipairs(BIKE_STATS) do
        StatSetInt(stat, 0, true)
      end
      TriggerEvent("ev-buffs:addUIBuff", { buffedBikeStats = false })
    end,
    data = function(percent, timeOverride)
      return {
        duration = timeOverride or (baseBuffDuration * percent),
        startTime = GetGameTimer(),
      }
    end,
  }
}

-- pKey: string - avoid stacking with key
-- pBuffs: [ { buff: string - buff name, percent: double - strength 0.0 - 1.0 } ]
-- - swimming
-- - stress
RegisterNetEvent("ev-buffs:applyBuff")
AddEventHandler("ev-buffs:applyBuff", function(pKey, pBuffs)
  -- print("ev-buffs:applyBuff", pKey, json.encode(pBuffs))
  for buffKey, buffData in pairs(currentActiveBuffs) do
    if buffData["keyConfigs"][pKey] then
      buffData["keyConfigs"][pKey].duration = 1
    end
  end
  for _, b in pairs(pBuffs) do
    if not currentActiveBuffs[b.buff] then
      currentActiveBuffs[b.buff] = {
        active = false,
        keyConfigs = {},
        percent = 0.0,
      }
    end
    local value = buffFunctions[b.buff]
    currentActiveBuffs[b.buff].onStart = value.onStart
    currentActiveBuffs[b.buff].onEnd = value.onEnd
    currentActiveBuffs[b.buff].onUpdate = value.onUpdate
    currentActiveBuffs[b.buff]["keyConfigs"][pKey] = value.data(b.percent, b.timeOverride)
    currentActiveBuffs[b.buff]["keyConfigs"][pKey].percent = b.percent
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(5000)
    local currentTime = GetGameTimer()
    for buffKey, buffData in pairs(currentActiveBuffs) do
      local shouldStart = false
      local additivePercent = 0.0
      local localPercents = {}
      for sourceKey, sourceData in pairs(currentActiveBuffs[buffKey]["keyConfigs"]) do
        if ((sourceData.duration + sourceData.startTime) > currentTime) then
          shouldStart = true
          additivePercent = additivePercent + sourceData.percent
        end
      end
      if additivePercent < 0 then
        additivePercent = 0.0
      end
      if additivePercent > 1 then
        additivePercent = 1.0
      end
      if buffData.active and (additivePercent ~= currentActiveBuffs[buffKey]["percent"]) then
        if buffData.onUpdate then
          buffData.onUpdate(additivePercent, currentActiveBuffs[buffKey]["percent"])
        end
        currentActiveBuffs[buffKey]["percent"] = additivePercent
      end
      if (not buffData.active) and shouldStart then
        buffData.active = true
        if buffData.onStart then
          buffData.onStart(additivePercent)
        end
      end
      if isDead or (buffData.active and (not shouldStart)) then
        buffData.active = false
        if buffData.onEnd then
          buffData.onEnd()
        end
      end
    end
  end
end)

--

Citizen.CreateThread(function()
  -- tests)
  -- stressgain
  -- TriggerEvent("ev-buffs:applyBuff", "test", { { buff = "stressgain", percent = 0.33, timeOverride = 10000 } })
  -- Wait(5000)
  -- TriggerEvent("client:newStress", true, 1000)
  -- Wait(15000)
  -- TriggerEvent("client:newStress", true, 1000)

  -- strength
  -- RPC.execute("ev-skills:server:adjustSkill", "strength", 0, 'set')
  -- Wait(2000)
  -- TriggerEvent("ev-buffs:applyBuff", "test", { { buff = "strength", percent = 0.5, timeOverride = 30000 } })
  -- TriggerEvent("ev-buffs:applyBuff", "test1", { { buff = "strength", percent = 0.5, timeOverride = 10000 } })
  -- intelligence
  -- RPC.execute("ev-skills:server:adjustSkill", "intelligence", 0, 'set')
  -- Wait(2000)
  -- TriggerEvent("ev-buffs:applyBuff", "test", { { buff = "int", percent = 0.5, timeOverride = 30000 } })
  -- TriggerEvent("ev-buffs:applyBuff", "test1", { { buff = "int", percent = 0.5, timeOverride = 10000 } })

  -- TriggerEvent("client:newStress", true, 20000)
end)

exports('BuffIntel', function()
  return isIntelBuff
end)

RegisterCommand("teststambuff", function(source, args, raw)
  TriggerEvent("ev-buffs:applyBuff", "test", { { buff = "strength", percent = 0.6, timeOverride = 10000 } })
  --TriggerEvent("ev-buffs:applyBuff", "test", { { buff = "swimming", percent = 0.33, timeOverride = 30000 } })
  --TriggerEvent("ev-buffs:applyBuff", "test", { { buff = "jobluck", percent = 0.33, timeOverride = 30000 } })
end, false)

-- stressblock (makes stress icon yellow) (no extra circle)
-- stressgain (makes stress icon yellow) (no extra circle)
-- fullness (makes hunger icon yellow) (no extra circle)
-- jobluck (shows dollar sign icon, with yellow icon)
-- alert (shows exclamation icon, with yellow icon)
-- swimming (makes oxygen icon yellow) (no extra circle)
-- stamina (shows swimming icon, with yellow icon)
-- strength (shows strength icon, with yellow icon)
-- int (shows intelligence icon, with yellow icon)
-- double (shows double icon (database) with yellow icon)
-- bikeStats (shows bike icon with yellow icon)