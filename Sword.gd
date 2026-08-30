class_name Sword
extends Node2D

var player: Player
var attack_ready = [true, true]

func attack(index: int):
	if (not attack_ready[index - 1]):
		return 
	# 这个武器(这样的攻击方式)攻击结束后进入冷却
	attack_ready[index - 1] = false
	get_child(index - 1).start()

	#print("Sword attack ", index, "!")
	# 进行攻击判定
	$AttackArea.monitoring = true
	
func end_attack():
	$AttackArea.monitoring = false

func setup(player_reference):
	player = player_reference
	print(player)

func _on_attack_1_timer_timeout() -> void:
	#print("Attack 1 Cooldown Terminated!")
	attack_ready[0] = true

func _on_attack_2_timer_timeout() -> void:
	#print("Attack 2 Cooldown Terminated!")
	attack_ready[1] = true

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		print("Hit enemy: ", area)	
