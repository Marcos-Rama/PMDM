extends Area2D
@onready var game_manager = %Gamemanager

func _on_body_entered(body: Node2D) -> void:
	
	print ("You died!")
