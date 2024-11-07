extends Area2D

@onready var game_manager = %Gamemanager

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	game_manager.add_point()
