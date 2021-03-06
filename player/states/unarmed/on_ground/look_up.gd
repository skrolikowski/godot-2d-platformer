extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.animatedSprite.play("Look Up")

#
# [State: Transition]
func check_state() -> void:
	#
	# Idle
	if player.up == 0:
		emit_signal("transition_to", "idle")
	#
	# Crouch
	if player.down > 0 && not player.aiming:
		emit_signal("transition_to", "crouch")
	#
	# Move
	elif player.direction != 0 && not player.aiming:
		emit_signal("transition_to", "move")

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Jump
	if event.is_action_pressed("jump"):
		emit_signal("transition_to", "jump")
