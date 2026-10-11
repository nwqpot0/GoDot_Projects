class_name UMLProperty
extends RefCounted

var id: String
var name: String
var type: String


func _init(
	name_: String = "property",
	type_: String = "Variant"
) -> void:
	id = str(ResourceUID.create_id())
	name = name_
	type = type_
