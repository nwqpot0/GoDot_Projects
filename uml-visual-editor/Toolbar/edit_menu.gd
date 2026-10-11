# edit_menu.gd
class_name EditMenu
extends ToolbarSlot


func setup() -> void:
	var popup := get_popup()
	popup.clear()


	popup.add_item("Undo")
	popup.add_item("Redo")
	popup.add_separator()

	popup.add_item("Cut")
	popup.add_item("Copy")
	popup.add_item("Paste")
	popup.add_item("Duplicate")
	popup.add_item("Delete")
	popup.add_separator()

	popup.add_item("Preferences...")
