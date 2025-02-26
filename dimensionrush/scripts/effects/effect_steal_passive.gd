class_name EffectStealPassive
extends Effect

# remove item from inventory if stolen
func init_effect(player : Node):
	self.player = player
	self.player.inventory.reset()
	
func process_effect(delta : float):
	return true
	
func end_effect():
	pass
