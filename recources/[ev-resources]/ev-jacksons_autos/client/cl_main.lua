RegisterNetEvent('FinishMoneyCheckForCar')
RegisterNetEvent('createSaleVehicle')
local vehshop_blips = {}
local buyPlate = {}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0
local commissionbuy = 0
local rank = 0

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
local currentCarSpawnLocation = 0
local ownerMenu = false

local vehshopDefault = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 4000, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 5000, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 5000, description = {}, model = "rumpo"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 200, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 250, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 400, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 200, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 600, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 600, description = {}, model = "tribike3"},
			}
		},		
	}
}

vehshop = vehshopDefault
local vehshopOwner = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "S-Class", description = ''},
				{name = "B-Class", description = ''},
			}
		},
		["s-class"] = {
			title = "s-class",
			name = "s-class",
			buttons = {
				{name = "Bravado Gauntlet Classic", costs = 148500, description = {}, model = "gauntlet3"},
				{name = "Grotti Furia", costs = 158000, description = {}, model = "furia"},
				{name = "Vulcar Nebula Turbo", costs = 125000, description = {}, model = "nebula"},
				{name = "Grotti Turismo Classic", costs = 126000, description = {}, model = "turismo2"},
				{name = "Itali GTO", costs = 154000, description = {}, model = "italigto"},
				{name = "Itali RSX", costs = 156000, description = {}, model = "italirsx"},
				{name = "Gauntlet HELFIRE", costs = 154000, description = {}, model = "gauntlet4"},
				{name = "Comet SR", costs = 125000, description = {}, model = "comet5"},
				{name = "Dominator GTX", costs = 140000, description = {}, model = "dominator3"},
				{name = "Jester Retro", costs = 135000, description = {}, model = "jester3"},
				{name = "Drafter", costs = 152000, description = {}, model = "Drafter"},
				{name = "Jester RR", costs = 134000, description = {}, model = "Jester4"},
				{name = "Dominator ASP", costs = 147500, description = {}, model = "Dominator7"},
				{name = "Vectre", costs = 150000, description = {}, model = "Vectre"},
				{name = "Sultan RS", costs = 148000, description = {}, model = "SultanRS"},
				{name = "ZR350", costs = 140000, description = {}, model = "ZR350"},
				{name = "Elegy Retro Custom", costs = 147500, description = {}, model = "elegy"},
				{name = "Progen T20", costs = 145000, description = {}, model = "T20"},
				{name = "Remus", costs = 135000, description = {}, model = "Remus"},
				{name = "RT3000", costs = 132000, description = {}, model = "RT3000"},
				{name = "Dominator GTT", costs = 138000, description = {}, model = "DOMINATOR8"},
				{name = "Annis Euros", costs = 160000, description = {}, model = "EUROS"},
				{name = "Futo GTX", costs = 128000, description = {}, model = "Futo2"},
				{name = "Calico GTF", costs = 148000, description = {}, model = "Calico"},
				{name = "Comet S2", costs = 1340000, description = {}, model = "COMET6"},
				{name = "UBERMACHT Cypher", costs = 137000, description = {}, model = "Cypher"},
				{name = "Growler", costs = 148000, description = {}, model = "Growler"},
				{name = "Sultan RS classic", costs = 140000, description = {}, model = "Sultan3"},
				{name = "Banshee 900R", costs = 150000, description = {}, model = "banshee2"},
				{name = "Coquette D10", costs = 150000, description = {}, model = "coquette4"},
				{name = "Schlagen GT", costs = 140000, description = {}, model = "Schlagen"},
				{name = "Infernus Classic", costs = 135000, description = {}, model = "infernus2"},
				{name = "Deviant", costs = 130000, description = {}, model = "deviant"},
				{name = "Grotti Turismo R", costs = 135000, description = {}, model = "turismor"},
			}
		},
        ["b-class"] = {
			title = "b-class",
			name = "b-class",
			buttons = {
				{name = "Lampadati Komoda", costs = 58000, description = {}, model = "komoda"},
				{name = "Dinka Blista", costs = 40000, description = {}, model = "blista"},
				{name = "Albany VSTR", costs = 60000, description = {}, model = "vstr"},
				{name = "Dinka Sugoi", costs = 56000, description = {}, model = "sugoi"},
				{name = "Karin Kuruma", costs = 58000, description = {}, model = "kuruma"},
				{name = "Vapid GB200", costs = 56000, description = {}, model = "gb200"},
				{name = "Lampadati Tropos Rally", costs = 45000, description = {}, model = "tropos"},
				{name = "Bollokon Prairie", costs = 42000, description = {}, model = "prairie"},
				{name = "Annis Savestra", costs = 47000, description = {}, model = "savestra"},
				{name = "Ubermacht Sentinel", costs = 50000, description = {}, model = "sentinel"},
				{name = "Ubermacht Sentinel XS", costs = 50000, description = {}, model = "sentinel2"},
				{name = "Ubermacht Zion Classic", costs = 43000, description = {}, model = "zion3"},
				{name = "Bravado Buffalo", costs = 57500, description = {}, model = "buffalo"},
				{name = "Bravado Buffalo S", costs = 57500, description = {}, model = "buffalo2"},				
				{name = "Shyster Fusilade", costs = 45000, description = {}, model = "fusilade"},
				{name = "Karin Futo", costs = 45000, description = {}, model = "futo"},
				{name = "Revolter", costs = 65000, description = {}, model = "revolter"},
				{name = "Ubermacht Schafter", costs = 53000, description = {}, model = "schafter2"},
				{name = "Enus Cognoscenti", costs = 55000, description = {}, model = "cognoscenti"},
				{name = "Enus Cognoscenti 55", costs = 55000, description = {}, model = "cog55"},
				{name = "Cheval Fugitive", costs = 50000, description = {}, model = "fugitive"},
				{name = "Karin Intruder", costs = 43000, description = {}, model = "intruder"},
				{name = "Declasse Premier", costs = 30000, description = {}, model = "premier"},
				{name = "Zirconium Stratum", costs = 60000, description = {}, model = "stratum"},
				{name = "Enus Super Diamond", costs = 56000, description = {}, model = "superd"},
				{name = "Obey Tailgater", costs = 48000, description = {}, model = "tailgater"},
				{name = "Dewbauchee Exemplar", costs = 42000, description = {}, model = "exemplar"},
				{name = "Ocelot Jackal", costs = 43000, description = {}, model = "jackal"},
				{name = "Ubermacht Oracle", costs = 42000, description = {}, model = "oracle"},
				{name = "Ubermacht Oracle XS", costs = 42000, description = {}, model = "oracle2"},
				{name = "Lampadati Felon", costs = 45000, description = {}, model = "felon"},
				{name = "Coil Raiden", costs = 62000, description = {}, model = "raiden"},
				{name = "Cheval Surge", costs = 50000, description = {}, model = "surge"},
				{name = "Weeny Issi Sport", costs = 55000, description = {}, model = "issi7"},
				{name = "Lampadati Michelli GT", costs = 49000, description = {}, model = "michelli"},
				{name = "Vapid Retinue", costs = 50000, description = {}, model = "retinue"},
				{name = "Vapid Retinue MkII", costs = 52000, description = {}, model = "retinue2"},
				{name = "Nagasaki Outlaw", costs = 47000, description = {}, model = "outlaw"},
				{name = "Maxwell Vagrant", costs = 52000, description = {}, model = "vagrant"},
				{name = "Karin Everon", costs = 55000, description = {}, model = "everon"},
				{name = "Vapid Trophy Truck", costs = 52000, description = {}, model = "trophytruck"},
				{name = "Vapid Desert Raid", costs = 50000, description = {}, model = "trophytruck2"},
				{name = "Albany Buccaneer", costs = 46000, description = {}, model = "buccaneer"},
				{name = "Albany Buccaneer Custom", costs = 46000, description = {}, model = "buccaneer2"},				
				{name = "Vapid Clique", costs = 44000, description = {}, model = "clique"},
				{name = "Willard Faction", costs = 49000, description = {}, model = "faction"},
				{name = "Declasse Impaler", costs = 47000, description = {}, model = "impaler"},
				{name = "Imponte Nightshade", costs = 46000, description = {}, model = "nightshade"},
				{name = "Imponte Phoenix", costs = 45000, description = {}, model = "phoenix"},
				{name = "Cheval Picador", costs = 44000, description = {}, model = "picador"},
				{name = "Bravado Rat-Truck", costs = 47500, description = {}, model = "ratloader2"},
				{name = "Declasse Sabre Turbo Custom", costs = 50000, description = {}, model = "sabregt2"},
				{name = "Declasse Stallion", costs = 48000, description = {}, model = "stalion"},
				{name = "Declasse Tulip", costs = 45000, description = {}, model = "tulip"},
				{name = "Declasse Vigero", costs = 48000, description = {}, model = "vigero"},
				{name = "Albany Virgo", costs = 65000, description = {}, model = "virgo"},
				{name = "Benefactor Stirling GT", costs = 62000, description = {}, model = "feltzer3"},
				{name = "Invetero Coquette Classic", costs = 58000, description = {}, model = "coquette2"},
				{name = "Invetero Coquette Blackfin", costs = 60000, description = {}, model = "coquette3"},
				{name = "Grotti GT500", costs = 57500, description = {}, model = "gt500"},
				{name = "Declasse Mamba", costs = 56000, description = {}, model = "mamba"},
				{name = "Grotti Stinger", costs = 50000, description = {}, model = "stinger"},
				{name = "Grotti Stinger GT", costs = 50000, description = {}, model = "stingergt"},
				{name = "Ocelot Swinger", costs = 58000, description = {}, model = "swinger"},
				{name = "Lampadati Viseris", costs = 57000, description = {}, model = "viseris"},
				{name = "Dewbauchee Rapid GT Classic", costs = 55000, description = {}, model = "rapidgt3"},
				{name = "HK Warrener", costs = 50000, description = {}, model = "Warrener2"},
				{name = "Jugular", costs = 55000, description = {}, model = "jugular"},
			}
		},
	}
}

