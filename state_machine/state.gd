# Base interface for all states
class_name State
extends Node

# warning-ignore:unused_signal
signal transition_to(state_name)

# Bootstrap
func init() -> void:
	pass

# Initialize the state. E.g. change the animation.
func enter(_data := {}) -> void:
	pass

# Clean up the state.
func exit() -> void:
	pass

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass
	
# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass

func check_state() -> void:
	pass

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass

func _on_animation_finished(_name: String):
	pass
