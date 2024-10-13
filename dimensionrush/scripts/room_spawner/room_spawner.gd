class_name RoomSpawner
extends Node2D

var room_scenes : Array[PackedScene] = []
var start_room_scene : PackedScene = preload("res://scenes/rooms/start_room.tscn")
var end_room_scene : PackedScene = preload("res://scenes/rooms/end_room.tscn")
var last_room : Room = null
var current_room : Room = null
var next_room : Room = null

var rng = RandomNumberGenerator.new()

@export var is_upper : bool

func reset() -> void:
	if last_room != null:
		last_room.queue_free()
		last_room = null
	
	if current_room != null:
		current_room.queue_free()
		current_room = null
	
	if next_room != null:
		if next_room.spawn_trigger_entered.is_connected(_on_spawn_trigger_entered):
			next_room.spawn_trigger_entered.disconnect(_on_spawn_trigger_entered)
			
		if next_room.spawn_trigger_entered.is_connected(_on_end_room_entered):
			next_room.spawn_trigger_entered.disconnect(_on_end_room_entered)
			
		next_room.queue_free()
		next_room = null
	
	init()


func init() -> void:
	rng.seed = GameManager.game_seed
	rng.state = 23
	print(is_upper)
	print(rng.seed)
	print(rng.state)
	
	instantiate_rooms()

func _enter_tree() -> void:
	room_scenes = load_scenes_from_folder("res://scenes/rooms/default_rooms/")
	
func _process(_delta: float) -> void:
		pass

func instantiate_rooms() -> void:
	#add start room as current room
	current_room = start_room_scene.instantiate()
	add_child(current_room)
	
	var last_room_index = rng.randi() % room_scenes.size()
	print("last room: " + str(last_room_index))

	
	
	#add last room
	var last_room_scene = room_scenes[last_room_index]
	last_room = last_room_scene.instantiate()
	last_room.position.x = -current_room.width
	add_child(last_room)
	
	#add next room
	var next_room_index = rng.randi() % room_scenes.size()
	print("next room: " + str(next_room_index))

	var next_room_scene = room_scenes[next_room_index]
	next_room = next_room_scene.instantiate()
	next_room.position.x = current_room.width
	add_child(next_room)
	next_room.spawn_trigger_entered.connect(_on_spawn_trigger_entered)
	
	

#instanciate room, add child, connect sinals
func _on_spawn_trigger_entered() -> void:
	despawn_room(last_room)
	last_room = current_room
	current_room = next_room
	if next_room.spawn_trigger_entered.is_connected(_on_spawn_trigger_entered):
		next_room.spawn_trigger_entered.disconnect(_on_spawn_trigger_entered)
	next_room = null
	call_deferred("spawn_room")
	
	
func spawn_room() -> void:
	var next_room_pos_x = current_room.position.x + current_room.width
	if GameManager.game_mode == GameManager.GAME_MODES.DISTANCE and next_room_pos_x > GameManager.level_distance:
		spawn_finish_room(next_room_pos_x)
		return
		
	var next_room_index = rng.randi() % room_scenes.size()
	print("next room: " + str(next_room_index))

	var next_room_scene = room_scenes[next_room_index]
	next_room = next_room_scene.instantiate()
	next_room.position.x = next_room_pos_x
	add_child(next_room)
	next_room.spawn_trigger_entered.connect(_on_spawn_trigger_entered)
	
	
func despawn_room(room : Room) -> void:
	room.queue_free()
	
func spawn_finish_room(position_x: float) -> void:
	next_room = end_room_scene.instantiate()
	next_room.position.x = position_x
	add_child(next_room)
	next_room.spawn_trigger_entered.connect(_on_end_room_entered)
	
func _on_end_room_entered() -> void:
	SignalManager.player_has_reached_end.emit(is_upper)

func load_scenes_from_folder(folder_path: String) -> Array:
	var dir = DirAccess.open(folder_path)
	var scenes : Array[PackedScene] = []

	if dir:
		var files = dir.get_files()  # Get a list of all files in the directory

		for file_name in files:
			# Only process .tscn files
			if file_name.ends_with(".tscn"):
				var scene_path = folder_path + "/" + file_name
				var scene = load(scene_path)
				scenes.append(scene)
			else:
				print("Failed to open directory: " + folder_path)
				
	return scenes
