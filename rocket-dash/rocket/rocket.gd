extends CharacterBody2D

const MAX_VERTICAL_SPEED := 200.0
const MAX_X_SPEED       := 150.0
const DASH_X_SPEED      := 500.0
const DASH_TIME         := 0.3
const VERTICAL_ACCEL    := 1200.0
const VERTICAL_DECEL    := 800.0
const HORIZONTAL_DECEL  := 1000.0  

@onready var dash_timer: Timer = $DashTimer  
@onready var camera_2d: Camera2D = $"../Camera2D"

var target_vspeed := 0.0
var dash_active := false

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		target_vspeed = -MAX_VERTICAL_SPEED
	elif Input.is_action_pressed("ui_down"):
		target_vspeed =  MAX_VERTICAL_SPEED
	else:
		target_vspeed = 0.0

	if abs(target_vspeed - velocity.y) < 1.0:
		velocity.y = target_vspeed
	elif target_vspeed == 0.0:
		velocity.y = move_toward(velocity.y, 0.0, VERTICAL_DECEL * delta)
	else:
		velocity.y = move_toward(velocity.y, target_vspeed, VERTICAL_ACCEL * delta)

	if Input.is_action_just_pressed("ui_accept") and !dash_active:
		start_dash()

	if Input.is_action_just_released("ui_accept") and dash_active:
		stop_dash()

	if dash_active:
		velocity.x = DASH_X_SPEED
	else:
		velocity.x = move_toward(velocity.x, MAX_X_SPEED, HORIZONTAL_DECEL * delta)
		
	move_and_slide()
	
	var min_y := -160.0
	var max_y :=  160.0
	position.y = clamp(position.y, min_y, max_y)
	
	Global.isboost = dash_active

func start_dash() -> void:
	dash_active = true
	dash_timer.start(DASH_TIME)

func stop_dash() -> void:
	dash_active = false
	if !dash_timer.is_stopped():
		dash_timer.stop()

func _on_DashTimer_timeout() -> void:
	stop_dash()
