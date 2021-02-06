extends Area2D

signal position_changed(pos)

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var sprite: Sprite = $Sprite


func _ready() -> void:
	sprite.modulate.a = 0
	assert(connect("body_entered", self, "_on_body_entered") == OK)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		anim_player.play("fade_in")


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
		emit_signal("position_changed", global_position)


func _on_body_entered(_body: PhysicsBody2D) -> void:
	anim_player.play("fade_out")
