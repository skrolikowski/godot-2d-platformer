extends MotionState

#
# [State: Enter]
func enter(_data := {}) -> void:	
	player.animatedSprite.play("Wall Slide")

#
# [State: Transition]
func check_state() -> void:
	#
	# OnFloor
	if player.is_on_floor():
		emit_signal("transition_to", "idle")
	#
	# InAir
	elif player.direction == 0:
		emit_signal("transition_to", "fall")

#
# [State: Input]
func handle_input(event) -> void:
	#
	# Wall Jump
	if event.is_action_pressed("jump"):
		emit_signal("transition_to", "wall_jump", { axis = -player.look_direction })

