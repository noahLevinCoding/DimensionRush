class_name EffectBlind
extends Effect

var effect_time = 5
var remaining_effect_time = effect_time

var color_rect : ColorRect = null
 

func init_effect(player : Node):
	self.player = player
	
	
	color_rect = ColorRect.new()
	color_rect.size = Vector2i(1920, 540)
	color_rect.color = Color(0, 0, 0, 0.5)
	self.player.effect_container.add_child(color_rect)
	color_rect.position = Vector2(-960, -270)
	
	color_rect.material = ShaderMaterial.new()
	color_rect.material.shader = preload( "res://shader/effects/blind.gdshader")
	
	
	
func process_effect(delta : float):
	remaining_effect_time -= delta
	if remaining_effect_time <= 0:
		return true
		
	return false
	
func end_effect():
	if color_rect:
		self.player.effect_container.remove_child(color_rect)
		color_rect.queue_free()
