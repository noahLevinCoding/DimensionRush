class_name GameStateSelectOnePlayerControls
extends State

@export var player_controls_resources : Array[PlayerControlsResource]

@export var player_controls_resource_id_label : Label
@export var next_button : Button

var selected_player_controls_resource : PlayerControlsResource = null

func enter():
	reset()
	visible = true
	
func exit():
	visible = false

func _unhandled_input(event: InputEvent):
	for player_controls_resource in player_controls_resources:
		if is_action_of_player_controls_resource_just_pressed(player_controls_resource):
			selected_player_controls_resource = player_controls_resource
			player_controls_resource_id_label.text = str(player_controls_resource.id)
			next_button.disabled = false
		

func is_action_of_player_controls_resource_just_pressed(player_controls_resource: PlayerControlsResource) -> bool:
	var left_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.left)
	var right_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.right)
	var up_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.up)
	var down_just_pressed 	= Input.is_action_just_pressed(player_controls_resource.down)
	
	return left_just_pressed or right_just_pressed or up_just_pressed or down_just_pressed

func reset():
	player_controls_resource_id_label.text = "0"
	next_button.disabled = true
	selected_player_controls_resource = null


func _on_next_button_pressed():
	if selected_player_controls_resource != null:
		GameManager.first_player_controls_resource = selected_player_controls_resource
	
		if 	 GameManager.player_mode == GameManager.PLAYER_MODES.SINGLEPLAYER:
			state_transition.emit(self, "Titlescreen")
		elif GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE:
			state_transition.emit(self, "MultiplayerOnlineConnection")


func _on_back_button_up():
	state_transition.emit(self, "PlayerMode")
