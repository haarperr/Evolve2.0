Config = {
    Inventory = 'np', -- if qb inventory type 'qb' or np inventory type 'np'
    InventoryName = 'ev-inventory',
    TargetName = 'q',
    FrameWork = 'esx', -- or you can use esx (if you are using new qb-core type new-qb)

    Peds = {
        [1] = vector4(1602.96, 3708.16, 33.4, 139.44),
        [2] = vector4(569.84, -1023.8, 32.6, 107.48),
        [3] = vector4(-1439.96, -378.16, 37.12, 112.44)
    },

    startped = {
        [1] = vector4(-1564.08, -440.30, 36.01, 133.45)
    },

    Corners = {
        [1] = vector3(1552.72, 3689.92, 34.48),
        [2] = vector3(-152.0987, -2035.403, 22.707763),
        [3] = vector3(673.29071, 201.07421, 93.504981),
        [4] = vector3(-390.8697, -137.8393, 38.527053),
        [5] = vector3(159.5664, -1737.869, 29.254535),
        [6] = vector3(-1326.231, -1044.333, 7.4314107),
        [7] = vector3(-929.9666, 292.97021, 70.701713),
        [8] = vector3(-33.14533, 6516.7802, 31.262533),
        [9] = vector3(1808.0168, 4582.121, 36.248184),
        [10] = vector3(1229.7456, -1692.032, 39.462047)
    },

    CarSpawnLoc = {
        [1] = vector4(1580.16, 3723.08, 34.56, 148.56),
        [2] = vector4(-181.6374, -2035.824, 27.620607, 75.060401),
        [3] = vector4(813.7431, 213.944, 81.579635, 148.88044),
        [4] = vector4(-439.1447, -103.276, 39.694995, 37.115097),
        [5] = vector4(100.17118, -1743.51, 29.304788, 310.37442),
        [6] = vector4(-1320.178, -1005.191, 7.6503548, 123.56649),
        [7] = vector4(-857.9289, 185.16496, 71.049156, 346.52008),
        [8] = vector4(107.77635, 6643.8422, 32.445312, 132.68867),
        [9] = vector4(1718.5452, 4702.8959, 42.674926, 94.286613),
        [10] = vector4(1198.0798, -1750.083, 38.662097, 31.035415)
    },

    CarStopLoc = {
        [1] = vector3(1549.28, 3693.36, 34.6),
        [2] = vector3(-153.5692, -2033.492, 22.633916),
        [3] = vector3(673.29071, 201.07421, 93.504981),
        [4] = vector3(-390.5425, -136.652, 38.456768),
        [5] = vector3(158.56784, -1738.366, 29.240036),
        [6] = vector3(-1326.974, -1049.346, 7.4170861),
        [7] = vector3(-929.1844, 292.7286, 70.736282),
        [8] = vector3(-27.98838, 6517.7651, 32.43227),
        [9] = vector3(1809.981, 4579.5952, 36.191501),
        [10] = vector3(1229.7456, -1692.032, 39.462047)
    },

    CarFinishLoc = {
        [1] = vector3(1489.48, 3662.28, 34.68),
        [2] = vector3(-257.1615, -2119.366, 22.096162),
        [3] = vector3(617.05682, 195.23992, 99.008293),
        [4] = vector3(-391.2099, -203.9425, 36.389244),
        [5] = vector3(162.45802, -1817.739, 28.266754),
        [6] = vector3(-1356.246, -1139.402, 4.7198519),
        [7] = vector3(-1002.529, 347.17349, 70.833625),
        [8] = vector3(-175.9005, 6448.1752, 32.133975),
        [9] = vector3(1809.981, 4579.5952, 36.191501),
        [10] = vector3(1314.2027, -1663.54, 51.407882)
    }
}

    local collected, runStarted = false, false
    local prop = nil
    local model, model2 = nil, nil
    local ped = nil
    local veh = nil
    local car_ped_spawned = false
    local oldugum_bolge = nil
    local toplampaket, handoff, jobs = 0, 0, 0
    local incar = false
    local elimde = false
    local pPlate = nil
    local bliptable = {}
        CreateThread(function()
            while true do
                local msec = 5000
                if runStarted and not car_ped_spawned then
                    for k,v in pairs(Config.Corners) do
                        local dist = #(GetEntityCoords(PlayerPedId()) - vector3(v.x, v.y, v.z)) <= 10.0
                        if dist then
                            oldugum_bolge = k

                            if not car_ped_spawned then
                                car_ped_spawned = true
                                TriggerServerEvent('spawn-car')
                            end
                        end
                    end
                    if not runStarted then
                        Wait(1000)
                    end
                end
                Wait(msec)
            end
        end)

        RegisterNetEvent('start-oxy', function()
            if exports['ev-inventory']:hasEnoughOfItem('darkmarketdeliveries', 1) and exports['ev-inventory']:hasEnoughOfItem('vpnxj', 1) then
                TriggerEvent('ev-phone:oxyRunNoti', 'Wait for a job offer !')
                Citizen.Wait(math.random(60000, 120000))
                TriggerEvent('ev-phone:oxyrun:offer')
            else
                TriggerEvent('DoLongHudText', 'You need a delivery list and a VPN to work here !', 2)
            end
        end)

        RegisterNetEvent('ev-oxy:Accept:Offer')
        AddEventHandler('ev-oxy:Accept:Offer', function()
            TriggerServerEvent('started-job')
            TriggerEvent('ev-phone:oxyRunNoti', 'Head towards the location on your GPS.')
        end)

        RegisterNetEvent('start-job', function()
            CreateThread(function()
                while true do
                    incar = IsPedInAnyVehicle(PlayerPedId())
                    if incar then
                        TriggerServerEvent('car-found')
                        break
                    end
                    Wait(1000)
                end
            end)
        end)

        RegisterNetEvent('generate-ped-loc', function()
            local generatePedLoc = math.random(1, #Config.Peds)
            ClearAllBlipRoutes()
            blipolustur(Config.Peds[generatePedLoc].x, Config.Peds[generatePedLoc].y, 524, 3, 0.7, 'Supplier')

            exports["ev-interact"]:AddPeekEntryByModel(GetHashKey('a_m_m_bevhills_01'), {{
                event = "collect-package",
                id = "collect-pack",
                icon = "wrench",
                label = "Collect Package",
                parameters = {},
            }}, { distance = { radius = 2.5 } })
        end)

        RegisterNetEvent('collect-package', function()
            if toplampaket < 10 then
                ClearAllBlipRoutes()
                for _,v in pairs(bliptable) do
                    RemoveBlip(v)
                end

                if not exports['ev-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
                    runStarted = true
                    TriggerEvent("player:receiveItem", "darkmarketpackage", 1, false, nil)
                    toplampaket = toplampaket+1
                    TriggerEvent('ev-phone:oxyRunNoti', '('..toplampaket..'/10) Packages Collected.')

                    if toplampaket == 10 then
                        TriggerEvent('ev-phone:oxyRunNoti', 'All Packages Collected.')
                        TriggerServerEvent('all-collected')
                    end
                else
                    TriggerEvent('DoLongHudText', 'Put the other package in your trunk before grabbing another.', 2)
                end
            else
                TriggerEvent('DoLongHudText', 'You can\'t get anymore.', 2)
            end
        end)

        RegisterNetEvent('generate-corner-loc', function()
            jobs = jobs+1
            for _,v in pairs(bliptable) do
                RemoveBlip(v)
            end

            local genCornerLoc = math.random(1, #Config.Corners)

            ClearAllBlipRoutes()
            blipolustur(Config.Corners[genCornerLoc].x, Config.Corners[genCornerLoc].y, 514, 3, 0.7, 'Corner')
        end)

        RegisterNetEvent('generate-new-corner-loc', function()
            if jobs == 2 then
                runStarted = false
                jobs = 0
                for _,v in pairs(bliptable) do
                    RemoveBlip(v)
                end
                return
            end
            jobs = jobs+1
            TriggerEvent('ev-phone:oxyRunNoti', 'Drive to the next location.')
            
            runStarted = false
            handoff = 0
            for _,v in pairs(bliptable) do
                RemoveBlip(v)
            end
            local genCornerLoc = math.random(1, #Config.Corners)
            if genCornerLoc == oldugum_bolge then
                if genCornerLoc == 3 then
                    genCornerLoc = genCornerLoc-1
                else
                    genCornerLoc = genCornerLoc+1
                end
                ClearAllBlipRoutes()
                blipolustur(Config.Corners[genCornerLoc].x, Config.Corners[genCornerLoc].y, 514, 3, 0.7, 'Corner')
            else
                ClearAllBlipRoutes()
                blipolustur(Config.Corners[genCornerLoc].x, Config.Corners[genCornerLoc].y, 514, 3, 0.7, 'Corner')
            end

            CreateThread(function()
                while true do 
                    Wait(750)
                    if #(GetEntityCoords(PlayerPedId()) - vector3(Config.Corners[genCornerLoc].x, Config.Corners[genCornerLoc].y, Config.Corners[genCornerLoc].z)) < 25.0 then
                        runStarted = true
                        break
                    end
                end
            end)
        end)

        RegisterNetEvent('spawn-car-client', function()
            model = generateModel()
            model2 = generatePedModel()

            while model == nil do Wait(10) end
            local generateCoords = Config.CarSpawnLoc[oldugum_bolge]

            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(10)
            end

            RequestModel(model2)
            while not HasModelLoaded(model2) do
                Wait(10)
            end

            veh = CreateVehicle(model, generateCoords.x, generateCoords.y, generateCoords.z, generateCoords.w, true, false)
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(veh), true)
            SetModelAsNoLongerNeeded(model)
            local plate = GetVehicleNumberPlateText(veh)
            pPlate = plate
            
            RequestModel(GetHashKey('a_m_m_soucent_03'))
            while not HasModelLoaded(GetHashKey('a_m_m_soucent_03')) do
                Wait(10)
            end
            
            ped = CreatePed('CIVMALE', model2, generateCoords.x+0.3, generateCoords.y, generateCoords.z, generateCoords.w, true, false)
            SetPedCanBeDraggedOut(ped, false)

            TaskVehicleDriveToCoord(ped, veh, Config.CarStopLoc[oldugum_bolge].x, Config.CarStopLoc[oldugum_bolge].y, Config.CarStopLoc[oldugum_bolge].z, 10.0, false, model, 316, 0.1, false)
            SetDriverAggressiveness(ped, 0.0)

            CreateThread(function()
                while true do 
                    Wait(25)
                    if #(GetEntityCoords(veh) - vector3(Config.CarStopLoc[oldugum_bolge].x, Config.CarStopLoc[oldugum_bolge].y, Config.CarStopLoc[oldugum_bolge].z)) < 1.0 then
                        canHandOff = true
                        FreezeEntityPosition(veh, true)
                        return
                    end
                end
            end)
        end)

        RegisterNetEvent('handoff-package', function()
            coordA = GetEntityCoords(PlayerPedId(), 1)
            coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
            vehicle = getVehicleInDirection(coordA, coordB)
            licensePlate = GetVehicleNumberPlateText(vehicle)

            if exports['ev-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
                if licensePlate == pPlate then
                    FreezeEntityPosition(veh, false)
                    if handoff < 5 then
                        DeleteObject(prop)
                        ClearPedTasks(PlayerPedId())
                        collected = false
                        canHandOff = false

                        handoff = handoff+1
                        TriggerEvent('ev-phone:oxyRunNoti', '('..handoff..'/5) Packages Handed Off.')

                        if math.random(1,100) <= 7 then
                            Wait(500)
                            TaskVehicleDriveWander(ped, veh, 20.0, 16777216)
                            SetDriverAggressiveness(ped, 0.0)
                            Wait(10000)
                            DeleteEntity(ped)
                            DeleteEntity(veh)
                            car_ped_spawned = false
                            if handoff == 5 then
                                TriggerServerEvent('handoff-limit')
                                return
                            end
                            return
                        end

                        if exports['ev-inventory']:hasEnoughOfItem('darkmarketpackage', 1, true) then
                            local rnd = math.random(1, 2)
                            if rnd == 1 then
                                exports["ev-dispatch"]:dispatchadd('10-37', "Investigate Suspicious Activity", "102")
                                TriggerEvent("player:receiveItem", "oxy", math.random(1, 5))
                            end
                            TriggerEvent("inventory:removeItem", "darkmarketpackage", 1)
                            TriggerEvent('ev-oxyruns:clean')
                            Wait(500)
                            TaskVehicleDriveWander(ped, veh, 20.0, 16777216)
                            SetDriverAggressiveness(ped, 0.0)
                            Wait(15000)
                            DeleteEntity(ped)
                            DeleteEntity(veh)
                            car_ped_spawned = false
                            if handoff == 5 then
                                TriggerServerEvent('handoff-limit')
                                runStarted = false
                                return
                            end
                        else
                            TriggerEvent('DoLongHudText', 'You forget the package ?', 2)
                        end
                    end
                else
                    TriggerEvent('DoLongHudText', 'Incorrect vehicle.', 2)
                end
            end
        end)

        generateModel = function()
            local models = {
                'sultan',
                'asea',
                'tailgater',
                'enduro',
                'Dubsta',
                'Cavalcade',
                'Dominator',
                'Phoenix',
                'Defiler',
                'Oracle',
                'Zion',
                'Prairie',
                'Gauntlet',
                'Virgo',
                'Tampa',
                'Stalion',
                'Asterope',
                'Reaper',
                'Zentorno',
                'Osiris',
                'Infernus'
            }
            local generateModel = math.random(1, #models)
            local retval = GetHashKey(models[generateModel])
            return retval
        end

        generatePedModel = function()
            local peds = {
                'ig_money',
                'a_m_y_beachvesp_02',
                'a_m_y_breakdance_01',
                'ig_car3guy1',
                'a_m_y_business_03',
                's_m_m_cntrybar_01',
                'ig_devin',
                'ig_dreyfuss',
                'a_m_m_fatlatin_01',
                'u_m_y_baygor',
            }
            local generateModel = math.random(1, #peds)
            local retval = GetHashKey(peds[generateModel])
            return retval
        end

        LoadPropDict = function(model)
            while not HasModelLoaded(GetHashKey(model)) do
                RequestModel(GetHashKey(model))
                Wait(10)
            end
        end

        loadAnimDict = function(dict)
            while not HasAnimDictLoaded(dict) do
                RequestAnimDict(dict)
                Wait(1)
            end
        end
        
        RegisterNetEvent('esx:onRemoveInventoryItem', function(item, amount)
            if prop ~= nil then
                elimde = false
                collected = false
                DeleteObject(prop)
                ClearPedTasks(PlayerPedId())
            end
        end)

        function blipolustur(x, y, sprite, colour, scale, text)
            local blip = AddBlipForCoord(x, y)
            SetBlipSprite(blip, sprite)
            SetBlipColour(blip, colour)
            SetBlipAsShortRange(blip, true)
            SetBlipScale(blip, scale)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(text)
            EndTextCommandSetBlipName(blip)
            SetBlipRoute(blip, true)
            table.insert(bliptable, blip)
        end

        function canHandOffPackages()
            if canHandOff then
                canHandOff = true
            elseif not canHandOff then
                canHandOff = false
            end
            return canHandOff
        end

        function getVehicleInDirection(coordFrom, coordTo)
            local offset = 0
            local rayHandle
            local vehicle
        
            for i = 0, 100 do
                rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
                a, b, c, d, vehicle = GetRaycastResult(rayHandle)
                
                offset = offset - 1
        
                if vehicle ~= 0 then break end
            end
            
            local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
            
            if distance > 25 then vehicle = nil end
        
            return vehicle ~= nil and vehicle or 0
        end

        local billsCleaningStuff = {
            ["band"] = { extra = 5, price = 100 },
            ["markedbills"] = { extra = 8, price = 250 },
            ["rollcash"] = { extra = 15, price = 30 },
            ["inkset"] = { extra = 15, price = 150 },
        }

        AddEventHandler("ev-oxyruns:clean", function(pRandomChance)
            local payment = 0
            for typ, conf in pairs(billsCleaningStuff) do
              local randomAmount = math.random(4, 12)
              local randomChance = pRandomChance and pRandomChance or 0.4
              local totalAmount = randomAmount + conf.extra
              if math.random() < randomChance and exports["ev-inventory"]:hasEnoughOfItem(typ, totalAmount, false) then
                TriggerEvent("inventory:removeItem", typ, totalAmount)
                payment = payment + (conf.price * totalAmount)
                payment = payment + math.random(5, 15)
                if exports['ev-hud']:MoneyBuff() then
                    TriggerServerEvent('ev-activities:givePayout', payment*2, 'cash', '[Oxy Run | With Buff | Cleaned Bands]')
                else
                    TriggerServerEvent('ev-activities:givePayout', payment, 'cash', '[Oxy Run | Without Buff | Cleaned Bands]')
                end
              end
            end
            if payment == 0 then
                TriggerServerEvent('ev-activities:givePayout', math.random(150, 350), 'cash', '[Oxy Run | Without Buff | Reg Payout]')
            end
          end)

          -- Thread Shit --

          function thread()
            peds = {}    
            
            pedcreate = function(name, hash, x, y, z, h)
                if peds[name] then
                    if peds[name].spawn then
                        DeletePed(peds[name].ped)
                        peds[name].spawn = false
                        peds[name].ped = 0
                    end
                end
                peds[name] = {hash = hash, x = x, y = y, z = z, h = h, spawn = false, ped = 0}
            end
        
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(5000)
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    for x, pedData in pairs(peds) do
                        local distance = #(coords - vector3(pedData.x, pedData.y, pedData.z))
                        if distance < 100 then
                            if not pedData.spawn then
                                Citizen.CreateThread(function()
                                    local hash = pedData.hash
                                    if not IsModelValid(hash) then 
                                        print("[PED] ".. hash .. "("..x..") invalid!")
                                    else
                                        while not HasModelLoaded(hash) do
                                            RequestModel(hash)
                                            Citizen.Wait(1) 
                                        end
                                        local ped = CreatePed(4, hash, pedData.x, pedData.y, pedData.z, pedData.h, false, true)
                                        FreezeEntityPosition(ped, true)
                                        SetEntityInvincible(ped, true)
                                        SetBlockingOfNonTemporaryEvents(ped, true)
                                        SetModelAsNoLongerNeeded(hash)
                                        peds[x].ped = ped
                                        peds[x].spawn = true
                                    end
                                end)
                            end
                        else
                            if pedData.spawn then
                                DeletePed(pedData.ped)
                                peds[x].spawn = false
                                peds[x].ped = 0
                            end
                        end
                    end
                end
            end)
        
            for i=1, #Config.Peds do
                pedcreate(Config.Peds[i]..'oxy', GetHashKey('a_m_m_bevhills_01'), Config.Peds[i].x, Config.Peds[i].y, Config.Peds[i].z, Config.Peds[i].w)
            end
            for i=1, #Config.startped do
                pedcreate(Config.startped[i]..'startjob', 0xA8C22996, Config.startped[i].x, Config.startped[i].y, Config.startped[i].z, Config.startped[i].w)
            end
        
            if Config.TargetName == 'q' then
        
                exports["ev-polytarget"]:AddCircleZone("oxystart", vector3(-1564.06, -440.33, 37.39), 0.55, {
                    useZ=true,
                })
                
                exports["ev-interact"]:AddPeekEntryByPolyTarget("oxystart", {
                    {
                        event = "start-oxy",
                        id = "oxystart1",
                        icon = "circle",
                        label = "Sign In.",
                        parameters = {},
                    }
                }, {
                    distance = { radius = 2.5 },
                    isEnabled = function()
                        return true
                    end,
                });  
                
            end
        end
        
        CreateThread(thread)