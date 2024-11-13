extends CharacterBody2D


const SPEED = 50
const SPEED_AGGRO = 300
var dir = -1
var player: CharacterBody2D
var colli: bool
var is_pig_chase: bool


@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var game_manager = %Gamemanager

var motion = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colli = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !is_pig_chase:
		if not ray_cast_right.is_colliding():
			if dir != -1:  # Si la dirección cambia, ajusta el flip
				dir = -1
				animated_sprite_2d.flip_h = false
			
		if not ray_cast_left.is_colliding():
			if dir != 1:  # Si la dirección cambia, ajusta el flip
				dir = 1
				animated_sprite_2d.flip_h = true  # Volteado (derecha)
		position.x += dir * SPEED * delta 
	else:
		player = Global.playerBody  
		var direction_to_player = position.direction_to(player.position)
		dir = sign(direction_to_player.x)
		animated_sprite_2d.flip_h = dir == 1
		position.x += dir * SPEED_AGGRO * delta 
	move_and_slide()
func die():
	queue_free()
	

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Main_char":
		print("Te pego")
		game_manager.less_life()
func _on_aggro_body_entered(body: Node2D) -> void:
	if body.name == "Main_char":
		is_pig_chase = true
		
func _on_aggro_body_exited(body: Node2D) -> void:
	if body.name == "Main_char":
		is_pig_chase = false
