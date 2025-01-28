class_name GameStateSelectTwoPlayerControls
extends State

@export var player_controls_resources : Array[PlayerControlsResource]

@export var keyboard_icon_node_1 : Node2D
@export var controller_icon_node_1 : Node2D

@export var keyboard_icon_node_2 : Node2D
@export var controller_icon_node_2 : Node2D

@export var next_button : CustomTextureButton
@export var next_label : CustomLabel

var selected_player_controls_resource_1 : PlayerControlsResource = null
var selected_player_controls_resource_2 : PlayerControlsResource = null

var is_first_players_choice : bool = true

func enter():
	reset()
	visible = true
	GameManager.game_is_running = false
	
	if GameManager.debug_mode:
		selected_player_controls_resource_1 = player_controls_resources[2]
		selected_player_controls_resource_2 = player_controls_resources[3]
		_on_next_button_pressed()
		
	
func exit():
	visible = false

func _unhandled_input(_event: InputEvent):
	for player_controls_resource in player_controls_resources:
		if is_action_of_player_controls_resource_just_pressed(player_controls_resource) and not is_player_controls_resource_already_in_use(player_controls_resource):
			if is_first_players_choice:
				selected_player_controls_resource_1 = player_controls_resource
			
				match player_controls_resource.type:
					PlayerControlsResource.INPUT_DEVICE_TYPE.KEYBOARD:
						keyboard_icon_node_1.visible = true
					PlayerControlsResource.INPUT_DEVICE_TYPE.CONTROLLER:
						controller_icon_node_1.visible = true
			
				is_first_players_choice = false
			else:
				selected_player_controls_resource_2 = player_controls_resource
				match player_controls_resource.type:
					PlayerControlsResource.INPUT_DEVICE_TYPE.KEYBOARD:
						keyboard_icon_node_2.visible = true
					PlayerControlsResource.INPUT_DEVICE_TYPE.CONTROLLER:
						controller_icon_node_2.visible = true
			
				next_button.disabled = false
				next_label.disabled = false
				
		
func is_action_of_player_controls_resource_just_pressed(player_controls_resource: PlayerControlsResource) -> bool:
	var left_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.left)
	var right_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.right)
	var up_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.up)
	var down_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.down)
	
	return left_just_pressed or right_just_pressed or up_just_pressed or down_just_pressed

func is_player_controls_resource_already_in_use(player_controls_resource : PlayerControlsResource) -> bool:
	if is_first_players_choice:
		return player_controls_resource == selected_player_controls_resource_2
	else:
		return player_controls_resource == selected_player_controls_resource_1

func reset():

	keyboard_icon_node_1.visible = false
	controller_icon_node_1.visible = false
	keyboard_icon_node_2.visible = false
	controller_icon_node_2.visible = false
	
	next_button.disabled = true
	next_label.disabled = true
	selected_player_controls_resource_1 = null
	selected_player_controls_resource_2 = null
	is_first_players_choice = true


func _on_next_button_pressed():
	if selected_player_controls_resource_1 != null and selected_player_controls_resource_2 != null and selected_player_controls_resource_1 != selected_player_controls_resource_2:
		GameManager.first_player_controls_resource 	= selected_player_controls_resource_1
		GameManager.second_player_controls_resource = selected_player_controls_resource_2
		state_transition.emit(self, "SelectGameMode")


func _on_back_button_pressed() -> void:
	state_transition.emit(self, "SelectPlayerMode")
