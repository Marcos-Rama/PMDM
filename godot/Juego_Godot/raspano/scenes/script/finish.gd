extends Area2D

@export var target_level : PackedScene
@onready var game_manager = %Gamemanager

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Main_char") and game_manager.points >= 3:
		get_tree().change_scene_to_packed(target_level)
		
