local ScopedWeapons = {
  [-1719357158] = true,
  [-90637530] = true
}

local isScoped = false

Citizen.CreateThread(function()
  while true do
    for weaponHash, v in pairs(ScopedWeapons) do
      if GetSelectedPedWeapon(PlayerPedId()) == weaponHash and IsPlayerFreeAiming(PlayerId()) then
        if not isScoped then
          isScoped = true
          exports["ev-ui"]:sendAppEvent("sniper-scope", { show = true })
        end
      elseif isScoped and not IsPlayerFreeAiming(PlayerId()) then
        isScoped = false
        exports["ev-ui"]:sendAppEvent("sniper-scope", { show = false })
      end
    end
    Citizen.Wait(100)
  end
end)
