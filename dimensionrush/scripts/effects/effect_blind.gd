class_name EffectBlind
extends Effect

var effect_time = 5
var remaining_effect_time = effect_time

var color_rect : ColorRect = null
 

func init_effect(player : Node):
	self.player = player
	
	self.player.camera.position_smoothing_enabled = false;
	
	color_rect = ColorRect.new()
	color_rect.size = Vector2i(1920, 540)
	color_rect.color = Color(0, 0, 0, 0.5)
	self.player.effect_container.add_child(color_rect)
	color_rect.position = Vector2(-960, -220)
	
	
	color_rect.material = ShaderMaterial.new()
	color_rect.material.shader = preload( "res://shader/effects/blind.gdshader")
	
	var player_pos = self.player.global_position
	player_pos.x = 960
	player_pos.y += 10
	
	color_rect.material.set_shader_parameter("player_position", player_pos)
	
	
func process_effect(delta : float):
	
	#var center_pos_x = (color_rect.get_global_rect().position.x - self.player.position.x) / 2
	#var center_pos_y = self.player.position.y + 10
	#
	#color_rect.material.set_shader_parameter("player_position", Vector2(center_pos_x, center_pos_y))
	#
	#
	var player_pos = self.player.global_position
	
	self.player.camera.position_smoothing_enabled = false;
	
	player_pos.x = 960
	player_pos.y += 10
	color_rect.material.set_shader_parameter("player_position", player_pos)
	
	remaining_effect_time -= delta
	if remaining_effect_time <= 0:
		return true
		
	return false
	
func end_effect():
	self.player.camera.position_smoothing_enabled = true;
	
	if color_rect:
		self.player.effect_container.remove_child(color_rect)
		color_rect.queue_free()
