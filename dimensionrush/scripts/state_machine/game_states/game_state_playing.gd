class_name GameStatePlaying
extends State

func enter():
	visible = true
	GameManager.game_is_running = true
	
func exit():
	visible = false
	
func update(delta):
	if GameManager.game_mode == GameManager.GAME_MODES.TIME:
		update_game_mode_time(delta)
		
func update_game_mode_time(delta):
	GameManager.remaining_level_time -= delta
	if GameManager.remaining_level_time <= 0.0:
		_on_finish_button_up()

func _on_finish_button_up():
	if GameManager.is_online_multiplayer():
		playing_on_finish_button_up.rpc()
	state_transition.emit(self, "GameOver")

@rpc("any_peer")
func playing_on_finish_button_up():
	state_transition.emit(self, "GameOver")


func _on_pause_button_up():
	if GameManager.is_online_multiplayer():
		playing_on_pause_button_up.rpc()
	state_transition.emit(self, "Pause")

@rpc("any_peer")
func playing_on_pause_button_up():
	state_transition.emit(self, "Pause")
