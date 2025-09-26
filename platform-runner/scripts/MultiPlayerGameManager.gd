extends Node


@export var player_scene : PackedScene

@onready var time_label = %time

var finished = false
var time_running = true

func _ready():
	var index = 0
	for i in MpGlobal.players:
		var currentplayer = player_scene.instantiate()
		currentplayer.name = str(MpGlobal.players[i].id)
		add_child(currentplayer)
		for spawn in get_tree().get_nodes_in_group("playerspawnpoint"):
			if spawn.name == str(index):
				currentplayer.global_position = spawn.global_position

func _process(_delta):
	
	var timer = 1000 - $Timer.time_left
	
	if time_running:
		
		time_label.text = "Time : " + str(int(timer))
	
	if finished:
		var final_time = timer
		MpGlobal.final_score = final_time
