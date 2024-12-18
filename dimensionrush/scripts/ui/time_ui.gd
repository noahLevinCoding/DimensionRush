class_name TimeUI
extends Control

@export var timer_label : Label

func _ready() -> void:
	SignalManager.changed_game_mode.connect(changed_game_mode)

func changed_game_mode():
	visible = (GameManager.game_mode == GameManager.GAME_MODES.TIME)
	
func _physics_process(delta: float):
	if visible:
		timer_label.text = "%0.2f" % GameManager.remaining_level_time
		
