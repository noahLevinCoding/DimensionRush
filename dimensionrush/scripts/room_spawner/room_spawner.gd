class_name RoomSpawner
extends Node2D

var rooms = null

func _ready() -> void:
	pass

func _enter_tree() -> void:
	rooms = load_scenes_from_folder("res://scenes/rooms/default_rooms/")


#instanciate room, add child, connect sinals
func spawn_room(room : Room) -> void:
	pass
	


func load_scenes_from_folder(folder_path: String) -> Array:
	var dir = DirAccess.open(folder_path)
	var scenes = []

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
