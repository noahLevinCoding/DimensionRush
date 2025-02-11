extends Control

var options_scene = preload("res://scenes/settings/settings.tscn")
var options_scene_instance = null

func _on_options_button_pressed() -> void:
	options_scene_instance = options_scene.instantiate()
	options_scene_instance.owner_state = owner
	owner.get_parent().add_child(options_scene_instance)
	options_scene_instance.global_position = Vector2.ZERO
	
	
	
	
