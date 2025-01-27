class_name CustomLabel
extends Label

var hovered : bool = false :
	set(value):
		hovered = value
		
		set_theme_overrides()

var disabled : bool = false : 
	set(value):
		disabled = value
		
		set_theme_overrides()
		
func set_theme_overrides():
	if disabled:
		add_theme_color_override("font_color", Color(0,0,0,0.5))
		add_theme_constant_override("outline_size", 0)
	else:
		add_theme_color_override("font_color", Color(0,0,0,1))
		
		if hovered:
			add_theme_constant_override("outline_size", 3)
		else:
			add_theme_constant_override("outline_size", 0)
