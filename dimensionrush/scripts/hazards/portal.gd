class_name Portal
extends Node2D


@export var start_node : Node2D
@export var end_node : Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and (not GameManager.is_online_multiplayer() or body.is_multiplayer_authority()):
		body.global_position = end_node.global_position