local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{
		entering = {-773.3459, -1025.549, 14.097204},
		inside = {-144.4265, -593.6467, 211.77507},
		outside = {-773.3459, -1025.549, 14.097204},
	}
}

local pSpawnLocations = {
	[1] =  { ['x'] = -784.1828, ['y'] = -1020.625, ['z'] = 13.15056, ['h'] = 348.48025, ['info'] = ' Car Spot 1' },
	[2] =  { ['x'] = -788.4473, ['y'] =  -1014.74, ['z'] = 13.149223, ['h'] = 120.02655, ['info'] = ' Car Spot 2' },
	[3] =  { ['x'] = -792.0605, ['y'] = -1024.84, ['z'] = 13.152756, ['h'] = 208.52059, ['info'] = ' Car Spot 3' },
	[4] =  { ['x'] = -786.9978, ['y'] = -1034.123, ['z'] = 13.149769, ['h'] = 210.76324, ['info'] = ' Car Spot 4' },
	[5] =  { ['x'] = -781.0368, ['y'] = -1028.777, ['z'] = 13.149988, ['h'] = 341.71646, ['info'] = ' Car Spot 5' },
}

local carTable = { 
	[1] = { ["model"] = "dubsta3", ["baseprice"] = 100000, ["commission"] = 15 },
	[2] = { ["model"] = "landstalker", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "bobcatxl", ["baseprice"] = 100000, ["commission"] = 15 },
	[4] = { ["model"] = "surfer", ["baseprice"] = 100000, ["commission"] = 15 },
}

