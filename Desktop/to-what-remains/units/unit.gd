extends CharacterBody3D

@export var unit_name = "Soldier"
@export var unit_class = "Frontier"
@export var max_hp = 100
@export var current_hp = 100
@export var move_range = 6.0

var is_selected = false
var is_moving = false
var target_position_3d = Vector3.ZERO
const MOVE_SPEED = 5.0

func _ready():
	print(unit_name + " is ready. HP: " + str(current_hp))
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func select():
	if GameManager.spend_cp(1):
		is_selected = true
		%SelectionRing.visible = true
		print(unit_name + " selected")
	#to let you know if unit is selected
		get_parent().selected_unit = self

func deselect():
	is_selected = false
	%SelectionRing.visible = false
	get_parent().selected_unit = null

func _on_hitbox_input_event(camera, event, event_position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("click registered")
			if is_selected:
				deselect()
			else:
				select()

func move_to(target_position: Vector3):
	#distance from current pos to target pos
	var distance = global_position.distance_to(target_position)
	if distance <= move_range:
		target_position_3d = target_position
		target_position_3d.y = global_position.y
		is_moving = true
		print(unit_name + " moving to " + str(target_position))
	else:
		print(unit_name + " target out of range")

func _physics_process(delta):
	if is_moving:
		#calc which dir to move, normalize keeps dir but sets length to 1 so speed stays consistent
		var direction = (target_position_3d - global_position).normalized()
		#checking how far the destination is
		var distance = global_position.distance_to(target_position_3d)
		
		#keep moving if more than .2 units away
		if distance > 0.2:
			velocity = direction * MOVE_SPEED
			move_and_slide()
			
			#face the dir of movement
			var look_target = global_position + direction
			look_at(look_target, Vector3.UP)
		#if less than .2 units, stop
		else:
			velocity = Vector3.ZERO
			global_position = target_position_3d
			is_moving = false
			print(unit_name + " arrived")
