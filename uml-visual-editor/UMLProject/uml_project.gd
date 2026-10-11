# uml_project.gd
class_name UMLProject
extends RefCounted

var uml_classes: Array[UMLClass] = []
var relationships: Array[UMLRelationship] = []
var naming_pattern : RegEx = null
signal class_added(newUMLClass: UMLClass)

#region project class related

func valid_name(name: String) -> bool:
	if naming_pattern == null:
		naming_pattern = RegEx.new()
		naming_pattern.compile("^[_a-zA-Z][_a-zA-Z0-9]*$")
	# keyword检测 - factory design pattern -> 根据导出的语言决定是否是keyword
	return naming_pattern.search(name) != null
	
func has_class_id(class_id: String) -> bool:
	return uml_classes.any(
		func(uml_class: UMLClass) -> bool:
			return uml_class.id == class_id
	)

func has_class_name(name: String) -> bool:
	return uml_classes.any(
		func(uml_class: UMLClass) -> bool:
			return uml_class.name == name
	)

func add_class(uml_class: UMLClass) -> void:
	uml_classes.append(uml_class)
	class_added.emit(uml_class)
#endregion

func remove_class(uml_class: UMLClass) -> void:
	uml_classes.erase(uml_class)


func add_relationship(relationship: UMLRelationship) -> void:
	relationships.append(relationship)


func remove_relationship(relationship: UMLRelationship) -> void:
	relationships.erase(relationship)
