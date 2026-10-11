# uml_relationship.gd
class_name UMLRelationship
extends RefCounted

enum Type {
	DEPENDENCY,
	ASSOCIATION,
	INHERITANCE
}

var id: String
var from_id: String
var to_id: String
var type: Type


func _init(
	from_id_: String,
	to_id_: String,
	type_: Type
) -> void:
	id = str(ResourceUID.create_id())
	from_id = from_id_
	to_id = to_id_
	type = type_
