class_name UMLInspector
extends PanelContainer

@onready var inspector_elements: VBoxContainer = $MarginContainer/VBoxContainer/InspectorElements
@export var inspector_class_scene: PackedScene

signal action_requested(action: InspectorElementAction)

func _ready():
	show_empty_state()

func set_selection(classes: Array[UMLClass]) -> void:
	clear()

	if classes.is_empty():
		show_empty_state()
	elif classes.size() == 1:
		show_class(classes[0])
	else:
		show_multiple_selection(classes)


func clear() -> void:
	for child in inspector_elements.get_children():
		child.queue_free()

#region inspector layout related

func show_empty_state() -> void:
	var label := Label.new()
	label.text = "No object selected"
	inspector_elements.add_child(label)


func show_class(uml_class: UMLClass) -> void:
	var element: InspectorClassElement = inspector_class_scene.instantiate()

	inspector_elements.add_child(element)

	element.setup(uml_class)

	element.action_requested.connect(
		_on_inspector_action_requested
	)


func show_multiple_selection(uml_classes: Array[UMLClass]) -> void:
	var label := Label.new()
	label.text = "%d classes selected" % uml_classes.size()
	inspector_elements.add_child(label)
#endregion

# 将子控件的信号传播给main
func _on_inspector_action_requested(action: InspectorElementAction):
	action_requested.emit(action)
