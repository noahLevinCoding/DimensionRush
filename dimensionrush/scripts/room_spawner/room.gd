class_name Room
extends Node2D

@export var spawn_trigger : Area2D
@export var door_trigger : Area2D

@onready var width : float = $TileMapPlatform.get_used_rect().size.x * $TileMapPlatform.rendering_quadrant_size * $TileMapPlatform.scale.x


func _on_spawn_trigger_area_entered(area: Area2D) -> void:
	print("Spawn Trigger")



func _on_door_trigger_area_entered(area: Area2D) -> void:
	print("Door Trigger")
