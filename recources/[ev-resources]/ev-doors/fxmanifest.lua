





fx_version 'cerulean'

games {
    'gta5',
    'rdr3'
}

client_scripts {
  '@ev-lib/client/cl_rpc.lua',
  '@ev-lib/client/cl_ui.lua',
  '@ev-lib/client/cl_interface.lua',
  '@ev-lib/client/cl_polyhooks.lua',
	'client/cl_*.lua'
}

shared_scripts {
  '@ev-lib/shared/sh_util.lua',
	"shared/*.lua"
}

server_scripts {
  '@ev-lib/server/sv_rpc.lua',
  '@ev-lib/server/sv_sql.lua',
	'server/*.lua'
}