





fx_version 'bodacious'
game 'gta5'

shared_scripts{
    "@ev-lib/shared/sh_util.lua",
    "@ev-lib/client/cl_rpc.lua",
}

client_scripts{
    "events.lua",
    "functions.lua",
    "zones.lua",
    "config.lua",
}

server_script 'server.lua'


