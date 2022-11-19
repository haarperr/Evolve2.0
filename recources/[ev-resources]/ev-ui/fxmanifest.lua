fx_version 'cerulean'
games {'gta5'}

ui_page "html/index.html"

files({
	"html/*",
	"html/img/*",
	"html/css/*",
	"html/font/*",
	"html/js/*"
})

client_script "@ev-lib/client/cl_ui.lua"
client_script "@ev-lib/client/cl_interface.lua"


client_scripts {
	"client/*.lua",
	"@ev-lib/client/cl_polyhooks.lua",
	"@ev-lib/client/cl_ui.lua",
	'@ev-lib/client/cl_rpc.lua',
	'client/model/*.lua'
	
}
server_scripts {
	"server/*",
	"@ev-lib/server/sv_asyncExports.lua",
	'@ev-lib/server/sv_rpc.lua',
	'@ev-lib/server/sv_sql.lua',
}
