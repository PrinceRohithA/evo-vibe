extends CanvasLayer


@onready var label: Label = $Control/VBoxContainer/Label

var ps: PackedScene = load("res://rocket-dash/game.tscn") 

func _on_button_pressed() -> void:
	Global.score = 0
	get_tree().change_scene_to_packed(ps)
