extends Area2D

var activated : int
func _on_body_entered(body):
	
	if body.name == "main_character":
		Global.save_respawn = true
		activated += 1
		if activated == 1:
			$AnimatedSprite2D.animation = "touch"
			$Timer.start()


func _on_timer_timeout():
	$AnimatedSprite2D.animation = "end"
