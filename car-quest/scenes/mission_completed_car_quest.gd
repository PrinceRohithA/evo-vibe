extends CanvasLayer



var ps: PackedScene = load("res://god-scenes/transition_4.tscn") 

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(ps)
