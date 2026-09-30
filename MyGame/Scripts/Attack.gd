class_name Attack
extends Resource

var damage: float
var effect: AttackEffect

func _init(p_damage: float, p_effect: AttackEffect = null):
	damage = p_damage
	effect = p_effect
