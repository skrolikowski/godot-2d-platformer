class_name Player
extends KinematicBody2D

onready var timer:   Timer	= $"Timer"
onready var body:    Node2D = $Body
onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

onready var animatedSprite: AnimationPlayer = get_node("Body/AnimationPlayer") as AnimationPlayer
onready var meleeShape2d: CollisionShape2D = get_node("Body/MeleeArea2D/MeleeShape2D") as CollisionShape2D
# Bounds
onready var boundsStand:  CollisionShape2D = get_node("BoundsStand") as CollisionShape2D
onready var boundsCrouch: CollisionShape2D = get_node("BoundsCrouch") as CollisionShape2D
# Ledge Checking
onready var ledgeUpperRay2d: RayCast2D = get_node("Body/LedgeUpperRay2d") as RayCast2D
onready var ledgeLowerRay2d: RayCast2D = get_node("Body/LedgeLowerRay2d") as RayCast2D
# Ceiling Checks
onready var ceilingLeftRay2d:  RayCast2D = get_node("Body/CeilingLeftRay2d") as RayCast2D
onready var ceilingRightRay2d: RayCast2D = get_node("Body/CeilingRightRay2d") as RayCast2D
# Wall Checks
onready var wallUpperRay2d: RayCast2D = get_node("Body/WallUpperRay2d") as RayCast2D
onready var wallLowerRay2d: RayCast2D = get_node("Body/WallLowerRay2d") as RayCast2D

var velocity:     Vector2 = Vector2.ZERO
var move_speed:   int = 400
var speed:        int = move_speed
var dash_speed:   int = move_speed * 1.5
var air_speed:    int = move_speed * 0.75
var leap_speed:   int = move_speed * 1.25
var crawl_speed:  int = move_speed * 0.5
var roll_speed:   int = move_speed * 0.85

var direction: float = 0.0
var right:     float = 0.0
var left:      float = 0.0
var up:        float = 0.0
var down:      float = 0.0
var shift:     bool  = false
var aiming:    bool  = false
var melee:     bool  = false

var is_on_upper_wall:    bool = false
var is_on_lower_wall:    bool = false
var is_on_left_ceiling:  bool = false
var is_on_right_ceiling: bool = false
var can_stand:           bool = true
var can_wall_slide:      bool = false
var can_detect_ledge:    bool = false
var can_grab_ledge:      bool = false

var time_off_ground: float = 0
var wall_friction:   float = 0.08

var jump:           bool  = false
var jump_buffer:	float = 0.25
var jump_impulse:   int   = 1200
var jump_release:   float = jump_impulse * 0.2
var jump_count:     int   = 0
var jump_max_count: int   = 2

var previous_state: String
var current_state: String

var climb_offset: Vector2 = Vector2(28, -84)
var collision_info: KinematicCollision2D
var look_direction: Vector2 = Vector2.RIGHT setget set_look_direction


#
# Player Input
func record_input(event: InputEvent) -> void:
	#
	# Left
	if event.is_action_pressed("left") && left <= 0.01:
		left = event.get_action_strength("left")
		direction -= left
	elif event.is_action_released("left"):
		direction += left
		left = 0.0
	#
	# Right
	elif event.is_action_pressed("right") && right <= 0.01:
		right = event.get_action_strength("right")
		direction += right
	elif event.is_action_released("right"):
		direction -= right
		right = 0.0
	#
	# Up
	elif event.is_action_pressed("up") && up <= 0.01:
		up = event.get_action_strength("up")
	elif event.is_action_released("up"):
		up = 0.0
	#
	# Down
	elif event.is_action_pressed("down") && down <= 0.01:
		down = event.get_action_strength("down")
	elif event.is_action_released("down"):
		down = 0.0
	#
	# Jump
	elif event.is_action_pressed("jump") && !jump:
		jump = true
	elif event.is_action_released("jump"):
		jump = false
	#
	# Shift
	elif event.is_action_pressed("shift") && !shift:
		shift = true
	elif event.is_action_released("shift"):
		shift = false
	#
	# Aim
	elif event.is_action_pressed("aim") && !aiming:
		aiming = true
	elif event.is_action_released("aim"):
		aiming = false
	#
	# Melee
	elif event.is_action_pressed("melee") && !melee:
		melee = true
	elif event.is_action_released("melee"):
		melee = false

#
#
func _process(delta: float):
	if is_on_floor():
		time_off_ground = 0
	else:
		time_off_ground += delta

#
# [Query: Is player requesting axis?]
func query_axis() -> Vector2:
	return Vector2(right - left, up - down)


#
# [Test: Ceiling Detection]
func test_ceiling() -> void:
	ceilingLeftRay2d.force_raycast_update()
	ceilingRightRay2d.force_raycast_update()

	is_on_left_ceiling  = ceilingLeftRay2d.is_colliding()
	is_on_right_ceiling = ceilingRightRay2d.is_colliding()
	# debug
	# ceilingLeftRay2d.visible  = ceilingLeftRay2d.is_colliding()
	# ceilingRightRay2d.visible = ceilingRightRay2d.is_colliding()
	
	can_stand = not is_on_left_ceiling && not is_on_right_ceiling

#
# [Test: Wall/Ledge Detection]
func test_walls_and_ledge() -> void:
	wallUpperRay2d.force_raycast_update()
	wallLowerRay2d.force_raycast_update()

	is_on_upper_wall = wallUpperRay2d.is_colliding()
	is_on_lower_wall = wallLowerRay2d.is_colliding()
	can_wall_slide   = is_on_upper_wall && is_on_lower_wall
	can_detect_ledge = not is_on_upper_wall && is_on_lower_wall
	can_grab_ledge   = false

	if can_detect_ledge:
		ledgeUpperRay2d.force_raycast_update()
		
		can_grab_ledge = ledgeUpperRay2d.is_colliding()

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
func _on_state_changed(name: String, prev_name: String) -> void:
	current_state  = name
	previous_state = prev_name
