

RegisterServerEvent('ev-civjobs:sell-gem-cash')
AddEventHandler('ev-civjobs:sell-gem-cash', function()
    local src = tonumber(source)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(74, 124)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Gem and got $'..cash, 1)

    exports["ev-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Gem", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('ev-civjobs:sell-stone-cash')
AddEventHandler('ev-civjobs:sell-stone-cash', function()
    local src = tonumber(source)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(35, 74)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Gem and got $'..cash, 1)

    exports["ev-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Stone", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('ev-civjobs:sell-coal-cash')
AddEventHandler('ev-civjobs:sell-coal-cash', function()
    local src = tonumber(source)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(14, 65)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Coal and got $'..cash, 1)

    exports["ev-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Coal", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('ev-civjobs:sell-diamond-cash')
AddEventHandler('ev-civjobs:sell-diamond-cash', function()
    local src = tonumber(source)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(265, 432)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Diamond and got $'..cash, 1)

    exports["ev-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Diamond", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('ev-civjobs:sell-sapphire-cash')
AddEventHandler('ev-civjobs:sell-sapphire-cash', function()
    local src = tonumber(source)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(167, 245)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Sapphire and got $'..cash, 1)

    exports["ev-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Sapphire", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('ev-civjobs:sell-ruby-cash')
AddEventHandler('ev-civjobs:sell-ruby-cash', function()
    local src = tonumber(source)
    local user = exports["ev-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(187, 345)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Ruby and got $'..cash, 1)

    exports["ev-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Ruby", 
        { amount = tostring(cash) })
end)