class_name EffectInvertControls
extends Effect

var effect_time = 5
var remaining_effect_time = effect_time


func init_effect(player : Node):
	self.player = player
	print("4")
	player.invert_controls = true
	
func process_effect(delta : float):
	player.invert_controls = true
	
	remaining_effect_time -= delta
	if remaining_effect_time <= 0:
		return true
		
	return false
	
func end_effect():
	player.invert_controls = false
