extends HBoxContainer

@export var game_seed_label : Label

func _ready() -> void:
	SignalManager.changed_game_seed.connect(_on_changed_game_seed)

func _on_changed_game_seed():
	game_seed_label.text = str(GameManager.game_seed)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		DisplayServer.clipboard_set(str(GameManager.game_seed))
