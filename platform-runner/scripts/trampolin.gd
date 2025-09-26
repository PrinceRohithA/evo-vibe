extends Area2D



func _on_body_entered(body):
	
	if body.name == "main_character":
		$AnimatedSprite2D.animation = "jump"
		Global.trampolin_collition = true
		$Timer.start()


func _on_body_exited(body):
	
	if body.name == "main_character":
		Global.trampolin_collition = false


func _on_timer_timeout():
	$AnimatedSprite2D.animation = "default"
