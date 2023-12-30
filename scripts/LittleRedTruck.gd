extends Sprite2D

var loaded = false
var driving = Vector2.ZERO

@onready var game_scene = get_node("..")
@onready var pinned_position = position.x
@export var enter_speed = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = -50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_scene.entering:
		if pinned_position >= position.x:
			if not $AnimationPlayer.is_playing():
				$AnimationPlayer.play("Entering")
			position.x += enter_speed * _delta
		else:
			$AnimationPlayer.play("IdleEmptyDriver")
			game_scene.entering = false
	else:
		game_process()
	
func game_process():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("IdleEmpty")
	if driving:
		position.x += driving.x
		if get_viewport_rect().size.x < position.x - 48:
			game_scene.truck_count = 0
			queue_free()
	else:
		if game_scene.pine_count:
			if game_scene.bounce_count == 0:
				$AnimationPlayer.play("IdleFullDriver")
			elif game_scene.paddle_count == 0:
				$AnimationPlayer.play("IdleEmptyDriver")
		else:
			if game_scene.bounce_count == 0:
				$AnimationPlayer.play("IdleEmptyDriver")
			elif game_scene.paddle_count == 0:
				$AnimationPlayer.play("IdleEmptyDriver")
				
		if game_scene.bounce_count == 0 and game_scene.paddle_count == 0:
			driving = Vector2(1, 0)
			if game_scene.pine_count:
				$AnimationPlayer.play("DrivingFull")
			else:
				$AnimationPlayer.play("DrivingEmpty")
