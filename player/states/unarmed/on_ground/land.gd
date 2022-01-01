extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.velocity = Vector2.ZERO
	player.jump_count = 0
	
	sprite.play("Land")

#
# [State: Transition]
func check_state() -> void:
	var axis: Vector2 = player.query_axis()
	#
	# Crouch
	if axis.y > 0:
		emit_signal("transition_to", "crouch")
	#
	# Move
	elif axis.x != 0:
		emit_signal("transition_to", "move")

#
# [State: Input]
func handle_input(event) -> void:
	# var hold: Vector2 = player.query_axis()
	#
	# Jump
	if event.is_action_pressed("jump"):
		emit_signal("transition_to", "jump")
	# #
	# # Crouch
	# elif event.is_action_pressed("down") or player.down > 0:
	# 	emit_signal("transition_to", "crouch")
	# #
	# # Move
	# elif event.is_action_pressed("left") or event.is_action_pressed("right") or hold.x != 0:
	# 	emit_signal("transition_to", "move")

#
# [State: OnAnimationFinished]
func _on_animation_finished():
	emit_signal("transition_to", "idle")
