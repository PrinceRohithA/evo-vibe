extends CharacterBody2D


const SPEED = 200.0
const RUN_SPEED = 300.0

var hit = 0
var direction = -1

var max_hit_angle = 145
var min_hit_angle = 35

var run_animation = false
var queue_free_b = false

var one = 0
var two = 0

func _on_collition_area_body_entered(body):
	
	if body.name == "main_character":
		var angle_between_player_angry_pig = rad_to_deg(Global.player_pos.angle_to_point(position))
		if angle_between_player_angry_pig >= 45 and angle_between_player_angry_pig <= 145:
			Global.angry_pig_get_hit = true
			hit += 1
		if angle_between_player_angry_pig <= 45 or angle_between_player_angry_pig >=145:
			Global.respawn = true

func _on_wall_body_entered(body):
	
	if body.name == "TileMap":
		if direction == 1:
			direction = -1
		elif direction == -1: 
			direction = 1

func _on_wall_2_body_entered(body):
	
	if body.name == "TileMap":
		if direction == 1:
			direction = -1
		elif direction == -1:
			direction = 1

func _physics_process(_delta):
	
	if hit == 1:
		velocity.x = direction * RUN_SPEED
	else:
		velocity.x = direction * SPEED
	
	if hit == 2:
		if two == 0:
			$Timer.start()
			$AnimatedSprite2D.animation = "hit2"
			two += 1
		if queue_free_b:
			queue_free()
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	
	if hit == 0:
		$AnimatedSprite2D.animation = "walk"
	
	if hit == 1:
		if one == 0:
			$Timer.start()
			$AnimatedSprite2D.animation = "hit1"
			one += 1
		if run_animation:
			$AnimatedSprite2D.animation = "run"
	
	move_and_slide()

func _on_timer_timeout():
	if hit == 1:
		run_animation = true
	if hit == 2:
		queue_free_b = true
