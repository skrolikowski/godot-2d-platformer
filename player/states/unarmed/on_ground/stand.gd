# [State: Stand]
extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.boundsStand.disabled  = false
	player.boundsCrouch.disabled = true

	player.animatedSprite.play("Stand")


# [State: Transition]
func check_state() -> void:
	#
	# Move
	if player.direction != 0:
		emit_signal("transition_to", "move")

#
# [State: Input]
func handle_input(_event) -> void:
	#
	# Jump
	if player.jump:
		emit_signal("transition_to", "jump")

#
# [State: OnAnimationFinished]
func _on_animation_finished(_name: String):
	emit_signal("transition_to", "idle")
