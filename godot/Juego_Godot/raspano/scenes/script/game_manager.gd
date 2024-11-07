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
	if lives >= 0:
		lives_label.text = "Vidas: " + str(lives)
	else:
		respawn()
		
	
func respawn():
		get_tree().reload_current_scene()

	
	 # Implementa una función como parte del respawn.
