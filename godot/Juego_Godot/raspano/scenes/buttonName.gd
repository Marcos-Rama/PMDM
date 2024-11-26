extends Button



func _on_pressed() -> void:
	set_player_name()
	print(Global.player_name)
	get_tree().change_scene_to_file("res://scenes/level1.tscn")


func set_player_name():
	var line_edit = %LineEdit

	if line_edit:
		var input_name = line_edit.text.strip_edges()  # Obtener el texto del LineEdit
		if input_name == "":  # Verificamos si el nombre está vacío
			$Layer/Panel/Label.text = "Por favor, introduce un nombre válido."
		else:
			Global.player_name = input_name
	else:
			print("Error: LineEdit no se encuentra en la ruta especificada.")
