# [State: Stand]
extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	sprite.play("Stand")

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Jump
	if event.is_action_pressed("jump"):
		emit_signal("transition_to", "jump")
	#
	# Move
	elif event.is_action_pressed("left") or event.is_action_pressed("right"):
		emit_signal("transition_to", "move")

#
# [State: OnAnimationFinished]
func _on_animation_finished():
	emit_signal("transition_to", "idle")
