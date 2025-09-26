extends Node2D

@onready var camera: Camera2D = $"../Camera2D"
@onready var top_wall: StaticBody2D = $TopWall
@onready var bottom_wall: StaticBody2D = $BottomWall

func _physics_process(_delta: float) -> void:
	var rect = get_viewport_rect()
	var world_size = rect.size * camera.zoom
	var half_h = world_size.y / 2.0
	
	var cam_pos = camera.global_position

	top_wall.global_position.y = cam_pos.y - half_h
	bottom_wall.global_position.y = cam_pos.y + half_h
