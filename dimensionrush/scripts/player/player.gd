#class_name Player
extends CharacterBody2D

@export var player_controls_resource : PlayerControlsResource

func _enter_tree():
	player_controls_resource = GameManager.first_player_controls_resource
	set_multiplayer_authority(name.to_int())
	SignalManager.reset_multiplayer_authority.connect(reset_multiplayer_authority)

func _physics_process(delta):
	if not GameManager.game_is_running:
		return
	
	if player_controls_resource == null:
		return 
		
		
	if not GameManager.is_online_multiplayer() or is_multiplayer_authority():
		velocity = Input.get_vector(player_controls_resource.left, player_controls_resource.right, player_controls_resource.up, player_controls_resource.down) * 400
		move_and_slide()
	
		
func reset_multiplayer_authority():
	set_multiplayer_authority(1);
