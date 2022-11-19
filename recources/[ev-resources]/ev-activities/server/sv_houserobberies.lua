-- This is the door location, you can add as many as you want. The server will pick one randomly on every script start
--[[local doorLocation = {
	{1510.51, 6326.125, 24.60},

	{2440.1853027344, 4068.1313476562, 38.064727783203},
	{1945.3436279297, 3848.1767578125, 32.162307739258},
	{1360.9454345703, 3603.8234863281, 34.956840515137},
	{-1102.1115722656, 2721.86328125, 18.800397872925},	
	{-167.05793762207, 6312.3432617188, 31.672353744507},	
	{-1131.0240478516, -1551.8345947266, 4.5883464813232},
	{-1126.1490478516, -1447.3342285156, 5.0547857284546},	
	{-845.40698242188, -1088.4503173828, 11.638411521912},
	{810.69061279297, -750.23449707031, 26.738609313965},
	{889.71368408203, -1045.7983398438, 35.171173095703},
	{945.85107421875, -1138.0458984375, 26.459283828735},
	{914.02081298828, -1273.4448242188, 27.096141815186},
	{890.34527587891, -2222.0827636719, 30.509479522705}, 
}	]]--

--[[
	↓↓↓ DON'T CHANGE ANYTHING FROM HERE ↓↓↓
]]--

local x,y,z
local cooldown = 0
local expect, door, initiated = false, false, false
local wait = 10000
local num = 0 
local cooldownTimer = {}
local props = {
	['prop_micro_01'] = {item = 'microwave'},
	['prop_coffee_mac_02'] = {item = 'coffeemaker'},
}

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		num = math.random(111,999)
		print('^2[House Robbery]: Started^7')
		initiated = true
	end
end)

Citizen.CreateThread(function()
	while not initiated do
		Citizen.Wait(10)
	end
	RPC.register('ev-houserobbery:enter_property', function(source, ...)
		local cb = {x,y,z,num}
		return cb
	end)	
	print('^4[House Robbery]:^4 Initilised Framework')
end)

function getIdenti(source)
	for k,v in pairs(GetPlayerIdentifiers(source))do       
		if string.sub(v, 1, string.len("license:")) == "license:" then
			return v
		end		
	end
end

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(cooldownTimer) do
			if v.time <= 0 then
				ResetCooldownTimer(v.identifier)
			else
				v.time = v.time - 1
			end
		end
		Citizen.Wait(30 * 60 * 1000)
	end
end)

function ResetCooldownTimer(source)
    for k,v in pairs(cooldownTimer) do
        if v.identifier == source then
            table.remove(cooldownTimer,k)
        end
    end
end

function CheckCooldownTimer(source)
    for k,v in pairs(cooldownTimer) do
        if v.identifier == source then
            return true
        end
    end
    return false
end

RegisterServerEvent('ev-activities:givePayout')
AddEventHandler('ev-activities:givePayout', function(amount, pType, text)
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()

    if pType == "cash" then
        user:addMoney(amount)
    elseif pType == "bank" then
        user:addBank(amount)
    end

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** ev [Activities] | Payout Log **",
          ["description"] = "Log | Amount: $"..amount.." | Type: "..pType.." | Job Type (Buff / No Buff): "..text.." | Character Name: "..charInfo.first_name.." "..charInfo.last_name.." | State ID: "..charInfo.id,
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012082748120371200/uKANz5zVohLS7k2k2e9TqIszavZMMGXZB4gssBjzjYBxZhuBh5cozpHIN9dpFlMSkgF0", function(err, text, headers) end, 'POST', json.encode({username = "ev | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)