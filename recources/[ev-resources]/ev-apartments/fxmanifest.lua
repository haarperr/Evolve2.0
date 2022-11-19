





fx_version 'cerulean'
games { 'gta5' }

dependencies {
  "PolyZone"
}

client_script "@ev-lib/client/cl_ui.lua"
client_script "@ev-lib/client/cl_interface.lua"
client_script "config.lua"

client_scripts {
  "@PolyZone/client.lua",
  "@PolyZone/BoxZone.lua",
  "@PolyZone/CircleZone.lua",
  "@PolyZone/ComboZone.lua",
  "@PolyZone/EntityZone.lua",
  '@ev-errorlog/client/cl_errorlog.lua',
  '@ev-lib/client/cl_rpc.lua',
  'client/cl_*.lua'
}


shared_script 'shared/sh_*.*'

server_scripts {
    '@ev-lib/server/sv_rpc.lua',
    '@ev-lib/server/sv_sql.lua',
    'server/sv_*.lua',
}

export "getModule"