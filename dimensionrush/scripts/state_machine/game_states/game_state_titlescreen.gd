class_name GameStateTitlescreen
extends State

func enter():
	visible = true
	GameManager.reset()
	

	var args = OS.get_cmdline_args()
	if "debug" in args:
		GameManager.debug_mode = true
		_on_play_button_up()
	
	
func exit():
	visible = false

func _on_play_button_up():
	state_transition.emit(self, "SelectPlayerMode")

func _on_exit_button_up():
	get_tree().quit()
