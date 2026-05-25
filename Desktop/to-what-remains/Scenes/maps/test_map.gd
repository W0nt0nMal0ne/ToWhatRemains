extends Node3D

var selected_unit = null

func _unhandled_input(event):
	if event is InputEventKey:
		#space bar ends the turn
		if event.pressed and event.keycode == KEY_SPACE:
			GameManager.end_turn()
			#when turn ends, unit is deselected
			if selected_unit != null:
				selected_unit.deselect()
			print("Player ended turn")
	
	
	
	#when the right click is triggered
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			var camera = $CameraRig/Camera3D
			#knowing where all the coll shapes are for raycast
			var space_state = get_world_3d().direct_space_state
			#to know where mouse curosr in on screen
			var mouse_pos = get_viewport().get_mouse_position()
			
			#where ray starts
			var ray_origin = camera.project_ray_origin(mouse_pos)
			#where ray ends, 1000 units forward, can change
			var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 1000
			
			#packages for Godot to understand physics
			var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
			#where raycast hits
			var result = space_state.intersect_ray(query)
			
			if result and selected_unit != null:
				selected_unit.move_to(result.position)
