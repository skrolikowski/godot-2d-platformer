class_name StateMachine
extends Node

# Emit when changing to new state..
signal state_changed(current_state)

export var initial_state := NodePath()
# onready var state: State = get_node(initial_state)
var state: State
var state_map := {}
var state_stack := []

var _active = false setget set_active

func _ready() -> void:
	yield(owner, "ready")
	
	# subscribe to state changes
	for child in get_children():
		child.connect("transition_to", self, "_change_state")
	
	# initial state
	set_active(true)
	state = get_node(initial_state)
	state_stack.push_front(state)
	_change_state(state.name.to_lower())

#
# [State: Input]		
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

#
# [State: Update]
func _process(delta: float) -> void:
	state.update(delta)

#
# [State: Physics Update]
func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _on_animation_finished() -> void:
	if not _active:
		return

	state._on_animation_finished()

#
# [Internal: Enable/Disable State]
func set_active(value: float) -> void:
	_active = value
	
	set_physics_process(value)
	set_process_input(value)

	if not _active:
		state = null
		state_stack = []

#
# [Internal: Change State]
func _change_state(name, data := {}) -> void:
	if not _active:
		return
	
	state.exit()
	
	# stack management
	if name == "previous":
		state_stack.pop_front()
	elif name == "dead":
		queue_free()
		return
	elif name in state_map:
		state_stack[0] = state_map[name]
	
	# change state
	state = state_stack[0]
	emit_signal("state_changed", name)
	
	if name != "previous":
		state.enter(data)
	
