extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.speed = player.roll_speed

	player.animatedSprite.play("Roll")

#
# [State: OnAnimationFinished]
func _on_animation_finished(_name: String) -> void:
	player.test_ceiling()
	
	if player.can_stand:
		emit_signal("transition_to", "stand")
	else:
		emit_signal("transition_to", "crouch")

# [Animation Callback]
func _on_momentum_lost() -> void:
	player.speed = 0
