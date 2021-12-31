extends MotionState

#
# [State: Enter]
func enter(_data := {}) -> void:
	sprite.play("Climb")

#
# [State: OnAnimationFinished]
func _on_animation_finished():
	player.position += player.climb_offset * Vector2(player.look_direction.x, 1)

	emit_signal("transition_to", "idle")