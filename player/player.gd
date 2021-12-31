class_name Player
extends KinematicBody2D

onready var timer:   Timer	= $"Timer"
onready var body:    Node2D = $Body
onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# For Ledge Checking..
onready var ledgeUpperRay2d: RayCast2D = get_node("Body/LedgeUpperRay2d") as RayCast2D
onready var ledgeLowerRay2d: RayCast2D = get_node("Body/LedgeLowerRay2d") as RayCast2D
onready var wallUpperRay2d:  RayCast2D = get_node("Body/WallUpperRay2d") as RayCast2D
onready var wallLowerRay2d:  RayCast2D = get_node("Body/WallLowerRay2d") as RayCast2D

var velocity:     Vector2 = Vector2.ZERO
var move_speed:   int = 500
var speed:        int = move_speed
var dash_speed:   int = move_speed * 1.25
var air_speed:    int = move_speed * 0.65
var crouch_speed: int = move_speed * 0.3
var roll_speed:   int = move_speed * 0.5

var direction: float = 0.0
var right:     float = 0.0
var left:      float = 0.0
var up:        float = 0.0
var down:      float = 0.0

var wall_friction: float = 0.08

var jump_request:   bool  = false
var jump_buffer:	float = 0.5
var jump_impulse:   int   = 1200
var jump_release:   int   = jump_impulse * 0.2
var jump_count:     int   = 0
var jump_max_count: int   = 2

var roll_time: float = 0.3

var current_state: String
var climb_offset: Vector2 = Vector2(28, -84)
var collision_info: KinematicCollision2D
var look_direction: Vector2 = Vector2.RIGHT setget set_look_direction

#
# Player Input
func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left") && left <= 0.01:
		left = event.get_action_strength("left")
		direction -= left
	elif event.is_action_released("left"):
		direction += left
		left = 0.0
	elif event.is_action_pressed("right") && right <= 0.01:
		right = event.get_action_strength("right")
		direction += right
	elif event.is_action_released("right"):
		direction -= right
		right = 0.0
	elif event.is_action_pressed("up") && up <= 0.01:
		up = event.get_action_strength("up")
	elif event.is_action_released("up"):
		up = 0.0
	elif event.is_action_pressed("down") && down <= 0.01:
		down = event.get_action_strength("down")
	elif event.is_action_released("down"):
		down = 0.0
	elif event.is_action_pressed("jump") && !jump_request:
		jump_request = true
	elif event.is_action_released("jump"):
		jump_request = false

#
# [Query: Is player requesting axis?]
func query_axis() -> Vector2:
	return Vector2(right - left, up - down)

#
#
# func take_damage(attacker, amount: int) -> void:
# 	pass

#
#
func set_look_direction(value: Vector2) -> void:
	look_direction = value

	if value.x != 0:
		body.scale.x = sign(value.x)

#
#
func set_dead() -> void:
	set_process_input(false)
	set_physics_process(false)

#
#
func _on_state_changed(name: String) -> void:
	current_state = name
