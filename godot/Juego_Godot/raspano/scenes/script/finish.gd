extends Area2D

@export var target_level : PackedScene
@onready var game_manager = %Gamemanager

func _on_body_entered(body: Node2D) -> void:
	if Global.total_scenes >= 0:
		if (body.name == "Main_char") and game_manager.points >= 3:
			Global.total_points += game_manager.points
			get_tree().change_scene_to_packed(target_level)
			print("total points" +  str(Global.total_points))
			Global.save()
			Global.total_scenes += 1
			if Global.total_scenes == 1:
				game_manager.points = 0
				game_manager.lives = 3
			if Global.total_scenes == 2:
				Global.total_scenes = 0
				game_manager.points = 0
				game_manager.lives = 3

	#elif Global.total_scenes == 1:
		#if (body.name == "Main_char") and game_manager.points >= 6:
			#get_tree().change_scene_to_packed(target_level)
			#Global.total_scenes += 1
		
