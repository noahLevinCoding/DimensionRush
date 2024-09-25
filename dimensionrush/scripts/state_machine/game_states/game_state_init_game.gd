class_name GameStateInitGame
extends State

@export var start_button : Button

func enter():
	init_game_on_online_ready.rpc()
	visible = true
	
	
func exit():
	resetUI()
	visible = false


@rpc("any_peer")
func init_game_on_online_ready():
	start_button.disabled = false

@rpc("any_peer")
func init_game_on_start_button_up():
	state_transition.emit(self, "Playing")

func _on_start_button_up():
	init_game_on_start_button_up.rpc()
	state_transition.emit(self, "Playing")

@rpc("any_peer")
func init_game_on_back_button_up():
	state_transition.emit(self, "SelectGameMode")

func _on_back_button_up():
	if GameManager.is_online_multiplayer():
		init_game_on_back_button_up.rpc()
	
	state_transition.emit(self, "SelectGameMode")

func resetUI():
	if GameManager.is_online_multiplayer():
		start_button.disabled = true
