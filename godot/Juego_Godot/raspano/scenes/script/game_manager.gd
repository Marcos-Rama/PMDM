extends Node

@onready var points_label = %PointsLabel
@onready var lives_label = %VidasLabel

static var points = 0
static var lives = 3


func add_point():
	points += 1
	Global.total_level_point += 1
	print("Gemas: " + str(points))
	points_label.text = "Gemas: " + str(points)
	
func less_life():
	print(lives)
	lives -= 1
	print("vidas: " + str(lives))
	if lives >= 0:
		lives_label.text = "Vidas: " + str(lives)
	else:
		lives = 3
		points = 0
		points_label.text = "Gemas: " + str (points)
		lives = 3
		lives_label.text = "Vidas: " + str (lives)
		Global.total_level_point = 0
		respawn()
		
func more_life():
	print(lives)
	if lives < 3:
		lives += 1
	print("vidas: " + str(lives))
	lives_label.text = "Vidas: " + str(lives)
	
func respawn():
		get_tree().reload_current_scene()

	
	 # Implementa una función como parte del respawn.
