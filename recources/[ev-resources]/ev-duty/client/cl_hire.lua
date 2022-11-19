RegisterNetEvent("ev-jobsystem:PoliceJobMenu")
AddEventHandler("ev-jobsystem:PoliceJobMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedPD", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:PoliceJobMenu2")
AddEventHandler("ev-jobsystem:PoliceJobMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedPD", valid[1].input)
    end
end)

-- DOJ------------------------------------------------------------------------------------------------------------------
--Judge-----------------------------------

RegisterNetEvent("ev-jobsystem:JudgeJobMenuHire")
AddEventHandler("ev-jobsystem:JudgeJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedJudge", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:JudgeJobMenuFire")
AddEventHandler("ev-jobsystem:JudgeJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedJudge", valid[1].input)
    end
end)
--DA------------------------------------

RegisterNetEvent("ev-jobsystem:DAJobMenuHire")
AddEventHandler("ev-jobsystem:DAJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedDA", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:DAJobMenuFire")
AddEventHandler("ev-jobsystem:DAJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedDA", valid[1].input)
    end
end)

--ADA---------------------------------------

RegisterNetEvent("ev-jobsystem:ADAJobMenuHire")
AddEventHandler("ev-jobsystem:ADAJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedADA", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:ADAJobMenuFire")
AddEventHandler("ev-jobsystem:ADAJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedADA", valid[1].input)
    end
end)

--Defender-------------------------------------------

RegisterNetEvent("ev-jobsystem:DefenderJobMenuHire")
AddEventHandler("ev-jobsystem:DefenderJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedDefender", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:DefenderJobMenuFire")
AddEventHandler("ev-jobsystem:DefenderJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedDefender", valid[1].input)
    end
end)

-- Tow Hire / Fire ----------------------------------------------------------------------------------------------------
RegisterNetEvent("ev-jobsystem:TowJobMenuHire")
AddEventHandler("ev-jobsystem:TowJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedTow", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:TowJobMenuFire")
AddEventHandler("ev-jobsystem:TowJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedTow", valid[1].input)
    end
end)

-- Heat Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:heatJobMenuHire")
AddEventHandler("ev-jobsystem:heatJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassHeat", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:heatJobMenuFire")
AddEventHandler("ev-jobsystem:heatJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassHeat", valid[1].input)
    end
end)

-- Bondi Boys Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:bondiJobMenuHire")
AddEventHandler("ev-jobsystem:bondiJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassBondi", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:bondiJobMenuFire")
AddEventHandler("ev-jobsystem:bondiJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassBondi", valid[1].input)
    end
end)

-- Casino Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:casinoJobMenuHire")
AddEventHandler("ev-jobsystem:casinoJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassCasino", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:casinoJobMenuFire")
AddEventHandler("ev-jobsystem:casinoJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassCasino", valid[1].input)
    end
end)


-- Real Estate Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:reJobMenuHire")
AddEventHandler("ev-jobsystem:reJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassRe", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:reJobMenuFire")
AddEventHandler("ev-jobsystem:reJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassRe", valid[1].input)
    end
end)

-- Rockford Records Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:rrJobMenuHire")
AddEventHandler("ev-jobsystem:rrJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassrr", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:rrJobMenuFire")
AddEventHandler("ev-jobsystem:rrJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassrr", valid[1].input)
    end
end)


-- Yakuza Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:yakuzaJobMenuHire")
AddEventHandler("ev-jobsystem:yakuzaJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassYakuza", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:yakuzaJobMenuFire")
AddEventHandler("ev-jobsystem:yakuzaJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassYakuza", valid[1].input)
    end
end)

-- Winery Job Menu --------------------------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:WineryJobMenuHire")
AddEventHandler("ev-jobsystem:WineryJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassWinery", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:WineryJobMenuFire")
AddEventHandler("ev-jobsystem:WineryJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassWinery", valid[1].input)
    end
end)

--- EMS --------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:EMSJobMenu")
AddEventHandler("ev-jobsystem:EMSJobMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedEMS", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:EMSJobMenu2")
AddEventHandler("ev-jobsystem:EMSJobMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedEMS", valid[1].input)
    end
end)

----AK customs Hire / Fire --------------------------

RegisterNetEvent("ev-jobsystem:AkJobMenuHire")
AddEventHandler("ev-jobsystem:AkJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassAk_customs", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:AkJobMenuFire")
AddEventHandler("ev-jobsystem:AkJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassAk_customs", valid[1].input)
    end
end)

---- Radical Hire / Fire --------------------------

RegisterNetEvent("ev-jobsystem:RadicalJobMenuHire")
AddEventHandler("ev-jobsystem:RadicalJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassRadical", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:RadicalJobMenuFire")
AddEventHandler("ev-jobsystem:RadicalJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassRadical", valid[1].input)
    end
end)

----AOD Hire / Fire --------------------------

