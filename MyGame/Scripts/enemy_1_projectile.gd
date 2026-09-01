extends Area2D

# 飞向玩家当前位置

@export var speed := 200.0
@export var lifetime := 6
var direction := Vector2(0, 0)
var map

func _ready():
	await get_tree().create_timer(lifetime + randf_range(-1.5, 1.5)).timeout
	queue_free()

func setup(map_reference):
	map = map_reference

func _process(delta):
	global_position += direction * speed * delta
	rotation = direction.angle()

func _on_body_entered(body: Node2D) -> void:
	var player := body as Player
	if (player != null && is_in_group("projectile_enemy")):
		#print("Hits Player!")
		player.take_damage(40)
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	var enemy := area as Enemy
	print(area.name, ' ', area.get_groups())
	if (enemy != null && is_in_group("projectile_friendly")):
		enemy.take_damage(30)
		queue_free()
