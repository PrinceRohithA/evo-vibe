extends Area2D


@export var on : bool


func _process(_delta):
	
	if on:
		$AnimatedSprite2D.animation = "on"
	
	if not on:
		$AnimatedSprite2D.animation = "off"


func _on_body_entered(body):
	
	if body.name == "main_character":
		
		if on:
			on = false
	
		elif not on:
			on = true
