fx_version 'cerulean'
games { 'gta5' }

client_scripts {
  '@ev-errorlog/client/cl_errorlog.lua',
  '@ev-sync/client/lib.lua',
  '@ev-lib/client/cl_rpc.lua',
  '@ev-lib/client/cl_ui.lua',
  '@ev-lib/client/cl_animTask.lua',
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/ComboZone.lua',
  'client/cl_*.lua',
}

shared_script {
  '@ev-lib/shared/sh_util.lua',
  'shared/sh_*.*',
}

server_scripts {
  'config.lua',
  '@ev-lib/server/sv_rpc.lua',
  '@ev-lib/server/sv_sql.lua',
  '@ev-lib/server/sv_sql.js',
  '@ev-lib/server/sv_asyncExports.js',
  '@ev-lib/server/sv_asyncExports.lua',
  'server/sv_*.lua',
  'server/sv_*.js',
}
