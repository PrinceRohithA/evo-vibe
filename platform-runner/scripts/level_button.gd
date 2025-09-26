extends TextureButton


@export var unlocked : bool
@export var level : int
@export var target_scene : PackedScene

var max_level : int


func _ready():
	max_level = len(Global.level)


func _process(_delta):
	
	if Global.level[level] == 1:
		$star1.visible = true
	else:
		$star1.visible = false
	if Global.two_star_condition[level] <= Global.points[level] and Global.points[level] != 0:
		$star2.visible = true
	else:
		$star2.visible = false
	if Global.three_star_condition[level] <= Global.points[level] and Global.points[level] != 0:
		$star3.visible = true
	else:
		$star3.visible = false
	
	if Global.level_unlocked[level] == 1:
		unlocked = true
	
	if !unlocked:
		modulate = Color(0.2,0.2,0.2)


func _on_button_up():
	if unlocked:
		get_tree().change_scene_to_packed(target_scene)
