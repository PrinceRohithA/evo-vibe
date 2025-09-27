extends Node


#Rocket Dash

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

#Platform Runner

#main game variables
var total_points = 0

#player
var player_pos : Vector2

var two_star_condition = { 

1 : 0,
2 : 0,
3 : 0,
4 : 0,
5 : 0,
6 : 0,
7 : 0,
8 : 0,
9 : 0,
10 : 0,
11 : 0

}

var three_star_condition = { 

1 : 0,
2 : 0,
3 : 0,
4 : 0,
5 : 0,
6 : 0,
7 : 0,
8 : 0,
9 : 0,
10 : 0,
11 : 0 

}

var points = { 

1 : 0,
2 : 0,
3 : 0,
4 : 0,
5 : 0,
6 : 0,
7 : 0,
8 : 0,
9 : 0,
10 : 0,
11 : 0

}

var level = {

1 : 0,
2 : 0,
3 : 0,
4 : 0,
5 : 0,
6 : 0,
7 : 0,
8 : 0,
9 : 0,
10 : 0,
11 : 0

}

var level_unlocked = {

1 : 1,
2 : 0,
3 : 0,
4 : 0,
5 : 0,
6 : 0,
7 : 0,
8 : 0,
9 : 0,
10 : 0,
11 : 0

}

#mainmenu variables
var total_points_label : String

#Trampolin variables
var trampolin_collition : bool

#fan variable
var fan_on : bool
var on_fan_range : bool
var switch_required : bool

#respawn variable
var respawn_pos : Vector2i
var save_respawn : bool
var respawn : bool

#character menu
var pink_man = true
var mask_dude : bool
var ninja_frog : bool
var virtual_guy : bool

#mobile buttons
var mobile_left = false
var mobile_right = false
var mobile_jump = false

#angry pig
var angry_pig_get_hit : bool
var angry_pig_get_collide : bool

func _process(_delta):
	pass

#Main Menu Total Points
func addpoints():
	total_points += 1
	total_points_label = " * " + str(total_points)


var car_on_track: bool
