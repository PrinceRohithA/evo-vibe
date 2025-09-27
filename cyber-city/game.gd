extends Node3D


func _process(delta: float) -> void:
	print(Global.hearts_collected)
	if Global.hearts_collected >= 3:
		get_tree().change_scene_to_file("res://god-scenes/transition_5.tscn")
