function uuid()
    math.randomseed(GetGameTimer())
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function loadModel(pModelName)
  RequestModel(pModelName)
  while not HasModelLoaded(pModelName) do
      Citizen.Wait(100)
  end
end


function encodeAccountId(plain)
    if type(plain) == 'number' then
        return math.floor(exports["ev-financials"]:EncodeId(plain))
    end
end

function decodeAccountId(encoded)
    if type(encoded) == 'number' then
        return exports["ev-financials"]:DecodeId(encoded)
    end
end

function isValidDate(str)
  if not str then return false end
  local y, m, d = str:match("(%d+)/(%d+)/(%d+)")

  y, m, d = tonumber(y), tonumber(m), tonumber(d)

  if not y or y <= 1970 or y >= 2038 then
      return false
  elseif not m or m < 1 or m > 12 then
      return false
  elseif not d or d < 1 or d > 31 then
      return false
  else
      return true
  end
end

function shallowcopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
      copy = {}
      for orig_key, orig_value in pairs(orig) do
          copy[orig_key] = orig_value
      end
  else -- number, string, boolean, etc
      copy = orig
  end
  return copy
end

function reverse(tbl)
    for i=1, math.floor(#tbl / 2) do
        tbl[i], tbl[#tbl - i + 1] = tbl[#tbl - i + 1], tbl[i]
    end

    return tbl
end

function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function ReverseTable(t)
    local reversedTable = {}
    local itemCount = #t
    for i, v in ipairs(t) do
        reversedTable[itemCount + 1 - i] = v
    end
    return reversedTable
end

function has_value(tab, val)
    if not tab then return false end
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function roundDecimals(num, decimals)
    local mult = math.pow(10, decimals or 0)
    return math.floor(num * mult + 0.5) / 100
end

function round(num)
    return tonumber(string.format("%.0f", num))
end

-- Server side only
function generateUTCTimestamp()
  local now = os.time()
  local tz_offset = os.difftime(now, os.time(os.date("!*t", now)))
  local epoch = os.time(os.date("!*t"))
  local utc = epoch + tz_offset
  return math.floor(utc)
end

function stringJoin(pData, pSeparator)
  local values = ""
  for _, value in pairs(pData) do
    values = values .. ("'%s'"):format(value) .. pSeparator
  end
  return (values):sub(1, #values - 1)
end
