extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMP_TIME = 0.2  # Tiempo máximo de salto en segundos
@onready var animation_main_char = $AnimatedSprite2D
@onready var game_manager = %Gamemanager
var bodies_in = false

var jump_time = 0.0 #Almacenar el tiempo que lleva en el aire
var is_jumping = false
var dash_count = 0

# Define la posición inicial del personaje con un valor por defecto
var initial_position: Vector2 
func _process(delta):
	# Obtener la posición del ratón relativa a la posición del personaje
	var mouse_position = get_global_mouse_position()
	var direction_to_mouse = mouse_position.x - global_position.x
	if animation_main_char.animation == "idle" or animation_main_char.animation == "attack_anim":
	# Determinar si el personaje debe voltear en función de la posición del ratón
		if direction_to_mouse < 0:
			animation_main_char.flip_h = true  # Volteamos el sprite a la izquierda
		else:
			animation_main_char.flip_h = false  # Volteamos el sprite a la derecha
			
func _ready():
	self.position = Global.spawn_point
 # Cambia a la posición inicial deseada


func _physics_process(delta: float) -> void:
	initial_position = position
	
	if Input.is_action_just_pressed("Dash"):
		dash()
	
	if Input.is_action_pressed("Attack"):
		
		animation_main_char.animation = "attack_anim"
		
	else:
		if is_on_floor():
			dash_count = 0
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
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	var isLeft = velocity.x < 0
	animation_main_char.flip_h = isLeft

func dash():
	if dash_count < 1:
		var mouse_position = get_global_mouse_position()
		var dir = (position - mouse_position).normalized()
		if dir.y < 0:
			dir.y = 0  # Anula la componente vertical hacia arriba
		velocity = dir * SPEED * 5
		dash_count +=1
	

func _on_water_1_body_entered(body: Node2D) -> void:
	if "Main_char" in body.name:
		game_manager.less_life()
		global_position = Global.spawn_point
		#game_manager.respawn()# Replace with function body.
		
func _on_snail_1_body_entered(body: Node2D) -> void:
		game_manager.less_life()
		

func _on_hit_main_body_entered(body: Node2D) -> void:
	if "Snail" in body.name:
		bodies_in = true
		print("Detectado para hit")
	if Input.is_action_pressed("Attack") and bodies_in:
				body.die()

func _on_hit_main_body_exited(body: Node2D) -> void:
	if "Snail" in body.name:
		bodies_in = false
		print("No para hit")
