pRan = false

function Login.playerLoaded() end

function Login.characterLoaded()
  -- Main events leave alone 
  TriggerEvent("ev-base:playerSpawned")
  TriggerEvent("playerSpawned")
  TriggerServerEvent('character:loadspawns')
  TriggerEvent("ev-base:initialSpawnModelLoaded")
  -- Main events leave alone 

  -- Everything that should trigger on character load 
  TriggerServerEvent('checkTypes')
  TriggerServerEvent('isVip')
  TriggerEvent("fx:clear")
  TriggerServerEvent("raid_clothes:retrieve_tats")
  TriggerEvent('ev-bankrobbery:client:CreateTrollysEvent')
  TriggerServerEvent("currentconvictions")
  TriggerServerEvent("Evidence:checkDna")
  TriggerEvent("banking:viewBalance")
  TriggerServerEvent('ev-doors:requestlatest')
  TriggerServerEvent("item:UpdateItemWeight")
  TriggerServerEvent("ReturnHouseKeys")
  TriggerServerEvent("requestOffices")
  Wait(500)
  TriggerServerEvent("police:getAnimData")
  TriggerServerEvent("server:currentpasses")
  TriggerEvent("ev-hud:SetValues", exports['isPed']:isPed('cid'))
  TriggerServerEvent("police:getEmoteData")
  TriggerServerEvent("police:SetMeta")
  TriggerServerEvent('ev-scoreboard:AddPlayer')
  TriggerServerEvent("ev-base:PolyZoneUpdate")
  TriggerEvent("ev-housing:loadHousingClient")
  TriggerEvent("ev-admin/client/loadMenu")
  TriggerServerEvent("ev-housing:getGarages")
  TriggerServerEvent("ev-phone:getAbdulTaxies")
  TriggerServerEvent("retreive:jail",exports["isPed"]:isPed("cid"))
  TriggerServerEvent("ev-phone:checkForNonDocumentedLicenses", exports['isPed']:isPed("cid"))
  -- TriggerServerEvent("weapon:general:check")
  -- Anything that might need to wait for the client to get information, do it here.
  TriggerServerEvent("login:get:keys")

  --Sync Whiteboards
  TriggerServerEvent("SpawnEventsServer")

  --Meth shit
  TriggerServerEvent('ev-methtable:spawnInitialized')

  
  -- // New Clothing Menu // --
  --TriggerServerEvent("ev_clothing:retrieve_tats")
  --TriggerServerEvent('ev_clothing:get_character_current')
  --TriggerServerEvent('ev_clothing:get_character_face')

  TriggerServerEvent("ev-weapons:getAmmo")
  Wait(4000)
  TriggerServerEvent("bank:getLogs")
  TriggerEvent('ev-hud:EnableHud', true)
end

RegisterNetEvent('ev-spawn:spawnCharacter')
AddEventHandler('ev-spawn:spawnCharacter', function()

  if not pRan then
    pRan = true
    isNear = false
    TriggerServerEvent('ev-base:sv:player_control')
    TriggerServerEvent('ev-base:sv:player_settings')
    TriggerEvent("spawning", false)
    TriggerEvent("attachWeapons")
    TriggerServerEvent("request-dropped-items")
    TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))

    if Spawn.isNew then
        Wait(1000)

        TriggerEvent('ev-hud:ChangeThirst', 95)
        TriggerEvent('ev-hud:ChangeHunger', 95)
        TriggerEvent('ev-hud:SaveValues')
        TriggerServerEvent('ev-spawn:initBoosting')
        -- TriggerServerEvent('ev-spawn:licenses')

        -- commands to make sure player is alive and full food/water/health/no injuries
        local src = GetPlayerServerId(PlayerId())
        TriggerServerEvent("reviveGranted", src)
        TriggerEvent("Hospital:HealInjuries", src, true)
        TriggerServerEvent("ems:healplayer", src)
        TriggerEvent("heal", src)
        TriggerEvent("status:needs:restore", src) 

        TriggerServerEvent("ev-spawn:newPlayerFullySpawned")
      end
  end
  SetPedMaxHealth(PlayerPedId(), 200)
  runGameplay()
  Spawn.isNew = false
end)