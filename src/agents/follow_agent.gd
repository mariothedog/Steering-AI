extends KinematicBody2D

const DISTANCE_THESHOLD := 3.0

export var max_speed := 500.0

onready var sprite: Sprite = $Sprite

var _velocity := Vector2.ZERO


func _physics_process(_delta: float) -> void:
	var target_global_pos := get_global_mouse_position()
	
	if global_position.distance_to(target_global_pos) <= DISTANCE_THESHOLD:
		return
	
	_velocity = Steering.follow(
		_velocity,
		global_position,
		target_global_pos,
		max_speed
	)
	
	_velocity = move_and_slide(_velocity)
	
	sprite.rotation = _velocity.angle()
