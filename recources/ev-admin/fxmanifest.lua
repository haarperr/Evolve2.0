fx_version "cerulean"
description "AdminUI"
author "loleris"
version '0.0.1'
game "gta5"

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ev-lib/server/sv_sqlother.lua',
    '@ev-lib/server/sv_rpc.lua',
    '@ev-lib/server/sv_rpc.js',
    '@ev-lib/server/sv_sql.lua',
    '@ev-lib/server/sv_sql.js',
    'dist/server/*.js',
    'server/sv_*.lua'
}

client_scripts {
    '@ev-lib/client/cl_rpc.js',
    '@ev-lib/client/cl_rpc.lua',
    '@ev-lib/client/cl_poly.js',
    'dist/client/*.js',
    'client/cl_*.lua',
}