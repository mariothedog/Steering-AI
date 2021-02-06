extends KinematicBody2D

const ARRIVE_THESHOLD := 3.0

export var max_speed := 500.0
export var target_path: NodePath
export var follow_offset := 150.0

onready var sprite: Sprite = $Sprite
onready var target: Node2D = get_node(target_path)

var _velocity := Vector2.ZERO


func _ready() -> void:
	if not target or target == self:
		set_physics_process(false)


func _physics_process(_delta: float) -> void:
	var target_global_pos := target.global_position
	
	var dist_to_target := global_position.distance_to(target_global_pos)
	if dist_to_target <= ARRIVE_THESHOLD:
		return
	
	var follow_offset_vec := target_global_pos.direction_to(global_position) * follow_offset
	var follow_global_position: Vector2
	if dist_to_target > follow_offset:
		follow_global_position = target_global_pos + follow_offset_vec
	else:
		follow_global_position = global_position
	
	_velocity = Steering.arrive_to(
		_velocity,
		global_position,
		follow_global_position,
		max_speed
	)
	_velocity = move_and_slide(_velocity)
	sprite.rotation = _velocity.angle()
