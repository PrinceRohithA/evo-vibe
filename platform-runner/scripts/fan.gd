extends Area2D


@export var on : bool
@export var switch_attached : bool

func _process(_delta):
	
	Global.fan_on = on
	
	if on:
		$AnimatedSprite2D.animation = "on"
		Global.fan_on = on
	else:
		$AnimatedSprite2D.animation = "off"

func _on_body_entered(body):
	if body.name == "main_character":
		Global.on_fan_range = true

func _on_body_exited(body):
	if body.name == "main_character":
		Global.on_fan_range = false
