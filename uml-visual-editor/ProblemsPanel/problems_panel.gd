class_name ProblemsPanel
extends PanelContainer

signal close_requested
signal issue_selected(issue: ProjectIssue)

@export var problem_item_scene: PackedScene

@onready var issue_count_label: Label = $VBoxContainer/MarginContainer/VBoxContainer/Header/IssueCountLabel
@onready var close_button: Button = $VBoxContainer/MarginContainer/VBoxContainer/Header/CloseButton
@onready var issue_list: VBoxContainer = $VBoxContainer/MarginContainer/VBoxContainer/ScrollContainer/IssueList



func _ready() -> void:
	close_button.pressed.connect(
		func():
			close_requested.emit()
	)


func set_issues(issues: Array[ProjectIssue]) -> void:
	_clear_items()
	_add_issues(issues)

func _add_issues(issues: Array[ProjectIssue]) -> void:
	issue_count_label.text = str(issues.size()) + " Issues"
	if issues.is_empty():
		var label := Label.new()
		label.text = "No problems"
		issue_list.add_child(label)
		return

	for issue in issues:
		var item: ProblemItem = problem_item_scene.instantiate()
		issue_list.add_child(item)
		item.setup(issue)

		item.locate_requested.connect(
			func(selected_issue: ProjectIssue):
				issue_selected.emit(selected_issue)
		)
		
func _clear_items() -> void:
	for child in issue_list.get_children():
		child.queue_free()
