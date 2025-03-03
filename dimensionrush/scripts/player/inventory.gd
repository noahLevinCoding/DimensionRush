class_name Inventory
extends Node

var add_item_audio_stream_player : AudioStreamPlayer
var use_item_audio_stream_player : AudioStreamPlayer

var item_type : Item.ITEM_TYPE = Item.ITEM_TYPE.SPEED_BOOST
var has_item : bool = false :
	set(value):
		has_item = value
		if has_item == false:
			has_item_no_sync = false
		
		SignalManager.inventory_changed.emit(self.owner.is_upper, has_item, item_type)
var has_item_no_sync : bool = false 

# Add an item to the inventory
func add_item(item_type):
	if has_item:
		return false
		
	self.item_type = item_type
	has_item = true
	
	add_item_audio_stream_player.play()

	return true

# Use the item from the inventory
func use_item():
	if not has_item:
		return
		
	has_item = false
	
	use_item_audio_stream_player.play()
	
	# Apply effect based on the item type
	match item_type:
		Item.ITEM_TYPE.SPEED_BOOST:
			SignalManager.add_effect.emit(self.owner.is_upper, self.owner.is_upper, Item.ITEM_TYPE.SPEED_BOOST, false)
		Item.ITEM_TYPE.INVERT_CONTROLS:
			SignalManager.add_effect.emit(self.owner.is_upper, not self.owner.is_upper, Item.ITEM_TYPE.INVERT_CONTROLS, false)
		Item.ITEM_TYPE.STUN:
			SignalManager.add_effect.emit(self.owner.is_upper, not self.owner.is_upper, Item.ITEM_TYPE.STUN, false) 
		Item.ITEM_TYPE.BLIND:
			SignalManager.add_effect.emit(self.owner.is_upper, not self.owner.is_upper, Item.ITEM_TYPE.BLIND, false) 
		Item.ITEM_TYPE.STEAL_ACTIVE:
			SignalManager.add_effect.emit(self.owner.is_upper, self.owner.is_upper, Item.ITEM_TYPE.STEAL_ACTIVE, false)
			SignalManager.add_effect.emit(self.owner.is_upper, not self.owner.is_upper, Item.ITEM_TYPE.STEAL_PASSIVE, false)

			
func _enter_tree() -> void:
	reset()

func reset():
	has_item = false
