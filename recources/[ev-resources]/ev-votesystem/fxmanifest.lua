





fx_version 'bodacious'
game 'gta5'

client_script "@ev-errorlog/client/cl_errorlog.lua"

client_script "client.lua"
server_script "@ev-lib/server/sv_rpc.lua"
server_script "@ev-lib/server/sv_sql.lua"
server_script "server.lua"


exports {
	'getTax'
} 