RegisterNetEvent("ev-jobsystem:AodJobMenuHire")
AddEventHandler("ev-jobsystem:AodJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassAod", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:AodJobMenuFire")
AddEventHandler("ev-jobsystem:AodJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassAod", valid[1].input)
    end
end)
---- Pearls customs Hire / Fire ----------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:PearlsJobMenuHire")
AddEventHandler("ev-jobsystem:PearlsJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassPearls", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:PearlsJobMenuFire")
AddEventHandler("ev-jobsystem:PearlsJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassPearls", valid[1].input)
    end
end)

----VU Hire / Fire --------------------------

RegisterNetEvent("ev-jobsystem:VUJobMenuHire")
AddEventHandler("ev-jobsystem:VUJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassVU", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:VUJobMenuFire")
AddEventHandler("ev-jobsystem:VUJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassVU", valid[1].input)
    end
end)

--PDM -------------------------------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:PDMJobMenu")
AddEventHandler("ev-jobsystem:PDMJobMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedPDM", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:PDMJobMenu2")
AddEventHandler("ev-jobsystem:PDMJobMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedPDM", valid[1].input)
    end
end)

RegisterNetEvent("ev-jobsystem:NoodleJobMenu")
AddEventHandler("ev-jobsystem:NoodleJobMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedNoodle", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:NoodleJobMenu2")
AddEventHandler("ev-jobsystem:NoodleJobMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedNoodle", valid[1].input)
    end
end)

RegisterNetEvent("ev-jobsystem:BSJobMenuHire")
AddEventHandler("ev-jobsystem:BSJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassBS", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:BSJobMenuFire")
AddEventHandler("ev-jobsystem:BSJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassBS", valid[1].input)
    end
end)

RegisterNetEvent("ev-jobsystem:SandersJobMenu")
AddEventHandler("ev-jobsystem:SandersJobMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedSanders", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:SandersJobMenu2")
AddEventHandler("ev-jobsystem:SandersJobMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedSanders", valid[1].input)
    end
end)

RegisterNetEvent("ev-jobsystem:TowJobMenu")
AddEventHandler("ev-jobsystem:TowJobMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedTow", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:TowJobMenu2")
AddEventHandler("ev-jobsystem:TowJobMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedTow", valid[1].input)
    end
end)

RegisterNetEvent("ev-jobsystem:releaseVehicle")
AddEventHandler("ev-jobsystem:releaseVehicle", function()
    local ped = PlayerPedId()
	local dist = #(GetEntityCoords(ped)-vector3(-193.37142944336,-1162.4571533203,23.668823242188))
	if dist <= 2.5 then 
        local valid = exports["ev-keyboard"]:KeyboardInput({
            header = "Release Vehicle Menu",
            rows = {
                {
                    id = 0,
                    txt = "Plate Number"
                },
            }
        })
        if valid then
            TriggerServerEvent("ev-jobsystem:releaseVehicle", valid[1].input)
        end
    else
        exports['ev-notification']:Alert({style = 'error', duration = 3000, message = 'You need to be at the front desk at the tow union to release the vehicle!'})
    end
end)

RegisterNetEvent("ev-jobsystem:WeedMenu")
AddEventHandler("ev-jobsystem:WeedMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedWeed", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:WeedMenu2")
AddEventHandler("ev-jobsystem:WeedMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedWeed", valid[1].input)
    end
end)

RegisterNetEvent("ev-jobsystem:GalMenu")
AddEventHandler("ev-jobsystem:GalMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedGal", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:GalMenu2")
AddEventHandler("ev-jobsystem:GalMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedGal", valid[1].input)
    end
end)

RegisterNetEvent("ev-jobsystem:LostMenu")
AddEventHandler("ev-jobsystem:LostMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedLost", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:LostMenu2")
AddEventHandler("ev-jobsystem:LostMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedLost", valid[1].input)
    end
end)

RegisterNetEvent("ev-jobsystem:RedMenu")
AddEventHandler("ev-jobsystem:RedMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedRed", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:RedMenu2")
AddEventHandler("ev-jobsystem:RedMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedRed", valid[1].input)
    end
end)

RegisterNetEvent("ev-jobsystem:UGMenu")
AddEventHandler("ev-jobsystem:UGMenu", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addJobWhitelsitedUG", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:UGMenu2")
AddEventHandler("ev-jobsystem:UGMenu2", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:fireJobWhitelsitedUG", valid[1].input)
    end
end)

-- Suits Job Menu --------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:suitsJobMenuHire")
AddEventHandler("ev-jobsystem:suitsJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassSuits", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ev-jobsystem:suitsJobMenuFire")
AddEventHandler("ev-jobsystem:suitsJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassSuits", valid[1].input)
    end
end)

-- UG Casino Job Menu --------------------------------------------------------------------------------------

RegisterNetEvent("ev-jobsystem:ugCasinoJobMenuHire")
AddEventHandler("ev-jobsystem:ugCasinoJobMenuHire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:addCharacterPassUgCasino", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ev-jobsystem:ugCasinoJobMenuFire")
AddEventHandler("ev-jobsystem:ugCasinoJobMenuFire", function()
    local valid = exports["ev-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ev-jobsystem:removeCharacterPassUgCasino", valid[1].input)
    end
end)