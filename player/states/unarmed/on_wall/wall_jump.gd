extends MotionState

#
# [State: Enter]
func enter(data := {}) -> void:
	player.velocity.x = player.move_speed * data.axis.x * 0.5
	player.velocity.y = -player.jump_impulse * 0.5

	player.jump_count = 2
	
	sprite.play("Double Jump")

#
# [State: OnAnimationFinished]
func _on_animation_finished():
	emit_signal("transition_to", "fall")
