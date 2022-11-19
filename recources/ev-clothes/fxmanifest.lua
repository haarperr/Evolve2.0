fx_version 'cerulean'
game 'gta5'
 
lua54 'yes' -- Add in case you want to use lua 5.4 (https://www.lua.org/manual/5.4/manual.html)
 
client_scripts {
    '@ev-lib/client/cl_rpc.lua',
    '@ev-lib/client/cl_interface.lua',
    '@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
    "client/names.json",
    "client/customfunctions.js",
    'client/*.lua', -- Globbing method for multiple files
}

shared_script "config.lua"

server_scripts {
    '@ev-lib/server/sv_rpc.lua',
    "@oxmysql/lib/MySQL.lua",
    "client/names.json",
    'server.lua' -- Globbing method for multiple files
}

ui_page 'web/build/index.html'
 
files {
    'web/build/index.html',
    'web/build/**/*'
}

escrow_ignore {
    'config.lua',
}