extends MotionState

#
# [State: Enter]
func enter(_data := {}) -> void:
	sprite.play("Hang")

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Climb
	if event.is_action_pressed("up"):
		emit_signal("transition_to", "climb")
	#
	# Drop
	elif event.is_action_pressed("down"):
		emit_signal("transition_to", "fall")
	#
	# Jump
	elif event.is_action_pressed("jump"):
		emit_signal("transition_to", "wall_jump", { axis = Vector2.UP })
