extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animation_main_char = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	#Animations
	if (velocity.x > 1 || velocity.x < -1):
		animation_main_char.animation = "run"
	else:
		animation_main_char.animation = "idle"
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animation_main_char.animation = "Jump"
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	animation_main_char.flip_h = isLeft
