extends Area2D

@onready var game_manager = %Gamemanager
@onready var sfk_heal: AudioStreamPlayer = $sfk_heal
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	pass 
	
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Main_char" and game_manager.lives < 3:
		game_manager.more_life()
		animation_player.play("PickUp_heart")
