extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0
const TRAMPOLIN_VELOCITY = -1500.0
const FAN_VELOCITY = -700.0

var direction = 0
var direction1 = 0

var pos : Vector2i

@onready var sprite_2d = $AnimatedSprite2D

var gravity = 2500.0

func _physics_process(delta):
	if velocity.x > 1 or velocity.x < -1:
		sprite_2d.animation = "running"
	elif not(velocity.x > 1 or velocity.x < -1):
		sprite_2d.animation = "default"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y < 0:
			sprite_2d.animation = "jumping"
		if velocity.y > 0:
			sprite_2d.animation = "falling"

	# Handle jump.
	if (Input.is_action_just_pressed("ui_accept") and is_on_floor()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
	
	if Global.mobile_left:
		direction1 = -1
	elif Global.mobile_right:
		direction1 = 1
	else:
		direction1 = 0
	
	if direction1:
		velocity.x = direction1 * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
	
	if Global.mobile_jump and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	move_and_slide()
	
	#position
	pos = position
	Global.player_pos = pos
	
	var is_left = velocity.x < 0
	var is_right = velocity.x > 0
	if is_left:
		sprite_2d.flip_h = true
	elif is_right:
		sprite_2d.flip_h = false
	
	#tranpolin
	if Global.trampolin_collition:
		velocity.y = TRAMPOLIN_VELOCITY
		Global.trampolin_collition = false
	
	#fan
	if Global.on_fan_range and Global.fan_on:
		velocity.y = FAN_VELOCITY
	
	#angry pig
	if Global.angry_pig_get_hit:
		velocity.y = JUMP_VELOCITY
		Global.angry_pig_get_hit = false
	
	#respawn
	
	if Global.save_respawn:
		Global.respawn_pos = pos
		Global.save_respawn = false
	
	if Global.respawn:
		position = Global.respawn_pos
		Global.respawn = false