function updateCarTable(model,price,name)
	for i=1, #carTable do
		carTable[currentCarSpawnLocation]["id"] = i
		carTable[currentCarSpawnLocation]["model"] = model
		carTable[currentCarSpawnLocation]["baseprice"] = price
		carTable[currentCarSpawnLocation]["name"] = name
		TriggerServerEvent("ev-jacksons_autos:CarTable",carTable)
	end
end

local myspawnedvehs = {}

RegisterNetEvent("ev-jacksons_autos:testdrive")
AddEventHandler("ev-jacksons_autos:testdrive", function()
	if exports["ev-business"]:IsEmployedAt('jacksons_autos') or #(vector3(-775.9081, -1032.289, 13.719951) - GetEntityCoords(PlayerPedId())) > 50.0 then

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent('DoLongHudText', 'Could not locate vehicle!', 2)
		return
	end

	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(-775.9081, -1032.289, 13.719951, 3.000, 0, 70)

	if not DoesEntityExist(veh) then

		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model, -775.9081, -1032.289, 13.719951, 299.46417, true,false)
		local vehplate = "JAU"..math.random(10000,99999)
		SetVehicleNumberPlateText(veh, vehplate)
		local plate = GetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		TriggerEvent("keys:addNew",vehplate, plate)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)

		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
		Citizen.Wait(100)
		exports['ev-interface']:hideInteraction()
		myspawnedvehs[veh] = true
		end
	else
		TriggerEvent('DoLongHudText', 'A car is on the spawn point.', 2)
	end
