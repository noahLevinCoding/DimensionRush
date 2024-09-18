class_name GameStateTitlescreen
extends State

func enter():
	visible = true
	
func exit():
	visible = false

func _on_play_button_up():
	state_transition.emit(self, "PlayerMode")

func _on_exit_button_up():
	get_tree().quit()
