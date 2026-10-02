extends Control

# 在 Inspector 中选择点击“开始游戏”后进入的场景。
@export_file("*.tscn") var start_scene_path: String

@onready var start_button: Button = $CenterContainer/VBoxContainer/StartButton
@onready var quit_button: Button = $CenterContainer/VBoxContainer/QuitButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

	start_button.grab_focus()


func _on_start_pressed() -> void:
	print("start pressed!")
	if start_scene_path.is_empty():
		push_warning("请先设置 Start Scene Path。")
		return

	var error := get_tree().change_scene_to_file(start_scene_path)

	if error != OK:
		push_error("无法打开场景：%s" % start_scene_path)


func _on_quit_pressed() -> void:
	print("quit pressed")
	get_tree().quit()
