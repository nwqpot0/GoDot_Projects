class_name KnockbackEffect
extends AttackEffect

var force: float


func _init(p_force: float) -> void:
	force = p_force

func apply(context: AttackContext) -> void:
	context.target.knockback(
		context.direction,
		force
	)
