class_name EffectStealActive
extends Effect

var done := false

func init_effect(player : Node):
	self.player = player
	SignalManager.ping_other_player_response.connect(ping_other_player_response)
	SignalManager.ping_other_player.emit(player)
	
func ping_other_player_response(other_player: Player):
	
	if self.player != null:
		if other_player.inventory.has_item:
			self.player.inventory.add_item(other_player.inventory.item_type)
		
	done = true
	
func process_effect(delta : float):
	return done
	
func end_effect():
	pass
