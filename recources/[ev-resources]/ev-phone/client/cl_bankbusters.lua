local currentGroups = {}

RegisterNetEvent("ev-phone:addToCurrentBanks", function(data)
    local addedBank = {
        bankName = data.bankName,
        bankExpires = data.bankExpires,
        status = data.status,
        bankID = data.bankID
    }
    RPC.execute("ev-phone:addToCurrentBanks", addedBank)
end)

RegisterNUICallback('tryClaimBank', function(data, cb)
    print('add your event here ! : bank id: ', data.bbid)
end)

RegisterNUICallback('getCurrentBanks', function(data, cb)
    local banks = RPC.execute('ev-phone:getCurrentBanks')
    currentGroups = RPC.execute("getBankBusterGroups")
    SendNUIMessage({
        openSection = "sendCurrentBanks",
        bankData = banks,
    })
end)

RegisterNUICallback('inBankBusterGroup', function()
    for k,v in pairs(currentGroups) do
        local nec = v.members
        for j,s in pairs(nec) do
            if  tonumber(s.cid) == exports['isPed']:isPed("cid") then
                SendNUIMessage({
                    openSection = "sendBankBusterGroup",
                    groupID = k
                })
                buildBankBustersGroup(k)
            else
                SendNUIMessage({
                    openSection = "sendBankBusterGroup",
                    groupID = "none"
                })
            end
        end
    end
end)

RegisterNetEvent("SendHeistNotification", function(pMsg)
    phoneNotification("misc",pMsg,"Heist")
end)

RegisterNetEvent("SendHeistRequestNotification", function(pData)
    local title = "Bank Busters"
    data = {bankBusterGroupID = pData.groupID, bankBusterTargetID = pData.targetID, bankBusterSenderID = pData.senderID, bankBusterTargetCID = pData.targetCID, amount = "Someone invited you to join their group!"}
    phoneBillNotification("bankbusters", data, title)
end)

RegisterNUICallback('onPlayerJoinBankBusters', function(data, cb)
    RPC.execute("ev-phone:addPlayerToGroup", tonumber(data.targetCID), data.groupID, tonumber(data.senderID))
end)

local newGroupTable = {}
function buildNewGroupTable(oldGroupTable)
    newGroupTable = {}
    for k,v in pairs(oldGroupTable) do
        newGroupTable[#newGroupTable+1] = {
            ["cid"] = v.cid,
            ["name"] = v.name,
            ["leader"] = v.leader
        }
    end
    return newGroupTable
end

function buildBankBustersGroup(groupID)
    local myGroup = buildNewGroupTable(currentGroups[groupID].members)
    for k,v in pairs(myGroup) do
        print(v.cid, v.name, v.leader)
    end
    SendNUIMessage({
        openSection = "buildBankBustersGroup",
        bankBustersGroupData = myGroup
    })
end

RegisterNUICallback('addBankbusterGroup', function(data, cb)
    RPC.execute("ev-phone:requestPlayerToGroup", tonumber(data.cid), data.groupID)
end)

RegisterNUICallback('createBankbusterGroup', function(data, cb)
    RPC.execute("ev-phone:createGroup")
end)

RegisterNUICallback('leaveBankbusterGroup', function(data, cb)
    for k,v in pairs(currentGroups) do
        for j,s in pairs(v.members) do
            if tonumber(s.cid) == tonumber(data.cid) and s.leader then
                RPC.execute("ev-phone:deleteGroup", data.groupID)
            elseif tonumber(s.cid) == tonumber(data.cid) then
                RPC.execute("ev-phone:removePlayerFromGroup", tonumber(data.cid), data.groupID)
            end
        end
    end
end)