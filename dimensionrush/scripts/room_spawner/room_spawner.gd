class_name RoomSpawner
extends Node2D

var room_scenes : Array[PackedScene] = []
var last_room : Room = null
var current_room : Room = null
var next_room : Room = null

var rng = RandomNumberGenerator.new()


func _ready() -> void:
	rng.seed = GameManager.game_seed
	instantiate_rooms()

func _enter_tree() -> void:
	room_scenes = load_scenes_from_folder("res://scenes/rooms/default_rooms/")
	
	

func instantiate_rooms() -> void:
	#add current room
	var current_room_scene = room_scenes[rng.randi() % room_scenes.size()]
	current_room = current_room_scene.instantiate()
	add_child(current_room)
	
	#add last room
	var last_room_scene = room_scenes[rng.randi() % room_scenes.size()]
	last_room = last_room_scene.instantiate()
	last_room.position.x = -current_room.width
	add_child(last_room)
	
	#add next room
	var next_room_scene = room_scenes[rng.randi() % room_scenes.size()]
	next_room = next_room_scene.instantiate()
	next_room.position.x = current_room.width
	add_child(next_room)
	
	


#instanciate room, add child, connect sinals
func spawn_room(room : Room) -> void:
	pass
	


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
