class_name GameStateGameOver
extends State

func enter():
	visible = true
	
	
func exit():
	visible = false
	GameManager.game_is_running = false

func _on_restart_button_up():
	if GameManager.is_online_multiplayer():
		game_over_on_restart_button_up.rpc()
	state_transition.emit(self, "InitGame")

@rpc("any_peer")
func game_over_on_restart_button_up():
	state_transition.emit(self, "InitGame")


func _on_titlescreen_button_up():
	if GameManager.is_online_multiplayer():
		game_over_on_titlescreen_button_up.rpc()
	state_transition.emit(self, "Titlescreen")

@rpc("any_peer")
func game_over_on_titlescreen_button_up():
	state_transition.emit(self, "Titlescreen")
