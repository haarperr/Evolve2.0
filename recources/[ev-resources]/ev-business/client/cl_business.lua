RegisterInterfaceCallback("ev-ui:createBusiness", function(data, cb)
  local success, message = RPC.execute("CreateBusiness", data)
  cb({ data = {}, meta = { ok = success, message = message } })
end)

RegisterInterfaceCallback("ev-ui:getBusinessTypes", function(data, cb)
  local success, message = RPC.execute("GetBusinessTypes")
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("ev-ui:getBusinesses", function(data, cb)
  local success, message = RPC.execute("GetBusinesses")
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("ev-ui:getEmploymentInformation", function(data, cb)
  local success, message = RPC.execute("GetEmploymentInformation", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("ev-ui:getBusinessEmployees", function(data, cb)
  local success, message = RPC.execute("GetBusinessEmployees", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("ev-ui:getBusinessRoles", function(data, cb)
  local success, message = RPC.execute("GetBusinessRoles", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("ev-ui:createBusinessRole", function(data, cb)
  local success, message = RPC.execute("CreateBusinessRole", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("ev-ui:changeBusinessRole", function(data, cb)
  local success, message = RPC.execute("ChangeBusinessRole", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("ev-ui:hireBusinessEmployee", function(data, cb)
  local success, message = RPC.execute("HireBusinessEmployee", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("ev-ui:removeBusinessEmployee", function(data, cb)
  local success, message = RPC.execute("RemoveBusinessEmployee", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("ev-ui:businessPayEmployee", function(data, cb)
  local success, message = RPC.execute("BusinessPayEmployee", data)
  cb({ data = message or {}, meta = { ok = success, message = message or "Unknown Error; check account balance" } })
end)

RegisterInterfaceCallback("ev-ui:businessPayExternal", function(data, cb)
  local success, message = RPC.execute("BusinessPayExternal", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("ev-ui:businessChargeExternal", function(data, cb)
  RPC.execute("ChargeExternal", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)
RegisterInterfaceCallback("ev-ui:businessChargeAccept", function(data, cb)
  local success, message = RPC.execute("BusinessChargeAccept", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

--[[ RegisterNetEvent("business:chargeAcceptPrompt")
AddEventHandler("business:chargeAcceptPrompt", function(data)
  SendUIMessage({
    source = "ev-nui",
    app = "phone",
    data = {
      action = "charge-accept",
      data = data,
    },
  })
end) ]]
