extends Node2D

@export var next_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_packed(next_level)
		# Do something when the left mouse button is clicked
