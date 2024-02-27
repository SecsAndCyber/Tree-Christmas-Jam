extends LumberjackActor

var velocity = Vector2.UP * speed

func pregame_physics_process(_delta):
	visible = true

func game_physics_process(delta):
	if "Chopping" in $AnimationPlayer.current_animation:
		if $AnimationPlayer.is_playing ( ):
			return
		
	if position.distance_squared_to(Target.position) < 2:
		game_scene.bounce_count = 0
		queue_free()
		
	if game_scene.pine_count:
		$AnimationPlayer.play("Dragging-Down")
		# Go to truck
		set_collision_mask_value(1,false)
		if position.distance_squared_to(Target.position) > 2:
			velocity = position.direction_to(Target.position) * 50
			move_and_collide(velocity * delta)
	else:
		# Play Game
		var collision = move_and_collide(velocity * delta)
		
		# Check collision with window boundaries
		if collision:
			if "Paddle" == collision.get_collider().name and velocity.y < 0:
				print("Ignore bouncing off the bottom")
			else:
				print("Bouncing off " + collision.get_collider().name)
				var collision_direction = collision.get_normal()
				# Reflect the velocity using the collision information
				velocity = velocity.bounce(collision_direction)

				if velocity.y > 0:
					if "TreeBody" == collision.get_collider().name: # going down
						velocity = speed * position.direction_to(Target.position)

				elif velocity.y > -20:
					# Sharp left and rights with no vertical change is boring
					velocity.y = -20

				if "TreeBody" == collision.get_collider().name:
					$AnimationPlayer.play("Chopping-Up")
					return
				
		if velocity.y > 0:
			# Normal, going down
			$AnimationPlayer.play("Walking-Down")
		if velocity.y < 0:
			# Green, going up
			$AnimationPlayer.play("Walking-Up")
