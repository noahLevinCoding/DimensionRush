class_name Laser
extends Node2D


@export var width : int = 10

@export var has_timer : bool = false
@export var off_time  : float = 2.0
@export var on_time   : float = 2.0

var is_on : bool = true :
	set(value):
		is_on = value
		collision_polygon.visible = is_on #TODO: remove
		collision_polygon.disabled = not is_on
		
@export var has_start_path : bool = false
@export var has_end_path   : bool = false
@export var start_path_velocity : float = 10.0
@export var end_path_velocity : float = 10.0


@export var start_node 	  	  : PathFollow2D
@export var end_node 		  : PathFollow2D
@export var collision_polygon : CollisionPolygon2D

func _ready() -> void:
	create_collision_polygon()
	
	if has_timer:
		get_tree().create_timer(on_time).timeout.connect(_on_timer_timeout)

# Create the collision polygon based on the start and end nodes
func create_collision_polygon():
	var start_position = start_node.global_position
	var end_position   = end_node.global_position
	
	var direction = (end_position - start_position).normalized()
	var perpendicular = direction.orthogonal() * (width / 2)
	
	var points = [
		start_position + perpendicular,
		start_position - perpendicular,
		end_position   - perpendicular,
		end_position   + perpendicular
	]
	
	var local_points = points.map(func(p): return collision_polygon.to_local(p))
	collision_polygon.polygon = local_points

# Handle when a body enters the laser area
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and (not GameManager.is_online_multiplayer() or body.is_multiplayer_authority()):
		SignalManager.player_died.emit(body)

# Toggle the laser state after the timer times out
func _on_timer_timeout():
	is_on = not is_on

	if is_on:
		get_tree().create_timer(on_time).timeout.connect(_on_timer_timeout)
	else:
		get_tree().create_timer(off_time).timeout.connect(_on_timer_timeout)

# Move the start and end path nodes, and update the collision polygon
func _physics_process(delta: float) -> void:
	if has_start_path:
		start_node.progress += start_path_velocity * delta
		if is_equal_approx(start_node.progress_ratio, 1.0) or is_zero_approx(start_node.progress_ratio):
			start_path_velocity *= -1
			
	if has_end_path:
		end_node.progress += end_path_velocity * delta
		if is_equal_approx(end_node.progress_ratio, 1.0) or is_zero_approx(end_node.progress_ratio):
			end_path_velocity *= -1
			
	if has_start_path or has_end_path:
		create_collision_polygon()
		
