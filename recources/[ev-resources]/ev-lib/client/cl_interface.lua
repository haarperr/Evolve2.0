local registered = {}

function RegisterInterfaceCallback(name, cb)
  local function interceptCb(data, innerCb)
    cb(data, function(result)
      if result.meta.ok then
        result.meta.message = "done"
      end
      innerCb(result)
    end)
  end
  AddEventHandler(('_apx_uiReq:%s'):format(name), interceptCb)

  if (GetResourceState("ev-interface") == "started") then 
    exports["ev-interface"]:RegisterIntefaceEvent(name) 
  end

  registered[#registered + 1] = name
end

function SendInterfaceMessage(data)
  exports["ev-interface"]:SendInterfaceMessage(data)
end

function SetInterfaceFocus(hasFocus, hasCursor)
  exports["ev-interface"]:SetInterfaceFocus(hasFocus, hasCursor)
end

function GetInterfaceFocus()
  return exports["ev-interface"]:GetInterfaceFocus()
end

AddEventHandler("_apx_uiReady", function()
  for _, eventName in ipairs(registered) do
    exports["ev-interface"]:RegisterIntefaceEvent(eventName)
  end
end)