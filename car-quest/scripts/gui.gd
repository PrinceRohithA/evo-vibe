extends Control

@export var vehicle : Vehicle

@onready var speed_label = $VBoxContainer/Speed
@onready var rpm_label = $VBoxContainer/RPM
@onready var gear_label = $VBoxContainer/Gear
@onready var label: Label = $Label
@onready var timer: Timer = $Timer

@onready var ps: PackedScene = preload("res://car-quest/scenes/play_again_car_quest.tscn")

func _process(_delta):
	speed_label.text = str(round(vehicle.speed * 3.6)) + " km/h"
	rpm_label.text = str(round(vehicle.motor_rpm)) + " rpm"
	gear_label.text = "Gear: " + str(vehicle.current_gear)
	if !Global.car_on_track:
		if timer.is_stopped():
			timer.start(5)
	else:
		if !timer.is_stopped():
			timer.stop()

	if !timer.is_stopped():
		label.text = "Return to track or you will be eliminated in... " + str(int(timer.time_left))
	else:
		label.text = ""

func _on_timer_timeout() -> void:
	print("Change to play again")
	get_tree().change_scene_to_packed(ps)
	
