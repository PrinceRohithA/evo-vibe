extends Node

var score: int = 0
var previous_scores: Array = [0]

var isboost: bool

var player_name: String
var rollno: int

func connect_obstacle(obs: Node) -> void:
	obs.hit.connect(_on_obstacle_hit)

func _on_obstacle_hit(op: String, val: int) -> void:
	match op:
		"+": score += val
		"-": score -= val
		"*": score *= val
		"/": score = int(score / val)
