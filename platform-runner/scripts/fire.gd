extends Area2D


@export var on : bool


func _ready():
	on = true


func _process(_delta):
	
	if on:
		$AnimatedSprite2D.animation = "on"
	else:
		$AnimatedSprite2D.animation = "off"


func _on_body_entered(body):
	
	if body.name == "main_character" and on:
		Global.respawn = true


func _on_timer_timeout():
	
	$Timer.start()
	if on:
		on = false
	else:
		on = true
