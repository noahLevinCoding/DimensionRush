class_name InventoryUi
extends Control

@export var is_upper : bool
@export var background : ColorRect
@export var foreground : ColorRect

func _ready() -> void:
	SignalManager.inventory_changed.connect(_on_inventory_changed)

func set_item(has_item : bool):
	foreground.visible = has_item
	
func _on_inventory_changed(is_upper : bool, has_item : bool):
	pass
	#print("On inventory changed")
	#print("Is upper: " + str(is_upper))
	#print("Has item: " + str(has_item))
	#if is_upper == self.is_upper:
		#print("Condition true")
		#set_item(has_item)
