fx_version 'cerulean'
game 'gta5'
author 'negbook'

lua54 'yes'
escrow_ignore {
	'example.lua',
	'example-sv.lua'
}

files {
	'tasksync.lua.sourcecode',
	'tasksync_custom.lua.sourcecode',
	'tasksync_once.lua.sourcecode',
	'tasksync_with_scaleform.lua.sourcecode',
	'tasksync_with_drawtext.lua.sourcecode',
	'tasksync_with_keys.lua.sourcecode',
}
client_scripts {
'log.lua',
--'example.lua'
}

server_scripts {
'versionchecker.lua',
'log.lua',
--'example-sv.lua'
}



