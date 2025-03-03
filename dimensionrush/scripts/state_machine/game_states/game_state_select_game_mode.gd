class_name GameStateSelectGameMode
extends State

@export var time_button : CustomTextureButton
@export var time_label : CustomLabel
@export var distance_button : CustomTextureButton
@export var distance_label : CustomLabel

@export var main_node : Control
@export var time_node : Control
@export var distance_node : Control

@export var seed_line_edit : LineEdit

func enter():
	resetUI()
	visible = true
	GameManager.game_is_running = false
	
	if GameManager.debug_mode:
		_on_distance_option_3_button_pressed()
	
func exit():
	visible = false


func resetUI():
	time_button.disabled 	 = GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE and GameManager.multiplayer_mode == GameManager.MULTIPLAYER_MODES.CLIENT
	time_label.disabled = time_button.disabled
	distance_button.disabled = GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE and GameManager.multiplayer_mode == GameManager.MULTIPLAYER_MODES.CLIENT
	distance_label.disabled = distance_button.disabled
	seed_line_edit.editable  = not (GameManager.player_mode == GameManager.PLAYER_MODES.MULTIPLAYER_ONLINE and GameManager.multiplayer_mode == GameManager.MULTIPLAYER_MODES.CLIENT)

	seed_line_edit.text = ""

	main_node.visible = true
	time_node.visible = false
	distance_node.visible = false
	
		
@rpc
func select_game_mode_on_time_button_up(time, seed, auto_seed):
	GameManager.game_mode = GameManager.GAME_MODES.TIME
	GameManager.level_time = time
	
	GameManager.game_seed = seed
	GameManager.auto_game_seed = auto_seed
		
	state_transition.emit(self, "InitGame")


	
@rpc
func select_game_mode_on_distance_button_up(distance, seed, auto_seed):
	GameManager.game_mode = GameManager.GAME_MODES.DISTANCE
	GameManager.number_of_regions = distance
	
	GameManager.game_seed = seed
	GameManager.auto_game_seed = auto_seed
	
	state_transition.emit(self, "InitGame")



func select_time(time):
	GameManager.game_mode = GameManager.GAME_MODES.TIME
	GameManager.level_time = time
	
	if(seed_line_edit.text.is_valid_int()):
		GameManager.game_seed = int(seed_line_edit.text)
		GameManager.auto_game_seed = false
	else:
		GameManager.game_seed = randi()
		GameManager.auto_game_seed = true
		
	
	if GameManager.is_server():
		select_game_mode_on_time_button_up.rpc(time, GameManager.game_seed, GameManager.auto_game_seed)
	
	state_transition.emit(self, "InitGame")


func select_distance(distance):
	GameManager.game_mode = GameManager.GAME_MODES.DISTANCE
	GameManager.number_of_regions = distance
	
	if(seed_line_edit.text.is_valid_int()):
		GameManager.game_seed = int(seed_line_edit.text)
		GameManager.auto_game_seed = false
	else:
		GameManager.game_seed = randi()
		GameManager.auto_game_seed = true
	
	if GameManager.is_server():
		select_game_mode_on_distance_button_up.rpc(distance, GameManager.game_seed, GameManager.auto_game_seed)
	
	state_transition.emit(self, "InitGame")


func _on_back_button_pressed() -> void:
	if GameManager.is_online_multiplayer():
		state_transition.emit(self, "MultiplayerOnlineConnection")
	elif GameManager.is_local_multiplayer():
		state_transition.emit(self, "SelectTwoPlayerControls")
	elif GameManager.is_singleplayer():
		state_transition.emit(self, "SelectOnePlayerControls")


func _on_distance_button_pressed() -> void:
	time_node.visible = false
	main_node.visible = false
	distance_node.visible = true


func _on_time_button_pressed() -> void:
	time_node.visible = true
	main_node.visible = false
	distance_node.visible = false


func _on_time_or_distance_button_pressed() -> void:
	main_node.visible = true
	time_node.visible = false
	distance_node.visible = false


func _on_time_option_1_button_pressed() -> void:
	select_time(10)


func _on_time_option_2_button_pressed() -> void:
	select_time(20)


func _on_time_option_3_button_pressed() -> void:
	select_time(30)


func _on_distance_option_1_button_pressed() -> void:
	select_distance(2)


func _on_distance_option_2_button_pressed() -> void:
	select_distance(4)


func _on_distance_option_3_button_pressed() -> void:
	select_distance(8)

func _input(event: InputEvent) -> void:
	if visible:
		if Input.is_action_just_pressed("escape"):
			_on_back_button_pressed()
