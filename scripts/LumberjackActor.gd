extends RigidBody2D
class_name LumberjackActor

@onready var game_scene = get_node("..")
@onready var Target = get_node("../Truck")
@export var speed = 95

func _physics_process(delta):
	if game_scene.entering:
		visible = false
		pregame_physics_process(delta)
	else:
		visible = true
		game_physics_process(delta)

func game_physics_process(_delta):
	pass
func pregame_physics_process(_delta):
	pass
