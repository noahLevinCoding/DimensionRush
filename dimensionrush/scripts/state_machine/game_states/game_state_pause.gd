class_name GameStatePause
extends State

func enter():
	visible = true
	
func exit():
	visible = false

func _on_restart_button_up():
	if GameManager.is_online_multiplayer():
		pause_on_restart_button_up.rpc()
	state_transition.emit(self, "InitGame")

@rpc("any_peer")
func pause_on_restart_button_up():
	state_transition.emit(self, "InitGame")


func _on_titlescreen_button_up():
	if GameManager.is_online_multiplayer():
		pause_on_titlescreen_button_up.rpc()
	state_transition.emit(self, "Titlescreen")

@rpc("any_peer")
func pause_on_titlescreen_button_up():
	state_transition.emit(self, "Titlescreen")


func _on_continue_button_up():
	if GameManager.is_online_multiplayer():
		pause_on_continue_button_up.rpc()
	state_transition.emit(self, "Playing")

@rpc("any_peer")
func pause_on_continue_button_up():
	state_transition.emit(self, "Playing")
