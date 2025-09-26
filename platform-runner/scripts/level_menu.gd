extends Node


func _on_level_1_button_up():
	get_tree().change_scene_to_file("res://Level Scenes/Level1.tscn")

func _on_level_2_button_up():
	get_tree().change_scene_to_file("res://Level Scenes/Level2.tscn")

func _on_level_3_button_up():
	get_tree().change_scene_to_file("res://Level Scenes/Level3.tscn")


func _on_back_button_up():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
