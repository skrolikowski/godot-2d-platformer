class_name MotionState
extends ActorState

#
# [State: Update]
func physics_update(delta: float) -> void:
	var collision_info: KinematicCollision2D = move_and_collide(delta)
	if not collision_info:
		return

	player.collision_info = collision_info

#
# [Internal: Move]
func move_and_collide(delta: float) -> KinematicCollision2D:
	#
	# Locked
	if player.aiming or player.current_state in ["climb","hang"]:
		player.velocity = Vector2.ZERO
	#
	# OnWall (falling)
	elif player.current_state == "wall_slide":
		player.velocity.y += player.gravity * delta * player.wall_friction
	#
	# OnWall (jumping)
	elif player.current_state == "wall_jump":
		player.velocity.y += player.gravity * delta 
	#
	# OnGround (rolling)
	elif player.current_state == "roll":
		player.velocity.x  = player.speed * player.look_direction.x
		player.velocity.y += player.gravity * delta	
	#
	# Default
	else:
		player.velocity.x  = player.speed * player.direction
		player.velocity.y += player.gravity * delta

	# move & correct
	player.velocity.y = player.move_and_slide_with_snap(
		player.velocity,
		Vector2.DOWN * 16,
		Vector2.UP,
		true).y

	if player.get_slide_count() == 0:
		return null

	return player.get_slide_collision(0)
