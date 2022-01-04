extends GDWeaponsLongAction

class_name GDWeaponsReloadAction

func _apply_end_action():
	get_node("../MagCapacity").refill()
	._apply_end_action()
