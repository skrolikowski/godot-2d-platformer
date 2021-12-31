extends InAirState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.velocity.y = -player.jump_impulse * 0.85
	player.jump_count += 1
	
	sprite.play("Double Jump")
		
#
# [State: OnAnimationFinished]
func _on_animation_finished():
	emit_signal("transition_to", "fall")
