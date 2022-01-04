extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.animatedSprite.play("Idle")

#
# [State: Transition]
func check_state() -> void:
	#
	# Look Up
	if player.up > 0:
		emit_signal("transition_to", "look_up")
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
	#
	# Melee
	elif event.is_action_pressed("melee"):
		emit_signal("transition_to", "melee")
