class_name GameStatePlayerMode
extends State


func enter():
	visible = true
	GameManager.game_is_running = false
	
	if GameManager.debug_mode:
		_on_multiplayer_local_button_pressed()
	
func exit():
	visible = false

func _on_singleplayer_button_pressed() -> void:
	GameManager.player_mode = GameManager.PLAYER_MODES.SINGLEPLAYER
	state_transition.emit(self, "SelectOnePlayerControls")


func _on_multiplayer_local_button_pressed() -> void:
	GameManager.player_mode = GameManager.PLAYER_MODES.MULTIPLAYER_LOCAL
	state_transition.emit(self, "SelectTwoPlayerControls")


func _on_multiplayer_online_button_pressed() -> void:
	GameManager.player_mode = GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE
	state_transition.emit(self, "SelectOnePlayerControls")


func _on_back_button_pressed() -> void:
	state_transition.emit(self, "Titlescreen")
