class_name EffectHandler
extends Node

var effects : Array[Effect]

# Connect the signal to add effects when the tree is entered
func _enter_tree() -> void:
	SignalManager.add_effect.connect(add_effect)

# Add a new effect based on the item type
func add_effect(source_is_upper : bool, destination_is_upper : bool, item_type : Item.ITEM_TYPE, is_synced : bool) -> void:
	if destination_is_upper != self.owner.is_upper:
		if GameManager.is_online_multiplayer() and not is_synced:
			add_effect_rpc.rpc(source_is_upper, destination_is_upper, item_type)
			
		return
		
	var effect = null
	
	# Match the item type to create the corresponding effect
	match item_type:
		Item.ITEM_TYPE.SPEED_BOOST:
			effect = EffectSpeedBoost.new()
		Item.ITEM_TYPE.STUN:
			effect = EffectStun.new()
		Item.ITEM_TYPE.BLIND:
			effect = EffectBlind.new()
		Item.ITEM_TYPE.INVERT_CONTROLS:
			effect =  EffectInvertControls.new()
		Item.ITEM_TYPE.STEAL_ACTIVE:
			effect = EffectStealActive.new()
		Item.ITEM_TYPE.STEAL_PASSIVE:
			effect = EffectStealPassive.new()
			
	# Initialize and add the effect	
	if effect != null:
		effects.append(effect)
		effect.init_effect(self.owner)
		
# RPC to synchronize adding an effect
@rpc("any_peer")
func add_effect_rpc(source_is_upper : bool, destination_is_upper : bool, item_type : Item.ITEM_TYPE):	
	SignalManager.add_effect.emit(source_is_upper, destination_is_upper, item_type, true)

# Process all active effects over time
func process(delta: float) -> void:
	for effect in effects:
		var remove_effect = effect.process_effect(delta)
		if remove_effect:
			effect.end_effect()
			effects.erase(effect)
