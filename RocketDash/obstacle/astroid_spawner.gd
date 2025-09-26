extends Node2D

@export var asteroid_scene: PackedScene
@export var spawn_interval := 1.0 
@onready var camera: Camera2D = $"../Camera2D"
@onready var timer: Timer = $Timer

func _ready() -> void:
	var t := Timer.new()
	t.wait_time = spawn_interval
	t.autostart = true
	t.one_shot = false
	add_child(t)
	t.timeout.connect(_spawn_asteroid)

func _spawn_asteroid() -> void:
	var asteroid = asteroid_scene.instantiate()
	var rocket = get_parent().get_node("Rocket")
	asteroid.position.x = rocket.position.x + 1500
	asteroid.position.y = randf_range(-325.0 / 2.0, 325.0 / 2.0)
	add_child(asteroid)

func _on_timer_timeout() -> void:
	if spawn_interval >= 0.4:
		spawn_interval -= 0.1
