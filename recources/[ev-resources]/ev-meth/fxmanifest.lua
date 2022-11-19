fx_version 'cerulean'

games { 'gta5' }
shared_script {
  "@ev-lib/server/sv_rpc.lua",
  "@ev-lib/server/sv_sql.lua",
  "@ev-lib/server/sv_asyncExports.lua"
}

client_scripts {
  "@ev-sync/client/lib.lua",
  '@ev-lib/client/cl_interface.lua',
  "@ev-lib/client/cl_polyhooks.lua",
  "@ev-locales/client/lib.lua",
  "@ev-lib/client/cl_rpc.lua",
  'client/cl_*.lua',
  "@PolyZone/client.lua",
}

server_scripts {
  "@ev-lib/server/sv_rpc.lua",
  'server/sv_*.lua',
  'server/sv_*.js',
  'build-server/sv_*.js',
}
  