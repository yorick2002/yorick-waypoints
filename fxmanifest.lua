fx_version 'cerulean'

game { 'gta5' }

author 'Yorick'
description 'FiveM waypoints script'
version '1.0.0'

ui_page 'client/web/build/index.html'
--ui_page 'http://localhost:5173'

client_scripts {
    'client/client.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'server/functions.lua'
}

files {
    'client/web/build/index.html',
    'client/web/build/**/*'
}
