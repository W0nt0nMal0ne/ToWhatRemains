extends Node3D

const PAN_SPEED = 10.0

func _process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_just_pressed("cam_left"):
		direction.x -= 1
	if Input.is_action_just_pressed("cam_right"):
		direction.x += 1
	if Input.is_action_just_pressed("cam_up"):
		direction.z -= 1
	if Input.is_action_just_pressed("cam_down"):
		direction.z += 1
	
	position += direction * PAN_SPEED * delta
	
