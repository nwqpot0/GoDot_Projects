extends Area2D

class_name Enemy

@export var projectile_scene: PackedScene
#@export var lifetime := 2
@export var health := 30.0
@export var speed := 80.0
var is_attacking := false
var player
var map

func setup(player_reference, map_reference):
	player = player_reference
	map = map_reference

func shoot():
	var projectile = projectile_scene.instantiate()
	projectile.setup(map)
	projectile.global_position = global_position
	# 确保Player已经存在了
	# var player = get_tree().current_scene.get_node("Player")
	# 确保Player被加入到了Player分组里
	projectile.direction = global_position.direction_to(player.global_position)
	get_tree().current_scene.add_child(projectile)
	
func _on_shoot_timer_timeout():
	$AnimatedSprite2D.play("Attack")
	is_attacking = true
	await $AnimatedSprite2D.animation_finished
	is_attacking = false
	shoot()

func _process(delta: float):
	if (is_attacking):
		return 
	var direction = global_position.direction_to(player.global_position)
	$AnimatedSprite2D.animation = "Run"
	$AnimatedSprite2D.flip_h = direction.x < 0
	global_position += direction * speed * delta

#func _ready():
	#print("enemy spawned\n")
	#await get_tree().create_timer(lifetime).timeout
	#queue_free()

func take_damage(damage := 10.0):
	health -= damage
	print("Health remaining: ", health)
	if (health <= 0):
		queue_free()
	
#func _on_body_entered(body: Node2D) -> void:
	#print(body.name)
	#if (body is Player):
		##print("Enemy Touched Player!")
		#body.take_damage(10)
		#
