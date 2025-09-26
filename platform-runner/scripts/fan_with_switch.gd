extends Node

func _process(_delta):
	
	if $lever.on:
		$Fan.on = true
	
	if not $lever.on:
		$Fan.on = false
