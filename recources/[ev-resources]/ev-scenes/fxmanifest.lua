fx_version 'cerulean'

games { 'gta5' }

client_script "@ev-lib/client/cl_interface.lua"

client_scripts {
  'client/cl_*.lua',
}

server_scripts {
  '@ev-lib/server/sv_sql.lua',
  'server/sv_*.lua',
}

