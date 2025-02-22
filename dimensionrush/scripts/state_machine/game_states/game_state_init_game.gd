class_name GameStateInitGame
extends State

@export var game_node : Node
@export var upper_subviewport : SubViewport
@export var lower_subviewport : SubViewport
@export var player_scene : PackedScene

@export var start_button : CustomTextureButton
@export var start_label : CustomLabel

var player_scene_instance_1 : Player = null
var player_scene_instance_2 : Player = null

signal reset_player_authority_done 
signal clear_nodes_done

var reset_player_authority_done_flag := false
var clear_nodes_done_flag := false

func enter():
	GameManager.game_is_running = false
	
	if GameManager.game_mode == GameManager.GAME_MODES.TIME:
		init_game_mode_time()
	elif GameManager.game_mode == GameManager.GAME_MODES.DISTANCE:
		init_game_mode_distance()
	
	
	if GameManager.is_online_multiplayer():
		enter_online()
	else:
		enter_offline()

func init_game_mode_time():
	#set total time
	GameManager.remaining_level_time = GameManager.level_time
	
	
func init_game_mode_distance():
	#set total distance
	pass
		
func enter_offline():
	clearNodes()
	spawnPlayer()
	start_button.disabled = false
	start_label.disabled = false
	visible = true
	
func enter_online():
	resetMultiplayerAuthority()
	reset_player_authority_done_rpc.rpc()
	if !reset_player_authority_done_flag:
		await reset_player_authority_done
	clearNodes()
	clear_nodes_done_rpc.rpc()
	if !clear_nodes_done_flag:
		await clear_nodes_done
	spawnPlayer()
	
	init_game_on_online_ready.rpc()
	visible = true
	
 
func resetMultiplayerAuthority():
	SignalManager.reset_multiplayer_authority.emit()
	
@rpc("any_peer")
func clear_nodes_done_rpc():
	clear_nodes_done_flag = true
	clear_nodes_done.emit()
	
	
@rpc("any_peer")
func reset_player_authority_done_rpc():
	reset_player_authority_done_flag = true
	reset_player_authority_done.emit()
	
func exit():
	resetUI()
	visible = false
	
	reset_player_authority_done_flag = false
	clear_nodes_done_flag = false


@rpc("any_peer")
func init_game_on_online_ready():
	start_button.disabled = false
	start_label.disabled = false

@rpc("any_peer")
func init_game_on_start_button_up():
	state_transition.emit(self, "Playing")


func resetUI():
	if GameManager.is_online_multiplayer():
		start_button.disabled = true
		start_label.disabled = true

@rpc("any_peer")
func clearNodes():
	if GameManager.is_server() or not GameManager.is_online_multiplayer():
		for child in upper_subviewport.get_children():
			if child is Player:
				upper_subviewport.remove_child(child)
				child.queue_free()
				
			
		
		for child in lower_subviewport.get_children():
			if child is Player:
				lower_subviewport.remove_child(child)
				child.queue_free()
				
		
	for child in upper_subviewport.get_children():
		if child is RoomSpawner:
				child.reset()
				
	for child in lower_subviewport.get_children():
		if child is RoomSpawner:
				child.reset()
			
	player_scene_instance_1 = null
	player_scene_instance_2 = null

@rpc("any_peer")
func spawnPlayer():
	if GameManager.is_local_multiplayer():
		spawnPlayerLocalMultiplayer()
	elif GameManager.is_online_multiplayer():
		spawnPlayerOnlineMultiplayer()
	elif GameManager.is_singleplayer():
		spawnPlayerSingleplayer()

func spawnPlayerLocalMultiplayer():
	player_scene_instance_1 = player_scene.instantiate()
	player_scene_instance_1.is_upper = true
	
	player_scene_instance_2 = player_scene.instantiate()
	player_scene_instance_2.is_upper = false
	
	upper_subviewport.add_child(player_scene_instance_1)
	lower_subviewport.add_child(player_scene_instance_2)
	
	player_scene_instance_1.player_controls_resource = GameManager.first_player_controls_resource
	player_scene_instance_2.player_controls_resource = GameManager.second_player_controls_resource

	player_scene_instance_2.PlayerSprite.scale.x = -1
	player_scene_instance_2.camera.offset.x *= -1

	
func spawnPlayerOnlineMultiplayer():
	if GameManager.is_server():
		player_scene_instance_1 = player_scene.instantiate()
		player_scene_instance_1.is_upper = true
	
		player_scene_instance_2 = player_scene.instantiate()
		player_scene_instance_2.is_upper = false
			
		player_scene_instance_1.name = "1"
		player_scene_instance_2.name = str(GameManager.client_peer_id)
		
		player_scene_instance_2.PlayerSprite.scale.x = -1
		player_scene_instance_2.camera.offset.x *= -1

		
		#upper_subviewport.add_child(player_scene_instance_1)
		#lower_subviewport.add_child(player_scene_instance_2)
		
		call_deferred("spawnPlayerOnlineMultiplayerDeferred", upper_subviewport, player_scene_instance_1)
		call_deferred("spawnPlayerOnlineMultiplayerDeferred", lower_subviewport, player_scene_instance_2)

	
func spawnPlayerOnlineMultiplayerDeferred(viewport, player_instance):
	viewport.add_child(player_instance, true)
	
func spawnPlayerSingleplayer():
	player_scene_instance_1 = player_scene.instantiate()
	player_scene_instance_1.is_upper = true
	
	player_scene_instance_2 = player_scene.instantiate()
	player_scene_instance_2.is_upper = false
	
	player_scene_instance_2.PlayerSprite.scale.x = -1
	player_scene_instance_2.camera.offset.x *= -1
	
	upper_subviewport.add_child(player_scene_instance_1)
	lower_subviewport.add_child(player_scene_instance_2)
	
	
	player_scene_instance_1.player_controls_resource = GameManager.first_player_controls_resource
	player_scene_instance_2.player_controls_resource = GameManager.second_player_controls_resource

	


func _on_play_button_pressed() -> void:
	if GameManager.is_online_multiplayer():
		init_game_on_start_button_up.rpc()
	state_transition.emit(self, "Playing")

func _input(event: InputEvent) -> void:
	if visible:
		if Input.is_action_just_pressed("accept"):
			_on_play_button_pressed()
