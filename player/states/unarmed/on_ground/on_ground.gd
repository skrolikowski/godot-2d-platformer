class_name OnGroundState
extends MotionState

#
# [State: Update]
func physics_update(delta: float) -> void:
	.physics_update(delta)

	#
	# InAir
	if not player.is_on_floor():
		emit_signal("transition_to", "fall")
