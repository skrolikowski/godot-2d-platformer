extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.speed = player.roll_speed

	sprite.play("Roll")

#
# [State: OnAnimationFinished]
func _on_animation_finished():
	emit_signal("transition_to", "stand")
