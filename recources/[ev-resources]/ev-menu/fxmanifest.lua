





fx_version 'cerulean'
games { 'gta5' }

client_script "@ev-lib/client/cl_interface.lua"

client_scripts {
  "@ev-lib/shared/sh_util.lua"
}

shared_scripts {
  "shared/sh_*.lua"
}

client_scripts {
  "@ev-locales/client/lib.lua",
  "client/cl_*.lua",
  "client/entries/cl_*.lua"
}

ui_page "html/ui.html"

files {
  "html/ui.html",
  "html/js/*.js",
  'html/css/*.css',
  'html/webfonts/*.eot',
  'html/webfonts/*.svg',
  'html/webfonts/*.ttf',
  'html/webfonts/*.woff',
  'html/webfonts/*.woff2'
}
