extends OnGroundState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.speed = player.crawl_speed
	
	sprite.play("Crawl")

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Roll
	if event.is_action_pressed("jump"):
		emit_signal("transition_to", "roll")
	#
	# Crouch
	elif event.is_action_released("left") or event.is_action_released("right"):
		emit_signal("transition_to", "crouch")

