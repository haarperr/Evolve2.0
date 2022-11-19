local nitroactive = false
local nitroflowrate = 0.3
local pNitrousLevel = 0
local oldNitrousLvl = 0
local nitroveh
local pNitrousInUse = false

RegisterNetEvent("ev-nitro:client:placeNitro")
AddEventHandler("ev-nitro:client:placeNitro", function() 
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply)
	local closestVeh = GetClosestVehicle(plyCoords.x, plyCoords.y, plyCoords.z, 4.0, 0, 0)
	if IsPedInVehicle(ply, GetVehiclePedIsIn(ply, false), false) and not IsThisModelAHeli(GetVehiclePedIsIn(ply, false)) and not IsThisModelABoat(GetVehiclePedIsIn(ply, false)) and not IsThisModelABike(GetVehiclePedIsIn(ply, false)) then
		if not GetIsVehicleEngineRunning(GetVehiclePedIsIn(ply, false)) then
			TriggerServerEvent('inventory:removeitem', 'nitrous')
			nitroactive = true
			nitroveh = GetVehiclePedIsIn(ply, false)
			pNitrousLevel = 100
        else
            TriggerEvent('DoLongHudText', 'You\'re engine needs to be off.', 2)
		end
	end
end)

RegisterNetEvent('ev-nitro:client:particlefx')
AddEventHandler('ev-nitro:client:particlefx', function (veh)	
	local exhaustNames = {
		"exhaust",    "exhaust_2",  "exhaust_3",  "exhaust_4",
		"exhaust_5",  "exhaust_6",  "exhaust_7",  "exhaust_8",
		"exhaust_9",  "exhaust_10", "exhaust_11", "exhaust_12",
		"exhaust_13", "exhaust_14", "exhaust_15", "exhaust_16"
	}
	for _, exhaustName in pairs(exhaustNames) do
		local boneIndex = GetEntityBoneIndexByName(veh, exhaustName)
		if boneIndex ~= -1 then
			local pos = GetWorldPositionOfEntityBone(veh, boneIndex)
			local off = GetOffsetFromEntityGivenWorldCoords(veh, pos.x, pos.y, pos.z)
			if not HasNamedPtfxAssetLoaded("core") then
				RequestNamedPtfxAsset("core")
				while not HasNamedPtfxAssetLoaded("core") do
					Wait(1)
				end
			end
		
			UseParticleFxAssetNextCall("core")
			StartParticleFxNonLoopedOnEntity('veh_backfire', veh, off.x, off.y, off.z, 0.0, 0.0, 0.0, 0.7, false, false, false)
		end
	end
end)

RegisterNetEvent('ev-nitro:client:particlefisfis')
AddEventHandler('ev-nitro:client:particlefisfis', function (type, veh)
	if type == 'fisfisac' then
		SetVehicleNitroPurgeEnabled(veh, true)
	elseif type == 'fisfiskapat' then
		SetVehicleNitroPurgeEnabled(veh, false)
	end
end)

local vehicles = {}
local particles = {}

function IsVehicleNitroPurgeEnabled(vehicle)
  return vehicles[vehicle] == true
end

function SetVehicleNitroPurgeEnabled(vehicle, enabled)
	if IsVehicleNitroPurgeEnabled(vehicle) == enabled then
	  return
	end
	if enabled then
	 	local bone = GetEntityBoneIndexByName(vehicle, 'bonnet')
	 	local pos = GetWorldPositionOfEntityBone(vehicle, bone)
	 	local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
	 	local ptfxs = {}
  
	 	for i=0,3 do
			local leftPurge = CreateVehiclePurgeSpray(vehicle, off.x - 0.5, off.y + 0.05, off.z, 40.0, -20.0, 0.0)
			local rightPurge = CreateVehiclePurgeSpray(vehicle, off.x + 0.5, off.y + 0.05, off.z, 40.0, 20.0, 0.0)
			
			table.insert(ptfxs, leftPurge)
			table.insert(ptfxs, rightPurge)
	 	end
  
	 	SetVehicleBoostActive(vehicle, 1)
	 	vehicles[vehicle] = true
	 	particles[vehicle] = ptfxs
	else
		if particles[vehicle] and #particles[vehicle] > 0 then
			for _, particleId in ipairs(particles[vehicle]) do
			  SetVehicleBoostActive(vehicle, 0)
			  StopParticleFxLooped(particleId)
			end
		end
  
	  vehicles[vehicle] = nil
	  particles[vehicle] = nil
	end
end

