local currentBanks = {}
local groupTable = {}

RPC.register("ev-phone:addToCurrentBanks", function(pSource, pBank)
    currentBanks[#currentBanks+1] = {
        bankName = pBank.bankName,
        bankExpires = pBank.bankExpires,
        status = pBank.status,
        bankID = pBank.bankID
    }
end)

RPC.register("ev-phone:getCurrentBanks", function(pSource)
    return currentBanks
end)

RPC.register("ev-phone:requestPlayerToGroup", function(pSource, pCid, pGroupID)
    local serverID = getPlayerFromCidForCharge(pCid)
    TriggerClientEvent("SendHeistRequestNotification", serverID, {
        groupID = pGroupID,
        targetID = serverID,
        senderID = pSource,
        targetCID = pCid
    })
end)

RPC.register("ev-phone:addPlayerToGroup", function(pSource, pCid, pGroupID, pSenderID)
    for k,v in pairs(groupTable) do
        if tonumber(pGroupID) == k then
            groupTable[k].members[#groupTable[k].members+1] = {
                ["cid"] = pCid,
                ["name"] = getFullNameFromCid(pCid),
                ["leader"] = false
            }
            TriggerClientEvent("SendHeistNotification", pSenderID, "Player joined")
        end
    end 
end)

RPC.register('ev-phone:removePlayerFromGroup', function(pSource, pCid, pGroupID)
    local jsonDecodedGroups = json.decode(groupTable)
    for k,v in pairs(jsonDecodedGroups) do
        if pGroupID == k then
            local jsonDecodedGroupMembers = json.decode(v.members)
            for j,s in pairs(jsonDecodedGroupMembers) do
                if pCid == tonumber(s.cid) then
                    table.remove(jsonDecodedGroupMembers, pCid)
                end
            end
        end
    end
end)

RPC.register("ev-phone:createGroup", function(pSource)
    local user = exports['ev-base']:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()
    local cid = char.id
    local getRandomInt = math.random(1, 999999999)
    groupTable[#groupTable+1] = {
        members = {
            [getRandomInt] = {
                ["cid"] = cid,
                ["name"] = getFullNameFromCid(cid),
                ["leader"] = true
            }
        }
    }
end)

RPC.register('ev-phone:deleteGroup', function(pSource, pGroupID)
    local jsonDecodedGroups = json.decode(groupTable)
    table.remove(jsonDecodedGroups, pGroupID)
    groupTable = json.encode(jsonDecodedGroups)
end)

RPC.register('ev-phone:getMyGroup', function(pSource, pCid)
    local jsonDecodedGroups = json.decode(groupTable)
    for k,v in pairs(jsonDecodedGroups) do
        local jsonDecodedGroupMembers = json.decode(v.members)
        for j,s in pairs(jsonDecodedGroupMembers) do
            if tonumber(s.cid) == pCid then
                local myGroupReturned = {
                    members = v.members
                }
                return myGroupReturned
            end
        end
    end
end)

RPC.register('getBankBusterGroups', function(pSource)
    return getBankBusterGroups()
end)

function getBankBusterGroups()
    return groupTable
end

function getFullNameFromCid(pCid)
    local data = MySQL.query.await([[
        SELECT * FROM characters WHERE id = ?
    ]], {pCid})
    return data[1].first_name .. " " .. data[1].last_name
end

function addBankBusters(pBanks)
    currentBanks = {}
    for k,v in pairs(pBanks) do
        currentBanks[#currentBanks+1] = {
            bankName = v.bankName,
            bankExpires = translateOSTimeBB(v.bankExpires),
            status = v.status,
            bankID = v.bankID
        }
    end
end

function translateOSTimeBB(pT)
    local newTime = tonumber(pT) - os.time()
    local finalTime = os.date('%Hh %Mm', newTime)
    return finalTime
end

exports('addBankBusters', addBankBusters)
exports('getBankBusterGroups', getBankBusterGroups)

RegisterCommand("addBankBusters", function(source, args, user)
    local pShit = {
        [1] = {
            bankName = 'Fleeca Bank (Legion)',
            bankExpires = os.time() + 28800,
            status = "Active",
            bankID = 1
        },
        [2] = {
            bankName = 'Fleeca Bank (Hawick)',
            bankExpires = os.time() + 28800,
            status = "Active",
            bankID = 2
        }
    }
    addBankBusters(pShit)
end)