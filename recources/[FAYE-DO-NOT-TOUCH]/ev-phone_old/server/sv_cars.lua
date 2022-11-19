RPC.register("fayzie:vehicles:getPlayerVehiclesWithCoordinates", function(pSource)
    local user = exports["ev-base"]:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()

    local data = Await(SQL.execute("SELECT * FROM characters_cars WHERE cid = @cid", {
        ["cid"] = char.id
    }))

    if not data then return {} end

    return data
end)

RPC.register("vehicle:coords", function(pSource, pPlate, pCoords, pHeading)
    local plate = pPlate.param
    local coords = pCoords.param
    local heading = pHeading.param

    location = {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        h = heading
    }

    local update = Await(SQL.execute("UPDATE characters_cars SET location = @location WHERE plate = @plate", {
        ["location"] = json.encode(location),
        ["plate"] = plate
    }))
end)

RPC.register("fayzie:garage:vehicleSpawn", function(pSource, pModel, pCoords, pPlate)
    local coords = pCoords.param
    local model = pModel.param
    local plate = pPlate.param
    plate = plate:gsub("%s+", "")
    plate = string.gsub(plate, "%s+", "")
    local car = CreateVehicle(model, coords.x, coords.y, coords.z, coords.h , true, true)
    local osTime = os.time()
    while not DoesEntityExist(car) do 
        Citizen.Wait(0) 
        if os.time() > osTime + 5 then break end
    end
    SetVehicleNumberPlateText(car, plate)
    print("set plate", plate)
    TriggerClientEvent("vehicle:keys:addNew", pSource, car, plate)
    local netId = NetworkGetNetworkIdFromEntity(car)

    return netId
end)

RPC.register("fayzie:vehicles:respawnVehicle", function(pSource, pData)
    local data = pData.param
    local plate = data.plate
    local model = data.model
    local coords = json.decode(data.location)

    plate = plate:gsub("%s+", "")
    plate = string.gsub(plate, "%s+", "")
    local car = CreateVehicle(model, coords.x, coords.y, coords.z, coords.h, true, true)
    local osTime = os.time()
    while not DoesEntityExist(car) do 
        Citizen.Wait(0) 
        if os.time() > osTime + 5 then break end
    end
    SetVehicleNumberPlateText(car, plate)
    print("set plate", plate)
    TriggerClientEvent("vehicle:keys:addNew", pSource, car, plate)
    local netId = NetworkGetNetworkIdFromEntity(car)

    return true, netId
end)