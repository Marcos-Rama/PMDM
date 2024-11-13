extends Area2D

@onready var game_manager = %Gamemanager
@onready var sfx_gem: AudioStreamPlayer = $sfx_gem
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Main_char":
		game_manager.add_point()
		animation_player.play("PickUp_gem")
