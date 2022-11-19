fx_version "cerulean"
games { "gta5" }

client_script "@ev-lib/client/cl_interface.lua"

shared_scripts {
	"@ev-lib/shared/sh_util.lua",
	"shared/*",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"@ev-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
	'@ev-lib/client/cl_ui.lua',
	"@ev-lib/client/cl_rpc.lua",
	"client/*",
}