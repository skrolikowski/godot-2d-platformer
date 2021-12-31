extends MotionState

func enter(_data := {}) -> void:
    # player.set_dead(true)
    sprite.play("die")

func _on_animation_finished() -> void:
    emit_signal("transition_to", "dead")