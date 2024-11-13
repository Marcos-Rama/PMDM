extends CharacterBody2D

const speed = 40
var dir: Vector2
var player: CharacterBody2D

var is_bat_chase: bool

func _ready():
	is_bat_chase = false
	
func _process(delta):
	move(delta)
	handle_animation()
	

func move(delta):
	if is_bat_chase:
		player = Global.playerBody
		velocity = position.direction_to(player.position) * speed
		dir.x = abs(velocity.x)/velocity.x
	elif !is_bat_chase:
		velocity += dir * speed * delta
	move_and_slide()
	

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5,0.8])
	if !is_bat_chase:
		dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
		print(dir)

func handle_animation():
	var animated_sprite = $AnimatedSprite2D
	animated_sprite.play("fly")
	if dir.x == 1:
		animated_sprite.flip_h = true
	elif dir.x == -1:
		animated_sprite.flip_h = false

func choose(array):
	array.shuffle()
	return array.front()
	

func _on_bee_aggro_body_entered(body: Node2D) -> void:
	if body.name == "Main_char":
		is_bat_chase = true
		
func _on_bee_aggro_body_exited(body: Node2D) -> void:
	if body.name == "Main_char":
		is_bat_chase = false


func die():
	queue_free()
