# toolbar.gd
# Responsible for setup + monitor signals from children slots and propagate them
extends HBoxContainer


signal action_requested(action: ToolbarAction.Type)

func _ready() -> void:
	for child in get_children():
		if child is ToolbarSlot:
			_setup_slot(child)

func _setup_slot(slot: ToolbarSlot) -> void:
	slot.setup()

	slot.action_requested.connect(
		_on_slot_action_requested
	)

func _on_slot_action_requested(
	action: ToolbarAction.Type
) -> void:
	action_requested.emit(action)
