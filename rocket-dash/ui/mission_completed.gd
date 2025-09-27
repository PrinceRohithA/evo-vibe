extends CanvasLayer


var ps: PackedScene = load("res://god-scenes/transition_2.tscn")

func _on_button_pressed() -> void:
	Global.score = 0
	get_tree().change_scene_to_packed(ps)
