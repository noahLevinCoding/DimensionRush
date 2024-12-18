class_name DistanceUI
extends Control

func _ready() -> void:
	SignalManager.changed_game_mode.connect(changed_game_mode)

func changed_game_mode():
	visible = (GameManager.game_mode == GameManager.GAME_MODES.DISTANCE)
