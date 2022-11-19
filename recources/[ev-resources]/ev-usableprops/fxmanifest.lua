





fx_version 'cerulean'
games {'gta5'}

--client_script "@npx/client/lib.js"
--server_script "@npx/server/lib.js"
--shared_script "@npx/shared/lib.lua"

client_script "@ev-errorlog/client/cl_errorlog.lua"
client_script "@ev-sync/client/lib.lua"

server_script "@ev-lib/server/sv_asyncExports.lua"

shared_script "@ev-lib/shared/sh_util.lua"

client_scripts {
  '@ev-lib/client/cl_rpc.lua',
  'cl_*.lua'
}

server_scripts {
  '@ev-lib/server/sv_sql.lua',
  '@ev-lib/server/sv_rpc.lua',
  'sv_*.lua'
}
