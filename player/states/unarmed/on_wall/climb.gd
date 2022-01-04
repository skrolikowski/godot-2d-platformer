extends MotionState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.boundsStand.disabled  = true
	player.boundsCrouch.disabled = true
	
	player.animatedSprite.play("Climb")

#
# [State: OnAnimationFinished]
func _on_animation_finished(_name: String):
	player.position += player.climb_offset * Vector2(player.look_direction.x, 1)
	player.boundsCrouch.disabled = false
	player.test_ceiling()

	if player.can_stand:
		emit_signal("transition_to", "stand")
	else:
		emit_signal("transition_to", "crouch")
