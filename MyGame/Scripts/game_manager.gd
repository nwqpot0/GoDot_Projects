extends Node

# 游戏开始时间
var game_time: float
var enemies_killed: int
@onready var player: Player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.PLAYER_DIED.connect(_on_player_died)
	game_time = 0
	enemies_killed = 0

func _process(delta):
	game_time += delta
	
func get_game_time() -> float:
	return game_time

func _on_player_died() -> void:
	get_tree().quit()
	
