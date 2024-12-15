extends CanvasLayer

func _ready() -> void:
	SignalManager.changed_game_state.connect(changed_game_state)

func changed_game_state():
	self.visible = GameManager.game_is_running
