extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not $AnimationPlayer.is_playing():
		get_tree().change_scene_to_file("res://Levels/MenuScreen.tscn")
