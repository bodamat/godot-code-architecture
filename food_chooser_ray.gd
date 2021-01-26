extends RayCast

export(Resource) var _runtime_data = _runtime_data as RuntimeData

var _is_mousing_over := false

func _input(event):
	var collided_area: Area = get_collider()
	if collided_area is Food:
		if not _is_mousing_over:
			_is_mousing_over = true
			GameEvents.emit_signal("food_moused_over", collided_area)
		
		if event is InputEventMouseButton \
			and event.is_pressed() \
			and _runtime_data.current_gameplay_state == Enums.GameplayState.FREEWALK:
			
			GameEvents.emit_signal("food_clicked", collided_area)
			
	elif _is_mousing_over:
		_is_mousing_over = false
		GameEvents.emit_signal("food_moused_out")
