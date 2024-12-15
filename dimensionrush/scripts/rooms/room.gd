class_name Room
extends Node2D

@export var spawn_trigger : Area2D
@export var door_coll_shape: CollisionShape2D
@export var spawn_coll_shape: CollisionShape2D

signal spawn_trigger_entered

@onready var width : float = $TileMapPlatform.get_used_rect().size.x * $TileMapPlatform.rendering_quadrant_size * $TileMapPlatform.scale.x


func _on_spawn_trigger_body_entered(body: Node2D) -> void:
	if body is Player:
		call_deferred("close_door")
		
		spawn_trigger_entered.emit()
	
func close_door():
	door_coll_shape.disabled = false
	spawn_coll_shape.disabled = true


func _on_camera_limit_trigger_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Room entered")
		print(body.is_upper)
		if body.is_upper:
			body.camera.limit_left = door_coll_shape.global_position.x - body.camera.offset.x
		else:
			body.camera.limit_right = door_coll_shape.global_position.x - body.camera.offset.x
