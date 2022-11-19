local usingAnimProp = false

local naturalMaterials = {
    GetHashKey('ROCK_9'),
    GetHashKey('ROCK_MOSSY_10'),
    GetHashKey('STONE_11'),
    GetHashKey('COBBLESTONE_12'),
    GetHashKey('SANDSTONE_SOLID_16'),
    GetHashKey('SANDSTONE_BRITTLE_17'),
    GetHashKey('SAND_LOOSE_18'),
    GetHashKey('SAND_COMPACT_19'),
    GetHashKey('SAND_WET_20'),
    GetHashKey('SAND_TRACK_21'),
    GetHashKey('SAND_DRY_DEEP_23'),
    GetHashKey('SAND_WET_DEEP_24'),
    GetHashKey('ICE_24'),
    GetHashKey('SNOW_LOOSE_26'),
    GetHashKey('SNOW_COMPACT_27'),
    GetHashKey('SNOW_DEEP_28'),
    GetHashKey('GRAVEL_SMALL_31'),
    GetHashKey('GRAVEL_LARGE_32'),
    GetHashKey('GRAVEL_DEEP_33'),
    GetHashKey('DIRT_TRACK_35'),
    GetHashKey('MUD_HARD_36'),
    GetHashKey('MUD_SOFT_38'),
    GetHashKey('MUD_DEEP_40'),
    GetHashKey('MARSH_41'),
    GetHashKey('MARSH_DEEP_42'),
    GetHashKey('SOIL_43'),
    GetHashKey('CLAY_HARD_44'),
    GetHashKey('CLAY_SOFT_45'),
    GetHashKey('GRASS_LONG_46'),
    GetHashKey('GRASS_47'),
    GetHashKey('GRASS_SHORT_48'),
}

local function benchHandler(pBenchType)
    local ped = PlayerPedId()

    if IsPedInAnyVehicle(ped, true) then
        return false
    end

    if IsPedArmed(ped, 7) then
        SetCurrentPedWeapon(ped, 0xA2719263, true)
    end

    if IsEntityPlayingAnim(ped, animDict, animation, 3) then
        ClearPedSecondaryTask(ped)
    else
        local pos = GetEntityCoords(ped)
        TaskStartScenarioAtPosition(
                    ped,
                    'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER',
                    pos.x + 0.0,
                    pos.y + 0.0,
                    pos.z - 0.5,
                    GetEntityHeading(ped),
                    0,
                    true,
                    true
                )
        TriggerEvent("destroyProp")
        usingAnimProp = true
    end
    Wait(500)
    local benchTypeToAttach = {
        ['wood'] = 'woodbench',
        ['stone'] = 'stonebench',
        ['metal'] = 'metalbench',
    }
    TriggerEvent("attachItem", benchTypeToAttach[pBenchType])
end

local benchTypeToObject = {
    ['wood'] = 'prop_bench_04',
    ['stone'] = 'prop_ld_bench01',
    ['metal'] = 'prop_snow_bench_01',
}

local benchModelToItem = {
    [`prop_bench_04`] = 'woodbench2',
    [`prop_ld_bench01`] = 'stonebench2',
    [`prop_snow_bench_01`] = 'metalbench2',
}

local function benchObjectHandler(pBenchType, pItem)
    local ped = PlayerPedId()

    if IsPedInAnyVehicle(ped, true) then
        return false
    end

    if IsPedArmed(ped, 7) then
        SetCurrentPedWeapon(ped, 0xA2719263, true)
    end

    local id = exports['ev-objects']:PlaceAndSaveObject(
        benchTypeToObject[pBenchType],
        { isPlacedBench = true },
        {
            collision = true,
            adjustZ = true,
            colZOffset = 0.5,
        },
        function (coords, materialHash, entity)
            return true
        end,
        'objects',
        60 * 10
    )
    if not id then
        return false
    end
    TriggerEvent('inventory:removeItem', pItem, 1)
    return false
end

