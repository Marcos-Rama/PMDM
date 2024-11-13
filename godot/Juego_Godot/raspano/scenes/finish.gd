extends Area2D

@export var target_level : PackedScene
@onready var transition_fx = preload("res://Assets/Music/Sounds/05_door_open_1.mp3")

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Main_char"):
		#MusicGame.play_FX(transition_fx, -12)
		get_tree().change_scene_to_packed(target_level)
