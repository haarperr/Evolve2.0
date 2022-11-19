fx_version 'cerulean'
games { 'gta5' }

--[[ dependencies {
  "ev-polyzone",
  "ev-lib",
  "ev-ui"
} ]]--

client_scripts {
  'client/cl_*.lua',
  'client/cl_*.js',
}

shared_script {
  'shared/sh_*.*',
}

server_scripts {
  'server/sv_*.lua',
  'server/sv_*.js',
}
