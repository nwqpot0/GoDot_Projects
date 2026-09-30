class_name KnockbackEffect
extends AttackEffect

var distance: float
var direction: Vector2

func _init(p_distance: float):
	distance = p_distance

func set_normalized_direction(p_dir : Vector2):
	direction = p_dir.normalized()

func apply(target: Node) -> void:
	#target.knockback(distance)
	target.global_position += direction * distance
