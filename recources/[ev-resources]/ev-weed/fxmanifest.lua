fx_version "cerulean"
games { "gta5" }

shared_script {
    "@ev-lib/shared/sh_util.lua",
    "shared/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "@ev-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
    "@ev-lib/client/cl_rpc.lua",
    "@ev-lib/client/cl_interface.lua",
    "@ev-sync/client/lib.lua",
    "@ev-lib/client/cl_polyhooks.lua",
    "@ev-locales/client/lib.lua",
    "client/*",
}