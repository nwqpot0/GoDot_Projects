extends Node2D

@onready var player := $Player
@onready var map := $Background
@onready var hud = $HUD
@onready var enemy_spawner := $EnemySpawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hud.setup(player)
	enemy_spawner.setup(player, map)
	player.position = map.size / 2
	# Set Cursor
	setup_cursor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup_cursor():
	Input.set_custom_mouse_cursor(
		load("res://Assets/Tiny Swords/Cursors/Cursor_02.png")
	)
