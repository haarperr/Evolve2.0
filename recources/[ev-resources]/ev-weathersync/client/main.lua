CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false

local disable = false


--- CODE
RegisterNetEvent('ev-weathersync:spawned')
AddEventHandler('ev-weathersync:spawned', function()
	disable = false
    TriggerServerEvent('ev-weathersync:server:RequestStateSync')
end)

RegisterNetEvent('ev-weathersync:client:EnableSync')
AddEventHandler('ev-weathersync:client:EnableSync', function()
	disable = false
    TriggerServerEvent('ev-weathersync:server:RequestStateSync')
	SetRainLevel(0.0)
end)

RegisterNetEvent('ev-weathersync:client:DisableSync')
AddEventHandler('ev-weathersync:client:DisableSync', function()
	disable = true

	Citizen.CreateThread(function() 
		while disable do 
			SetRainLevel(0.0)
			SetWeatherTypePersist('EXTRASUNNY')
			SetWeatherTypeNow('EXTRASUNNY')
			SetWeatherTypeNowPersist('EXTRASUNNY')
			NetworkOverrideClockTime(23, 0, 0)
			Citizen.Wait(5000)
		end
	end)
end)

RegisterNetEvent('ev-weathersync:client:DisableSyncSpawn')
AddEventHandler('ev-weathersync:client:DisableSyncSpawn', function()
	disable = true

	Citizen.CreateThread(function() 
		while disable do 
			SetRainLevel(0.0)
			SetWeatherTypePersist('EXTRASUNNY')
			SetWeatherTypeNow('EXTRASUNNY')
			SetWeatherTypeNowPersist('EXTRASUNNY')
			NetworkOverrideClockTime(12, 0, 0)
			Citizen.Wait(5000)
		end
	end)
end)

RegisterNetEvent('ev-weathersync:client:SyncTime')
AddEventHandler('ev-weathersync:client:SyncTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

RegisterNetEvent('ev-weathersync:client:SyncWeather')
AddEventHandler('ev-weathersync:client:SyncWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)

Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
		if not disable then
			local newBaseTime = baseTime
			if GetGameTimer() - 500  > timer then
				newBaseTime = newBaseTime + 0.25
				timer = GetGameTimer()
			end
			if freezeTime then
				timeOffset = timeOffset + baseTime - newBaseTime			
			end
			baseTime = newBaseTime
			hour = math.floor(((baseTime+timeOffset)/60)%24)
			minute = math.floor((baseTime+timeOffset)%60)
			NetworkOverrideClockTime(hour, minute, 0)
			TriggerEvent("timeheader", hour, minute)
			Citizen.Wait(2000)
		else
			Citizen.Wait(1000)
		end
    end
end)

Citizen.CreateThread(function()
    while true do
		if not disable then
			if lastWeather ~= CurrentWeather then
				lastWeather = CurrentWeather
				SetWeatherTypeOverTime(CurrentWeather, 15.0)
				Citizen.Wait(15000)
			end
			Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
			SetBlackout(blackout)
			ClearOverrideWeather()
			ClearWeatherTypePersist()
			SetWeatherTypePersist(lastWeather)
			SetWeatherTypeNow(lastWeather)
			SetWeatherTypeNowPersist(lastWeather)
			if lastWeather == 'XMAS' then
				SetForceVehicleTrails(true)
				SetForcePedFootstepsTracks(true)
			else
				SetForceVehicleTrails(false)
				SetForcePedFootstepsTracks(false)
			end
		else
			Citizen.Wait(1000)
		end
    end
end)

