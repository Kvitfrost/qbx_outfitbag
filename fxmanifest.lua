fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'QBX Outfit Bag - Store and change outfits on the go'
version '1.0.0'
author 'pvnqu'

dependencies {
    'ox_lib',
    'ox_target',
    'oxmysql',
    'ox_inventory',
    'qbx_core',
    'illenium-appearance'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/shared/locale.lua',
    'config.lua',
    'locales/en.lua',
    'locales/*.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
} 