end)

RegisterNetEvent("ev-jacksons_autos:EnableBuy")
AddEventHandler("ev-jacksons_autos:EnableBuy", function()
	if #(vector3(-775.4795, -1032.456, 14.129936) - GetEntityCoords(PlayerPedId())) > 50.0 and exports["ev-business"]:IsEmployedAt('jacksons_autos') then
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent('DoLongHudText', 'Could not locate vehicle!', 2)
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("ev-jacksons_autos:BuyEnabledSV",vehplate)
end)

RegisterNetEvent("ev-jacksons_autos:BuyEnabledCL")
AddEventHandler("ev-jacksons_autos:BuyEnabledCL", function(addplate)
	buyPlate[addplate] = true
	Citizen.Wait(60000)
	buyPlate[addplate] = nil
end)

RegisterNetEvent("ev-jacksons:CommissionPrice")
AddEventHandler("ev-jacksons:CommissionPrice", function(newAmount)
	if eexports["ev-business"]:IsEmployedAt('jacksons_autos') or #(vector3(-775.4795, -1032.456, 14.129936) - GetEntityCoords(PlayerPedId())) > 50.0 then
	for i = 1, #pSpawnLocations do
		if #(vector3(pSpawnLocations[i]["x"],pSpawnLocations[i]["y"],pSpawnLocations[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("ev-jacksons_autos:CarTable",carTable)
			end
		end
	end
end)

RegisterNetEvent("ev-jacksons_autos:ReturnCarTable")
AddEventHandler("ev-jacksons_autos:ReturnCarTable", function(newTable)
	carTable = newTable
	DespawnSaleVehicles()
	SpawnSaleVehicles()
end)

local hasspawned = false
local spawnedvehicles = {}
local vehicles_spawned = false

function BuyMenu()
	for i = 1, #pSpawnLocations do

		if #(vector3(pSpawnLocations[i]["x"],pSpawnLocations[i]["y"],pSpawnLocations[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			local veh = GetClosestVehicle(pSpawnLocations[i]["x"],pSpawnLocations[i]["y"],pSpawnLocations[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
				ClearPedTasksImmediately(PlayerPedId())
			end
			DisableControlAction(0,23)
			if IsControlJustReleased(0,47) and buyPlate[addplate] ~= nil then
				TriggerEvent('DoLongHudText', 'Attempting Purchase!', 1)
				AttemptBuy(i, false)
			end
		end
	end
end

function AttemptBuy(tableid)

	local veh = GetClosestVehicle(pSpawnLocations[tableid]["x"],pSpawnLocations[tableid]["y"],pSpawnLocations[tableid]["z"], 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent('DoLongHudText', 'Could not locate vehicle!', 2)
		return
	end

	local model = carTable[tableid]["model"]
	local commission = carTable[tableid]["commission"]
	local baseprice = carTable[tableid]["baseprice"]
	local name = carTable[tableid]["name"]
	local price = baseprice + (baseprice * commission/ 100)

	currentlocation = vehshop_blips[1]
	TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
	TriggerEvent("keys:addNew",veh, plate)
	TriggerServerEvent('ev-jacksons_autos:ChechMoney',name, model, price)
	commissionbuy = (baseprice * commission / 100)
	Citizen.Wait(100)
	exports['ev-interface']:hideInteraction()
end

function OwnerMenu()
	if not vehshop.opened then
		currentCarSpawnLocation = 0
		ownerMenu = false
	end
	for i = 1, #pSpawnLocations do
		if #(vector3(pSpawnLocations[i]["x"],pSpawnLocations[i]["y"],pSpawnLocations[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			ownerMenu = true
			currentCarSpawnLocation = i
			if IsControlJustReleased(0,38) then
				if vehshop.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end
		end
	end
end

function DrawPrices()
	for i = 1, #pSpawnLocations do
		if #(vector3(pSpawnLocations[i]["x"],pSpawnLocations[i]["y"],pSpawnLocations[i]["z"]) - GetEntityCoords(PlayerPedId())) < 1.5 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
			local veh = GetClosestVehicle(pSpawnLocations[i]["x"],pSpawnLocations[i]["y"],pSpawnLocations[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			icon = "<center><i class='fas fa-car' style=' color: white;font-size: 25px;text-align:center; padding:5px;'></i></center>"
			if exports["ev-business"]:IsEmployedAt('jacksons_autos') then
				if buyPlate[addplate] ~= nil then
					exports['ev-interface']:showInteraction("$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy.")
				else
					exports['ev-interface']:showInteraction("$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change")
				end
			else
				if buyPlate[addplate] ~= nil then
					exports['ev-interface']:showInteraction("$" .. math.ceil(price) .. " [G] to buy.")
				else
					exports['ev-interface']:showInteraction("Buy Price: $" .. math.ceil(price) .. " ")
				end
			end
		elseif #(vector3(pSpawnLocations[i]["x"],pSpawnLocations[i]["y"],pSpawnLocations[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			exports['ev-interface']:hideInteraction()
		end
	end
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function SpawnSaleVehicles()
	if not hasspawned then
		TriggerServerEvent("ev-jacksons_autos:RequestCarTable")
		Citizen.Wait(1500)
	end
	DespawnSaleVehicles(true)
	hasspawned = true
	for i = 1, #carTable do
		local model = GetHashKey(carTable[i]["model"])
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,pSpawnLocations[i]["x"],pSpawnLocations[i]["y"],pSpawnLocations[i]["z"]-1,pSpawnLocations[i]["h"],false,false)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,true)

		FreezeEntityPosition(veh,true)
		spawnedvehicles[#spawnedvehicles+1] = veh
		SetVehicleNumberPlateText(veh, i .. "CARSALE")
	end
	vehicles_spawned = true
end

function DespawnSaleVehicles(pDontWait)
	if pDontWait == nil and not pDontWait then
		Wait(15000)
	end
	for i = 1, #spawnedvehicles do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawnedvehicles[i]))
	end
	vehicles_spawned = false
end

Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {191,"Enter"}}
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["generalUseSecondary"] = table["generalUseSecondary"]
end)

