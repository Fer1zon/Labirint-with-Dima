extends Node
@onready var sfx_bus_index = AudioServer.get_bus_index("SFX")
@onready var music_bus_index = AudioServer.get_bus_index("Music")
var end_game_data : Dictionary = {
	"level_scene" : null,
	"level_number" : null
}

var save_dir = "user://saves"
var save_path = "user://saves/config.cfg"

func _ready() -> void:
	create_save_file()
	load_save_file()

func play_global_sound(load_sound : Resource, audio_bus : String = "SFX"):
	var audio_player:AudioStreamPlayer = AudioStreamPlayer.new()
	audio_player.bus = audio_bus
	audio_player.stream = load_sound
	audio_player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(audio_player)
	
	audio_player.connect("finished", queue_free_node.bind(audio_player))
	audio_player.play()
	
func queue_free_node(node:Node):
	node.queue_free()
	
func create_save_file():
	var config = ConfigFile.new()
	
	if not DirAccess.dir_exists_absolute(save_dir):
		DirAccess.make_dir_absolute(save_dir)
		
	if not FileAccess.file_exists(save_path):
		var file_ = FileAccess.open(save_path, FileAccess.WRITE)
		file_.close()
		
		config.set_value("sound_settings", "SFX", 1.0)
		config.set_value("sound_settings", "Music", 1.0)
		config.save(save_path)
		
		AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(1.0))
		AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(1.0))
		return
		
		
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(config.get_value("sound_settings", "SFX", 1.0)))
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(config.get_value("sound_settings", "Music", 1.0)))
		
	
func load_save_file():
	var config = ConfigFile.new()
	config.load(save_path)
	
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(config.get_value("sound_settings", "SFX", 1.0)))
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(config.get_value("sound_settings", "Music", 1.0)))
		

	
		
	
