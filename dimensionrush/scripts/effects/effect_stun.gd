class_name EffectStun
extends Effect

var effect_time = 5
var remaining_effect_time = effect_time

func init_effect(player : Node):
	self.player = player
	player.is_stunned = true
	
func process_effect(delta : float):
	player.is_stunned = true
	
	remaining_effect_time -= delta
	if remaining_effect_time <= 0:
		return true
		
	return false
	
func end_effect():
	player.is_stunned = false
