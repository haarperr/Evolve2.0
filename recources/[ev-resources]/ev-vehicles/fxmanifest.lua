fx_version 'bodacious'
games { 'rdr3', 'gta5' }

client_scripts {
    '@ev-lib/client/cl_interface.lua',
    'client/*.lua',
    '@ev-lib/client/cl_main.lua',
}


server_scripts {
    'server/*.lua',
    '@ev-lib/server/sv_main.lua',
}

exports {
    'GetVehicleTable',
    'SetVehicleMods',
}