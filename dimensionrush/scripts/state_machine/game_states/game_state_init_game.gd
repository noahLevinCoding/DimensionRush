class_name GameStateInitGame
extends State

@export var start_button : Button

func enter():
	resetUI()
	init_game_on_online_ready.rpc()
	visible = true
	
	
func exit():
	visible = false


@rpc
func init_game_on_online_ready():
	start_button.disabled = false

@rpc 
func init_game_on_start_button_up():
	state_transition.emit(self, "Playing")

func _on_start_button_up():
	init_game_on_start_button_up.rpc()
	state_transition.emit(self, "Playing")


func _on_back_button_up():
	state_transition.emit(self, "SelectGameMode")

func resetUI():
	if GameManager.is_online_multiplayer():
		start_button.disabled = true
