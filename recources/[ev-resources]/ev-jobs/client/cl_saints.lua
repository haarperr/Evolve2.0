
Citizen.CreateThread(function()
    exports["ev-polyzone"]:AddBoxZone("saint_stash_1", vector3(-1796.87, 439.61, 128.39), 1, 1, {
        name="saint_stash_1",
        heading=0,
        --debugPoly=false,
        minZ=124.59,
        maxZ=128.59
    })
end)

SaintsStash = false

RegisterNetEvent('ev-polyzone:enter')
AddEventHandler('ev-polyzone:enter', function(name)
    if name == "saint_stash_1" then
        SaintsStash = true     
        SaintsStashhhh()
        local isEmployed = exports["ev-business"]:IsEmployedAt("saints")
        if isEmployed then
            exports['ev-interface']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('ev-polyzone:exit')
AddEventHandler('ev-polyzone:exit', function(name)
    if name == "saint_stash_1" then
        SaintsStash = false
        exports['ev-interface']:hideInteraction()
    end
end)

function SaintsStashhhh()
	Citizen.CreateThread(function()
        while SaintsStash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["ev-business"]:IsEmployedAt("saints")
                if isEmployed then
                    TriggerEvent('ev-stashes:openAspect', 1)
                end
			end
		end
	end)
end

RegisterNetEvent('ev-stashes:openAspect')
AddEventHandler('ev-stashes:openAspect', function(stashNum)
    TriggerEvent('server-inventory-open', '1', 'saints-stash'..stashNum)
end)