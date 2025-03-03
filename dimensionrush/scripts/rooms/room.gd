class_name Room
extends Node2D

@export var spawn_trigger : Area2D
@export var door_sprite : Sprite2D
@export var door_coll_shape: CollisionShape2D
@export var spawn_coll_shape: CollisionShape2D
@export var spawnpoint : Node2D

signal spawn_trigger_entered(player: Player)

@onready var width : float = $TileMapPlatform.get_used_rect().size.x * $TileMapPlatform.rendering_quadrant_size * $TileMapPlatform.scale.x

# Calculate effective width of the tilemap
func calc_width():
	width = $TileMapPlatform.get_used_rect().size.x * $TileMapPlatform.rendering_quadrant_size * $TileMapPlatform.scale.x

# spawn next room
func _on_spawn_trigger_body_entered(body: Node2D) -> void:
	if body is Player:
		call_deferred("close_door")
		
		
		spawn_trigger_entered.emit(body)

# prevent player from returning to previvious room
func close_door():
	door_coll_shape.disabled = false
	spawn_coll_shape.disabled = true
	
	door_sprite.visible = true

func _on_camera_limit_trigger_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.is_upper:
			body.camera.limit_left = door_coll_shape.global_position.x - body.camera.offset.x
		else:
			body.camera.limit_right = door_coll_shape.global_position.x - body.camera.offset.x
