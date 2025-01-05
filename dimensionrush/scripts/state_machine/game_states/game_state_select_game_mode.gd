class_name GameStateSelectGameMode
extends State

@export var time_button : Button
@export var distance_button : Button

@export var main_node : Control
@export var time_node : Control
@export var distance_node : Control

@export var seed_line_edit : LineEdit

func enter():
	resetUI()
	visible = true
	GameManager.game_is_running = false
	
	if GameManager.debug_mode:
		_on_distance_option_3_button_up()
	
func exit():
	visible = false


func resetUI():
	time_button.disabled 	 = GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE and GameManager.multiplayer_mode == GameManager.MULTIPLAYER_MODES.CLIENT
	distance_button.disabled = GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE and GameManager.multiplayer_mode == GameManager.MULTIPLAYER_MODES.CLIENT
	seed_line_edit.editable  = not (GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE and GameManager.multiplayer_mode == GameManager.MULTIPLAYER_MODES.CLIENT)

	seed_line_edit.text = ""

	main_node.visible = true
	time_node.visible = false
	distance_node.visible = false
	


func _on_back_button_up():
	if GameManager.is_online_multiplayer():
		state_transition.emit(self, "MultiplayerOnlineConnection")
	elif GameManager.is_local_multiplayer():
		state_transition.emit(self, "SelectTwoPlayerControls")
	elif GameManager.is_singleplayer():
		state_transition.emit(self, "SelectOnePlayerControls")
	


func _on_time_button_up():
	time_node.visible = true
	main_node.visible = false
	distance_node.visible = false
		
@rpc
func select_game_mode_on_time_button_up(time, seed):
	GameManager.game_mode = GameManager.GAME_MODES.TIME
	GameManager.level_time = time
	
	GameManager.game_seed = seed
		
	state_transition.emit(self, "InitGame")


func _on_distance_button_up():
	time_node.visible = false
	main_node.visible = false
	distance_node.visible = true
	

	
@rpc
func select_game_mode_on_distance_button_up(distance, seed):
	GameManager.game_mode = GameManager.GAME_MODES.DISTANCE
	GameManager.number_of_regions = distance
	
	GameManager.game_seed = seed
	
	state_transition.emit(self, "InitGame")


func _on_time_option_1_button_up() -> void:
	select_time(10)


func _on_time_option_2_button_up() -> void:
	select_time(20)


func _on_time_option_3_button_up() -> void:
	select_time(30)

func select_time(time):
	GameManager.game_mode = GameManager.GAME_MODES.TIME
	GameManager.level_time = time
	
	if(seed_line_edit.text.is_valid_int()):
		GameManager.game_seed = int(seed_line_edit.text)
	else:
		GameManager.game_seed = randi()
		
	
	if GameManager.is_server():
		select_game_mode_on_time_button_up.rpc(time, GameManager.game_seed)
	
	state_transition.emit(self, "InitGame")


func _on_time_or_distance_back_button_up() -> void:
	main_node.visible = true
	time_node.visible = false
	distance_node.visible = false


func _on_distance_option_1_button_up() -> void:
	select_distance(2)


func _on_distance_option_2_button_up() -> void:
	select_distance(4)


func _on_distance_option_3_button_up() -> void:
	select_distance(8)

func select_distance(distance):
	GameManager.game_mode = GameManager.GAME_MODES.DISTANCE
	GameManager.number_of_regions = distance
	
	if(seed_line_edit.text.is_valid_int()):
		GameManager.game_seed = int(seed_line_edit.text)
	else:
		GameManager.game_seed = randi()
	
	if GameManager.is_server():
		select_game_mode_on_distance_button_up.rpc(distance, GameManager.game_seed)
	
	state_transition.emit(self, "InitGame")
