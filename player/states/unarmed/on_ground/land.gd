extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.jump_count = 0
	
	player.animatedSprite.play("Land")

#
# [State: Transition]
func check_state() -> void:
	#
	# Crouch
	if player.down > 0:
		emit_signal("transition_to", "crouch")
	#
	# Move
	elif player.direction != 0:
		emit_signal("transition_to", "move")

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Jump
	if event.is_action_pressed("jump"):
		emit_signal("transition_to", "jump")

#
# [State: OnAnimationFinished]
func _on_animation_finished(_name: String) -> void:
	emit_signal("transition_to", "idle")
