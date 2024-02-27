extends Node2D

var entering = true
var tree_count = 0
var pine_count = 0
var paddle_count = 1
var bounce_count = 1
var truck_count = 1

@export var next_level: PackedScene

func _process(_delta):
	if truck_count <= 0:
		# Game Over
		if pine_count:
			# Winner
			get_tree().change_scene_to_packed(next_level)
		else:
			# Sad exit
			get_tree().reload_current_scene()
