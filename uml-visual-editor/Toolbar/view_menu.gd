# view_menu.gd
class_name ViewMenu
extends ToolbarSlot


func setup() -> void:
	var popup := get_popup()
	popup.clear()


	popup.add_item("Zoom In")
	popup.add_item("Zoom Out")
	popup.add_item("Reset Zoom")
	popup.add_separator()

	popup.add_check_item("Show Project Panel")
	popup.add_check_item("Show Inspector")
	popup.add_separator()

	popup.add_check_item("Show Grid")
	popup.add_check_item("Snap to Grid")
