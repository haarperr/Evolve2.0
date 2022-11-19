fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_scripts {
    "@ev-lib/client/cl_rpc.lua",
    "@ev-lib/client/cl_interface.lua",
    'client/*.lua'
}

server_scripts {
    "@ev-lib/server/sv_rpc.lua",
    'server/*.lua'
}
 