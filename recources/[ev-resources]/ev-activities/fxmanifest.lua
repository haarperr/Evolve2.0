fx_version 'adamant'
games { 'gta5' }

client_script {
    '@ev-lib/client/cl_rpc.lua',
	'@ev-lib/client/cl_ui.lua',
	'@ev-lib/client/cl_interface.lua',
    '@ev-lib/client/cl_ui.js',
    'client/cl_*.lua'
}

server_script {
    '@ev-lib/server/sv_rpc.lua',
    'server/sv_*.lua'
}

exports {
    'canHandOffPackages'
}