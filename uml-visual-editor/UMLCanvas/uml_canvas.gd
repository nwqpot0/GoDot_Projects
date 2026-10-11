# uml_canvas.gd
class_name UMLCanvas
extends GraphEdit

signal selection_changed(selected_classes: Array[UMLClass])

@export var uml_class_scene: PackedScene
var selected_classes: Array[UMLClass] = []


func get_view_center() -> Vector2:
	return scroll_offset + size / (2.0 * zoom)

# 全量更新
func bind_project(project: UMLProject) -> void:
	project.class_added.connect(_on_class_added)

func _on_class_added(uml_class: UMLClass) -> void:
	#print("New class added with name %s and id %s\n" % [uml_class.name, uml_class.id])
	var node: UMLClassNode = uml_class_scene.instantiate()
	add_child(node)
	node.setup(uml_class)
	
	node.selection_state_changed.connect(
		_on_class_selection_state_changed
	)

func _on_class_selection_state_changed(
	node: UMLClassNode,
	is_selected: bool
) -> void:
	refresh_selection()
	
func refresh_selection() -> void:
	var selected_models: Array[UMLClass] = []

	for child in get_children():
		if child is UMLClassNode and child.selected:
			selected_models.append(child.model)
			#print(child.model.id)
	
	selection_changed.emit(selected_models)
