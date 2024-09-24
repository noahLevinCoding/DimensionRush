class_name GameStateSelectGameMode
extends State


func enter():
	visible = true
	
func exit():
	visible = false


func _on_back_button_up():
	back_transition.emit(self)
