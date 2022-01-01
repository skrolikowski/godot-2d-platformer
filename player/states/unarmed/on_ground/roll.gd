extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.speed = player.roll_speed

	sprite.play("Roll")

#
# [State: OnAnimationFinished]
func _on_animation_finished():
	player.test_ceiling()
	
	if player.can_stand:
		emit_signal("transition_to", "stand")
	else:
		emit_signal("transition_to", "crouch")
