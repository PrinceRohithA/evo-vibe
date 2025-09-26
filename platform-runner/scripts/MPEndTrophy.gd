extends Area2D


@onready var multi_player_game_manager = %MultiPlayerGameManager

func _on_body_entered(body):
	
	if (body.name == "main_character"):
		$Timer.start()
		$AnimatedSprite2D.animation = "ended"
		multi_player_game_manager.time_running = false


func _on_timer_timeout():
	
	$AnimatedSprite2D.animation = "default"
	get_tree().change_scene_to_file("res://scenes/level_menu.tscn")
