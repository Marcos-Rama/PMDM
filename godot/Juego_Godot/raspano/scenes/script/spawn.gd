extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Main_char":
		Global.update_spawn(self.global_position)
