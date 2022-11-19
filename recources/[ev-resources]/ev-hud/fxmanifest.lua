fx_version 'cerulean'
game 'gta5'


client_script {
    '@ev-lib/client/cl_interface.lua',
    'config.lua',
	'client/*.lua'
}

server_script {
    'server/*.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/*.css',
    'html/*.js',
    'html/img/*.png',
    'html/static/js/*.js',
    'html/static/css/*.css',
    'html/static/media/*.ttf',
    'html/static/media/*.png',
    'html/static/media/*.jpg',
    'html/static/media/*.gif',
    'html/static/media/*.ogg',
}

exports {
    'sendfpscarhud',
    'dobuffthing',
    'IntelegenceBuff',
    'MoneyBuff'
}