extends Node2D

@export var content_node : Control

var owner_state : State

var settings_audio_scene 	  = preload("res://scenes/settings/settings_audio.tscn")
var settings_controls_scene   = preload("res://scenes/settings/settings_controls.tscn")
var settings_dimensions_scene = preload("res://scenes/settings/settings_dimensions.tscn")
var settings_items_scene 	  = preload("res://scenes/settings/settings_items.tscn")
var settings_credits_scene 	  = preload("res://scenes/settings/settings_credits.tscn")

func _ready() -> void:
	_on_audio_button_pressed()
	owner_state.visible = false

func _on_back_pressed() -> void:
	owner_state.visible = true
	queue_free()

func clear_content() -> void:
	for child in content_node.get_children():
		child.queue_free()

func _on_audio_button_pressed() -> void:
	clear_content()
	content_node.add_child(settings_audio_scene.instantiate())


func _on_controls_button_pressed() -> void:
	clear_content()
	content_node.add_child(settings_controls_scene.instantiate())


func _on_dimensions_button_pressed() -> void:
	clear_content()
	content_node.add_child(settings_dimensions_scene.instantiate())


func _on_items_button_pressed() -> void:
	clear_content()
	content_node.add_child(settings_items_scene.instantiate())


func _on_credits_button_pressed() -> void:
	clear_content()
	content_node.add_child(settings_credits_scene.instantiate())

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		_on_back_pressed()
