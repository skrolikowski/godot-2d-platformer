extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.speed = player.move_speed
	
	sprite.play("Run")

#
# [State: Update]
func physics_update(delta: float) -> void:
	if player.direction == 0:
		emit_signal("transition_to", "idle")

	.physics_update(delta)

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Jump
	if event.is_action_pressed("jump") or player.jump:
		emit_signal("transition_to", "jump")
