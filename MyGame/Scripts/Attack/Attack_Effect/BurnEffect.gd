class_name BurnEffect
extends AttackEffect

var damage_per_tick: float
var duration: float

func _init(p_damage_per_tick: float, p_duration: float):
	damage_per_tick = p_damage_per_tick
	duration = p_duration

func apply(target: Node) -> void:
	#target.apply_burn(damage_per_tick, duration)
	pass
