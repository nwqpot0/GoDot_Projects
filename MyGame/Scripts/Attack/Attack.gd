class_name Attack
extends Resource

var damage: float
var effects: Array[AttackEffect] = []

func _init(p_damage: float, p_effects: Array[AttackEffect] = []):
	damage = p_damage
	effects = p_effects

func apply(context: AttackContext) -> void:
	context.target.take_damage(damage)

	for effect in effects:
		effect.apply(context)
