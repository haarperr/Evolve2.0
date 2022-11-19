local LootPaleto = false
CnaRob = true
Step1 = false

RegisterServerEvent("step1enable", function()
    local source = source
    Step1 = true
end)

RegisterServerEvent("ev-paleto:startCoolDown", function()
    local source = source
    CnaRob = false
    Available = false
    CreateThread(function()
        while true do
            Citizen.Wait(7200000)
            CnaRob = true
            Available = true
            TriggerServerEvent('ev-doors:change-lock-state', 45, true) 
        end
    end)
end)

RegisterServerEvent('ev-paleto:tut_tut')
AddEventHandler('ev-paleto:tut_tut', function()
    local src = source
    if not LootPaleto then
        LootPaleto = true
        TriggerClientEvent('ev-vault:grab', src)
        Citizen.Wait(40000)
        LootPaleto = false
    end
end)

RegisterServerEvent('ev-paleto:hacklaptop')
AddEventHandler('ev-paleto:hacklaptop', function()
    if Step1 then
        TriggerClientEvent('ev-paleto:startpaleto', source)
    end
end)