AddEventHandler("ev-companions:showPetshop", function(pArgs, pEntity, pContext)
    local data = {}

    for _, pet in ipairs(pArgs["Pets"]) do
        pet.type = pArgs["Type"]
        pet.department = pArgs["Department"]

        table.insert(data, {
            title = pet.name,
            description = "$" .. pet.price,
            children = {
                { title = "Confirmar Purchase", action = "ev-pets:purchasePet", key = pet },
            },
        })
    end

    exports["ev-ui"]:showContextMenu(data)
end)

RegisterUICallback("ev-pets:purchasePet", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = "" } })
    exports["ev-ui"]:closeApplication("context")

    exports["ev-ui"]:openApplication("textbox", {
        callbackUrl = "ev-pets:purchasePetDone",
        key = data,
        items = {{icon = "paw", label = "Animal name", name = "name"}},
        show = true
    })
end)

RegisterUICallback("ev-pets:purchasePetDone", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = "" } })
    exports["ev-ui"]:closeApplication("textbox")

    local r = RPC.execute("ev-pets:purchasePet", data)
    if not r then return end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)

    for i, v in ipairs(PetshopConfig) do
        exports["ev-npcs"]:RegisterNPC(v["NPC"], "ev-companions")
        local group = { "isPetshopSeller" }

        local data = {
            {
                id = "petshop_" .. i,
                label = v["Label"],
                icon = "paw",
                event = "ev-companions:showPetshop",
                parameters = v,
            }
        }

        local options = {
            distance = { radius = 2.5 },
            -- isEnabled = function()
            --     return exports["isPed"]:isPed("myjob") == v["Job"]
            -- end
        }

        exports["ev-interact"]:AddPeekEntryByFlag(group, data, options)
    end
end)

RegisterCommand('pet', function(source, args, RawCommand)
    for i, v in ipairs(PetshopConfig) do
        TriggerEvent("ev-companions:showPetshop", v)
    end
end)