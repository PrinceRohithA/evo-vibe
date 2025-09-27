extends Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	print(2)
	print(body.name)
	if body.name == "player":
		print(1)
		Global.hearts_collected += 1
		call_deferred("queue_free")
