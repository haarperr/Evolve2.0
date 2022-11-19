--// Client Side Enter Donation Shop //--

local InEnterZoneDonators = false
local isInDonatorShop = nil

RegisterNetEvent('ev-base:enterDonatorShop')
AddEventHandler('ev-base:enterDonatorShop', function()
  DoScreenFadeOut(0)
  isInDonatorShop = true
  if not IsPedInAnyVehicle(PlayerPedId()) then
    SetEntityCoords(PlayerPedId(), -1267.001, -3013.357, -48.49024)
  else
    SetPedCoordsKeepVehicle(PlayerPedId(), -1267.001, -3013.357, -48.49024)
  end
  Citizen.Wait(2500)
  DoScreenFadeIn(500)
end)

RegisterNetEvent('ev-base:leaveDonatorShop')
AddEventHandler('ev-base:leaveDonatorShop', function()
  DoScreenFadeOut(0)
  isInDonatorShop = false
  if not IsPedInAnyVehicle(PlayerPedId()) then
    SetEntityCoords(PlayerPedId(), -1389.545, -3258.531, 13.551619)
    SetEntityHeading(PlayerPedId(), 327.5429)
  else
    SetPedCoordsKeepVehicle(PlayerPedId(), -1389.545, -3258.531, 13.551619)
    SetEntityHeading(PlayerPedId(), 327.5429)
  end
  Citizen.Wait(2500)
  DoScreenFadeIn(500)
end)

Citizen.CreateThread(function()
  exports["ev-polyzone"]:AddBoxZone("donator_shop_enter", vector3(-1395.48, -3266.11, 13.94), 5, 9.0, {
    name="donator_shop_enter",
    heading=330,
    minZ=11.94,
    maxZ=15.94
  })
end)

RegisterNetEvent('ev-polyzone:enter')
AddEventHandler('ev-polyzone:enter', function(name)
    if name == "donator_shop_enter" then
        InEnterZoneDonators = true     
        DonatorShopEnter()
        exports['ev-interface']:showInteraction("[E] Enter Warehouse")
    end
end)


RegisterNetEvent('ev-polyzone:exit')
AddEventHandler('ev-polyzone:exit', function(name)
    if name == "donator_shop_enter" then
        InEnterZoneDonators = false
        exports['ev-interface']:hideInteraction()
    end
end)

function DonatorShopEnter()
  Citizen.CreateThread(function()
      while InEnterZoneDonators do
      Citizen.Wait(5)
      if IsControlJustReleased(0, 38) then
        TriggerServerEvent('ev-base:donationShopEnter')
      end
    end
  end)
end

--// Client Side Check Dono Information //--

RegisterCommand('donatorinfo', function()
  TriggerServerEvent('ev-base:donatorShopInformation')
end)

RegisterNetEvent('ev-base:checkDonatorShopInformation')
AddEventHandler('ev-base:checkDonatorShopInformation', function(pCarReedeemables, pDesireCoinReedeemables, pPlateChanges)
  TriggerEvent('DoLongHudText', 'Car Reedeemable Tokens: '..pCarReedeemables.. ' <br> Desire Coin Reedeemables: '..pDesireCoinReedeemables.. '<br> Plate Changes: '..pPlateChanges)
end)

RegisterInterfaceCallback('ev-base:reedeemCoin', function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
    exports['ev-interface']:openApplication('textbox', {
      callbackUrl = 'ev-base:reedeemCoinToken',
      key = 1,
      items = {
        {
          icon = "money-bill",
          label = "How many tokens do you want to use ?",
          name = "pCoinTokenAmountTrade",
        },
      },
      show = true,
  })
end)

RegisterInterfaceCallback('ev-base:reedeemCoinToken', function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  TriggerServerEvent('ev-base:updateCharactersDesireCoin', data.values.pCoinTokenAmountTrade)
end)

--// Client Side Check Dono Information //--

--// Client Side Desire Coin Trade //--

RegisterInterfaceCallback('ev-base:donationShopTradeDesireCoin', function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
    exports['ev-interface']:openApplication('textbox', {
        callbackUrl = 'ev-base:tradeDesireCoin',
        key = 1,
        items = {
          {
            icon = "money-bill",
            label = "How Much Desire Coin ?",
            name = "pDesireCoinAmt",
          },
        },
        show = true,
    })
end)

RegisterInterfaceCallback('ev-base:tradeDesireCoin', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerServerEvent('ev-base:donationShopDesireCoin', data.values.pDesireCoinAmt)
end)

--// Client Side Desire Coin Trade //--

--// Client Side Reedeem Vehicle //--

