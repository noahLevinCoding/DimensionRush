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
