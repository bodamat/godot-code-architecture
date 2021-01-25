extends RayCast

var _is_mousing_over := false

func _input(_event):
	var collided_area: Area = get_collider()
	if collided_area is Food:
		if not _is_mousing_over:
			_is_mousing_over = true
			GameEvents.emit_signal("food_moused_over", collided_area)
	elif _is_mousing_over:
		_is_mousing_over = false
		GameEvents.emit_signal("food_moused_out")
