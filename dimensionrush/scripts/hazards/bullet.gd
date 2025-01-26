class_name Bullet
extends Node2D

var speed : float = 100.0

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT * delta * speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if not GameManager.is_online_multiplayer() or body.is_multiplayer_authority():
			SignalManager.player_died.emit(body)
	else:
		queue_free()
