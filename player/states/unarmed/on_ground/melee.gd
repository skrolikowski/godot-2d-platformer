extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.animatedSprite.play("Attack 1")

# #
# # [State: Transition]
# func check_state() -> void:
# 	#
# 	# Crouch
# 	if player.down > 0:
# 		emit_signal("transition_to", "crouch")
# 	#
# 	# Move
# 	elif player.direction != 0:
# 		emit_signal("transition_to", "move")

# #
# # [State: Input]
# func handle_input(event) -> void:
# 	#
# 	# Jump
# 	if event.is_action_pressed("jump"):
# 		emit_signal("transition_to", "jump")

#
# [State: OnAnimationFinished]
func _on_animation_finished(_name: String) -> void:
	emit_signal("transition_to", "idle")

func on_melee_area2d_enabled() -> void:
	player.meleeShape2d.disabled = false
	
func on_melee_area2d_disabled() -> void:
	player.meleeShape2d.disabled = true
