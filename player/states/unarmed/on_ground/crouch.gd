extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.boundsStand.disabled  = true
	player.boundsCrouch.disabled = false

	player.animatedSprite.play("Crouch")

#
# [State: Update]
func physics_update(delta: float) -> void:
	player.test_ceiling()
	
	.physics_update(delta)

#
# [State: Transition]
func check_state() -> void:
	#
	# Stand
	if player.down == 0 and player.can_stand && not player.aiming:
		emit_signal("transition_to", "stand")
	#
	# Crawl
	elif player.direction != 0 && not player.aiming:
		emit_signal("transition_to", "crawl")

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Roll
	if event.is_action_pressed("jump"):
		emit_signal("transition_to", "roll")
