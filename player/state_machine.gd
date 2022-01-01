class_name ActorStateMachine
extends StateMachine

onready var player: Player = owner as Player

# OnGround
onready var idle   := $Idle
onready var crouch := $Crouch
onready var stand  := $Stand
onready var crawl  := $Crawl
onready var roll   := $Roll
onready var land   := $Land
onready var move   := $Move
# OnWall
onready var climb      := $Climb
onready var hang       := $Hang
onready var wall_slide := $WallSlide
onready var wall_jump  := $WallJump
# InAir
onready var jump     := $Jump
onready var fall     := $Fall

func _ready() -> void:
	state_map = {
		# OnGround
		"idle":   idle,
		"crouch": crouch,
		"stand":  stand,
		"crawl":  crawl,
		"roll":   roll,
		"move":   move,
		"land":   land,
		# OnWall
		"hang":       hang,
		"climb":      climb,
		"wall_slide": wall_slide,
		"wall_jump":  wall_jump,
		# InAir
		"jump": jump,
		"fall": fall,
	}
	
func _change_state(name, data := {}) -> void:
	if not _active:
		return
	
	####################
	# Pushdown Automata
	####################

	# if name in ["jump"]:
	# 	state_stack.push_front(state_map[name])
		
	._change_state(name, data)

func _unhandled_input(event: InputEvent):
	# handle input that can interrupt states..
	# i.e. attack, take damage, etc..
	
	state.handle_input(event)


func _on_animation_finished():
	state._on_animation_finished()
