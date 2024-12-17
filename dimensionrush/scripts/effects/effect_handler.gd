class_name EffectHandler
extends Node

var effects : Array[Effect]
 
func _enter_tree() -> void:
	SignalManager.add_effect.connect(add_effect)

func add_effect(source_is_upper : bool, destination_is_upper : bool, item_type : Item.ITEM_TYPE, is_synced : bool) -> void:
	if destination_is_upper != self.owner.is_upper:
		if GameManager.is_online_multiplayer() and not is_synced:
			add_effect_rpc.rpc(source_is_upper, destination_is_upper, item_type)
			
		return
		
	var effect = null
		
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
			
	if effect != null:
		effects.append(effect)
		effect.init_effect(self.owner)
		
		
@rpc("any_peer")
func add_effect_rpc(source_is_upper : bool, destination_is_upper : bool, item_type : Item.ITEM_TYPE):	
	SignalManager.add_effect.emit(source_is_upper, destination_is_upper, item_type, true)

func process(delta: float) -> void:
	for effect in effects:
		var remove_effect = effect.process_effect(delta)
		if remove_effect:
			effect.end_effect()
			effects.erase(effect)
