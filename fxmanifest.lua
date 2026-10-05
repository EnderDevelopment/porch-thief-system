fx_version 'cerulean'
game 'gta5'

description 'Porch Thief System'
version '1.0.0'

author 'EnderDevelopment'

dependency 'es_extended'

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

shared_scripts {
    'config.lua'
}