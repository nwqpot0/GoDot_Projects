class_name ProjectIssueManager
extends Node

signal project_issues_changed(issues: Array[ProjectIssue])

var current_issues: Array[ProjectIssue] = []

func set_issues(issues: Array[ProjectIssue]) -> void:
	current_issues = issues
	_emit_changed()


func add_issue(issue: ProjectIssue) -> void:
	current_issues.append(issue)
	_emit_changed()


func add_issues(issues: Array[ProjectIssue]) -> void:
	current_issues.append_array(issues)
	_emit_changed()


# remove object reference
func remove_issue(issue: ProjectIssue) -> void:
	current_issues.erase(issue)
	_emit_changed()

func remove_issues(issues: Array[ProjectIssue]) -> void:
	for issue in issues:
		current_issues.erase(issue)
	_emit_changed()

func clear_issues() -> void:
	current_issues.clear()
	_emit_changed()


func get_issues() -> Array[ProjectIssue]:
	return current_issues


func _emit_changed() -> void:
	project_issues_changed.emit(current_issues)
