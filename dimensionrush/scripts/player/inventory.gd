class_name Inventory
extends Node

var item_type : Item.ITEM_TYPE 
var has_item : bool = false :
	set(value):
		has_item = value
		if has_item == false:
			has_item_no_sync = false
		
		SignalManager.inventory_changed.emit(self.owner.is_upper, has_item)
var has_item_no_sync : bool = false :
	set(value):
		has_item_no_sync = value
		#SignalManager.inventory_changed.emit(self.owner.is_upper, has_item)

func _process(delta: float) -> void:
	print("Is upper: " + str(self.owner.is_upper))
	print("Has item: " + str(has_item))

func add_item(item_type):
	if has_item:
		return false
		
	self.item_type = item_type
	has_item = true

	return true

func _enter_tree() -> void:
	reset()

func reset():
	has_item = false
