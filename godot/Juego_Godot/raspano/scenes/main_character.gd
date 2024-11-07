extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMP_TIME = 0.2  # Tiempo máximo de salto en segundos
@onready var animation_main_char = $AnimatedSprite2D
@onready var game_manager = %Gamemanager

var jump_time = 0.0 #Almacenar el tiempo que lleva en el aire
var is_jumping = false


# Define la posición inicial del personaje con un valor por defecto
var initial_position: Vector2 = Vector2.ZERO

 # Cambia a la posición inicial deseada

func _physics_process(delta: float) -> void:
	initial_position = position
	
	if is_on_floor():
		is_jumping = false  # Reinicia el estado de salto al tocar el suelo
		jump_time = 0.0  # Reinicia el tiempo de salto
		if velocity.x > 1 or velocity.x < -1:
			animation_main_char.animation = "run"
		else:
			animation_main_char.animation = "idle"
	else:
		# Cambia la animación según si sube o baja en el aire
		if velocity.y > 0.0:
			animation_main_char.animation = "jump_down"
		else:
			animation_main_char.animation = "jump_up"
			
	#Manejo del salto
	if Input.is_action_pressed("Jump") and (is_on_floor() or is_jumping):
		if jump_time < MAX_JUMP_TIME:
			velocity.y = JUMP_VELOCITY
			jump_time += delta
			is_jumping = true  # Indica que el personaje está en modo de salto
	elif not Input.is_action_pressed("Jump") and is_jumping:
		is_jumping = false  # Termina el salto cuando se deja de presionar la tecla
			
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Movimiento lateral
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	animation_main_char.flip_h = isLeft

func _on_water_1_body_entered(body: Node2D) -> void:
	if "Main_char" in body.name:
		game_manager.respawn()# Replace with function body.
