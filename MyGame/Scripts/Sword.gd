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

var current_attack: int = NONE

# 防止同一次挥刀重复命中同一个目标
var hit_targets: Array[Area2D] = []


# ATTACK1: 高伤害，无额外效果
# ATTACK2: 低伤害 + 击退
var attack_info = [
	null,

	Attack.new(
		50.0,
		[]
	),

	Attack.new(
		25.0,
		[
			KnockbackEffect.new(150.0 * 6)
		]
	)
]


func _ready() -> void:
	$AttackArea.monitoring = false


func setup(player_reference: Player) -> void:
	player = player_reference


func attack(index: int) -> bool:
	if index <= NONE or index >= attack_ready.size():
		return false

	if not attack_ready[index]:
		return false

	# 新的一次攻击开始时，清空已经命中过的目标
	hit_targets.clear()

	current_attack = index

	attack_ready[index] = false
	is_attacking[index] = true

	$AttackArea.monitoring = true

	return true


func _on_attack_area_area_entered(hitbox: Area2D) -> void:
	#print(hitbox)
	if current_attack == NONE:
		return
		
	if hitbox.is_in_group("enemy"):
		#print("Enemy Hit!")
		var target := hitbox.entity as Enemy

		if target == null:
			return

		var direction: Vector2 = (
			get_global_mouse_position() - 
			target.global_position
		).normalized()

		var context := AttackContext.new(
			player,
			target,
			direction,
			target.global_position
		)

		attack_info[current_attack].apply(context)
	elif hitbox.is_in_group("projectile_enemy"):
		deflect(hitbox)


func deflect(target: Area2D) -> void:
	target.add_to_group("projectile_friendly")
	target.remove_from_group("projectile_enemy")

	target.direction *= -1


func end_attack() -> void:
	if current_attack == NONE:
		return

	$AttackArea.monitoring = false

	var finished_attack := current_attack

	is_attacking[finished_attack] = false

	match finished_attack:
		ATTACK1:
			$Attack1_Timer.start()

		ATTACK2:
			$Attack2_Timer.start()

	current_attack = NONE


func _on_attack_1_timer_timeout() -> void:
	attack_ready[ATTACK1] = true


func _on_attack_2_timer_timeout() -> void:
	attack_ready[ATTACK2] = true
