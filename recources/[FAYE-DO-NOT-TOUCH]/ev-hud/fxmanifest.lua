fx_version "cerulean"

description "Cool - Hud"
author "cool"
version '0.0.1'

lua54 'yes'

game "gta5"

ui_page 'web/build/index.html'

client_scripts {
  "@ev-lib/client/cl_rpc.lua",
  "client/cl_exports.lua",
  "client/cl_main.lua",
  "client/cl_utils.lua",
  "client/model/cl_*.lua"
}

server_scripts {
  "@ev-lib/server/sv_rpc.lua",
  "@ev-lib/server/sv_sql.lua",
  "server/sv_*.lua"
}

files {
  'web/build/index.html',
  'web/build/**/*'
}

exports {
	'BuffIntel',
	'BuffStress',
	'BuffLuck',
	'BuffHunger',
  'BuffThirst',
	'BuffAlert',
}