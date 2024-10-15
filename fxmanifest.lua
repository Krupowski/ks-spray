fx_version 'bodacious'
game 'gta5'

author 'Krupowski Studio 
description 'Boski skrypt na analne zabawy'
version '2.0.0'

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}

shared_script {
'@es_extended/imports.lua'
}

dependencies {
    'es_extended',
    'ox_lib',
    'ox_inventory',
    'ox_target'
}
