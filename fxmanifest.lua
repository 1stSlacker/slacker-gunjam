fx_version 'cerulean'
game 'gta5'

author 'Your Name'
description 'QBCore Gun Jamming Script'
version '1.0.0'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

shared_script 'config.lua'

dependencies {
    'qb-core', -- Make sure you have QBCore as a dependency
}
