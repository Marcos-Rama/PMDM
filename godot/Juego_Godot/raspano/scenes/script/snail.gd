extends CharacterBody2D


const SPEED = 50
var dir = -1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var game_manager = %Gamemanager

var motion = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not ray_cast_right.is_colliding():
		if dir != -1:  # Si la dirección cambia, ajusta el flip
			dir = -1
			animated_sprite_2d.flip_h = false
		
	if not ray_cast_left.is_colliding():
		if dir != 1:  # Si la dirección cambia, ajusta el flip
			dir = 1
			animated_sprite_2d.flip_h = true  # Volteado (derecha)
		
	position.x += dir * SPEED * delta
func die():
	queue_free()
func _on_stomp_snail_body_entered(body: Node2D) -> void:
	die() # Replace with function body.
	
	
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Main_char":
		game_manager.less_life()
