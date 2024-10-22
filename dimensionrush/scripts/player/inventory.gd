class_name Inventory
extends Node

@export var item_type : Item.ITEM_TYPE 
@export var has_item : bool = false

func add_item(item_type):
	if has_item:
		return false
		
	self.item_type = item_type
	has_item = true

	return true

func reset():
	has_item = false
