# ProjectEditManager
# “怎么请求改变状态？”
class_name ProjectManager
extends RefCounted

signal class_added(newUMLClass: UMLClass)

var project: UMLProject

enum ManagerAction{
	ADD_CLASS,
	ADD_PROPERTY,
	UPD_PROPERTY,
	DEL_PROPERTY,
	ADD_METHOD,
	UPD_METHOD,
	DEL_METHOD
}

func get_current_project():
	return project

func _init(p_project: UMLProject) -> void:
	project = p_project

# class cannot be null
# class cannot have an empty name
# class should have unique id
func add_class(uml_class: UMLClass) -> ProjectManagerActionResult:
	if uml_class == null:
		return ProjectManagerActionResult.failed("class is null")
	if uml_class.name.is_empty():
		return ProjectManagerActionResult.failed("class name cannnot be empty")
	if project.has_class_id(uml_class.id):
		return ProjectManagerActionResult.failed("class id exists")
	if not project.valid_name(uml_class.name):
		return ProjectManagerActionResult.failed("invalid class name")
		
	project.add_class(uml_class)
	class_added.emit(uml_class)
	return ProjectManagerActionResult.ok(uml_class, "class added")
