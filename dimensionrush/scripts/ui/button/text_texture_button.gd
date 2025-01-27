class_name CustomTextureButton
extends TextureButton

@export var label : CustomLabel

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	label.hovered = true


func _on_mouse_exited() -> void:
	label.hovered = false
