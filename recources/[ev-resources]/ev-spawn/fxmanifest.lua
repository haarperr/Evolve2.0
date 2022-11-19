





fx_version 'cerulean'
games {'gta5'}

-- dependency "durp-base"
-- dependency "raid_clothes"

client_script "@ev-lib/client/cl_interface.lua"

ui_page "html/index.html"
files({
	"html/*",
	"html/images/*",
	"html/css/*",
	"html/webfonts/*",
	"html/js/*"
})


client_script '@ev-lib/client/cl_rpc.lua'
client_script "client/*"

server_script '@ev-lib/server/sv_rpc.lua'
shared_script "shared/sh_spawn.lua" 
server_script "server/*"

lua54 'yes'