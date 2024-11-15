extends TabBar
 
func _ready():
	%Master.value = Persistence.config.get_value("Audio", '0')
	AudioServer.set_bus_volume_db(0,linear_to_db(%Master.value))
 
	%Music.value = Persistence.config.get_value("Audio", '1')
	AudioServer.set_bus_volume_db(1,linear_to_db(%Music.value))
 
	%SFX.value = Persistence.config.get_value("Audio", '2')
	AudioServer.set_bus_volume_db(0,linear_to_db(%SFX.value))
	apply_volume_settings()
 
 
func _on_master_value_changed(value):
	set_volume(0,value)

 
func _on_music_value_changed(value):
	set_volume(1,value)

 
func _on_sfx_value_changed(value):
	set_volume(2,value)


func apply_volume_settings():
	var master_volume = Persistence.get_audio_volume("master") 
	var music_volume = Persistence.get_audio_volume("music") 
	var sfx_volume = Persistence.get_audio_volume("sfx")
	
	AudioServer.set_bus_volume_db(0, linear_to_db(master_volume)) 
	AudioServer.set_bus_volume_db(1, linear_to_db(music_volume)) 
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx_volume)) 
	
	print("Volumen aplicado: Master ", master_volume, "Music ", music_volume, "SFX" , sfx_volume)
	
	
func set_volume(idx,value):
	AudioServer.set_bus_volume_db( idx, linear_to_db(value) )
	Persistence.config.set_value("Audio",str(idx),value)
	Persistence.save_data()
