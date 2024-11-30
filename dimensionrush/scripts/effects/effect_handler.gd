class_name EffectHandler
extends Node

var effects : Array[Effect]
 
func _enter_tree() -> void:
	SignalManager.add_effect.connect(add_effect)

func add_effect(source_is_upper : bool, destination_is_upper : bool, item_type : Item.ITEM_TYPE) -> void:
	if destination_is_upper != self.owner.is_upper:
		return
		
	var effect = null
		
	match item_type:
		Item.ITEM_TYPE.SPEED_BOOST:
			effect = EffectSpeedBoost.new()
		Item.ITEM_TYPE.STUN:
			pass
			#effect = EffectStun()
		Item.ITEM_TYPE.BLIND:
			pass
			#effect = EffectBlind()
			
			
			
	if effect != null:
		effects.append(effect)
		effect.init_effect(self.owner)

func _process(delta: float) -> void:
	for effect in effects:
		var remove_effect = effect.process_effect(delta)
		if remove_effect:
			effect.end_effect()
			effects.erase(effect)
