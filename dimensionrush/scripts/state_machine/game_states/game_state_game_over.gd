class_name GameStateGameOver
extends State

@export var winner_label : Label

var upper_player : Player = null
var lower_player : Player = null

func _ready() -> void:
	SignalManager.on_player_ready.connect(on_player_ready)

func on_player_ready(player: Player):
	if player.is_upper:
		upper_player = player;
	else:
		lower_player = player

func enter():
	visible = true
	GameManager.game_is_running = false
	
	var upper_player_position_x = upper_player.position.x
	var lower_player_position_x = -lower_player.position.x
	
	var upper_player_wins = upper_player_position_x >= lower_player_position_x
	
	if upper_player_wins:
		winner_label.text = "Upper player wins!"
	else:
		winner_label.text = "Lower player wins!"
	
func exit():
	visible = false

func _on_restart_button_up():
	if GameManager.auto_game_seed:
		GameManager.game_seed = randi()
	
	if GameManager.is_online_multiplayer():
		game_over_on_restart_button_up.rpc(GameManager.game_seed)
		
	state_transition.emit(self, "InitGame")

@rpc("any_peer")
func game_over_on_restart_button_up(game_seed):
	GameManager.game_seed = game_seed
	state_transition.emit(self, "InitGame")


func _on_titlescreen_button_up():
	if GameManager.is_online_multiplayer():
		game_over_on_titlescreen_button_up.rpc()
	state_transition.emit(self, "Titlescreen")

@rpc("any_peer")
func game_over_on_titlescreen_button_up():
	state_transition.emit(self, "Titlescreen")

func _on_change_game_mode_button_up() -> void:
	if GameManager.is_online_multiplayer():
		pause_on_change_game_mode_button_up.rpc()
	state_transition.emit(self, "SelectGameMode")
	
@rpc("any_peer")
func pause_on_change_game_mode_button_up():
	state_transition.emit(self, "SelectGameMode")
