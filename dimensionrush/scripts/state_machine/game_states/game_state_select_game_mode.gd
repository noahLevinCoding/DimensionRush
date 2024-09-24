class_name GameStateSelectGameMode
extends State

@export var time_button : Button
@export var distance_button : Button

func enter():
	resetUI()
	visible = true
	
func exit():
	visible = false


func resetUI():
	time_button.disabled 	 = GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE and GameManager.multiplayer_mode == GameManager.MULTIPLAYER_MODES.CLIENT
	distance_button.disabled = GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE and GameManager.multiplayer_mode == GameManager.MULTIPLAYER_MODES.CLIENT


func _on_back_button_up():
	back_transition.emit(self)


func _on_time_button_up():
	GameManager.game_mode = GameManager.GAME_MODES.TIME
	
	if GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE and GameManager.multiplayer_mode == GameManager.MULTIPLAYER_MODES.SERVER:
		test_rpc.rpc()
	
	state_transition.emit(self, "InitGame")
	


func _on_distance_button_up():
	GameManager.game_mode = GameManager.GAME_MODES.DISTANCE
	
	
	
	state_transition.emit(self, "InitGame")
	
@rpc
func test_rpc():
	if GameManager.multiplayer_mode == GameManager.MULTIPLAYER_MODES.CLIENT:
		print("Client:")
	else:
		print("Host:")
	print("Test RPC")
