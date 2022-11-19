
function GetBanTime(Expires)
    local Time = os.time()
    local Expiring = nil
    local ExpD = nil
    if Expires == '1hr' then
        Expiring = os.date("*t", Time + 3600)
        ExpD = tonumber(Time + 3600)
    elseif Expires == '6hrs' then
        Expiring = os.date("*t", Time + 21600)
        ExpD = tonumber(Time + 21600)
    elseif Expires == '12hrs' then
        Expiring = os.date("*t", Time + 43200)
        ExpD = tonumber(Time + 43200)
    elseif Expires == '1day' then
        Expiring = os.date("*t", Time + 86400)
        ExpD = tonumber(Time + 86400)
    elseif Expires == '3days' then
        Expiring = os.date("*t", Time + 259200)
        ExpD = tonumber(Time + 259200)
    elseif Expires == '1week' then
        Expiring = os.date("*t", Time + 604800)
        ExpD = tonumber(Time + 604800)
    elseif Expires == 'perm' then
        Expiring = os.date("*t", Time + 315360000) -- 10 Years
        ExpD = tonumber(Time + 315360000)
    end
    return Expiring, ExpD
end

function GetIds(src)
    local ids = {}

    for k,v in pairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            ids["hex"] = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            ids["license"] = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            ids["xbl"] = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ids["ip"] = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            ids["discord"] = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            ids["live"] = v
        end
    end

    if not ids["ip"] then
        ids["ip"] = GetPlayerEndpoint(src)
    end

    if not ids["steamid"] and ids["hex"] then
        ids["steamid"] = HexIdToSteamId(ids["hex"])
    end

    return ids
end

function HexIdToSteamId(hexid)
    local cid = HexIdToComId(hexid)
    local steam64 = math.floor(tonumber(string.sub( cid, 2)))
    local a = steam64 % 2 == 0 and 0 or 1
    local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
    local sid = "STEAM0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end

function HexIdToComId(hexid)
    return math.floor(tonumber(string.sub(hexid, 7), 16))
end

function IsSteamId(id)
    id = tostring(id)
    if not id then return false end
    if string.match(id, "^STEAM[01]:[01]:%d+$") then return true else return false end
end

function stringsplit(string, split)
    local t = {}
    local i = 0
    local f = string.find(string, split, 1, true)
    while f do
        i = i + 1
        t[i] = string.sub(string, 1, f-1)
        string = string.sub(string, f+1)
        f = string.find(string, split, 1, true)
    end
    i = i + 1
    t[i] = string
    return t
end

function getIdentifier(self, src, identifier)
    local ids = GetPlayerIdentifiers(src)
    for k, v in ipairs(ids) do
        for _, id in ipairs(stringsplit(v, ":")) do
            if id == identifier then
                return v
            end
        end
    end
    return false
end

function getUserToken(self, src)
    local tokens = {}
    for i = 0, GetNumPlayerTokens(src) do
        table.insert(tokens, GetPlayerToken(src, i))
    end

    Wait(100)

    if (#tokens > 0) then
        return tokens
    else
        return nil
    end
end

function generateUniqueBanId()
    math.randomseed(GetGameTimer())
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

local function getDate2(sec)
    local date = os.date("!*t", sec)
    return date["day"]-1, date["hour"], date["min"], date["sec"]
end

function isVerifiedAdmin(src)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
	local rank = user:getRank()
    if rank ~= 'user' then 
        return true 
    end 
    return false
end

function getevAdminifiers(pPlayer, pType)
    local Retval = nil
    local steamid  = ""
    local license2  = ""
    local discord  = ""
    local xbl      = ""
    local liveid   = ""
    local ip       = ""
    for e,k in pairs(GetPlayerIdentifiers(pPlayer))do
        if string.sub(k, 1, string.len("steam:")) == "steam:" then
            steamid = k
        elseif string.sub(k, 1, string.len("license:")) == "license:" then
            license2 = k
        elseif string.sub(k, 1, string.len("xbl:")) == "xbl:" then
            xbl  = k
        elseif string.sub(k, 1, string.len("ip:")) == "ip:" then
            ip = k
        elseif string.sub(k, 1, string.len("discord:")) == "discord:" then
            discord = k
        elseif string.sub(k, 1, string.len("live:")) == "live:" then
            liveid = k
        end
        if pType == "discord" then
            Retval = discord
        elseif pType == "ip" then
            Retval = ip
        elseif pType == "steam" then
            Retval = steamid
        end 
      end
    return Retval
end

local count = 0
RegisterNetEvent("ev:admin/server/ban-player", function(ServerId, Expires, Reason)
     -- Check if source exist

    -- 1 day = 86400
    local staff = source
    local banId = generateUniqueBanId()
    local banLength = Expires
    local pBanDate = os.time()
    local bannedBy = "Anticheat"
    local pUnbanDate = nil
    local pReason = Reason
    local pSteamId = getIdentifier(self, ServerId, "steam")
    local pLicense = getIdentifier(self, ServerId, "license")
    local pLicense2 = getIdentifier(self, ServerId, "license2")
    local pXbox = getIdentifier(self, ServerId, "xbox")
    local pLive = getIdentifier(self, ServerId, "live")
    local pDiscord = getIdentifier(self, ServerId, "discord")
    local pCFX = getIdentifier(self, ServerId, "fivem")
    local pIp = getIdentifier(self, ServerId, "ip")
    local pTokens = getUserToken(self, ServerId)
    local pTokenData = json.encode(pTokens)
    if banLength == 0 then
        pUnbanDate = 0
    else
        pUnbanDate = math.floor(os.time() + (banLength * 86400))
    end

    print(banId, pSteamId, GetPlayerName(ServerId), pLicense, pLicense2, pXbox, pLive, pDiscord, pCFX, pIp, pTokenData, bannedBy, pBanDate,pUnbanDate, pReason)

    local insertBan = SQL.execute("INSERT INTO bans (banid, steam, name, license, license2, xbox, live, discord, cfx, ip, token, bannedby, bannedon, expire, reason) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", {banId, pSteamId, GetPlayerName(ServerId), pLicense, pLicense2, pXbox, pLive, pDiscord, pCFX, pIp, pTokenData, bannedBy, pBanDate,pUnbanDate, pReason})
    Wait(500)

    local unbanDate
    if (pUnbanDate == 0) then
        unbanDate = "Permanent"
    else
        unbanDate = os.date('%Y-%m-%d', pUnbanDate)
    end
    DropPlayer(ServerId,
        "You are banned, you may appeal it at https://discord.gg/desireroleplay | Ban ID: " .. banId .. " | Reason: " .. pReason ..
            " | Unban Date: " .. unbanDate)
end)

local count = 0

RegisterNetEvent("ev:admin:unBan", function(pBanID)
    print(pBanID)
    local src = source
    if not isVerifiedAdmin(src) then return end

    local BanData = MySQL.query.await('SELECT * FROM bans WHERE banid = ?', {pBanID})
    if BanData and BanData[1] ~= nil then
        MySQL.query('DELETE FROM bans WHERE banid = ?', {pBanID})
        TriggerClientEvent('DoLongHudText', src, "You successfully unbanned the player.", 1)
        loadBanListMenu()
    else
        TriggerClientEvent('DoLongHudText', src, "Something went wrong.. This person is not banned.", 2)
    end
end)