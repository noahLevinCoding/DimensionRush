extends Node

enum PLAYER_MODES {NONE, SINGLEPLAYER, MULTIPLAYER_LOCAL, MULTIPLAYER_ONLINE}
enum MULTIPLAYER_MODES {NONE, CLIENT, SERVER}
enum GAME_MODES {NONE, TIME, DISTANCE}

var player_mode : PLAYER_MODES = PLAYER_MODES.NONE
var multiplayer_mode : MULTIPLAYER_MODES = MULTIPLAYER_MODES.NONE
var game_mode : GAME_MODES = GAME_MODES.NONE

var first_player_controls_resource 	: PlayerControlsResource = null
var second_player_controls_resource : PlayerControlsResource = null

func is_online_multiplayer() -> bool:
	return player_mode == PLAYER_MODES.MULTIPLAYER_ONLINE
	
func is_server() -> bool:
	return multiplayer_mode == MULTIPLAYER_MODES.SERVER
	
func is_client() -> bool:
	return multiplayer_mode == MULTIPLAYER_MODES.CLIENT
