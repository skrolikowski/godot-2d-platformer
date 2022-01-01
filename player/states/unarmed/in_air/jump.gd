extends MotionState

#
# [State: Enter]
func enter(data := {}) -> void:
	var axis: Vector2 = data.get('axis', Vector2.UP)
	var factor: float = 1.0

	player.speed       = player.air_speed
	player.jump_count += 1
	player.velocity    = axis * player.jump_impulse * factor

	if player.jump_count == 1:
		sprite.play("Jump")
	else:
		sprite.play("Double Jump")

#
# [State: Update]
func physics_update(delta: float) -> void:
	.physics_update(delta)

	#
	# Falling
	if player.velocity.y > 0:
		emit_signal("transition_to", "fall")

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Jump
	if event.is_action_pressed("jump"):
		#
		# Another Jump
		if player.jump_count >= 1 and player.jump_count < player.jump_max_count:
			emit_signal("transition_to", "jump", { factor = 0.85 })
	# #
	# # Terminate Jump
	# elif event.is_action_released("jump"):
	# 	player.velocity.y *= player.jump_release
