class_name EffectSpeedBoost
extends Effect

var max_speed_multiplier = 4.0
var effect_time = 8
var remaining_effect_time = effect_time


func init_effect(player : Node):
	self.player = player
	
	player.max_speed_multiplier = max_speed_multiplier
	player._updateData()
	
func process_effect(delta : float):
	if player.max_speed_multiplier != max_speed_multiplier:
		player.max_speed_multiplier = max_speed_multiplier
		player._updateData()
	
	remaining_effect_time -= delta
	if remaining_effect_time <= 0:
		return true
		
	return false
	
	
func end_effect():
	player.max_speed_multiplier = 1.0
	player._updateData()