--[[Functions]]--

function LocalPed()
	return PlayerPedId()
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			vehshop_blips[#vehshop_blips+1]= {blip = blip, pos = loc}
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(1)
				local inrange = false

				if #(vector3(-775.4795, -1032.456, 14.129936) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if myspawnedvehs[veh] ~= nil then
						DrawText3D(-775.4795, -1032.456, 14.129936,"["..Controlkey["generalUse"][2].."] Return Vehicle")
						if IsControlJustReleased(0,Controlkey["generalUse"][1]) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
						end
					end
				end

				for i,b in ipairs(vehshop_blips) do
					if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 100 then
						currentlocation = b
						if not vehicles_spawned then
--							print("Spawning Display Vehicles?")
							SpawnSaleVehicles()
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 35 then
							DrawPrices()
						end

						if exports["ev-business"]:IsEmployedAt('jacksons_autos') then
							OwnerMenu()
						end
						BuyMenu()
					else
						if vehicles_spawned then
--							print("Despawning Display ?")
							DespawnSaleVehicles()
						end
						Citizen.Wait(1000)
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	if ownerMenu then
		vehshop = vehshopOwner
	else
		vehshop = vehshopDefault
	end

	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	exports['ev-interface']:hideInteraction()
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator(name, veh, price, plate)
	Citizen.CreateThread(function()
		local ped = LocalPed()
		local pPrice = price
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			local name = name	
			local vehicle = veh
			local price = price		
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			local mods = {}
			for i = 0,24 do
				mods[i] = GetVehicleMod(veh,i)
			end
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			local pos = currentlocation.pos.outside

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			personalvehicle = CreateVehicle(model,-775.4795, -1032.456, 14.129936,true,false)
			SetEntityHeading(personalvehicle, 296.89608)
			SetModelAsNoLongerNeeded(model)

			if name == "rumpo" then
				SetVehicleLivery(personalvehicle,0)
			end

			if name == "taxi" then
				SetVehicleExtra(personalvehicle, 8, 0)
				SetVehicleExtra(personalvehicle, 9, 0)
				SetVehicleExtra(personalvehicle, 5, 1)
			end

			for i,mod in pairs(mods) do
				SetVehicleModKit(personalvehicle,0)
				SetVehicleMod(personalvehicle,i,mod)
			end

			SetVehicleOnGroundProperly(personalvehicle)
			SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
			SetVehicleColours(personalvehicle,colors[1],colors[2])
			SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
			TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
			SetEntityVisible(ped,true)			
			local primarycolor = colors[1]
			local secondarycolor = colors[2]	
			local pearlescentcolor = extra_colors[1]
			local wheelcolor = extra_colors[2]
			local VehicleProps = exports['ev-bennys']:FetchVehProps(personalvehicle)
			local model = GetEntityModel(personalvehicle)
			local vehname = GetDisplayNameFromVehicleModel(model)
			SetVehicleNumberPlateText(personalvehicle, plate)
			TriggerEvent("keys:addNew",personalvehicle, plate)
			TriggerServerEvent('ev-jacksons_autos:BuyVehicle', plate, vehname, vehicle, price, VehicleProps)
			TriggerServerEvent('ev-cardealer:log', exports['isPed']:isPed('cid'), vehname, price, plate, 'Jacksons Autos')
			TriggerServerEvent('ev-financials:business_money', price / 10, 'jacksons_autos', 'add')
			exports['ev-interface']:hideInteraction()
			DespawnSaleVehicles()
			SpawnSaleVehicles()
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

RegisterNetEvent("ev-jacksons_autos:FailedPurchase")
AddEventHandler("ev-jacksons_autos:FailedPurchase", function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
end)


function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,255,55,55,220)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,250)
	DrawText(0.255, 0.254)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.2, 0.2)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(250,250,250, 255)
	end

	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255,255,255,255)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255,55,55,220)
	end
