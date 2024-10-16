fx_version 'cerulean'
game 'gta5'

author 'Krupowski Studio'
description 'Boski skrypt na analne zabawy'
version '1.1.0'


client_scripts {
    'client/main.lua',        
    '@ox_lib/init.lua',       
}

server_scripts {
    'server/main.lua',        
    '@oxmysql/lib/MySQL.lua', 
}


dependencies {
    'es_extended',            
    'ox_inventory',           
    'ox_lib',                 
    'oxmysql'              
}


lua54 'yes'
