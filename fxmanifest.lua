fx_version 'cerulean'
game 'gta5'

author 'ツ ERRØR'
description 'Fivem ESX Police Job'
version '1.0'
lua54 'yes'

client_scripts {
    'client/main.lua',
    'client/cl_*.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}
shared_scripts {
    '@es_extended/imports.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

dependency {
    'ox_lib',
    'es_extended',
    'oxmysql'
}