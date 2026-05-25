extends CharacterBody3D

@export var unit_name = "Soldier"
@export var unit_class = "Frontier"
@export var max_hp = 100
@export var current_hp = 100
@export var move_range = 6.0

var is_selected = false

func _ready():
	print(unit_name + " is ready. HP: " + str(current_hp))
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func select():
	is_selected = true
	%SelectionRing.visible = true

func deselect():
	is_selected = false
	%SelectionRing.visible = false


func _on_hitbox_input_event(camera, event, event_position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("click registered")
			if is_selected:
				deselect()
			else:
				select()
