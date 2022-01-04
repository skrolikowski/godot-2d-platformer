extends MotionState

func enter(_data := {}) -> void:
    # player.set_dead(true)
    player.animatedSprite.play("Knockback")

func _on_animation_finished(_name: String) -> void:
    emit_signal("transition_to", "dead")