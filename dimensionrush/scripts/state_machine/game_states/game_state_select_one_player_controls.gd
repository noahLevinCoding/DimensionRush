class_name GameStateSelectOnePlayerControls
extends State

@export var player_controls_resources : Array[PlayerControlsResource]

@export var keyboard_icon_node : Node2D
@export var controller_icon_node : Node2D
@export var next_button : CustomTextureButton
@export var next_label : CustomLabel

var selected_player_controls_resource : PlayerControlsResource = null

func enter():
	reset()
	visible = true
	GameManager.game_is_running = false
	
func exit():
	visible = false

func _unhandled_input(_event: InputEvent):
	for player_controls_resource in player_controls_resources:
		if is_action_of_player_controls_resource_just_pressed(player_controls_resource):
			selected_player_controls_resource = player_controls_resource
			
			match player_controls_resource.type:
				PlayerControlsResource.INPUT_DEVICE_TYPE.KEYBOARD:
					keyboard_icon_node.visible = true
				PlayerControlsResource.INPUT_DEVICE_TYPE.CONTROLLER:
					controller_icon_node.visible = true
			
			next_button.disabled = false
			next_label.disabled = false
		

func is_action_of_player_controls_resource_just_pressed(player_controls_resource: PlayerControlsResource) -> bool:
	var left_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.left)
	var right_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.right)
	var up_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.up)
	var down_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.down)
	
	return left_just_pressed or right_just_pressed or up_just_pressed or down_just_pressed

func reset():
	keyboard_icon_node.visible = false
	controller_icon_node.visible = false
	
	next_button.disabled = true
	next_label.disabled = true
	selected_player_controls_resource = null


func _on_next_button_pressed():
	if selected_player_controls_resource != null:
		GameManager.first_player_controls_resource = selected_player_controls_resource
	
		if 	 GameManager.player_mode == GameManager.PLAYER_MODES.SINGLEPLAYER:
			state_transition.emit(self, "SelectGameMode")
		elif GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE:
			state_transition.emit(self, "MultiplayerOnlineConnection")


func _on_back_button_pressed() -> void:
	state_transition.emit(self, "SelectPlayerMode")
