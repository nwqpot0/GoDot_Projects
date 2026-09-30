class_name AttackContext
extends RefCounted

var attacker: Node
var target: Node
var direction: Vector2
var hit_position: Vector2

func _init(
	p_attacker: Node,
	p_target: Node,
	p_direction: Vector2,
	p_hit_position: Vector2
) -> void:
	attacker = p_attacker
	target = p_target
	direction = p_direction
	hit_position = p_hit_position
