local function checkExistenceClothes(cid, cb)
    exports.oxmysql:execute("SELECT cid FROM character_current WHERE cid = @cid LIMIT 1;", {["cid"] = cid}, function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end

local function checkExistenceFace(cid, cb)
    exports.oxmysql:execute("SELECT cid FROM character_face WHERE cid = @cid LIMIT 1;", {["cid"] = cid}, function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end

RegisterServerEvent("ev-clothes:insert_character_current")
AddEventHandler("ev-clothes:insert_character_current",function(data)
    if not data then return end
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getCurrentCharacter().id
    if not characterId then return end
    checkExistenceClothes(characterId, function(exists)
        local values = {
            ["cid"] = characterId,
            ["model"] = json.encode(data.model),
            ["drawables"] = json.encode(data.drawables),
            ["props"] = json.encode(data.props),
            ["drawtextures"] = json.encode(data.drawtextures),
            ["proptextures"] = json.encode(data.proptextures),
        }

        if not exists then
            local cols = "cid, model, drawables, props, drawtextures, proptextures"
            local vals = "@cid, @model, @drawables, @props, @drawtextures, @proptextures"

            exports.oxmysql:execute("INSERT INTO character_current ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end

        local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
        exports.oxmysql:execute("UPDATE character_current SET "..set.." WHERE cid = @cid", values)
    end)
end)

RegisterServerEvent("ev-clothes:insert_character_face")
AddEventHandler("ev-clothes:insert_character_face",function(data)
    print(json.encode(data.fadeStyle))
    if not data then return end
    local src = source

    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getCurrentCharacter().id

    if not characterId then return end

    checkExistenceFace(characterId, function(exists)
        local values = {
            ["cid"] = characterId,
            ["hairColor"] = json.encode(data.hairColor),
            ["headOverlay"] = json.encode(data.headOverlay),
            ["headStructure"] = json.encode(data.headStructure),
            ["headFade"] = json.encode(data.fadeStyle),
        }

        if not exists then
            local cols = "cid, hairColor, headOverlay, headStructure, headFade"
            local vals = "@cid, @hairColor,  @headOverlay, @headStructure, @headFade"

            exports.oxmysql:execute("INSERT INTO character_face ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end

        local set = "hairColor = @hairColor, headOverlay = @headOverlay,headStructure = @headStructure,headFade = @headFade"
        exports.oxmysql:execute("UPDATE character_face SET "..set.." WHERE cid = @cid", values )
    end)
end)

RegisterServerEvent("ev-clothes:insert_character_face_blend")
AddEventHandler("ev-clothes:insert_character_face_blend",function(data)
    print(json.encode(data.fadeStyle))
    if not data then return end
    local src = source

    local user = exports["ev-base"]:getModule("Player"):GetUser(src) 
    local characterId = user:getCurrentCharacter().id

    if not characterId then return end

    print(json.encode(data.headBlend))

    checkExistenceFace(characterId, function(exists)
        if data.headBlend == "null" or data.headBlend == nil then
            data.headBlend = '[]'
        else
            data.headBlend = json.encode(data.headBlend)
        end
        local values = {
            ["cid"] = characterId,
            ["headBlend"] = data.headBlend,
        }

        if not exists then
            local cols = "cid, headBlend"
            local vals = "@cid, @headBlend"

            exports.oxmysql:execute("INSERT INTO character_face ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end

        local set = "headBlend = @headBlend"
        exports.oxmysql:execute("UPDATE character_face SET "..set.." WHERE cid = @cid", values )
    end)
end)


RegisterServerEvent("ev-clothes:get_character_face")
AddEventHandler("ev-clothes:get_character_face",function(pSrc, fadeStyle)
    local src = (not pSrc and source or pSrc)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getCurrentCharacter().id
 
    if not characterId then return end

    exports.oxmysql:execute("SELECT cc.model, cf.hairColor, cf.headBlend, cf.headOverlay, cf.headStructure, cf.headFade FROM character_face cf INNER JOIN character_current cc on cc.cid = cf.cid WHERE cf.cid = @cid", {['cid'] = characterId}, function(result)
        if (result ~= nil and result[1] ~= nil) then
            local temp_data = {
                hairColor = json.decode(result[1].hairColor),
                headBlend = json.decode(result[1].headBlend),
                headOverlay = json.decode(result[1].headOverlay),
                headStructure = json.decode(result[1].headStructure),
                headFade = json.decode(result[1].fadeStyle),
            }
            local model = tonumber(result[1].model)
            if model == 1885233650 or model == -1667301416 then
                TriggerClientEvent("ev-clothes:setpedfeatures", src, temp_data)
            end
        else
            TriggerClientEvent("ev-clothes:setpedfeatures", src, false)
        end
	end)
end)

RegisterServerEvent("ev-clothes:get_character_current")
AddEventHandler("ev-clothes:get_character_current",function(pSrc)
    local src = (not pSrc and source or pSrc)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getCurrentCharacter().id

    if not characterId then return end 

    exports.oxmysql:execute("SELECT * FROM character_current WHERE cid = @cid", {['cid'] = characterId}, function(result)
        local temp_data = {
            model = result[1].model,
            drawables = json.decode(result[1].drawables),
            props = json.decode(result[1].props),
            drawtextures = json.decode(result[1].drawtextures),
            proptextures = json.decode(result[1].proptextures),
        }
        TriggerClientEvent("raid_clothes:setclothes", src, temp_data,0)
	end)
end)

RegisterServerEvent("ev-clothes:retrieve_tats")
AddEventHandler("ev-clothes:retrieve_tats", function(pSrc)
    local src = (not pSrc and source or pSrc)
	local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	exports.oxmysql:execute("SELECT * FROM character_tattoos WHERE cid = @identifier", {['identifier'] = char.id}, function(result)
        if(#result == 1) then
			--TriggerClientEvent("raid_clothes:settattoos", src, json.decode(result[1].tattoos))
		else
			local tattooValue = "{}"
			exports.oxmysql:execute("INSERT INTO character_tattoos (cid, tattoos) VALUES (@identifier, @tattoo)", {['identifier'] = char.id, ['tattoo'] = tattooValue})
			--TriggerClientEvent("raid_clothes:settattoos", src, {})
		end
	end)
end)

RegisterServerEvent("ev-clothes:set_tats")
AddEventHandler("ev-clothes:set_tats", function(data)
	local src = source
	local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	exports.oxmysql:execute("UPDATE character_tattoos SET tattoos = @tattoos WHERE cid = @identifier", {['tattoos'] = json.encode(data.tattoos), ['identifier'] = char.id})
end)

RegisterServerEvent('ev-clothes:loadPlayerSkin')
AddEventHandler('ev-clothes:loadPlayerSkin', function(ped)
    local src = source
    local user = exports['ev-base']:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local result = exports.oxmysql:executeSync('SELECT * FROM playerskins WHERE citizenid = ?', { char.id })
    print(char.id)
    print(json.encode(result))

    if result[1] ~= nil then
        print("Loading skin 1")
        TriggerClientEvent("ev-clothes:loadSkin", src, ped, json.decode(result[1].skin))
    else
        print("Loading skin 2")
        TriggerClientEvent("ev-clothes:loadSkin", src)
    end
end)

RPC.register('ev-clothes:getCosts', function(source, type, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money[type] >= tonumber(amount) then
        return true
    else
        return false
    end
end)

RPC.register("ev-clothes:getTextureNames", function(source, name)
    local data = LoadResourceFile(GetCurrentResourceName(), "./client/names.json")
    data = json.decode(data)

    if data then
        return data[1][name]
    else 
        return {}
    end
end)

RPC.register("ev-clothes:getPlayerGender", function(pSource)
    local user = exports['ev-base']:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()
    return char.gender
end)

--[[ RPC.register("ev-clothes:purchaseClothes", function(pSource, pType, pAmount)
    local user = exports['ev-base']:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()
    --user:getBalance()
    if pType == "cash" then
        if user:getCash() >= tonumber(pAmount) then
            user:removeCash(tonumber(pAmount))
            return true
        end 
        return false
    elseif pType == "bank" then
        if user:getBalance() >= tonumber(pAmount) then
            user:removeBank(tonumber(pAmount))
            return true
        end
        return false
    end
end) ]]

RPC.register("ev-clothes:purchaseClothes",function(pSource, pType, pAmount)
    local src = source
    local user = exports["ev-base"]:getModule("Player"):GetUser(pSource)
    if user:getCash() >= pAmount then
        user:removeMoney(pAmount)
    else
        TriggerClientEvent('DoLongHudText', src, 'You do not have enough money ! Required Ammount : $200', 2)
    end
    return true
end)
