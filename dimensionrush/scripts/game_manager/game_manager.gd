extends Node

enum PLAYER_MODES {SINGLEPLAYER, MULTIPLAYER_LOCAL, MULTIPLAYER_ONLINE}

var player_mode : PLAYER_MODES
var first_player_controls_resource 	: PlayerControlsResource = null
var second_player_controls_resource : PlayerControlsResource = null
