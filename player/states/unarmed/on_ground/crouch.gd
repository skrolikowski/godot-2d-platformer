extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	sprite.play("Crouch")

#
# [State: Update]
func physics_update(delta: float) -> void:
	#
	# check ledge raycast
	player.ledgeLowerRay2d.force_raycast_update()

	.physics_update(delta)

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Roll
	if event.is_action_pressed("jump"):
		emit_signal("transition_to", "roll")
	#
	# Stand
	elif event.is_action_released("down"):
		emit_signal("transition_to", "stand")
	#
	# Crawl
	elif event.is_action_pressed("left") or event.is_action_pressed("right"):
		emit_signal("transition_to", "crawl")