--// Generate Plate //--

RegisterInterfaceCallback('ev-base:donatorShopReedeemVehicle', function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
    exports['ev-interface']:openApplication('textbox', {
      callbackUrl = 'ev-base:reedeemDonatorCarGenPlate',
      key = 1,
      items = {
        {
          icon = "car",
          label = "Vehicle Model",
          name = "pCarModel",
        },
      },
      show = true,
    })
end)

--// Custom Plate //--

RegisterInterfaceCallback('ev-base:donatorShopReedeemVehicleCustomPlate', function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
    exports['ev-interface']:openApplication('textbox', {
      callbackUrl = 'ev-base:reedeemDonatorCarCustomPlate',
      key = 1,
      items = {
        {
          icon = "car",
          label = "Vehicle Model",
          name = "pCarModel",
        },
        {
          icon = "id-card",
          label = "Plate (Must be 8 Characters)",
          name = "pPlate",
        },
      },
      show = true,
  })
end)

RegisterInterfaceCallback('ev-base:reedeemDonatorCarGenPlate', function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  TriggerServerEvent('ev-base:donatorShopReedeemVehicleToken', data.values.pCarModel, '0', 'Generated')
end)

RegisterInterfaceCallback('ev-base:reedeemDonatorCarCustomPlate', function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  TriggerServerEvent('ev-base:donatorShopReedeemVehicleToken', data.values.pCarModel, data.values.pPlate, 'Custom')
end)

--// Client Side Reedeem Vehicle //--

--// Client Side Change Plate //--

RegisterNetEvent('ev-base:donatorChangePlateCl')
AddEventHandler('ev-base:donatorChangePlateCl', function()
  if IsPedInAnyVehicle(PlayerPedId()) then
    SetEntityCoords(GetVehiclePedIsIn(PlayerPedId()), -1286.264, -3021.525, -48.90517)
    SetEntityHeading(GetVehiclePedIsIn(PlayerPedId()), 89.691146)
    exports['ev-interface']:openApplication('textbox', {
      callbackUrl = 'ev-base:changePlateFinalize',
      key = 1,
      items = {
        {
          icon = "id-card",
          label = "New Plate (Must be 8 characters)",
          name = "pPlateNew",
        },
      },
      show = true,
    })
  else
    TriggerEvent('DoLongHudText', 'You need to be in a vehicle to use this.', 2)
  end
end)

RegisterInterfaceCallback('ev-base:changePlateFinalize', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('ev-base:donatorPlateChangeSV', GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), data.values.pPlateNew)
end)

RegisterNetEvent('ev-base:setVehicleNumberPlate')
AddEventHandler('ev-base:setVehicleNumberPlate', function(pPlate)
  SetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId()), pPlate)
  TriggerEvent('keys:addNew', GetVehiclePedIsIn(PlayerPedId()), pPlate)
  FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId()), false)
end)

-- // Peds // --

Citizen.CreateThread(function()
  --// Reedeem Car Ped Start //--
  modelHash = GetHashKey("ig_benny")
  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do
      Wait(1)
  end
  pReedeemCarPed = CreatePed(0, modelHash , -1290.615, -3014.003, -48.48992  -1, true)
  FreezeEntityPosition(pReedeemCarPed, true)
  SetEntityHeading(pReedeemCarPed, 268.9956)
  SetEntityInvincible(pReedeemCarPed, true)
  SetBlockingOfNonTemporaryEvents(pReedeemCarPed, true)
  --// Reedeem Car Ped End //--

    --// Reedeem Desire Coin Start //--
    modelHash = GetHashKey("a_f_m_eastsa_01")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    pReedeemCarPed = CreatePed(0, modelHash , -1243.485, -3023.203, -48.49002  -1, true)
    FreezeEntityPosition(pReedeemCarPed, true)
    SetEntityHeading(pReedeemCarPed, 88.369018)
    SetEntityInvincible(pReedeemCarPed, true)
    SetBlockingOfNonTemporaryEvents(pReedeemCarPed, true)
    --// Reedeem Desire Coin End //--
end)

--// Polyzones //--

local inZoneReedeemVeh = false

Citizen.CreateThread(function()
    exports['ev-polyzone']:AddBoxZone('reedeem_vehicle_zone', vector3(-1290.36, -3014.04, -48.49), 2, 2, {
      name = 'reedeem_vehicle_zone',
      heading=0,
      --debugPoly=true,
      minZ=-50.69,
      maxZ=-46.69
    })
end)

