class_name GameStatePause
extends State

func enter():
	visible = true
	GameManager.game_is_running = false
func exit():
	visible = false

@rpc("any_peer")
func pause_on_restart_button_up(game_seed):
	GameManager.game_seed = game_seed
	state_transition.emit(self, "InitGame")



@rpc("any_peer")
func pause_on_titlescreen_button_up():
	state_transition.emit(self, "Titlescreen")



@rpc("any_peer")
func pause_on_continue_button_up():
	state_transition.emit(self, "Playing")

	
@rpc("any_peer")
func pause_on_change_game_mode_button_up():
	state_transition.emit(self, "SelectGameMode")


func _on_quit_button_pressed() -> void:
	if GameManager.is_online_multiplayer():
		pause_on_titlescreen_button_up.rpc()
	state_transition.emit(self, "Titlescreen")


func _on_change_game_mode_button_pressed() -> void:
	if GameManager.is_online_multiplayer():
		pause_on_change_game_mode_button_up.rpc()
	state_transition.emit(self, "SelectGameMode")


func _on_restart_button_pressed() -> void:
	if GameManager.auto_game_seed:
		GameManager.game_seed = randi()
	
	if GameManager.is_online_multiplayer():
		pause_on_restart_button_up.rpc(GameManager.game_seed)
	state_transition.emit(self, "InitGame")


func _on_continue_button_pressed() -> void:
	if GameManager.is_online_multiplayer():
		pause_on_continue_button_up.rpc()
	state_transition.emit(self, "Playing")
