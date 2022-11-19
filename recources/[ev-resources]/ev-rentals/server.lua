

RegisterServerEvent('ev-carrent:hasmoney')
AddEventHandler('ev-carrent:hasmoney', function(price, vehicle)
    local vehicleName = vehicle
    local user = exports["ev-base"]:getModule("Player"):GetUser(source)
    local money = tonumber(user:getCash())
    if money >= price then
            user:removeMoney(price)
            TriggerClientEvent("ev-carrent:spawncar", user.source, vehicleName)
    else
            TriggerClientEvent('DoLongHudText', user.source, 'You dont have enough money on you!', 2)
    end
end)






