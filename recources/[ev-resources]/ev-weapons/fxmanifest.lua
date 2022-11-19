





games {"gta5"}

fx_version "cerulean"

description "Weapons"

dependencies  {
  "damage-events"
}

client_scripts {
  "@ev-errorlog/client/cl_errorlog.lua",
  "@ev-lib/client/cl_rpc.lua",
 -- "client.lua",
  "modes.lua",
  "melee.lua",
  "pickups.lua"
}

shared_script {
  "@ev-lib/shared/sh_util.lua"
}
server_scripts {
  "@ev-lib/server/sv_rpc.lua",
  "@ev-lib/server/sv_sql.lua",
  "server.lua"
}

server_export "getWeaponMetaData"
server_export "updateWeaponMetaData"

exports {
  "toName",
  "findModel"
}
