extends OnGroundState

#
# [State: Update]
func physics_update(delta: float) -> void:
	.physics_update(delta)

	#
	# Aiming => Idle
	if player.aiming:
		emit_signal("transition_to", "idle")

#
# [State: Transition]
func check_state() -> void:
	#
	# Stop
	if player.direction == 0:
		emit_signal("transition_to", "idle")
	#
	# Move
	else:
		if player.shift:
			player.speed = player.dash_speed
			player.animatedSprite.play("Dash")
		else:
			player.speed = player.move_speed
			player.animatedSprite.play("Run")

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Jump
	if event.is_action_pressed("jump"):
		if player.shift:
			emit_signal("transition_to", "jump", { speed = player.leap_speed })
		else:
			emit_signal("transition_to", "jump")
	#
	# Crawl
	elif event.is_action_pressed("down"):
		emit_signal("transition_to", "crawl")
