





fx_version "cerulean"
games {"gta5"}

server_script '@ev-lib/server/sv_rpc.lua'
client_script '@ev-lib/client/cl_rpc.lua'

client_scripts {
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}