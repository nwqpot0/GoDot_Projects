class_name UMLMethod
extends RefCounted

var id: String
var name: String
var return_type: String


func _init(
	name_: String = "method",
	return_type_: String = "void"
) -> void:
	id = str(ResourceUID.create_id())
	name = name_
	return_type = return_type_
