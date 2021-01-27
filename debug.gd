extends Node

func _input(event):
	var mouse_click = event as InputEventMouseButton
	
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	if Input.is_action_just_pressed("debug_show_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if mouse_click and mouse_click.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
