class_name CustomTextureButton
extends TextureButton

@export var hover_sound : AudioStreamMP3 = load("res://assets/sfx/button/click-buttons-ui-menu-sounds-effects-button-7-203601.mp3")
@export var click_sound : AudioStreamMP3 = load("res://assets/sfx/button/button_09-190435.mp3")


var audio_stream_player_hover : AudioStreamPlayer = null
var audio_stream_player_click : AudioStreamPlayer = null

var changed_visibility = false

@export var label : CustomLabel

func _ready() -> void:
	visibility_changed.connect(_on_visiblity_changed)
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	pressed.connect(_on_pressed)
	
	audio_stream_player_hover = AudioStreamPlayer.new()
	add_child(audio_stream_player_hover)
	if hover_sound != null:
		audio_stream_player_hover.stream = hover_sound
		audio_stream_player_hover.volume_db = -10
		
	audio_stream_player_click = AudioStreamPlayer.new()
	add_child(audio_stream_player_click)
	if click_sound != null:
		audio_stream_player_click.stream = click_sound
		audio_stream_player_click.volume_db = -20
	
#Prevent playing sounds directly after state change	
func _on_visiblity_changed():
	changed_visibility = true
	await get_tree().create_timer(0.25, true, false, true).timeout
	changed_visibility = false

func _on_mouse_entered() -> void:
	label.hovered = true
	
	if not disabled and not changed_visibility:
		audio_stream_player_hover.play()
		
func _on_pressed() -> void:
	if not disabled:
		audio_stream_player_click.play()

func _on_mouse_exited() -> void:
	label.hovered = false
