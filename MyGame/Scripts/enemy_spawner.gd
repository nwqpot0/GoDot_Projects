extends Node2D

@export var enemy_scene: PackedScene
@export var margin := 100.0
@export var spawn_rate_multiplier: float = 0.3
var player
var enemy
var map

var enemy_spawned := 0

func setup(player_reference, map_reference):
	player = player_reference
	map = map_reference

func _ready():
	spawn_loop()

func spawn_enemy():
	enemy = enemy_scene.instantiate()
	enemy.setup(player, map)
	get_node("../Enemies").add_child(enemy)
	
	var map_size = map.size
	var x = randf_range(0, map_size.x)
	var y : float
	#确保生成于边缘
	if (margin < x && x + margin < map_size.x):
		if (randf_range(0, 1) < 0.5):
			y = randf_range(0, margin)
		else:
			y = randf_range(map_size.y - margin, map_size.y)
	else:
		y = randf_range(0, map_size.y)
	enemy.global_position = Vector2(x, y)
	
func get_spawn_rate() -> float:
	var game_manager = get_parent().get_node("GameManager")
	var game_time = game_manager.get_game_time()
	return 0.25 + log(game_time + 1) * spawn_rate_multiplier
	
func spawn_loop():
	while true:
		var spawn_rate = get_spawn_rate()
		var wait_time = -log(randf()) / spawn_rate
		
		#var game_manager = get_parent().get_node("GameManager")
		#print("game time = ", game_manager.get_game_time())
		#print("spawn_rate = ", spawn_rate)
		#print("wait_time = ", wait_time)
		#print('\n')
		
		await get_tree().create_timer(wait_time).timeout
		spawn_enemy()
		enemy_spawned += 1
		#print("enemy_spawned = ", enemy_spawned)
		#print("game time = ", game_manager.get_game_time())
		#print('\n')
	
