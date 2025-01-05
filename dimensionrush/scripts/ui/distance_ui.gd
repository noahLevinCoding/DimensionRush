class_name DistanceUI
extends Control

@export var upper_progress_label : Label
@export var lower_progress_label : Label

var upper_player : Player = null
var lower_player : Player = null

func _ready() -> void:
	SignalManager.changed_game_mode.connect(changed_game_mode)
	SignalManager.on_player_ready.connect(on_player_ready)

func changed_game_mode():
	visible = (GameManager.game_mode == GameManager.GAME_MODES.DISTANCE)

func on_player_ready(player: Player):
	if player.is_upper:
		upper_player = player
	else:
		lower_player = player

func _physics_process(delta: float):
	if visible and upper_player and lower_player and not is_zero_approx(GameManager.level_distance):
		upper_progress_label.text = "%0.2f" % (abs(upper_player.position.x) / GameManager.level_distance)
		lower_progress_label.text = "%0.2f" % (abs(lower_player.position.x) / GameManager.level_distance)
	
