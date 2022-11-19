-- timing and text config below

-- want to change the font size? change line 16 in ui.css

-- want to change font color? chnage line 20 in ui.css

--[[ want to change the position? use lines 28 - 32, you will need to know some css
tutorial for this is in forum post ]]

-- Created by Floh : )

----------------
---- CONFIG ----
----------------

-- time between each item showing
local cycleTime = 6000
-- time before showing watermark again after all items show
local restTime = 2

-- enable name?
local nameEnabled = false
-- your server name
-- use /restart simple-watermark to update
local name = 'AstralRP'

-- enable link?
local linkEnabled = false
-- your server link
-- use /restart simple-watermark to update
local link = 'discord.gg/AstralRP'

-- enable logo?
-- logo file should be 1:1 (square) and at least 128px x 128px
--[[ if you change the logo file without restarting server,
make sure to /stop simple-watermark, /refresh, /start simple-watermark]]
local logoEnabled = true

--------------------
--------------------
------- CODE -------
--------------------
--------------------
-- only edit if you are the smart
--------------------

local showWatermark = true

CreateThread(function()
  Wait(1000)
  -- send config values to NUI
  SendNuiMessage(json.encode{
    type = 'setup',
    nametext = name,
    linktext = link,
  })
  Wait(2000)
  while true do

    -- show each item if enabled, then hide
    if nameEnabled then
      -- show name
      SendNuiMessage(json.encode{
        type = 'showItem',
        item = 'name',
      })

      Wait(cycleTime * 1000)
      -- hide
      Wait(1000)
    end

    if linkEnabled then
      -- show link
      SendNuiMessage(json.encode{
        type = 'showItem',
        item = 'link',
      })

      Wait(cycleTime * 6000)
      -- hide
      Wait(6000)
    end

    if logoEnabled then
      -- show logo
      SendNuiMessage(json.encode{
        type = 'showItem',
        item = 'logo',
      })

      Wait(cycleTime * 6000)
      -- hide
      Wait(6000)
    end
  end
end)
