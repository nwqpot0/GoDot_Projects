class_name ProjectSession
extends Node

signal project_issues_changed(issues: Array[ProjectIssue])
signal class_added(uml_class: UMLClass)

var project: UMLProject
var edit_manager: ProjectManager 
var issue_manager: ProjectIssueManager
var validator: ProjectValidator
var session_id: String

func _init(_project: UMLProject,) -> void:
	session_id = _generate_session_id()
	project = _project
	
	edit_manager = ProjectManager.new(_project)
	issue_manager = ProjectIssueManager.new()
	validator = ProjectValidator.new()
	
	# connect to signals
	issue_manager.project_issues_changed.connect(_on_project_issues_changed)
	edit_manager.class_added.connect(_on_class_added)
	
func _generate_session_id() -> String:
	return "session_%s_%s" % [
		str(Time.get_ticks_usec()),
		str(randi())
	]

func getProject():
	return project
	
# ==================================
# Signals
# ==================================

func _on_project_issues_changed(issues: Array[ProjectIssue]):
	project_issues_changed.emit(issues)

func _on_class_added(uml_class: UMLClass):
	class_added.emit(uml_class)

# ==================================
# API to ProjectManager
# ==================================
func add_class(uml_class: UMLClass) -> ProjectManagerActionResult:
	var result : ProjectManagerActionResult = edit_manager.add_class(uml_class)
	validate_project()
	return result

# ==================================
# API to IssueManager
# ==================================
func set_issues(issues: Array[ProjectIssue]):
	issue_manager.set_issues(issues)
	
func add_issue(issue: ProjectIssue) -> void:
	issue_manager.add_issue(issue)

func add_issues(issues: Array[ProjectIssue]) -> void:
	issue_manager.add_issues(issues)

# remove object reference
func remove_issue(issue: ProjectIssue) -> void:
	issue_manager.remove_issue(issue)

func remove_issues(issues: Array[ProjectIssue]) -> void:
	issue_manager.remove_issues(issues)

func clear_issues() -> void:
	issue_manager.clear_issues()

func get_issues() -> Array[ProjectIssue]:
	return issue_manager.get_issues()

# ==================================
# API to ProjectValidator
# ==================================

func validate_project() -> Array[ProjectIssue]:
	var issues: Array[ProjectIssue] = validator.validate(project)
	set_issues(issues)
	return issues
