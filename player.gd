extends KinematicBody

export var _mouse_sensitivity := 0.1 # := equal : float = 0.05
export var _mouse_invert_x := false
export var _mouse_invert_y := false
export var _camera_clamp_degree_x := 90.0
export var _move_speed := 3.0

export(Resource) var _runtime_data = _runtime_data as RuntimeData

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	aim(event)

func _physics_process(_delta):
	if _runtime_data.current_gameplay_state == Enums.GameplayState.FREEWALK:
		movement()


func aim(event) -> void:
	var mouse_motion = event as InputEventMouseMotion;
	if mouse_motion:
		var mouse_invert_y_value = -1 if _mouse_invert_y else 1
		var mouse_invert_x_value = -1 if _mouse_invert_x else 1
		
		rotation_degrees.y -= mouse_motion.relative.x * _mouse_sensitivity * mouse_invert_y_value
		
		var current_tilt: float = $Camera.rotation_degrees.x
		current_tilt -= mouse_motion.relative.y * _mouse_sensitivity * mouse_invert_x_value
		
		$Camera.rotation_degrees.x = clamp(current_tilt, -_camera_clamp_degree_x, _camera_clamp_degree_x)


func movement() -> void:
	var movement_vector: Vector3
	var forward_vector: Vector3
	var right_vector: Vector3

	if Input.is_action_pressed("move_forward"):
		forward_vector = -transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		forward_vector = transform.basis.z
		
	if Input.is_action_pressed("move_left"):
		right_vector = -transform.basis.x
	elif Input.is_action_pressed("move_right"):
		right_vector = transform.basis.x
	
	movement_vector = forward_vector + right_vector
	movement_vector = movement_vector.normalized()
	
# warning-ignore:return_value_discarded
	move_and_slide(movement_vector * _move_speed)
