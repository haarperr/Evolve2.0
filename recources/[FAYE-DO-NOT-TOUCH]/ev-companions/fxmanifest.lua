fx_version "cerulean"
games { "gta5" }

shared_scripts {
    "shared/*",
}

server_scripts {
    "@ev-lib7/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
    "@ev-lib7/client/cl_rpc.lua",
    "@ev-lib7/client/cl_ui.lua",
    "client/*",
}