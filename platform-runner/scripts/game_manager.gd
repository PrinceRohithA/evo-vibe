extends Node


@export var level : int
@export var two_star_condition : int
@export var three_star_condition : int
@export var respawn_pos : Vector2i
@export var next_scene: PackedScene

@onready var points_label = %PointsLabel
@onready var points = 0

const NINJA_FROG = preload("res://platform-runner/scenes/ninja_frog.tscn")

func _ready():
	points_label.text = "x" + str(Global.total_points)
	Global.two_star_condition[level] = two_star_condition
	Global.three_star_condition[level] = three_star_condition
	Global.respawn_pos = respawn_pos
	var ninja_frog = NINJA_FROG.instantiate()
	add_child(ninja_frog)
	ninja_frog.position = respawn_pos

func addpoints():
	points += 1
	points_label.text = "x" + str(Global.total_points)

func addtotalpoints():
	if points > Global.points[level]:
		Global.points[level] = points
