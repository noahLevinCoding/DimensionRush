class_name DistanceUI
extends Control

@export var upper_progress_label : Label
@export var lower_progress_label : Label

@export var upper_progress_bar : TextureProgressBar
@export var lower_progress_bar : TextureProgressBar

var upper_player : Player = null
var lower_player : Player = null

func _ready() -> void:
	SignalManager.changed_game_mode.connect(changed_game_mode)
	SignalManager.on_player_ready.connect(on_player_ready)
	SignalManager.on_player_destroy.connect(on_player_destroy)
 
func changed_game_mode():
	visible = (GameManager.game_mode == GameManager.GAME_MODES.DISTANCE)

func on_player_ready(player: Player):
	if player.is_upper:
		upper_player = player;
	else:
		lower_player = player
		
func on_player_destroy(player: Player):
	if player.is_upper:
		upper_player = null;
	else:
		lower_player = null

func _physics_process(delta: float):
	if visible and upper_player and lower_player and not is_zero_approx(GameManager.level_distance):
		
		var upper_progress =  abs(clamp(upper_player.position.x / GameManager.level_distance, 0.0, 1.0))
		var lower_progress =  abs(clamp(-lower_player.position.x / GameManager.level_distance, 0.0, 1.0))
		
		upper_progress_label.text = "%0.2f" % upper_progress
		lower_progress_label.text = "%0.2f" % lower_progress
		
		upper_progress_bar.value = upper_progress 
		lower_progress_bar.value = lower_progress
				
	
