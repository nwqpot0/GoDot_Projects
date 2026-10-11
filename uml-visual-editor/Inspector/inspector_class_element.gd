# inspector_class_element.gd
class_name InspectorClassElement
extends VBoxContainer

signal action_requested(action: InspectorElementAction)

var model: UMLClass


@onready var name_edit: TextEdit = $"Name Section/NameEdit"

@onready var properties_container: VBoxContainer = $"Properies Section/PropertiesContainer"

@onready var add_properties_button: Button = $"Properies Section/AddProperties Button"

@onready var methods_container: VBoxContainer = $"Methods Section/MethodsContainer"

@onready var add_methods_button: Button = $"Methods Section/AddMethods Button"



func setup(uml_class: UMLClass) -> void:
	model = uml_class

	_refresh_name()
	_refresh_properties()
	_refresh_methods()
#
	#_bind_model_signals()


#func _bind_model_signals() -> void:
	#if not model.name_changed.is_connected(_on_name_changed):
		#model.name_changed.connect(_on_name_changed)
#
	#if not model.property_added.is_connected(_on_property_changed):
		#model.property_added.connect(_on_property_changed)
#
	#if not model.property_removed.is_connected(_on_property_removed):
		#model.property_removed.connect(_on_property_removed)
#
	#if not model.property_changed.is_connected(_on_property_changed):
		#model.property_changed.connect(_on_property_changed)
#
	#if not model.method_added.is_connected(_on_method_changed):
		#model.method_added.connect(_on_method_changed)
#
	#if not model.method_removed.is_connected(_on_method_removed):
		#model.method_removed.connect(_on_method_removed)
#
	#if not model.method_changed.is_connected(_on_method_changed):
		#model.method_changed.connect(_on_method_changed)
#
#
#func _ready() -> void:
	#name_edit.text_submitted.connect(_on_name_submitted)
	#name_edit.focus_exited.connect(_on_name_focus_exited)
#
	#add_property_button.pressed.connect(_on_add_property_pressed)
	#add_method_button.pressed.connect(_on_add_method_pressed)
#

#region name related actions

func _refresh_name() -> void:
	name_edit.text = model.name
#
#
#func _on_name_submitted(new_name: String) -> void:
	#_try_rename(new_name)
#
#
#func _on_name_focus_exited() -> void:
	#_try_rename(name_edit.text)
#
#
#func _try_rename(new_name: String) -> void:
	#if model == null:
		#return
#
	#var success := model.rename(new_name)
#
	#if not success:
		#name_edit.text = model.name
#
#
#func _on_name_changed(new_name: String) -> void:
	#name_edit.text = new_name

#endregion

#region property related actions
func _refresh_properties():
	pass
#endregion

#region method related actions
func _refresh_methods():
	pass
