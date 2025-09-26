extends Node


var total_points_label_str : String
@onready var total_points_label = %"Total Points Label"

var level_menu = preload("res://scenes/level_menu.tscn")

func _on_texture_button_pressed():
	get_tree().change_scene_to_packed(level_menu)

func _process(_delta):
	total_points_label_str = Global.total_points_label
	if total_points_label_str != "":
		total_points_label.text = total_points_label_str

func _on_character_pressed():
	get_tree().change_scene_to_file("res://scenes/character_selection_menu.tscn")

func _on_mp_button_pressed():
	get_tree().change_scene_to_file("res://scenes/mp_menu.tscn")
