extends KinematicBody2D

const DISTANCE_THESHOLD := 3.0

export var max_speed := 500.0
export var slow_radius := 200.0

onready var sprite: Sprite = $Sprite

var _velocity := Vector2.ZERO
var _target_global_pos := Vector2.ZERO


func _physics_process(_delta: float) -> void:
	if global_position.distance_to(_target_global_pos) <= DISTANCE_THESHOLD:
		set_physics_process(false)
		return
	
	_velocity = Steering.arrive_to(
		_velocity,
		global_position,
		_target_global_pos,
		max_speed,
		slow_radius
	)
	
	_velocity = move_and_slide(_velocity)
	
	sprite.rotation = _velocity.angle()


func _on_target_position_changed(pos: Vector2) -> void:
	_target_global_pos = pos
	set_physics_process(true)