local itemHandlers = {
    ['lawnchair'] = function(info)
        local animDict = "timetable@reunited@ig_10"
        local animation = "base_amanda"

        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, true) then
            return false
        end

        if IsPedArmed(ped, 7) then
            SetCurrentPedWeapon(ped, 0xA2719263, true)
        end

        LoadAnimDict(animDict)

        if IsEntityPlayingAnim(ped, animDict, animation, 3) then
            ClearPedSecondaryTask(ped)
        else
            local animLength = GetAnimDuration(animDict, animation)
            TaskPlayAnim(ped, animDict, animation, 1.0, 1.0, animLength, 1, 0, 0, 0, 0)
            TriggerEvent("destroyProp")
            usingAnimProp = true
        end
        TriggerEvent("attachItem", "lawnchair")
        return true
    end,
    ['lawnchair2'] = function(info)
        local animDict = "timetable@ron@ig_3_couch"
        local animation = "base"

        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, true) then
            return false
        end

        if IsPedArmed(ped, 7) then
            SetCurrentPedWeapon(ped, 0xA2719263, true)
        end

        LoadAnimDict(animDict)

        if IsEntityPlayingAnim(ped, animDict, animation, 3) then
            ClearPedSecondaryTask(ped)
        else
            local animLength = GetAnimDuration(animDict, animation)
            TaskPlayAnim(ped, animDict, animation, 1.0, 1.0, animLength, 1, 0, 0, 0, 0)
            TriggerEvent("destroyProp")
            usingAnimProp = true
        end
        TriggerEvent("attachItem", "lawnchair2")
        return true
    end,
    ['pailshovel'] = function(info)
        local validSand = {
            [-1595148316] = true,
            [1288448767] = true,
        }
        local sandcastles = {
            `prop_beach_sandcas_01`,
            `prop_beach_sandcas_03`,
            `prop_beach_sandcas_04`,
            `prop_beach_sandcas_05`,
        }

        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, true) then
            return false
        end

        local offsetCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 1.5, 0)
        local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(offsetCoords.x, offsetCoords.y, offsetCoords.z, offsetCoords.x, offsetCoords.y, offsetCoords.z - 2, 1, 0, 4)
        local retval, hit, endCoords, _, materialHash, _ = GetShapeTestResultIncludingMaterial(rayHandle)
        if not hit then return end
        if not validSand[materialHash] then return end

        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
        local finished = exports["ev-taskbar"]:taskBar(15000, "Building Sandcastle", false, true, false, false, nil, 5.0, ped)
        ClearPedTasks(ped)
        if finished == 100 then
            local sandcastle = sandcastles[math.random(1, #sandcastles)]
            RequestModel(sandcastle)
            while not HasModelLoaded(sandcastle) do
                Wait(0)
            end
            local obj = CreateObject(sandcastle, endCoords, true, false, false)
            SetTimeout(120000, function()
                SetEntityAsMissionEntity(obj, true, true)
                Sync.DeleteObject(obj)
            end)
        end
        return false
    end,
    ['stopsign'] = function(info)
        local animDict = "amb@world_human_janitor@male@base"
        local animation = "base"

        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, true) then
            return false
        end

        if IsPedArmed(ped, 7) then
            SetCurrentPedWeapon(ped, 0xA2719263, true)
        end

        LoadAnimDict(animDict)

        if IsEntityPlayingAnim(ped, animDict, animation, 3) then
            ClearPedSecondaryTask(ped)
        else
            local animLength = GetAnimDuration(animDict, animation)
            TaskPlayAnim(ped, animDict, animation, 1.0, 1.0, animLength, 49, 0, 0, 0, 0)
            TriggerEvent("destroyProp")
            usingAnimProp = true
        end
        TriggerEvent("attachItem", "stopsign")
        return true, animDict, animation
    end,
    ['woodbench'] = function(info)
        return benchHandler('wood')
    end,
    ['stonebench'] = function(info)
        return benchHandler('stone')
    end,
    ['metalbench'] = function(info)
        return benchHandler('metal')
    end,
    ['metalbench2'] = function(info)
        return benchObjectHandler('metal', 'metalbench2')
    end,
    ['woodbench2'] = function(info)
        return benchObjectHandler('wood', 'woodbench2')
    end,
    ['stonebench2'] = function(info)
        return benchObjectHandler('stone', 'stonebench2')
    end,
    ['tent'] = function(info)
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, true) then
            return false
        end

        local tents = {
            "prop_skid_tent_01",
            "prop_skid_tent_03"
        }
        local id = exports['ev-objects']:PlaceAndSaveObject(
            tents[math.random(1, #tents)],
            { isTent = true },
            {
                forceGroundSnap = true,
                zOffset = -0.915,
            },
            function (coords, materialHash, entity)
                for _,material in ipairs(naturalMaterials) do
                    if materialHash == material then
                        return true
                    end
                end
                return false
            end
        )
        if not id then
            return false
        end
        TriggerEvent('inventory:removeItem', 'tent', 1)
        return false
    end,
    ['letterbox'] = function(info)
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, true) then
            return false
        end
        --get user's properties
        local properties = exports['ev-housing']:getHousingData()

        local cid = exports['isPed']:isPed('cid')
        local _, employment  = RPC.execute("GetEmploymentInformation", { character = { id = cid } })

        local elements = {}
        local propertyOptions = {}
        for _,property in pairs(properties) do
            propertyOptions[#propertyOptions+1] = {
                name=property.name,
                id=property.id
            }
        end
        elements[#elements+1] = {
            _type='select',
            name='property',
            label='Select Property',
            options=propertyOptions
        }
        local businessOptions = {}
        for _,business in pairs(employment) do
            businessOptions[#businessOptions+1] = {
                name=business.name,
                id=business.id
            }
        end
        elements[#elements+1] = {
            _type='select',
            name='business',
            label='Select Business',
            options=businessOptions
        }

        local foundInfo
        local checkCoords
        local mailType
        local name
        if elements then
            local prompt2 = exports['ev-ui']:OpenInputMenu(elements)
            if not prompt2 then
                return false
            end
            if prompt2.business then
                mailType = 'business'
            elseif prompt2.property then
                mailType = 'property'
            end
            local plyCoords = GetEntityCoords(PlayerPedId())
            if mailType == 'property' then
                local housingTable = exports['ev-housing']:retriveHousingTable()
                local property = housingTable[prompt2.property]
                foundInfo = prompt2.property
                name = property.Street
                checkCoords = vector3(property[1].x, property[1].y, property[1].z)
                if #(checkCoords - plyCoords) > 50.0 then
                    TriggerEvent('DoLongHudText', 'Too far away from property.', 2)
                    return
                end
            elseif mailType == 'business' then
                local zones = exports['ev-polyzone']:GetZones(plyCoords)
                if not zones then
                    TriggerEvent('DoLongHudText', 'Too far from business or no stash found.', 2)
                    return false
                end
                local selectedBusinessCode
                for _,business in pairs(employment) do
                    if business.id == prompt2.business then
                        foundInfo = business.code
                        selectedBusinessCode = business.code
                        name = business.name
                        break
                    end
                end
                local foundZone
                for _,zone in pairs(zones) do
                    if zone.name == 'business_stash' and zone.data and (zone.data.id == selectedBusinessCode or zone.data.biz == selectedBusinessCode) then
                        foundZone = zone
                        break
                    end
                end
                if not foundZone then
                    TriggerEvent('DoLongHudText', 'Too far from business or no stash found.', 2)
                    return false
                end
                checkCoords = vector3(foundZone.center.x, foundZone.center.y, plyCoords.z)
                if #(checkCoords - plyCoords) > 75.0 then
                    TriggerEvent('DoLongHudText', 'Too far away from business.', 2)
                    return
                end
            end
        end

        local models = {
            "prop_letterbox_01",
            "prop_letterbox_02",
            "prop_letterbox_03",
        }

        local model = models[math.random(1, #models)]
        local results = exports['ev-objects']:PlaceObject(
            model,
            {
                forceGroundSnap = true,
                zOffset = -0.05,
            },
            function (coords, materialHash, entity)
                local roll = GetEntityRoll(entity)
                local pitch = GetEntityPitch(entity)
                local dist = checkCoords and #(GetEntityCoords(entity) - checkCoords) or 0
                local onRoad = IsPointOnRoad(coords.x, coords.y, coords.z)
                return roll < 25.0 and roll > -25.0 and pitch < 25.0 and pitch > -25.0 and dist < 35.0 and not onRoad
            end
        )
        if not results[1] then
            return false
        end

        local objId = RPC.execute('ev-usableprops:placeLetterbox', model, results[2].coords, results[2].rotation, mailType, foundInfo, name)
        if objId then
            TriggerEvent('inventory:removeItem', 'letterbox', 1)
        end
        return false
    end
}

AddEventHandler('ev-inventory:itemUsed', function(item, info)
    if itemHandlers[item] then
        local doPropCheck, animDict, anim = itemHandlers[item](info)
        if doPropCheck then
            Citizen.CreateThread(function()
                while usingAnimProp do
                    Wait(1000)
                    if (not animDict and not IsUsingSittingAnimation()) or (animDict and not IsEntityPlayingAnim(PlayerPedId(), animDict, anim, 3)) or IsPedInAnyVehicle(PlayerPedId(), true) then
                        TriggerEvent("destroyProp")
                        usingAnimProp = false
                    end
                end
            end)
        end
    end
end)

function IsUsingSittingAnimation()
    local sittingAnims = {
        {"timetable@ron@ig_5_p3", "ig_5_p3_base"},
        {"timetable@reunited@ig_10", "base_amanda"},
        {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy"},
        {"timetable@maid@couch@", "base"},
        {"timetable@ron@ig_3_couch", "base"}
    }
    local player = PlayerPedId()
    local isSitting = false
    for _,anims in ipairs(sittingAnims) do
        if IsEntityPlayingAnim(player, anims[1], anims[2], 3) then
            isSitting = true
        end
    end
    return isSitting
end

local function getMailboxInfo(pEntity)
    local object = exports['ev-objects']:GetObjectByEntity(pEntity)
    if not object then
        return false
    end

    local mailType = object.data.metadata.type
    if not mailType then
        return false
    end

    return object.data.metadata.id, mailType, object
end

local function isPD()
    local job = exports["ev-base"]:getModule("LocalPlayer"):getVar("job")
    return job == 'police' or job == 'judge'
end

local deletedObjects = {}
local PaidMeters = {}


-- Citizen.CreateThread(function()
--     exports["ev-interact"]:AddPeekEntryByModel({ `prop_sign_road_01a` }, {{
--         event = "ev-usableprops:stealStopSign",
--         id = "ev-usableprops:stealStopSign",
--         icon = "hammer",
--         label = "Steal!",
--         parameters = {},
--     }}, {
--         distance = { radius = 2.0 },
--         isEnabled = function(pEntity)
--           return deletedObjects[pEntity] == nil
--         end,
--     })

--     exports["ev-interact"]:AddPeekEntryByModel({ 2108567945, -1940238623 }, {{
--         event = "ev-usableprops:payParkingMeter",
--         id = "ev-usableprops:parking_pay",
--         icon = "dollar-sign",
--         label = "pay for meter ($5)",
--         parameters = { price = 5 },
--     }}, {
--         distance = { radius = 2.0 },
--         isEnabled = function(pEntity)
--           return PaidMeters[pEntity] == nil
--         end,
--     })

--     exports["ev-interact"]:AddPeekEntryByModel({ `prop_skid_tent_01`, `prop_skid_tent_03` }, {{
--         event = "ev-usableprops:pickupTent",
--         id = "ev-usableprops:pickup_tent",
--         icon = "arrow-up",
--         label = "pickup tent",
--         parameters = {},
--     }}, {
--         distance = { radius = 2.0 },
--         isEnabled = function(pEntity)
--           return exports['ev-objects']:GetObjectByEntity(pEntity) ~= nil
--         end,
--     })

--     exports["ev-interact"]:AddPeekEntryByModel({ `prop_bench_04`, `prop_ld_bench01`, `prop_snow_bench_01` }, {{
--         event = "ev-usableprops:pickupBench",
--         id = "ev-usableprops:pickup_bench",
--         icon = "arrow-up",
--         label = "pickup bench",
--         parameters = {},
--     }}, {
--         distance = { radius = 2.0 },
--         isEnabled = function(pEntity, pContext)
--           return pContext.meta and pContext.meta.data.metadata and pContext.meta.data.metadata.isPlacedBench
--         end,
--     })

--     exports["ev-interact"]:AddPeekEntryByModel({ `prop_letterbox_01`, `prop_letterbox_02`, `prop_letterbox_03`, `prop_letterbox_04`, `prop_postbox_01a` }, {{
--         event = "ev-usableprops:openMail",
--         id = "ev-usableprops:open_mailbox",
--         icon = "envelope",
--         label = "deposit mail",
--         parameters = {},
--     }}, {
--         distance = { radius = 2.0 },
--         isEnabled = function(pEntity)
--             local info = getMailboxInfo(pEntity)
--             return info
--         end,
--     })

--     exports["ev-interact"]:AddPeekEntryByModel({ `prop_letterbox_01`, `prop_letterbox_02`, `prop_letterbox_03`, `prop_postbox_01a` }, {{
--         event = "ev-usableprops:checkMail",
--         id = "ev-usableprops:check_mailbox",
--         icon = "envelope-open",
--         label = "check mail",
--         parameters = {},
--     }}, {
--         distance = { radius = 2.0 },
--         isEnabled = function(pEntity)
--             local info, mailType = getMailboxInfo(pEntity)
--             local job = exports['isPed']:isPed('myjob')
--             return (mailType == 'business' and (exports['ev-business']:HasPermission(info, 'stash_access') or isPD())) or
--             (mailType == 'property' and exports['ev-housing']:hasPropertyAccess(info, true)) or
--             (mailType == 'mrpd' and isPD()) or
--             (mailType == 'pillbox' and (job == 'ems' or job == 'doctor'))
--         end,
--     })

--     exports["ev-interact"]:AddPeekEntryByModel({ `prop_letterbox_01`, `prop_letterbox_02`, `prop_letterbox_03` }, {{
--         event = "ev-usableprops:removeMailbox",
--         id = "ev-usableprops:remove_mailbox",
--         icon = "trash-alt",
--         label = "remove mailbox",
--         parameters = {},
--     }}, {
--         distance = { radius = 2.0 },
--         isEnabled = function(pEntity)
--             local info, mailType = getMailboxInfo(pEntity)
--             return mailType == 'business' and (exports['ev-business']:HasPermission(info, 'stash_access')) or
--             (mailType == 'property' and exports['ev-housing']:hasPropertyAccess(info, false))
--         end,
--     })

-- end)

AddEventHandler("ev-usableprops:stealStopSign", function(pArgs, pEntity, pContext)
    LoadAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    local ped = PlayerPedId()
    TaskPlayAnim(ped, 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 8.0, -8.0, -1, 1, 0, false, false, false)
    local finished = exports["ev-taskbar"]:taskBar(15000, "Stealing", false, true, false, false, nil, 5.0, ped)
    ClearPedTasks(ped)
    if finished == 100 then
        local playerCoords = GetEntityCoords(ped, true)
        DeleteEntityAtCoords(-949234773, playerCoords)
        TriggerEvent("player:receiveItem", "stopsign", 1)
    end
end)

function DeleteEntityAtCoords(pModel, pCoords)
    local object = GetClosestObjectOfType(pCoords, 1.0, pModel, false, false, false)
    if DoesEntityExist(object) then
        SetEntityAsMissionEntity(object, true, true)
        DeleteEntity(object)
        deletedObjects[object] = true
    end
end

RegisterNetEvent("ev-usableprops:deleteEntity", DeleteEntityAtCoords)

function LoadAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        local timeout = false

        RequestAnimDict(animDict)

        Citizen.SetTimeout(5000, function()
            timeout = true
        end)

        while not HasAnimDictLoaded(animDict) and not timeout do
            Citizen.Wait(0)
        end
    end
end

AddEventHandler("ev-usableprops:payParkingMeter", function(args, entity, context)
    PaidMeters[entity] = true
    local success = RPC.execute('ev-usableprops:payParkingMeter', args.price)
    if success then
        local pos = GetEntityCoords(entity)
        TriggerServerEvent("ev-scenes:addScene", {
            coords = vector3(pos.x, pos.y, pos.z + 1.0),
            text = '$ PAID',
            distance = 3.0,
            color = 'green',
            caret = true,
            font = 4,
            solid = false,
            background = {
              r = 80,
              g = 80,
              b = 80,
              alpha = 155
            }
          })
    end
end)

AddEventHandler("ev-usableprops:pickupTent", function(args, entity, context)
    local tent = exports['ev-objects']:GetObjectByEntity(entity)
    if tent then
        local success = exports['ev-objects']:DeleteObject(tent.id)
        if success then
            TriggerEvent("player:receiveItem", "tent", 1)
        end
    end
end)

AddEventHandler("ev-usableprops:pickupBench", function(args, entity, context)
    local bench = exports['ev-objects']:GetObjectByEntity(entity)
    if bench then
        local success = exports['ev-objects']:DeleteObject(bench.id)
        if success then
            TriggerEvent("player:receiveItem", benchModelToItem[bench.data.model], 1)
        end
    end
end)

local waitForClose = false
local closeData = {}
AddEventHandler("ev-usableprops:openMail", function(args, entity, context)
    local info, mailType, object = getMailboxInfo(entity)
    waitForClose = RPC.execute('ev-usableprops:openMailbox', info, mailType, object.id)
    if waitForClose then
        closeData = {
            info = info,
            mailType = mailType,
            objId = object.id
        }
    end
end)

AddEventHandler("ev-usableprops:checkMail", function(args, entity, context)
    if isPD() and mailType == 'business' then
        local prompt = exports['ev-ui']:OpenInputMenu({
            { label = "Auth Code", name = "password", type = "password" },
        }, function(values)
            return values.password and values.password:len() > 0
        end)
        if not prompt then return end
    end
    local info, mailType, object = getMailboxInfo(entity)
    RPC.execute('ev-usableprops:checkMailbox', info, mailType, object.id)
end)

AddEventHandler('ev-inventory:closed', function(pName)
    if waitForClose and pName == 'mailtemp:' .. closeData.mailType .. ':' .. closeData.objId then
        RPC.execute('ev-usableprops:closeMailbox', closeData.info, closeData.mailType, closeData.objId)
        waitForClose = false
        closeData = {}
    end
end)

AddEventHandler('ev-usableprops:removeMailbox', function(args, entity, context)
    TriggerEvent("animation:PlayAnimation","mechanic3")
    local finished = exports['ev-taskbar']:taskBar(15000, "Removing mailbox", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        local obj = exports['ev-objects']:GetObjectByEntity(entity)
        if not obj then
            return
        end
        exports["ev-objects"]:DeleteObject(obj.id)
    end
end)

AddEventHandler('ev-objects:objectCreated', function(pObject, handle)
    if pObject.data.metadata.mail then
        FreezeEntityPosition(handle, false)
    end
end)

AddEventHandler('ev-spawn:characterSpawned', function(pCharacterId)
    RPC.execute('ev-usableprops:checkMailAlerts', pCharacterId)
end)
