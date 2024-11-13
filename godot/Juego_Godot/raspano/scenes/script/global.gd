extends Node

var playerBody: CharacterBody2D
var spawn_point = Vector2(-550,225)
var total_scenes = 0

func update_spawn(new_point):
	spawn_point = new_point
