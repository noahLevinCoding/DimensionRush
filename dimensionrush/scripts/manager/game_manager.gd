extends Node

enum PLAYER_MODES {NONE, SINGLEPLAYER, MULTIPLAYER_LOCAL, MULTIPLAYER_ONLINE}
enum MULTIPLAYER_MODES {NONE, CLIENT, SERVER}
enum GAME_MODES {NONE, TIME, DISTANCE}

var player_mode 	 : PLAYER_MODES 		= PLAYER_MODES.NONE
var multiplayer_mode : MULTIPLAYER_MODES 	= MULTIPLAYER_MODES.NONE
var game_mode 		 : GAME_MODES 			= GAME_MODES.NONE

var client_peer_id : int = 0

var first_player_controls_resource 	: PlayerControlsResource = null
var second_player_controls_resource : PlayerControlsResource = null

var game_is_running : bool = false

var game_seed = 12345
var level_distance = 10000

func reset():
	SignalManager.close_connection.emit()
	
	player_mode 		= PLAYER_MODES.NONE
	multiplayer_mode 	= MULTIPLAYER_MODES.NONE
	game_mode 			= GAME_MODES.NONE
	
	client_peer_id = 0
	
	first_player_controls_resource  = null
	second_player_controls_resource = null
	
	game_is_running = false

func is_online_multiplayer() -> bool:
	return player_mode == PLAYER_MODES.MULTIPLAYER_ONLINE
	
func is_local_multiplayer() -> bool:
	return player_mode == PLAYER_MODES.MULTIPLAYER_LOCAL
	
func is_singleplayer() -> bool:
	return player_mode == PLAYER_MODES.SINGLEPLAYER
	
func is_server() -> bool:
	return multiplayer_mode == MULTIPLAYER_MODES.SERVER
	
func is_client() -> bool:
	return multiplayer_mode == MULTIPLAYER_MODES.CLIENT
