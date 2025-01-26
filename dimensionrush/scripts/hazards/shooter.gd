class_name Shooter 
extends Node2D

@export var time_between_shots : float = 1.0
@export var speed : float = 100.0

@export var animated_sprite : AnimatedSprite2D
@export var bullet_scene : PackedScene#

var is_preparing : bool = false


func _ready() -> void:
	get_tree().create_timer(time_between_shots).timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	spawn_bullet()
	get_tree().create_timer(time_between_shots).timeout.connect(_on_timer_timeout)

func spawn_bullet():
	animated_sprite.play("prepare")
	is_preparing = true
	
	


func _on_sprite_animation_finished() -> void:
	if is_preparing:
		is_preparing = false
		animated_sprite.play("shoot")
		var bullet = bullet_scene.instantiate()
		bullet.speed = speed
		add_child(bullet)
