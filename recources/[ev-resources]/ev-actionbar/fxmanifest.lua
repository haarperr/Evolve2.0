





fx_version 'cerulean'
games {"gta5"}

description "actionbar"

client_scripts {
  "@ev-errorlog/client/cl_errorlog.lua",
  '@ev-lib/client/cl_rpc.lua',
  "client.lua",
}

shared_script {
  '@ev-lib/shared/sh_util.lua'
}

server_scripts {
  '@ev-lib/server/sv_rpc.lua',
  '@ev-lib/server/sv_sql.lua',
}