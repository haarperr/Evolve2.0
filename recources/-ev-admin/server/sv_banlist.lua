local BanList            = {}
local BanListLoad        = false
local joined = false

CreateThread(function()
	while true do
		Wait(1000)
		if BanListLoad == false then
			loadBanListMenu()
			if BanList ~= {} then
				print("Ban List Successfully Loaded.")
				BanListLoad = true
			else
				print("ERROR: Ban List did not load.")
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(10000)
		if BanListLoad == true then
			loadBanListMenu()
		end
	end
end)

function getPrioType(pSource)
	local pSrc = pSource
	local user = exports['ev-base']:getModule("Player"):GetUser(pSource)
	return "Prio Broke:) ~ loleris"
end

function getEverything()
	local everything = {}
	for k,v in pairs(GetPlayers()) do
		local char
		local user = exports['ev-base']:getModule("Player"):GetUser(tonumber(v))
		local cash
		local steamid 
		if user then 
			char = user:getCurrentCharacter() 
			cash = user:getCash()
			steamid = user:getVar("hexid")
		end
		local pt = getPrioType(tonumber(v))
		local fullname
		local lastname
		local firstname
		local cid
		local bank
		if char then
			cid = char.id
			bank = char.bank
			fullname = char.first_name .. ' ' .. char.last_name
			firstname = char.first_name
			lastname = char.last_name
		else
			cash = '0'
			bank = '0'
			cid = 'No Character CID'
			fullname = 'No Character Name'
			firstname = 'No Character Firstname'
			lastname = 'No Character Surname'
		end
		everything[#everything+1] = {
			["name"]          = GetPlayerName(tonumber(v)),
            ["SteamID"]       = steamid,
            ["serverID"]      = v,
            ["queueType"]     = getPrioType(tonumber(v)),
            ["charID"]        = cid,
            ["charName"]      = fullname,
			["charFirstname"] = firstname,
			["charSurname"]   = lastname,
			["charCash"]      = "$" .. cash,
			["charBank"]      = "$" .. bank
		}
	end
	return everything
end

exports('getEverything',getEverything)

RegisterNetEvent("oneMoreTryAdminSv", function()
	TriggerClientEvent("oneMoreTryAdmin",source,BanList)
end)

function getBanList()
	return BanList
end

RPC.register("getBanList", function(pSource)
	return BanList
end)

exports('getBanList',getBanList)

function loadBanListMenu()
	exports.oxmysql:execute('SELECT * FROM bans', {}, function(data)
		BanList = {}
			

		for i=1, #data, 1 do
			local exp2
			if data[i].expire == 0 then
				exp2 = "Permanent"
			else
				exp2 = os.date('%m-%d-%Y', data[i].expire)
			end

			print(data[i].ip)
			BanList[#BanList+1] = {
				banid     = data[i].banid,
				steamid = data[i].steam,
				name = data[i].name,
				license = data[i].license,
				license2 = data[i].license2,
				xbox = data[i].xbox,
				live = data[i].live,
				cfx = data[i].cfx,
				discord = data[i].discord,
				ip = data[i].ip,
				token = data[i].token,
				reason    = data[i].reason,
				bannedby  = data[i].bannedby,
				expire    = data[i].expire,
				bannedon  = data[i].bannedon,
				bannedon2 = os.date('%m-%d-%Y', data[i].bannedon),
				expire2   = exp2,
			}
		end
	end)
end

exports('getIdentifier', getIdentifier)
exports('getUserToken', getUserToken)

function deletebanned(license) 
	exports.oxmysql:execute(
		'DELETE FROM bans WHERE license=@license',
		{
		  ['@license']  = license
		},
		function ()
			loadBanListMenu()
	end)
end

exports('deletebanned',deletebanned)