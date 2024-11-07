extends Node

@onready var points_label = %PointsLabel
@onready var lives_label = %VidasLabel

static var points = 0
static var lives = 3

func add_point():
	points += 1
	print(points)
	points_label.text = "Points: " + str(points)
	
func less_life():
	print(lives)
	lives -= 1
	print(lives)
	if lives <= 0:
		print("Game Over!")
	lives_label.text = "Vidas: " + str(lives)
		
	
func respawn():
	less_life()
	 # Guardar el estado actual del jugador en el GameManager si se requiere más información.
	if lives > 0:
		get_tree().reload_current_scene()


	
	 # Implementa una función como parte del respawn.
