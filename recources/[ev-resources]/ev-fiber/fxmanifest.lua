








fx_version "cerulean"

games { "gta5" }

description "Sanyo Fiber"

version "0.1.0"

ui_page 'nui/index.html'

files {
    'nui/**/*',
}

server_scripts {
    "@ev-lib/server/sv_npx.js",
    "@ev-lib/server/sv_rpc.js",
    "@ev-lib/server/sv_sql.js",
    "@ev-lib/shared/sh_cacheable.js",
    "@ev-lib/server/sv_asyncExports.js",
    "server/*.js",
}

client_scripts {
    "@ev-lib/client/cl_rpc.js",
    "client/*.js",
}
