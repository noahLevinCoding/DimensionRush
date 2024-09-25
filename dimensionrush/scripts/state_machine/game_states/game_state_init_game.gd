class_name GameStateInitGame
extends State

@export var game_node : Node
@export var upper_subviewport : SubViewport
@export var lower_subviewport : SubViewport
@export var player_scene : PackedScene

@export var start_button : Button

func enter():
	
	spawnPlayer()
	
	GameManager.game_is_running = false
	if GameManager.is_online_multiplayer():
		init_game_on_online_ready.rpc()
	else:
		start_button.disabled = false
		
	visible = true
	
	
func exit():
	resetUI()
	visible = false


@rpc("any_peer")
func init_game_on_online_ready():
	start_button.disabled = false

@rpc("any_peer")
func init_game_on_start_button_up():
	state_transition.emit(self, "Playing")

func _on_start_button_up():
	if GameManager.is_online_multiplayer():
		init_game_on_start_button_up.rpc()
	state_transition.emit(self, "Playing")


func resetUI():
	if GameManager.is_online_multiplayer():
		start_button.disabled = true


func spawnPlayer():
	if GameManager.is_local_multiplayer():
		spawnPlayerLocalMultiplayer()
	elif GameManager.is_online_multiplayer():
		spawnPlayerOnlineMultiplayer()
	elif GameManager.is_singleplayer():
		spawnPlayerSingleplayer()

func spawnPlayerLocalMultiplayer():
	var player_scene_instance_1 = player_scene.instantiate()
	var player_scene_instance_2 = player_scene.instantiate()
	
	upper_subviewport.add_child(player_scene_instance_1)
	lower_subviewport.add_child(player_scene_instance_2)
	
	player_scene_instance_1.player_controls_resource = GameManager.first_player_controls_resource
	player_scene_instance_2.player_controls_resource = GameManager.second_player_controls_resource


	
func spawnPlayerOnlineMultiplayer():
	if GameManager.is_server():
		var player_scene_instance_1 = player_scene.instantiate()
		var player_scene_instance_2 = player_scene.instantiate()
		
		player_scene_instance_1.name = "1"
		player_scene_instance_2.name = str(GameManager.client_peer_id)
		
		upper_subviewport.add_child(player_scene_instance_1)
		lower_subviewport.add_child(player_scene_instance_2)
		
	
func spawnPlayerSingleplayer():
	var player_scene_instance_1 = player_scene.instantiate()
	var player_scene_instance_2 = player_scene.instantiate()
	
	upper_subviewport.add_child(player_scene_instance_1)
	lower_subviewport.add_child(player_scene_instance_2)
	
	player_scene_instance_1.player_controls_resource = GameManager.first_player_controls_resource
	player_scene_instance_2.player_controls_resource = GameManager.second_player_controls_resource