function CreateVehiclePurgeSpray(vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Wait(1)
		end
	end

    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_sht_steam', vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, nitroflowrate, 0.0, 0.0, 0.0)
end

local fisfismode = false
local nitromode = true
Citizen.CreateThread(function()
	while true do 
		local sleep = 1500
		if nitroactive and pNitrousLevel > 0 and IsPedInVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), false) then
			sleep = 1
			if fisfismode then
				if IsControlPressed(0, 21) and nitroveh == GetVehiclePedIsIn(PlayerPedId(), false) then -- fışfış
					TriggerServerEvent('ev-nitro:server:particlefisfis', 'fisfisacc', nitroveh)
					SetVehicleBoostActive(nitroveh, 4) --Boost Sound
					pNitrousInUse = true
					pNitrousLevel = pNitrousLevel - 0.1
				else
					pNitrousInUse = false
					TriggerServerEvent('ev-nitro:server:particlefisfis', 'fisfiskapatt', nitroveh)
				end
			elseif nitromode then
				if IsControlPressed(0, 21) and nitroveh == GetVehiclePedIsIn(PlayerPedId(), false) then -- nitro
					TriggerServerEvent('ev-nitro:server:particlefx', nitroveh)
					SetVehicleBoostActive(nitroveh, 4) --Boost Sound
					pNitrousInUse = true
					pNitrousLevel = pNitrousLevel - 0.1
					Citizen.InvokeNative(0xB59E4BD37AE292DB, nitroveh, 2.0)
					Citizen.InvokeNative(0x93A3996368C94158, nitroveh, 7.0)
				else
					Citizen.InvokeNative(0xB59E4BD37AE292DB, nitroveh, 1.0)
                    Citizen.InvokeNative(0x93A3996368C94158, nitroveh, 1.0)
					pNitrousInUse = false 
				end
			end
		elseif pNitrousLevel <= 0 then
			pNitrousLevel = 0
			nitroactive = false
			pNitrousInUse = false 
			TriggerServerEvent('ev-nitro:server:particlefisfis', 'fisfiskapatt', nitroveh)
		end
		Wait(sleep)
	end
end)

exports('nitroLevelLeave', function()
	oldNitrousLvl = pNitrousLevel
	Citizen.Wait(100)
	pNitrousLevel = 0
end)

exports('nitroLevelEnter', function()
	pNitrousLevel = oldNitrousLvl
	nitroactive = true
end)

exports('nitroLevel', function()
	return pNitrousLevel
end)

exports('NitrousUse', function()
	return pNitrousInUse
end)

AddEventHandler('onResourceStart', function (resource)
	pNitrousLevel = 0
	nitroactive = false
	TriggerServerEvent('ev-nitro:server:particlefisfis', 'fisfiskapatt')
	nitroveh = nil
	pNitrousInUse = false 
end)

RegisterCommand('+nosMode', function()
	if nitroveh == GetVehiclePedIsIn(PlayerPedId(), false) then
		if not fisfismode and nitromode then
			fisfismode = true
			nitromode = false
			TriggerEvent('DoLongHudText', 'Nitro Mode: Purge')
		elseif not nitromode and fisfismode then
			nitromode = true
			fisfismode = false
			TriggerEvent('DoLongHudText', 'Nitro Mode: Boost')
		end
	end
end)

RegisterCommand('+changeFlowPlus', function()
	if nitroflowrate <= 0.9 and nitroveh == GetVehiclePedIsIn(PlayerPedId(), false) then
		nitroflowrate = nitroflowrate + 0.1
		TriggerEvent('DoLongHudText', 'Purge Spray Flowrate: ' .. nitroflowrate)
		Wait(500)
	end
end)

RegisterCommand('+changeFlowMinus', function()
	if nitroflowrate >= 0.2 and nitroveh == GetVehiclePedIsIn(PlayerPedId(), false) then
		nitroflowrate = nitroflowrate - 0.1
		TriggerEvent('DoLongHudText', 'Purge Spray Flowrate: ' .. nitroflowrate)
		Wait(500)
	end
end)

Citizen.CreateThread(function()
    exports["ev-keybinds"]:registerKeyMapping("", "Nitrous", "Change Mode", "+nosMode", "-nosMode", "")

	exports["ev-keybinds"]:registerKeyMapping("", "Nitrous", "Flow Rate Higher", "+changeFlowPlus", "-changeFlowPlus", "")

	exports["ev-keybinds"]:registerKeyMapping("", "Nitrous", "Flow Rate Lower", "+changeFlowMinus", "-changeFlowMinus", "")
end)