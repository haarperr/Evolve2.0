





resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
client_script "@ev-errorlog/client/cl_errorlog.lua"


client_script {
  '@ev-lib/client/cl_interface.lua',
  "gui.lua",
  "cl_towgarage.lua"
}
server_script "sv_towgarage.lua"
