class_name Door
extends Switchable

@export var col_shape : CollisionShape2D

func switch():
	col_shape.disabled = not col_shape.disabled
