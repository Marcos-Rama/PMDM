extends Node

const PATH = "user://settings.cfg"
var config = ConfigFile.new()

func _ready():
	
	config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	config.set_value("Video", "borderless", false)
	
	for i in range(3):
		config.set_value("Audio", str(i), 0.0)
	
	load_data()

func save_data():
	config.save(PATH)

func load_data():
	if config.load("user://settings.cfg") != OK:
		save_data()
		return
		
	load_video_settings()

func load_video_settings():
	var screen_type = config.get_value("Video","fullscreen")
	DisplayServer.window_set_mode(screen_type)
 
	var borderless = config.get_value("Video","borderless")
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, borderless)
 
func get_audio_volume(type: String) -> float:
	if type == "master":
		return config.get_value("Audio", "0", 0.5)
	elif type == "music":
		return config.get_value("Audio", "1", 0.5)
	elif type == "sfx":
		return config.get_value("Audio", "2", 0.5)
	return 0.5

func set_audio_volume(type: String, value: float):
	if type == "master":
		config.set_value("Audio", "0", value)
	elif type == "music":
		config.set_value("Audio", "1", value)
	elif type == "sfx":
		config.set_value("Audio", "2", value)
	save_data()
