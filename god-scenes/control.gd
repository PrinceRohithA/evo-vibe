extends Control

@onready var dialog_label: Label = $DialogLabel
@onready var timer: Timer = $TypeTimer
@onready var goal: Label = $Goal

@export var ps: PackedScene
@export var full_text: String
@export var goal_text: String

var char_index: int = 0
var typing_speed := 0.05

func _ready():
	full_text = full_text.replace("\\n", "\n")
	goal.text = goal_text
	show_text(full_text)

func show_text(_text: String):
	full_text = _text
	dialog_label.text = ""
	char_index = 0
	timer.start(typing_speed)

func _on_TypeTimer_timeout():
	if char_index < full_text.length():
		dialog_label.text += full_text[char_index]
		char_index += 1
	else:
		timer.stop()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_packed(ps)
