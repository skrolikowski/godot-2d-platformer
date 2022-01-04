extends MotionState

#
# [State: Enter]
func enter(data := {}) -> void:
	player.speed = data.get("speed", player.air_speed)

	player.animatedSprite.play("Fall")

#
# [State: Update]
func physics_update(delta: float) -> void:
	player.test_walls_and_ledge()

	.physics_update(delta)

#
# [State: Transition]
func check_state() -> void:
	#
	# OnGround
	if player.is_on_floor():	
		emit_signal("transition_to", "land")
	#
	# OnWall (forced)
	elif player.is_on_wall() and player.direction != 0:
		#
		# Ledge Grab
		if player.can_grab_ledge:
			emit_signal("transition_to", "hang", { direction = player.direction })
		#
		# Wall Slide
		elif player.can_wall_slide:
			emit_signal("transition_to", "wall_slide")

#
# [State: Input]
func handle_input(event):
	#
	# Jump
	if event.is_action_pressed("jump"):
		#
		# Double Jump
		if player.previous_state in ["jump", "fall"] and player.jump_count < player.jump_max_count:
			emit_signal("transition_to", "jump", { factor = 0.85 })
		#
		# Falling Jump
		elif player.previous_state == "move" and player.time_off_ground < player.jump_buffer:
			emit_signal("transition_to", "jump")
