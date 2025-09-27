extends RayCast3D


func _physics_process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider is CSGPolygon3D:
			Global.car_on_track = true
	else:
		Global.car_on_track = false
