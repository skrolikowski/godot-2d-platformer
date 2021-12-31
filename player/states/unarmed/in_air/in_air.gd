class_name InAirState
extends MotionState

var is_on_upper_wall: bool = false
var is_on_lower_wall: bool = false
var can_detect_ledge: bool = false

#
# [State: Update]
func physics_update(delta: float) -> void:
	#
	# update wall raycasts
	player.wallUpperRay2d.force_raycast_update()
	player.wallLowerRay2d.force_raycast_update()

	is_on_upper_wall = player.wallUpperRay2d.is_colliding()
	is_on_lower_wall = player.wallLowerRay2d.is_colliding()
	can_detect_ledge = false

	# check ledge raycast, if necessary
	if not is_on_upper_wall and is_on_lower_wall:
		player.ledgeUpperRay2d.force_raycast_update()
		can_detect_ledge = player.ledgeUpperRay2d.is_colliding()

	.physics_update(delta)

#
# [State: Transition]
func check_state() -> void:
	#
	# OnGround
	if player.is_on_floor():	
		emit_signal("transition_to", "land")
	#
	# OnWall (forced)
	elif player.is_on_wall() and player.direction != 0:
		#
		# Ledge Grab
		if can_detect_ledge:
			emit_signal("transition_to", "hang")
		#
		# Wall Slide
		elif is_on_upper_wall and is_on_lower_wall:
			emit_signal("transition_to", "wall_slide")

#
# [State: Input]
func handle_input(event):
	#
	# Double Jump
	if event.is_action_pressed("jump"):
		if not player.is_on_floor() and player.jump_count < player.jump_max_count:
			emit_signal("transition_to", "jump_2nd")
