extends InAirState

#
# [State: Enter]
func enter(_data := {}) -> void:
	player.speed = player.air_speed

	sprite.play("Fall")
