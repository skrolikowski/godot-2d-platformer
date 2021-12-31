class_name ActorState
extends State

onready var sprite: AnimatedSprite = owner.get_node("Body/AnimatedSprite") as AnimatedSprite
onready var player: Player = owner as Player


#
# [State: Update]
func update(_delta: float) -> void:
	update_facing()
	check_state()

#
# [State: Input]
func _unhandled_input(event) -> void:
	player.unhandled_input(event)

#
# [Query: Is player requesting dash?]
func query_dash() -> bool:
	return Input.is_action_pressed("dash")

#
# [Modifier: Update facing]
func update_facing() -> void:
	#
	# Face Left
	if player.left > 0:
		player.look_direction = Vector2.LEFT
	#
	# Face Right
	elif player.right > 0:
		player.look_direction = Vector2.RIGHT
