extends MotionState

var direction: float

#
# [State: Enter]
func enter(data := {}) -> void:
	direction = data.get("direction", 0)

	player.animatedSprite.play("Hang")

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
	elif event.is_action_pressed("left") && direction > 0:
		emit_signal("transition_to", "fall")
	elif event.is_action_pressed("right") && direction < 0:
		emit_signal("transition_to", "fall")
	#
	# Jump
	elif event.is_action_pressed("jump"):
		emit_signal("transition_to", "wall_jump", { axis = Vector2.UP })
