RegisterServerEvent('ev-hunting:skinReward')
AddEventHandler('ev-hunting:skinReward', function()
  local _source = source
  local user = exports["ev-base"]:getModule("Player"):GetUser(source)
  local randomAmount = math.random(1,50)
  if randomAmount > 1 and randomAmount < 20 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass1', 1)
  elseif randomAmount > 21 and randomAmount < 30 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass2', 1)
  elseif randomAmount > 31 and randomAmount < 44 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass3', 1)
  elseif randomAmount > 45 and randomAmount < 49 then
    TriggerClientEvent('player:receiveItem', _source, "huntingcarcass4", 1)
  end
end)

RegisterServerEvent('ev-hunting:removeBait')
AddEventHandler('ev-hunting:removeBait', function()
  local _source = source
  local user = exports["ev-base"]:getModule("Player"):GetUser(source)
  TriggerClientEvent('inventory:removeItem', _source, "huntingbait", 1)
end)

RegisterServerEvent('complete:job')
AddEventHandler('complete:job', function(totalCash)
  local _source = source
  local user = exports["ev-base"]:getModule("Player"):GetUser(source)
  user:addMoney(totalCash)
  TriggerEvent('ev-base:huntingLog', _source, totalCash)
end)