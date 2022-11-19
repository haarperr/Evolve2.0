function isAdministrator(src)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
	local rank = user:getRank()
	if rank == "admin" or rank == "dev" or rank == "owner" then
        return true, rank
	end

    return false, rank
end

exports("isAdministrator", isAdministrator)

function giveLicense(src, license)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    if not user then return false end
    local char = user:getCurrentCharacter()

    local update = Await(SQL.execute("UPDATE user_licenses SET status = @status WHERE cid = @cid AND type = @type", {
        ["@status"] = 1,
        ["@cid"] = char.id,
        ["@type"] = license
    }))

    if not update then return false end

    return true
end

exports("giveLicense", giveLicense)


function updateGarage(src, license_plate, garage)
    local update = Await(SQL.execute("UPDATE characters_cars SET current_garage = @current_garage WHERE license_plate = @license_plate", {
        ["@current_garage"] = garage,
        ["@license_plate"] = license_plate
    }))

    if not update then return false end

    return true
end

exports("updateGarage", updateGarage)

function giveJobWhitelist(src, job, rank)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    if not user then return false end
    local char = user:getCurrentCharacter()

    local update = Await(SQL.execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {
        ["@cid"] = char.id,
        ["@job"] = job,
        ["@rank"] = rank
    }))

    if not update then return false end

    return true
end

exports("giveJobWhitelist", giveJobWhitelist)

function giveCash(src, amount)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    if not user then return false end
    user:addMoney(tonumber(amount))

    return true
end

exports("giveCash", giveCash)

function sendLog(link, color, title, description, footer)
    local connect = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] = description,
	        ["footer"] = {
                ["text"] = footer,
            },
        }
    }
    PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "DesireRP",  avatar_url = "https://cdn.discordapp.com/attachments/991122949828530258/992926357413711872/unknown.png",embeds = connect}), { ['Content-Type'] = 'application/json' })
end

exports("sendLog", sendLog)

RegisterNetEvent("desirerp:admin:searchPlayerInventory")
AddEventHandler("desirerp:admin:searchPlayerInventory", function(pTarget)
    local user = exports["ev-base"]:getModule("Player"):GetUser(tonumber(pTarget))
    local cid = user:getCurrentCharacter().id
    TriggerClientEvent("server-inventory-open", source, "1", 'ply-'..cid)
end)

RegisterServerEvent('ev-admin:insertPrio')
AddEventHandler('ev-admin:insertPrio', function()
    local src = source
    local sid = GetPlayerIdentifiers(src)[1]

    exports.oxmysql:execute("INSERT INTO player_prio (steam_id, prioType) VALUES (@steam_id, @prioType)",
    {
        ['@steam_id'] = sid,
        ['@prioType'] = '0',
    })
end)