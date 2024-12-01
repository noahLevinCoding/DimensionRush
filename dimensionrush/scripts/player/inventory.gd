class_name Inventory
extends Node

var item_type : Item.ITEM_TYPE 
var has_item : bool = false :
	set(value):
		has_item = value
		if has_item == false:
			has_item_no_sync = false
		
		SignalManager.inventory_changed.emit(self.owner.is_upper, has_item)
var has_item_no_sync : bool = false 

func add_item(item_type):
	if has_item:
		return false
		
	self.item_type = item_type
	has_item = true

	return true

func use_item():
	if not has_item:
		return
		
	has_item = false
	
	
	match item_type:
		Item.ITEM_TYPE.SPEED_BOOST:
			SignalManager.add_effect.emit(self.owner.is_upper, self.owner.is_upper, item_type)
		Item.ITEM_TYPE.INVERT_CONTROLS:
			SignalManager.add_effect.emit(self.owner.is_upper, not self.owner.is_upper, item_type)
			
			
	

func _enter_tree() -> void:
	reset()

func reset():
	has_item = false
