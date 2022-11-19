fx_version 'cerulean'
games { 'gta5' }

shared_script "@mka-array/Array.lua"

client_scripts {
    '@ev-lib/client/cl_rpc.lua',
    '@ev-lib/client/cl_ui.lua',
	'@ev-lib/client/cl_interface.lua',
    '@ev-errorlog/client/cl_errorlog.lua',
    'client/cl_*.lua',
}

shared_script {
    '@ev-lib/shared/sh_util.lua',
}

server_scripts {
    '@ev-lib/server/sv_rpc.lua',
    '@ev-lib/server/sv_sql.lua',
    'server/sv_*.lua',
}