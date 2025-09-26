extends Area2D


@onready var game_manager = %GameManager
var delay = false

func _on_body_entered(body):
	if (body.name == "main_character"):
		Global.level[game_manager.level] = 1
		Global.level_unlocked[game_manager.level + 1] = 1
		game_manager.addtotalpoints()
		$Timer.start()
		$AnimatedSprite2D.animation = "ended"

func _on_timer_timeout():
	delay = true
	$AnimatedSprite2D.animation = "default"
	get_tree().change_scene_to_packed(game_manager.next_scene)
