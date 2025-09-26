extends Node2D

@export var obstacle_scene: PackedScene         
@export var spawn_interval: float = 0.6
@export var max_obstacles: int = 20
@export var spawn_distance_x: float = 1500.0    
@export var spawn_band_y: float = 325.0 / 2.0   
@export var cleanup_distance: float = 2000.0    

@onready var spawn_timer: Timer = $Timer
@onready var player: Node2D = $"../Rocket"     

var active_obstacles := []

func _ready() -> void:
	spawn_timer.wait_time = spawn_interval
	spawn_timer.timeout.connect(_on_SpawnTimer_timeout)
	spawn_timer.start()

func _on_SpawnTimer_timeout() -> void:
	if active_obstacles.size() >= max_obstacles:
		return
	
	var obs := obstacle_scene.instantiate()
	add_child(obs)
	
	obs.position.x = player.position.x + spawn_distance_x
	obs.position.y = randf_range(-spawn_band_y, spawn_band_y)

	active_obstacles.append(obs)
	
	var gm = get_node("/root/Global")
	gm.connect_obstacle(obs)

func _process(_delta: float) -> void:
	for obs in active_obstacles.duplicate():
		if not is_instance_valid(obs):
			active_obstacles.erase(obs)
			continue

		if obs.position.x < player.position.x - cleanup_distance:
			obs.queue_free()
			active_obstacles.erase(obs)
	
