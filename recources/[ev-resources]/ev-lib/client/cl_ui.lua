local registered = {}

function RegisterUICallback(name, cb)
  local function interceptCb(data, innerCb)
    cb(data, function(result)
      if result.meta.ok then
        result.meta.message = "done"
      end
      innerCb(result)
    end)
  end
  AddEventHandler(('_dpx_uiReq:%s'):format(name), interceptCb)

  if (GetResourceState("ev-ui") == "started") then 
    exports["ev-ui"]:RegisterUIEvent(name) 
  end

  registered[#registered + 1] = name
end

function SendUIMessage(data)
  exports["ev-ui"]:SendUIMessage(data)
end

function SetUIFocus(hasFocus, hasCursor)
  exports["ev-ui"]:SetUIFocus(hasFocus, hasCursor)
end

function GetUIFocus()
  return exports["ev-ui"]:GetUIFocus()
end

AddEventHandler("_dpx_uiReady", function()
  for _, eventName in ipairs(registered) do
    exports["ev-ui"]:RegisterUIEvent(eventName)
  end
end)
