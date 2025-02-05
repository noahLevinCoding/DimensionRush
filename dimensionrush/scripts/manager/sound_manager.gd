extends Node

var sound_resource : SoundResource = null

func _ready() -> void:
	if not ResourceLoader.exists("./saves/sound.tres"):
		create_save_dir()
		create_resource()
	else:
		load_resource()
	
	init_bus_volume()
	save_resource()
	
	
func create_save_dir():
	var dir = DirAccess.open("./")
	dir.make_dir_recursive("./saves")
		
func load_resource():
	sound_resource = ResourceLoader.load("./saves/sound.tres")
	
func create_resource():
	sound_resource = SoundResource.new()
	
	sound_resource.master_volume = 0.5
	sound_resource.music_volume  = 0.5
	sound_resource.ui_volume     = 0.5
	sound_resource.sfx_volume    = 0.5
	
	
func save_resource():
	sound_resource.master_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	sound_resource.music_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sound_resource.ui_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("UI")))
	sound_resource.sfx_volume = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

	ResourceSaver.save(sound_resource, "./saves/sound.tres")
		
func set_bus_volume_db(bus_index, db):
	AudioServer.set_bus_volume_db(bus_index, db)
	save_resource()
	
func init_bus_volume():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(sound_resource.master_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),  linear_to_db(sound_resource.music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("UI"),     linear_to_db(sound_resource.ui_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),    linear_to_db(sound_resource.sfx_volume))
