# uml_class.gd
class_name UMLClass
extends RefCounted

signal property_added(property: UMLProperty)
signal property_removed(property_id: String)
signal property_changed(property: UMLProperty)

signal method_added(method: UMLMethod)
signal method_removed(method_id: String)
signal method_changed(method: UMLMethod)

var id: String
var name: String

var position: Vector2

var properties: Array[UMLProperty] = []
var methods: Array[UMLMethod] = []


func _init(
	class_name_: String = "NewClass",
	position_: Vector2 = Vector2.ZERO
) -> void:
	id = str(ResourceUID.create_id())
	name = class_name_
	position = position_

func add_property(property: UMLProperty) -> bool:
	if property == null:
		return false

	properties.append(property)
	property_added.emit(property)

	return true
	
func remove_property(property_id: String) -> bool:
	for property in properties:
		if property.id == property_id:
			properties.erase(property)
			property_removed.emit(property_id)
			return true

	return false
	
func update_property(
	property_id: String,
	new_name: String,
	new_type: String
) -> bool:
	for property in properties:
		if property.id == property_id:
			property.name = new_name
			property.type = new_type

			property_changed.emit(property)
			return true

	return false

func add_method(method: UMLMethod) -> bool:
	if method == null:
		return false

	methods.append(method)
	method_added.emit(method)
	return true

func remove_method(method_id: String) -> bool:
	for method in methods:
		if method.id == method_id:
			methods.erase(method)
			method_removed.emit(method_id)
			return true

	return false

func update_method(
	method_id: String,
	new_name: String,
	new_return_type: String
) -> bool:
	for method in methods:
		if method.id == method_id:
			method.name = new_name
			method.return_type = new_return_type

			method_changed.emit(method)
			return true

	return false
