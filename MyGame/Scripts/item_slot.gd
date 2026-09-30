extends Panel


@onready var normal_style = preload("res://tres/item_slot_normal.tres")
@onready var highlight_style = preload("res://tres/item_slot_highlight.tres")
@export var item_scene : PackedScene

var selected := false

func set_selected(value: bool):
	selected = value
	
	if selected:
		add_theme_stylebox_override("panel", highlight_style)
	else:
		add_theme_stylebox_override("panel", normal_style)
