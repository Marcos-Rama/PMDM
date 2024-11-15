extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		#MusicGame.level_music = preload("res://Assets/Music/Music/Goblins_Den_(Regular).wav")
		#MusicGame.play_menu_music()
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	#MusicGame.play_level_music()
	get_tree().change_scene_to_file("res://scenes/level1.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
