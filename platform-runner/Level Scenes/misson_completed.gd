extends Control


@onready var ps: PackedScene = preload("res://god-scenes/transition_3.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(ps)
