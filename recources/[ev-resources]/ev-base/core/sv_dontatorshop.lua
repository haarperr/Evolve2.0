--// Server Side Enter Casino //--

RegisterServerEvent('ev-base:donationShopEnter')
AddEventHandler('ev-base:donationShopEnter', function()
    local src = source
    local user = exports['ev-base']:getModule('Player'):GetUser(src)
    local identifiers = GetPlayerIdentifiers(src)
    local pName = GetPlayerName(source)
    local pDiscord = 'None'
    local pSteam = 'None'

    exports.oxmysql:execute('SELECT * FROM `donators` WHERE `steam_id` = @SteamID', {['@SteamID'] = identifiers[1]}, function(pValuesDB)

        if pValuesDB[1].steam_id == identifiers[1] then
            TriggerClientEvent('ev-base:enterDonatorShop', src)
            TriggerClientEvent('DoLongHudText',  src, 'If your eyes are scuffed go in and out of first person. | F1 to exit donator shop.', 2)
        
            for k, v in pairs(identifiers) do
                if string.find(v, 'steam') then pSteam = v end
                if string.find(v, 'discord') then pDiscord = v end
            end

            local connect = {
                {
                ["color"] = color,
                ["title"] = "**Donator Shop**",
                ["title"] = string.format("Player Entered Donator Shop | \n\n Steam Name: "..pName.."\n\n━━━━━━━━━━━━━━━━━━\n\n`• Steam: %s`\n\n`• Discord: %s`", identifiers[1], pDiscord)
                }
            }
            PerformHttpRequest("https://discord.com/api/webhooks/1042997870292381748/1MclR-nDmeSwZwwQD0MeJPzafDotV9eJXKvRVkBWeSqByS0vsbjQ32HZMd1y0k2m-XGC", function(err, text, headers) end, 'POST', json.encode({username = "Evolve", embeds = connect, avatar_url = "https://i.imgur.com/L2nIIfT.png"}), { ['Content-Type'] = 'application/json' })
        end
    end)
end)

--// Server Side Check Dono Information //--

RegisterServerEvent('ev-base:donatorShopInformation')
AddEventHandler('ev-base:donatorShopInformation', function()
    local src = source
    local user = exports['ev-base']:getModule('Player'):GetUser(src)
    local identifiers = GetPlayerIdentifiers(src)

    exports.oxmysql:execute('SELECT `car_reedeemables`, `desire_coin_reedeem`, `custom_plate` FROM `donators` WHERE steam_id = @SteamID', {['@SteamID'] = identifiers[1]}, function(pInformation)
        TriggerClientEvent('ev-base:checkDonatorShopInformation', src, pInformation[1].car_reedeemables, pInformation[1].desire_coin_reedeem, pInformation[1].custom_plate)
    end)
end)

RegisterServerEvent('ev-base:updateCharactersDesireCoin')
AddEventHandler('ev-base:updateCharactersDesireCoin', function(pDesireCoinInput)
    local src = source
    local user = exports['ev-base']:getModule("Player"):GetUser(src)
    local identifiers = GetPlayerIdentifiers(src)
    local pCharInfo = user:getCurrentCharacter()
    
    exports.oxmysql:execute("SELECT `desire_coin_reedeem` FROM `donators` WHERE steam_id = @SteamID", {['@SteamID'] = identifiers[1]}, function(pDonationShop2)
        if pDonationShop2[1].desire_coin_reedeem >= tonumber(pDesireCoinInput) then
            exports.oxmysql:execute('UPDATE `donators` SET `desire_coin_reedeem` = @DesireCoinReedeemables WHERE `steam_id` = @SteamIdentifier',
                {
                    ['@DesireCoinReedeemables'] = pDonationShop2[1].desire_coin_reedeem - pDesireCoinInput,
                    ['@SteamIdentifier'] = identifiers[1]
                }, function()
                exports.oxmysql:execute("SELECT `DesireCoin` FROM `characters` WHERE id = @StateID", {['@StateID'] = pCharInfo.id}, function(pDonationShop)
                    exports.oxmysql:execute('UPDATE `characters` SET `DesireCoin` = @DesireCoin WHERE `id` = @StateID',
                        {
                            ['@DesireCoin'] = pDonationShop[1].DesireCoin + pDesireCoinInput,
                            ['@StateID'] = pCharInfo.id
                        }, function()
                    end)
                end)
            end)
        end
    end)
end)

--// Server Side Check Dono Information //--

--// Server Side Of Desire Coin Trade //--

