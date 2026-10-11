# uml_class_node.gd

class_name UMLClassNode
extends GraphNode

#region : signals
signal selection_state_changed(
	node: UMLClassNode,
	selected: bool
)
#endregion

var model: UMLClass

@onready var class_name_label: Label = $MarginContainer/VBoxContainer/ClassNameLabel
@onready var properties_container: VBoxContainer = $MarginContainer/VBoxContainer/PropertiesMargin/PropertiesContainer
@onready var methods_container: VBoxContainer = $MarginContainer/VBoxContainer/MethodsMargin/MethodsContainer

func setup(class_model: UMLClass) -> void:
	model = class_model
	
	title = model.name
	position_offset = model.position

	#region : connect signals
	#region : signals from self (GraphNode)
	node_selected.connect(_on_selected)
	node_deselected.connect(_on_deselected)
	#endregion
	#region : signals from uml class
	model.property_added.connect(_on_property_added)
	model.property_removed.connect(_on_property_removed)
	model.property_changed.connect(_on_property_changed)

	model.method_added.connect(_on_method_added)
	model.method_removed.connect(_on_method_removed)
	model.method_changed.connect(_on_method_changed)
	#endregion
	#endregion
	
	refresh()


func refresh_properties() -> void:
	for child in properties_container.get_children():
		child.queue_free()

	for property in model.properties:
		var label := Label.new()
		label.text = "%s : %s" % [
			property.name,
			property.type
		]

		properties_container.add_child(label)

#region : refreshes data
func refresh() -> void:
	class_name_label.text = model.name

	refresh_properties()
	refresh_methods()

func refresh_methods() -> void:
	for child in methods_container.get_children():
		child.queue_free()

	for method in model.methods:
		var label := Label.new()
		label.text = "%s() : %s" % [
			method.name,
			method.return_type
		]

		methods_container.add_child(label)

func _on_property_added() -> void:
	refresh_properties()

func _on_property_removed() -> void:
	refresh_properties()

func _on_property_changed() -> void:
	refresh_properties()

func _on_method_added() -> void:
	refresh_methods()

func _on_method_removed() -> void: 
	refresh_methods()

func _on_method_changed() -> void:
	refresh_methods()

#endregion

#region : on signals received
func _on_selected() -> void:
	#print("Selected: %s %s" % [model.name, model.id])
	#_apply_selected_style()
	selection_state_changed.emit(self, true)


func _on_deselected() -> void:
	#print("Deselected: %s %s" % [model.name, model.id])
	#_apply_normal_style()
	selection_state_changed.emit(self, false)
#endregion 
