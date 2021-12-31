extends InAirState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.velocity.y  = -player.jump_impulse
	player.speed       = player.air_speed
	player.jump_count += 1
	
	sprite.play("Jump")

#
# [State: OnAnimationFinished]
func _on_animation_finished():
	emit_signal("transition_to", "fall")
