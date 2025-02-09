extends Control

@export var video_stream_player : VideoStreamPlayer

func _ready() -> void:
	SignalManager.changed_game_state.connect(changed_game_state)

func changed_game_state():
	self.visible = not GameManager.game_is_running
	video_stream_player.paused = GameManager.game_is_running
