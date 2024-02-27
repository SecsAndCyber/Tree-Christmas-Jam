extends LumberjackActor

@onready var Bounce = get_node("../Bounce")
var velocity = 0
@onready var pinned_position = position.y

func pregame_physics_process(_delta):
	position.x = Bounce.position.x - min(Bounce.position.x/2, 25)
	position.y = Bounce.position.y
	pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func game_physics_process(delta):
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Blocking-Idle")
	if game_scene.pine_count or game_scene.bounce_count == 0:
		$AnimationPlayer.play("Walking-To-Truck")
		# Go to truck
		set_collision_mask_value(1,0)
		if position.distance_squared_to(Target.position) > 2:
			velocity = position.direction_to(Target.position) * 50
			move_and_collide(velocity * delta)
		else:
			game_scene.paddle_count = 0
			queue_free()
	else:
		var mouse_pos = get_global_mouse_position()
		
		# Check collision with window boundaries
		if mouse_pos.x < 0 or mouse_pos.x > get_viewport_rect().size.x:
			return # don't try moving off of the screen
		
		mouse_pos.y = pinned_position
		
		if position.y - pinned_position > 2:
			velocity = position.direction_to(mouse_pos) * speed
		else:
			velocity = position.direction_to(mouse_pos) * position.distance_squared_to(mouse_pos)
		if position.distance_squared_to(mouse_pos) > 2:
			$AnimationPlayer.play("Blocking-Walk")
		move_and_collide(velocity * delta)
