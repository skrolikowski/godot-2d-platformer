extends AnimatedSprite

func _ready():
	#warning-ignore:return_value_discarded
	owner.connect("direction_changed", self, "_on_direction_changed")

func _on_direction_changed(direction):
	match direction:
		Vector2.LEFT:
			flip_h = true
		Vector2.RIGHT:
			flip_h = false
