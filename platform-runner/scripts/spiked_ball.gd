extends Area2D


var i = 0.0
var reverse = false

func _physics_process(delta):
	
	rotation = i * delta
	
	if reverse:
		i -= 1
	else:
		i += 1
	
	if reverse and i <= 75 and i >= 0:
		i -= 0.2
	
	if not reverse and  i >= -75 and i <= 0:
		i += 0.2
	
	if reverse and i <= 50 and i >= 0:
		i -= 0.3
	
	if not reverse and  i >= -50 and i <= 0:
		i += 0.3
	
	if reverse and i <= 10 and i >= 0:
		i -= 0.3
	
	if not reverse and  i >= -10 and i <= 0:
		i += 0.3
	
	if not reverse and i <= 50 and i >= 0:
		i += 0.4
	
	if reverse and  i >= -50 and i <= 0:
		i -= 0.4
	
	if i <= -75:
		reverse = false
	
	if i >= 75:
		reverse = true


func _on_body_entered(body):
	
	if body.name == "main_character":
		Global.respawn = true