end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)

	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,250)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = PlayerPedId()
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		end
	elseif this == "vehicles" then
		if btn == "B-Class" then
			OpenMenu('b-class')
		 elseif btn == "S-Class" then
		 	OpenMenu('s-class')
		end
	elseif this == "b-class" or this == "s-class" then
		if ownerMenu then
			updateCarTable(button.model,button.costs,button.name)
		else
			TriggerServerEvent('ev-jacksons_autos:ChechMoney',button.name, button.model, button.costs)
		end
	end
end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "b-class" or vehshop.currentmenu == "s-class" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1]) ) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then

			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				--local br = button.rank ~= nil and button.rank or 0
				if exports["ev-business"]:IsEmployedAt('jacksons_autos') and i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)

					if button.costs ~= nil then
						drawMenuRight("$"..button.costs,vehshop.menu.x,y,selected)
					end

					y = y + 0.04
					if vehshop.currentmenu == "b-class" or vehshop.currentmenu == "s-class" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)


								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								SetModelAsNoLongerNeeded(hash)
								local timer = 9000
								while not DoesEntityExist(veh) and timer > 0 do
									timer = timer - 1
									Citizen.Wait(1)
								end
								TriggerEvent("vehsearch:disable",veh)

								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}
								local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 2)
								local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
								local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
								local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 
								if button.model == "rumpo" then
									SetVehicleLivery(veh,2)
								end
							end
						end
					end
					if selected and ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1])  ) then
						ButtonSelected(button)
					end
				end
			end

			if DoesEntityExist(fakecar.car) then
				if vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
					daz = 6.0
					if fakecar.model == "Chimera" then
						daz = 8.0
					end
					if fakecar.model == "bmx" then
						daz = 8.0
					end
					 x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, daz))
		        	Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 7.0, 7.0, 7.0, 0)
				else
		       		x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, 10.0))
		       		Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 10.0, 10.0, 10.0, 0)		
				end
				TaskWarpPedIntoVehicle(LocalPed(),fakecar.car,-1)
		    end

		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end
	end
end)

AddEventHandler('FinishMoneyCheckForCar', function(name, vehicle, price, plate)
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price, plate)
end)

local firstspawn = 0

ShowVehshopBlips(true)
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		--326 car blip 227 225
		ShowVehshopBlips(true)
		firstspawn = 1
	end
end)

AddEventHandler('createSaleVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
			Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		SetModelAsNoLongerNeeded(car)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
	end
end)

RegisterCommand('commission', function(source, args, raw)
	if exports["ev-business"]:IsEmployedAt('jacksons_autos') then
		local amount = args[1]
		if tonumber(amount) > 0 and tonumber(amount) <= 60 then
			TriggerEvent('ev-jacksons_autos:CommissionPrice', amount)
		else
			TriggerEvent('DoLongHudText', 'Invalid amount "/commision [amount]', 2)
		end
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

RegisterCommand('testdrive', function(source, args, raw)
	if exports["ev-business"]:IsEmployedAt('jacksons_autos') then
		TriggerEvent('ev-jacksons_autos:testdrive')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

RegisterCommand('enableBuy', function(source, args, raw)
	if exports["ev-business"]:IsEmployedAt('jacksons_autos') then
		TriggerEvent('ev-jacksons_autos:EnableBuy')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)