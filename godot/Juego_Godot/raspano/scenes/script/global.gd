extends Node

var playerBody: CharacterBody2D
var spawn_point = Vector2(-550,225)
var total_scenes = 0
var total_points = 0
var total_level_point = 0

func update_spawn(new_point):
	spawn_point = new_point
