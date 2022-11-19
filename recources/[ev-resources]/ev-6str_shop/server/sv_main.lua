local carTable = {
	[1] = { ["model"] = "gtr", ["baseprice"] = 100000, ["commission"] = 15 }, 
	[2] = { ["model"] = "gt86", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "lc500", ["baseprice"] = 100000, ["commission"] = 15 },
	[4] = { ["model"] = "gtrc", ["baseprice"] = 100000, ["commission"] = 15 },
	[5] = { ["model"] = "lc100", ["baseprice"] = 100000, ["commission"] = 15 },
}

-- Update car table to server
RegisterServerEvent('ev-6str_shop:CarTableTunerShop')
AddEventHandler('ev-6str_shop:CarTableTunerShop', function(table)
    if table ~= nil then
        carTable = table
        TriggerClientEvent('ev-6str_shop:ReturnVehicleTunerTable', -1, carTable)
        for i=1, #carTable do
            exports.oxmysql:execute("UPDATE vehicle_display SET model=@model, name=@name, commission=@commission, baseprice=@baseprice WHERE id=@id", {
                ['@id'] = i,
                ['@model'] = table[i]["model"],
                ['@name'] = table[i]["name"],
                ['@commission'] = table[i]["commission"],
                ['@baseprice'] = table[i]["baseprice"]
            })
        end
    end
end)

-- Enables finance for 60 seconds
RegisterServerEvent('ev-6str_shop:FinaceEnabledSV')
AddEventHandler('ev-6str_shop:FinaceEnabledSV', function(plate)
    if plate ~= nil then
        TriggerClientEvent('ev-6str_shop:FinaceEnabledCL', -1, plate)
    end
end)

RegisterServerEvent('ev-6str_shop:BuyEnabledSV')
AddEventHandler('ev-6str_shop:BuyEnabledSV', function(plate)
    if plate ~= nil then
        TriggerClientEvent('ev-6str_shop:BuyEnabledCL', -1, plate)
    end
end)

-- return table
-- TODO (return db table)
RegisterServerEvent('ev-6str_shop:RequestTableTunerShopCars')
AddEventHandler('ev-6str_shop:RequestTableTunerShopCars', function()
    local user = source
    exports.oxmysql:execute("SELECT * FROM vehicle_display", {}, function(display)
        for k,v in pairs(display) do
            carTable[v.id] = v
            v.price = carTable[v.id].baseprice
        end
        TriggerClientEvent('ev-6str_shop:ReturnVehicleTunerTable', user, carTable)
    end)
end)

-- Check if player has enough money
RegisterServerEvent('ev-6str_shop:ChechMoney')
AddEventHandler('ev-6str_shop:ChechMoney', function(name, model, price)
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getCurrentCharacter().id
    local cash = user:getCash()
    local plate = GeneratePlate()

    if tonumber(cash) >= price then
        user:removeMoney(price)
        TriggerClientEvent('FinishMoneyCheckForVehtuner', src, name, model, price, plate)
    elseif tonumber(cash) <= price then
        TriggerClientEvent('DoLongHudText', src, "You don't have enough money!", 2)
        TriggerClientEvent('ev-6str_shop:FailedPurchase', src)
    end
end)

RegisterServerEvent('ev-6str_shop:BuyVehicle')
AddEventHandler('ev-6str_shop:BuyVehicle', function(plate, name, vehicle, price, personalvehicle)
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local player = user:getVar("hexid")
    local char = user:getVar("character")
    exports.oxmysql:execute('INSERT INTO characters_cars (cid, license_plate, model, data, purchase_price, name, vehicle_state, current_garage) VALUES (@cid, @license_plate, @model, @data, @purchase_price, @name, @vehicle_state, @current_garage)',{
        ['@cid']   = char.id,
        ['@license_plate']  = plate,
        ['@model'] = vehicle,
        ['@data'] = json.encode(personalvehicle),
        ['@name'] = name,
        ['@purchase_price'] = price,
        ['@current_garage'] = "C",
        ['@vehicle_state'] = "Out",
    })
end)

function GeneratePlate()
    local plate = math.random(10, 99) .. "" .. GetRandomLetter(3) .. "" .. math.random(100, 999)
    local result = exports.oxmysql:scalarSync('SELECT license_plate FROM characters_cars WHERE license_plate = @license_plate', {['@license_plate'] = plate})
    if result then
        plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    end
    return plate:upper()
end

local NumberCharset = {}
local Charset = {}

for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomLetter(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end

-- Log --

RegisterServerEvent('ev-cardealer:log')
AddEventHandler('ev-cardealer:log', function(cid, model, price, plate, carDealer)
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)
    local identifiers = GetPlayerIdentifiers(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** ev [Car Dealer] | Car Dealership Log **",
          ["description"] = "Buyer State ID: "..cid.."\n Buyer Steam Name: "..pName.."\n Buyer Steam ID: "..identifiers[1].."\n Vehicle Model: "..model.." \n Purchase Price: $"..price.."\n Vehicle Plate: "..plate.."\n Car Dealership: "..carDealer,
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012082705128759366/CC3mBxVRZgSGPz87L_MuQzldIqf-Y-y50p0BSfDQyD1wfwUVT-YpopWgbZtK5JGJeHMI", function(err, text, headers) end, 'POST', json.encode({username = "ev", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)