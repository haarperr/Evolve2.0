





games {"gta5"}

fx_version "adamant"
version "1.0"

dependency "ev-base"

server_scripts {
    "@ev-lib/server/sv_sqlother.lua",
    "server.lua"
}

server_export "AddLog"
server_export "AddLogHex"