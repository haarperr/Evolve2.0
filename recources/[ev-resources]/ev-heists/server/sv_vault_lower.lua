AddEventHandler("explosionEvent", function(sender, ev)
    TriggerClientEvent('ev-vaultrob:lower:vaultdoor', sender)
end)