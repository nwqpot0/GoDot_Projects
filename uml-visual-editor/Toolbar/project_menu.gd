# project_menu.gd
class_name ProjectMenu
extends ToolbarSlot

enum Item {
	ADD_CLASS,
	ADD_RELATIONSHIP,
	PROJECT_SETTINGS,
	VALIDATE_PROJECT,
	GENERATE
}

func setup() -> void:
	var popup := get_popup()

	popup.add_item("Add Class", Item.ADD_CLASS)
	popup.add_item("Add Relationship", Item.ADD_RELATIONSHIP)
	popup.add_separator()

	popup.add_item("Project Settings...", Item.PROJECT_SETTINGS)
	popup.add_item("Validate Project", Item.VALIDATE_PROJECT)
	popup.add_separator()

	popup.add_item("Generate...", Item.GENERATE)
	
	if not popup.id_pressed.is_connected(_on_id_pressed):
		popup.id_pressed.connect(_on_id_pressed)
		
func _on_id_pressed(id: int) -> void:
	match id:
		Item.ADD_CLASS:
			action_requested.emit(
				ToolbarAction.Type.ADD_CLASS
			)

		Item.ADD_RELATIONSHIP:
			action_requested.emit(
				ToolbarAction.Type.ADD_RELATIONSHIP
			)
