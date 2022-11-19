fx_version "cerulean"
games { "gta5" }


client_scripts {
    "@ev-sync/client/lib.lua",
    '@ev-lib/client/cl_interface.lua',
    "@ev-lib/client/cl_polyhooks.lua",
    "@ev-locales/client/lib.lua",
    "@ev-lib/client/cl_rpc.lua",
    "client/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua", 
    "@ev-lib/server/sv_rpc.lua",
    "server/*",
}


shared_scripts {
    "shared/*",
} 
