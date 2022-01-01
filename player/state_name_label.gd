extends Label

func _ready() -> void:
	text = "Idle"
	
func _on_state_changed(name: String, _prev_name: String) -> void:
	text = name
