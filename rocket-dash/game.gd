extends Node2D

@onready var camera: Camera2D = $Environment/Camera2D
@onready var rocket: CharacterBody2D = $Environment/Rocket
@onready var score_label: Label = $CanvasLayer/Control/Label
@onready var game_timer: Timer = $GameTimer
@onready var timer_label: Label = $CanvasLayer/Control/Label2
@onready var environment: Node2D = $Environment
@onready var one_sec: Timer = $OneSec

var ps: PackedScene = load("res://rocket-dash/ui/play_again.tscn")
var ps2: PackedScene = load("res://rocket-dash/ui/mission_completed.tscn")
var game_over_: bool = false

func _ready() -> void:
	game_timer.start()
	one_sec.start()

func _process(_delta: float) -> void:
	camera.position.x = rocket.position.x 
	var time_left = int(game_timer.time_left)
	timer_label.text = "Time: %02d:%02d" % [time_left/60.0, time_left%60]
	score_label.text = "Score: " + str(Global.score)
	if Global.score > 1000000:
		get_tree().change_scene_to_packed(ps2)

func end_game() -> void:
	game_over_ = true
	environment.modulate = Color(1, 1, 1, 0.5)
	get_tree().call_deferred("change_scene_to_packed", ps)

func _on_GameTimer_timeout() -> void:
	end_game()

func _on_one_sec_timeout() -> void:
	if !game_over_:
		if Global.isboost:  
			Global.score += 5  
		else:
			Global.score += 1   
		one_sec.start()
