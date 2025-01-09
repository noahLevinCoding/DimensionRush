class_name Shooter 
extends Node2D

@export var time_between_shots : float = 1.0
@export var speed : float = 100.0

@export var raycast : RayCast2D 
@export var bullet_scene : PackedScene

func _ready() -> void:
	get_tree().create_timer(time_between_shots).timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	spawn_bullet()
	get_tree().create_timer(time_between_shots).timeout.connect(_on_timer_timeout)

func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.direction = raycast.target_position.normalized()
	bullet.speed = speed
	add_child(bullet)
