extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.boundsStand.disabled  = true
	player.boundsCrouch.disabled = false

	player.speed = player.crawl_speed
	
	sprite.play("Crawl")

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
	if player.down == 0 and player.can_stand:
		emit_signal("transition_to", "stand")
	#
	# Crouch
	elif player.direction == 0:
		emit_signal("transition_to", "crouch")

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Roll
	if event.is_action_pressed("jump"):
		emit_signal("transition_to", "roll")
