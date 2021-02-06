extends Node2D

onready var arrive_to_agents = $ArriveToAgents
onready var target = $Target


func _ready() -> void:
	for agent in arrive_to_agents.get_children():
		target.connect("position_changed", agent, "_on_target_position_changed")
