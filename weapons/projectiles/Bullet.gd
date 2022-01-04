extends Sprite

export var speed = 1000

func _physics_process(delta):
	var velocity = Vector2 (0, -speed).rotated (global_rotation)
	global_position +=  velocity * delta
