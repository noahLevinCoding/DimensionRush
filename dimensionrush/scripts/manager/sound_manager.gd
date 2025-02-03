extends Node

var sound_resource : SoundResource = null

func _ready() -> void:
	if not ResourceLoader.exists("./res/sound.tres"):
		create_save_dir()
		create_resource()
	else:
		load_resource()
		
	save_resource()
	
func create_save_dir():
	var dir = DirAccess.open("./")
	dir.make_dir_recursive("./res")
		
func load_resource():
	sound_resource = ResourceLoader.load("./res/sound.res")
	
func create_resource():
	sound_resource = SoundResource.new()
	
	sound_resource.master_volume = 10
	sound_resource.music_volume  = 10
	sound_resource.sfx_volume    = 10
	sound_resource.ui_volume     = 10
	
func save_resource():
	ResourceSaver.save(sound_resource, "./res/sound.res")
		
	
