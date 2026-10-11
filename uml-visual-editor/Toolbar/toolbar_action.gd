# toolbar_action.gd
class_name ToolbarAction
extends RefCounted


enum Type {
	NEW_PROJECT,
	OPEN_PROJECT,
	SAVE,
	SAVE_AS,

	UNDO,
	REDO,
	DELETE,

	ADD_CLASS,
	ADD_RELATIONSHIP,

	SHOW_PROJECT_PANEL,
	SHOW_INSPECTOR,
	SHOW_GRID
}
