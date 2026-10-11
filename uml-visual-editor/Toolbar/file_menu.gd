# file_menu.gd
class_name FileMenu
extends ToolbarSlot


func setup() -> void:
	var popup := get_popup()
	popup.clear()


	popup.add_item("New Project")
	popup.add_item("Open Project...")
	popup.add_separator()

	popup.add_item("Save")
	popup.add_item("Save As...")
	popup.add_separator()

	popup.add_item("Recent Projects")
	popup.add_separator()

	popup.add_item("Exit")
