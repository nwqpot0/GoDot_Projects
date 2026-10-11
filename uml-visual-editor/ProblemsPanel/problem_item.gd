# problem_item.gd
class_name ProblemItem
extends PanelContainer

signal locate_requested(issue: ProjectIssue)

var issue: ProjectIssue

@onready var severity_label: Label = $MarginContainer/HBoxContainer/SeverityLabel
@onready var message_label: Label = $MarginContainer/HBoxContainer/Content/MessageLabel
@onready var detail_label: Label = $MarginContainer/HBoxContainer/Content/DetailLabel
@onready var locate_button: Button = $MarginContainer/HBoxContainer/LocateButton


func setup(p_issue: ProjectIssue) -> void:
	issue = p_issue

	message_label.text = issue.message
	detail_label.text = _build_detail_text()

	match issue.severity:
		ProjectIssue.Severity.WARNING:
			severity_label.text = "⚠"

		ProjectIssue.Severity.ERROR:
			severity_label.text = "❌"


func _ready() -> void:
	locate_button.pressed.connect(_on_locate_pressed)


func _on_locate_pressed() -> void:
	if issue == null:
		return

	locate_requested.emit(issue)


func _build_detail_text() -> String:
	match issue.type:
		ProjectIssue.Type.DUPLICATE_NAME:
			var name: String = issue.metadata.get("name", "")
			return "Duplicate name: %s" % name
		ProjectIssue.Type.DEBUG_TEST:
			return "[Debug] Test Details"
	return ""
