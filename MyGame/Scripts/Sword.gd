class_name Sword
extends Node2D

var player: Player

enum {
	NONE,
	ATTACK1,
	ATTACK2
}

var attack_ready := [false, true, true]
var is_attacking := [false, false, false]
var attack_info := [null, null, null]

var current_attack = NONE


func _ready() -> void:
	attack_info = [
		null,
		Attack.new(50.0),
		Attack.new(
			25.0,
			KnockbackEffect.new(150.0)
		)
	]

	$AttackArea.monitoring = false


func attack(index: int) -> bool:
	if not attack_ready[index]:
		return false

	current_attack = index
	attack_ready[index] = false
	is_attacking[index] = true

	$AttackArea.monitoring = true

	return true


func _on_attack_area_area_entered(target: Area2D) -> void:
	if current_attack == NONE:
		return

	if target.is_in_group("enemy"):

		if current_attack == ATTACK2:
			attack_info[current_attack].effect.set_normalized_direction(
				get_global_mouse_position() - global_position
			)

		target.take_damage(
			attack_info[current_attack]
		)

	elif (
		target.is_in_group("projectile_enemy")
		and current_attack == ATTACK1
	):
		deflect(target)


func deflect(target):
	target.add_to_group("projectile_friendly")
	target.remove_from_group("projectile_enemy")
	target.direction *= -1


func end_attack():
	if current_attack == NONE:
		return

	$AttackArea.monitoring = false

	var finished_attack = current_attack

	is_attacking[finished_attack] = false

	# ATTACK1 = 1 → child 0
	# ATTACK2 = 2 → child 1
	match finished_attack:
		ATTACK1:
			$Attack1_Timer.start()
		ATTACK2:
			$Attack2_Timer.start()

	current_attack = NONE


func setup(player_reference):
	player = player_reference


func _on_attack_1_timer_timeout() -> void:
	attack_ready[ATTACK1] = true


func _on_attack_2_timer_timeout() -> void:
	attack_ready[ATTACK2] = true