RegisterServerEvent('ev-base:donationShopDesireCoin')
AddEventHandler('ev-base:donationShopDesireCoin', function(pCoinAmount)
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local pCharInfo = user:getCurrentCharacter()
    local identifiers = GetPlayerIdentifiers(src)
    local pName = GetPlayerName(src)
    local pDiscord = 'None'
    local pSteam = 'None'
    local x2 = 10000

    exports.oxmysql:execute("SELECT `DesireCoin` FROM `characters` WHERE id = @StateID", {['@StateID'] = pCharInfo.id}, function(pDonationShop)
        if pDonationShop[1].DesireCoin >= pCoinAmount then
            user:addMoney(pCoinAmount*x2)
            exports.oxmysql:execute('UPDATE `characters` SET `DesireCoin` = @DesireCoin WHERE `id` = @StateID',
                {
                    ['@DesireCoin'] = pDonationShop[1].DesireCoin - pCoinAmount,
                    ['@StateID'] = pCharInfo.id
                }, function()
            end)

            for k, v in pairs(identifiers) do
                if string.find(v, 'steam') then pSteam = v end
                if string.find(v, 'discord') then pDiscord = v end
            end

            local connect = {
                {
                    ["color"] = color,
                    ["title"] = "**Donator Shop**",
                    ["title"] = string.format("Reedeemed Desire Coin | \n\n Amount Of Tokens Removed: "..pCoinAmount.." \n\n Amount Of Money Reiceved: $"..pCoinAmount*x2.."  \n\n Steam Name: "..pName.."\n\n━━━━━━━━━━━━━━━━━━\n\n`• Steam Identifier: %s`\n\n`• Discord: %s`", identifiers[1], pDiscord)
                }
            }
            PerformHttpRequest("https://discord.com/api/webhooks/1042997870292381748/1MclR-nDmeSwZwwQD0MeJPzafDotV9eJXKvRVkBWeSqByS0vsbjQ32HZMd1y0k2m-XGC", function(err, text, headers) end, 'POST', json.encode({username = "Evolve", embeds = connect, avatar_url = "https://i.imgur.com/L2nIIfT.png"}), { ['Content-Type'] = 'application/json' })
        end
    end)
end)

--// Server Side Of Desire Coin Trade //--

--// Server Side Reedeem Donator Car //--