RegisterNetEvent('ev-polyzone:enter')
AddEventHandler('ev-polyzone:enter', function(pName)
  if pName == "reedeem_vehicle_zone" then
    ReedeemVehicleZone()
    exports['ev-interface']:showInteraction('[E] Reedeem Vehicle Token')
    inZoneReedeemVeh = true
  end
end)

RegisterNetEvent('ev-polyzone:exit')
AddEventHandler('ev-polyzone:exit', function(pName)
    if pName == "reedeem_vehicle_zone" then
      exports['ev-interface']:hideInteraction()
      inZoneReedeemVeh = false
    end
end)

function ReedeemVehicleZone()
  Citizen.CreateThread(function()
      while inZoneReedeemVeh do
        Citizen.Wait(5)
          if IsControlJustReleased(0, 38) then
            local pContextData = {
              {
                title = "Reedeem Donator Vehicle",
                children = {
                    { title = "Dont put stupid shit this is logged. 🥺" },
                    { title = "Click here to reedeem your donator vehicle.",
                    children = {
                      {
                        title = "Custom Plate",
                        action = "ev-base:donatorShopReedeemVehicleCustomPlate",
                      },
                      {
                        title = "Generated Plate",
                        action = "ev-base:donatorShopReedeemVehicle",
                      }
                    }
                  },
                },
              },
            }
            exports['ev-interface']:showContextMenu(pContextData)
          end
      end
  end)
end

local inZoneDesireCoin = false

Citizen.CreateThread(function()
    exports['ev-polyzone']:AddBoxZone('reedeem_desire_coin_zone', vector3(-1243.93, -3023.23, -48.49), 2, 2, {
      name = 'reedeem_desire_coin_zone',
      heading=0,
      --debugPoly=true,
      minZ=-50.69,
      maxZ=-46.69
    })
end)

RegisterNetEvent('ev-polyzone:enter')
AddEventHandler('ev-polyzone:enter', function(pName)
  if pName == "reedeem_desire_coin_zone" then
    ReedeemDesireCoinZone()
    exports['ev-interface']:showInteraction('[E] Reedeem Desire Coin')
    inZoneDesireCoin = true
  end
end)

RegisterNetEvent('ev-polyzone:exit')
AddEventHandler('ev-polyzone:exit', function(pName)
    if pName == "reedeem_desire_coin_zone" then
      exports['ev-interface']:hideInteraction()
      inZoneDesireCoin = false
    end
end)

function ReedeemDesireCoinZone()
  Citizen.CreateThread(function()
      while inZoneDesireCoin do
        Citizen.Wait(5)
          if IsControlJustReleased(0, 38) then
            local pContextData = {
              {
                title = "Desire Coin",
                children = {
                    { title = "Reedeem Desire Coin Tokens.", action="ev-base:reedeemCoin" },
                    { title = "Trade Desire Coin.", action="ev-base:donationShopTradeDesireCoin" },
                },
              },
            }
            exports['ev-interface']:showContextMenu(pContextData)
          end
      end
  end)
end

--// Change Vehicle Plate //--

local inZoneChangeVehiclePlate = false

Citizen.CreateThread(function()
    exports['ev-polyzone']:AddBoxZone('reedeem_plate_change', vector3(-1287.1, -3021.42, -48.49), 3.5, 6.9, {
      name = 'reedeem_plate_change',
      heading=0,
      --debugPoly=true,
      minZ=-50.69,
      maxZ=-46.69
    })
end)

RegisterNetEvent('ev-polyzone:enter')
AddEventHandler('ev-polyzone:enter', function(pName)
  if pName == "reedeem_plate_change" then
    if IsPedInAnyVehicle(PlayerPedId()) then
      ChangeVehiclePlateDonator()
      exports['ev-interface']:showInteraction('[E] Reedeem Change Vehicle Plate')
      inZoneChangeVehiclePlate = true
    end
  end
end)

RegisterNetEvent('ev-polyzone:exit')
AddEventHandler('ev-polyzone:exit', function(pName)
    if pName == "reedeem_plate_change" then
      exports['ev-interface']:hideInteraction()
      inZoneChangeVehiclePlate = false
    end
end)

function ChangeVehiclePlateDonator()
  Citizen.CreateThread(function()
      while inZoneChangeVehiclePlate do
        Citizen.Wait(5)
          if IsControlJustReleased(0, 38) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('ev-base:donatorChangePlateCl')
          end
      end
  end)
end
-- // Exports // --

function isInDonatorShopBuilding()
  if isInDonatorShop then
    isInDonatorShop = true
  elseif not isInDonatorShop then
    isInDonatorShop = false
  end
  return isInDonatorShop
end