class_name RoomSpawner
extends Node2D

@export var is_upper : bool

@export var start_room : PackedScene 
@export var end_room 	 : PackedScene 
@export var regions : Array[RegionResource] 

var already_spawned_regions_size = 3
var already_spawned_regions : Array[RegionResource] = []

var already_spawned_rooms_size = 3
var already_spawned_rooms : Array[PackedScene] = []

var regions_per_game : int = 0
var region_per_game : int = 0

var rooms_per_region_max : int = 2
var rooms_per_region_min : int = 6
var rooms_per_region : int = 0
var room_per_region : int = 0

var region_index : int = -1

var last_room : Room = null
var current_room : Room = null
var next_room : Room = null

var rng 		= RandomNumberGenerator.new()




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
	rng = RandomNumberGenerator.new()
	rng.seed = GameManager.game_seed
	
	regions_per_game = GameManager.level_distance
	already_spawned_regions = []
	
	if already_spawned_regions_size >= regions.size():
		already_spawned_regions_size = regions.size() - 1
	
	if GameManager.game_mode == GameManager.GAME_MODES.DISTANCE:
		calc_game_distance()
	
	instantiate_rooms()

func calc_game_distance():
	var rng_predict = RandomNumberGenerator.new()
	rng_predict.seed = GameManager.game_seed
	
	var already_spawned_regions_predict = [] 
	var current_room_predict : Node2D = start_room.instantiate()
	current_room_predict.calc_width()
	current_room_predict.position.x = -960
	#add_child(current_room_predict)
	
	var region_index_predict = rng_predict.randi() % regions.size()
	print("Region index: ")
	print(region_index_predict)
	
	while regions[region_index_predict] in already_spawned_regions_predict:
		region_index_predict = (region_index_predict + 1) % regions.size()
		print("Region index: ")
		print(region_index_predict)
		
	already_spawned_regions_predict.push_back(regions[region_index_predict])
	if already_spawned_regions_predict.size() > already_spawned_regions_size:
		already_spawned_regions_predict.pop_front()
		print("Pop front")
	
	var already_spawned_rooms_size_predict = regions[region_index_predict].rooms.size() / 2 
	var already_spawned_rooms_predict = []
	
	var rooms_per_region_predict = rng_predict.randi_range(rooms_per_region_min, rooms_per_region_max)
	print("Rooms per region predict")
	print(rooms_per_region_predict)
	var room_per_region_predict = 1
	var region_per_game_predict = 1
	
	var next_room_scene_predict = regions[region_index_predict].start_room
	var next_room_predict = next_room_scene_predict.instantiate()
	next_room_predict.calc_width()
	next_room_predict.position.x = current_room_predict.width + current_room_predict.position.x
	
	var distance = next_room_predict.position.x + next_room_predict.width
	print(distance)
	

func instantiate_rooms() -> void:
	
	#add start room as current room
	current_room = start_room.instantiate()
	current_room.position.x = -960
	add_child(current_room)
	
	region_index = rng.randi() % regions.size()
	while regions[region_index] in already_spawned_regions:
		region_index = (region_index + 1) % regions.size()
		
	already_spawned_regions.push_back(regions[region_index])
	if already_spawned_regions.size() > already_spawned_regions_size:
		already_spawned_regions.pop_front()
	
	#TODO
	already_spawned_rooms_size = regions[region_index].rooms.size() / 2 
	already_spawned_rooms = []
	
	rooms_per_region = rng.randi_range(rooms_per_region_min, rooms_per_region_max)
	room_per_region = 1
	region_per_game = 1
	
	var next_room_scene = regions[region_index].start_room
	next_room = next_room_scene.instantiate()
	next_room.position.x = current_room.width + current_room.position.x
	add_child(next_room)
	next_room.spawn_trigger_entered.connect(_on_spawn_trigger_entered)
	
	

#instanciate room, add child, connect sinals
func _on_spawn_trigger_entered(player: Player) -> void:
	despawn_room(last_room)
	last_room = current_room
	current_room = next_room
	
	player.player_movement_resource = regions[region_index].player_movement_resource
	
	if next_room.spawn_trigger_entered.is_connected(_on_spawn_trigger_entered):
		next_room.spawn_trigger_entered.disconnect(_on_spawn_trigger_entered)
	next_room = null
	call_deferred("spawn_room")
	

func spawn_room_in_region():
	var next_room_index = rng.randi() % regions[region_index].rooms.size()
	while regions[region_index].rooms[next_room_index] in already_spawned_rooms:
		next_room_index = (next_room_index + 1) % regions[region_index].rooms.size()
		
	var next_room_scene = regions[region_index].rooms[next_room_index]	
	
	already_spawned_rooms.push_back(next_room_scene)
	if already_spawned_rooms.size() > already_spawned_rooms_size:
		already_spawned_rooms.pop_front()
	
	next_room = next_room_scene.instantiate()
	next_room.position.x = current_room.width + current_room.position.x
	add_child(next_room)
	next_room.spawn_trigger_entered.connect(_on_spawn_trigger_entered)

func spawn_end_room_in_region():
	var next_room_scene = regions[region_index].end_room
	
	next_room = next_room_scene.instantiate()
	next_room.position.x = current_room.width + current_room.position.x
	add_child(next_room)
	next_room.spawn_trigger_entered.connect(_on_spawn_trigger_entered)
		
func spawn_start_room_in_new_region():
	region_index = rng.randi() % regions.size()
	while regions[region_index] in already_spawned_regions:
		region_index = (region_index + 1) % regions.size()
		
	already_spawned_regions.push_back(regions[region_index])
	if already_spawned_regions.size() > already_spawned_regions_size:
		already_spawned_regions.pop_front()
		
	#TODO
	already_spawned_rooms_size = regions[region_index].rooms.size() / 2  
	already_spawned_rooms = []
			
	rooms_per_region = rng.randi_range(rooms_per_region_min, rooms_per_region_max)
	
	region_per_game += 1
	if region_per_game > regions_per_game:
		spawn_end_room()
		return
	
	
	room_per_region = 1
	var next_room_scene = regions[region_index].start_room
	
	next_room = next_room_scene.instantiate()
	next_room.position.x = current_room.width + current_room.position.x
	add_child(next_room)
	next_room.spawn_trigger_entered.connect(_on_spawn_trigger_entered)
	
func spawn_room() -> void:
	
	room_per_region += 1
	
	if room_per_region < rooms_per_region:
		spawn_room_in_region()
	elif room_per_region == rooms_per_region:
		spawn_end_room_in_region()
	else:
		spawn_start_room_in_new_region()
	
	
	
func despawn_room(room : Room) -> void:
	if room != null:
		room.queue_free()
	
func spawn_end_room() -> void:
	next_room = end_room.instantiate()
	next_room.position.x = current_room.width + current_room.position.x
	add_child(next_room)
	next_room.spawn_trigger_entered.connect(_on_end_room_entered)
	
func _on_end_room_entered() -> void:
	SignalManager.player_has_reached_end.emit(is_upper)

	