RegisterServerEvent('ev-base:donatorShopReedeemVehicleToken')
AddEventHandler('ev-base:donatorShopReedeemVehicleToken', function(pCarModel, pCarPlate, pType)
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local pCharInfo = user:getCurrentCharacter()
    local identifiers = GetPlayerIdentifiers(src)
    local pVehPlate = GeneratePlate()
    local pName = GetPlayerName(src)
    local pDiscord = 'None'
    local pSteam = 'None'

    exports.oxmysql:execute("SELECT * FROM `donators` WHERE steam_id = @SteamID", {['@SteamID'] = identifiers[1]}, function(pDonationShop)
        if pDonationShop[1].car_reedeemables >= 1 then
            if pType == "Generated" then
                -- Removing Token --
                exports.oxmysql:execute('UPDATE `donators` SET `car_reedeemables` = @NewCarReedeemAmount WHERE `steam_id` = @SteamIdentifier',
                    {
                        ['@NewCarReedeemAmount'] = pDonationShop[1].car_reedeemables - 1,
                        ['@SteamIdentifier'] = identifiers[1]
                    }, function()
                end)

                -- Inserting Vehicle --
                exports.oxmysql:execute("INSERT INTO characters_cars (cid, model, current_garage, name, license_plate, vehicle_state) VALUES (@cid, @model, @current_garage, @name, @license_plate, @vehicle_state)", {
                    ['@cid'] = pCharInfo.id,
                    ['@model'] = pCarModel,
                    ['@current_garage'] = "C",
                    ['@name'] = pCarModel,
                    ['@license_plate'] = pVehPlate,
                    ['@vehicle_state'] = "In"
                })
                TriggerClientEvent('phone:addnotification', src, 'Donator Shop', 'Success, vehicle is in Alta St Garage.')

                for k, v in pairs(identifiers) do
                    if string.find(v, 'steam') then pSteam = v end
                    if string.find(v, 'discord') then pDiscord = v end
                end
    
                local connect = {
                    {
                    ["color"] = color,
                    ["title"] = "**Donator Shop [Generated Plate]**",
                    ["title"] = string.format("Reedeemed Vehicle [Generated Plate] \n\n Model: "..pCarModel.." | Plate: "..pVehPlate.." \n\n Character Name: "..pCharInfo.first_name.. " " ..pCharInfo.last_name.." \n\n State ID: "..pCharInfo.id.."\n\n Steam Name: "..pName.."\n\n━━━━━━━━━━━━━━━━━━\n\n`• Steam: %s`\n\n`• Discord: %s`", identifiers[1], pDiscord)
                    }
                }
                PerformHttpRequest("https://discord.com/api/webhooks/1042997870292381748/1MclR-nDmeSwZwwQD0MeJPzafDotV9eJXKvRVkBWeSqByS0vsbjQ32HZMd1y0k2m-XGC", function(err, text, headers) end, 'POST', json.encode({username = "Evolve", embeds = connect, avatar_url = "https://i.imgur.com/L2nIIfT.png"}), { ['Content-Type'] = 'application/json' })
            elseif pType == "Custom" then
                exports.oxmysql:execute('SELECT * FROM `donators` WHERE steam_id = @SteamID', {['@SteamID'] = identifiers[1]}, function(DataPlateUse)
                    if DataPlateUse[1].custom_plate >= 1 then
                        -- Remove Plate Use --
                        exports.oxmysql:execute('UPDATE `donators` SET `custom_plate` = @NewPlateAmt WHERE `steam_id` = @SteamIdentifier',
                            {
                                ['@NewPlateAmt'] = DataPlateUse[1].custom_plate - 1,
                                ['@SteamIdentifier'] = identifiers[1]
                            }, function()
                        end)
                        -- Removing Token --
                        exports.oxmysql:execute('UPDATE `donators` SET `car_reedeemables` = @NewCarReedeemAmount WHERE `steam_id` = @SteamIdentifier',
                            {
                                ['@NewCarReedeemAmount'] = pDonationShop[1].car_reedeemables - 1,
                                ['@SteamIdentifier'] = identifiers[1]
                            }, function()
                        end)

                        -- Inserting Vehicle --
                        exports.oxmysql:execute("INSERT INTO characters_cars (cid, model, current_garage, name, license_plate, vehicle_state) VALUES (@cid, @model, @current_garage, @name, @license_plate, @vehicle_state)", {
                            ['@cid'] = pCharInfo.id,
                            ['@model'] = pCarModel,
                            ['@current_garage'] = "C",
                            ['@name'] = pCarModel,
                            ['@license_plate'] = pCarPlate,
                            ['@vehicle_state'] = "In"
                        })
                        TriggerClientEvent('phone:addnotification', src, 'Donator Shop', 'Success, vehicle is in Alta St Garage.')

                        for k, v in pairs(identifiers) do
                            if string.find(v, 'steam') then pSteam = v end
                            if string.find(v, 'discord') then pDiscord = v end
                        end
            
                        local connect = {
                            {
                            ["color"] = color,
                            ["title"] = "**Donator Shop [Custom Plate]**",
                            ["title"] = string.format("Reedeemed Vehicle [Custom Plate] \n\n Model: "..pCarModel.." | Plate: "..pCarPlate.." \n\n Character Name: "..pCharInfo.first_name.. " " ..pCharInfo.last_name.." \n\n State ID: "..pCharInfo.id.."\n\n Steam Name: "..pName.."\n\n━━━━━━━━━━━━━━━━━━\n\n`• Steam: %s`\n\n`• Discord: %s`", identifiers[1], pDiscord)
                            }
                        }
                        PerformHttpRequest("https://discord.com/api/webhooks/1042997870292381748/1MclR-nDmeSwZwwQD0MeJPzafDotV9eJXKvRVkBWeSqByS0vsbjQ32HZMd1y0k2m-XGC", function(err, text, headers) end, 'POST', json.encode({username = "Evolve", embeds = connect, avatar_url = "https://i.imgur.com/L2nIIfT.png"}), { ['Content-Type'] = 'application/json' })
                    else
                        TriggerClientEvent('DoLongHudText', src, 'You do not have any custom plate uses left.', 2)
                    end
                end)
            end
        end
    end)
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

--// Server Side Reedeem Donator Car //--

--// Server Side Reedeem Donator Plate //--

RegisterServerEvent('ev-base:donatorPlateChangeSV')
AddEventHandler('ev-base:donatorPlateChangeSV', function(pPlate1, pPlate2)
    local src = source
    local user = exports['ev-base']:getModule('Player'):GetUser(src)
    local charData = user:getCurrentCharacter()
    local identifiers = GetPlayerIdentifiers(src)

    exports.oxmysql:execute('SELECT cid FROM `characters_cars` WHERE `license_plate` = @pLicensePlate', {['@pLicensePlate'] = pPlate1}, function(pDataVehTable)

        exports.oxmysql:execute('SELECT * FROM `donators` WHERE steam_id = @SteamID', {['@SteamID'] = identifiers[1]}, function(DataPlateUse)
            if DataPlateUse[1].custom_plate >= 1 then
                if charData.id == pDataVehTable[1].cid then
                    exports.oxmysql:execute('UPDATE `donators` SET `custom_plate` = @DesireCustomPlateReedemables WHERE `steam_id` = @SteamIdentifier',
                        {
                            ['@DesireCustomPlateReedemables'] = DataPlateUse[1].custom_plate - 1,
                            ['@SteamIdentifier'] = identifiers[1]
                        }, function()
                    end)
                    exports.oxmysql:execute('UPDATE `characters_cars` SET `license_plate` = @license_plate WHERE `license_plate` = @pPlate',
                        {
                            ['@license_plate'] = pPlate2,
                            ['@pPlate'] = pPlate1
                        }, function()
                    end)
                    TriggerClientEvent('ev-base:setVehicleNumberPlate', src, pPlate2)
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have any custom plate reedeemables left !', 2)
            end
        end)
    end)
end)