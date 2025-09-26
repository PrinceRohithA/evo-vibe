extends Node


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_pinkman_pressed():
	Global.pink_man = true
	Global.mask_dude = false
	Global.ninja_frog = false
	Global.virtual_guy = false


func _on_maskdude_pressed():
	Global.pink_man = false
	Global.mask_dude = true
	Global.ninja_frog = false
	Global.virtual_guy = false


func _on_ninjafrog_pressed():
	Global.pink_man = false
	Global.mask_dude = false
	Global.ninja_frog = true
	Global.virtual_guy = false


func _on_virtualguy_pressed():
	Global.pink_man = false
	Global.mask_dude = false
	Global.ninja_frog = false
	Global.virtual_guy = true

func _process(_delta):
	if Global.pink_man:
		$buttons/pinkman.disabled = true
	else:
		$buttons/pinkman.disabled = false
	if Global.mask_dude:
		$buttons/maskdude.disabled = true
	else:
		$buttons/maskdude.disabled = false
	if Global.ninja_frog:
		$buttons/ninjafrog.disabled = true
	else:
		$buttons/ninjafrog.disabled = false
	if Global.virtual_guy:
		$buttons/virtualguy.disabled = true
	else:
		$buttons/virtualguy.disabled = false
