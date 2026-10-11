extends Control

signal project_issues_changed(
	issues: Array[ProjectIssue]
)

@onready var toolbar: HBoxContainer = $MarginContainer/MainLayout/ToolbarMargin/Toolbar
@onready var uml_canvas: UMLCanvas = $MarginContainer/MainLayout/WorkplaceSplit/MainMargin/MainSplit/RightSplit/UMLCanvas
@onready var inspector_panel: UMLInspector = $MarginContainer/MainLayout/WorkplaceSplit/MainMargin/MainSplit/RightSplit/InspectorPanel
@onready var issue_summary_button: Button = $MarginContainer/MainLayout/StatusMargin/StatusBar/LeftStatus/IssueSummaryButton
@onready var problems_panel: ProblemsPanel = $MarginContainer/MainLayout/WorkplaceSplit/ProblemsPanel
@onready var developer_tools: DeveloperTools = $DeveloperTools

var current_session: ProjectSession

func _ready() -> void:	# load a project 
	#toolbar related
	toolbar.action_requested.connect(_on_toolbar_action_requested)
	
	#canvas related
	uml_canvas.selection_changed.connect(_on_canvas_selection_changed)
	
	#inspector related
	inspector_panel.action_requested.connect(_on_inspector_action_requested)
	
	#status related
	project_issues_changed.connect(issue_summary_button.set_issues)
	issue_summary_button.pressed.connect(_on_issue_summary_pressed)
	
	#problems panel related
	project_issues_changed.connect(problems_panel.set_issues)
	problems_panel.close_requested.connect(_on_problems_close_requested)
	
	# Session Related
	current_session = _create_new_project_session()
	_bind_session_signals()
	current_session.validate_project()
	
	# Developer's tools
	_initialize_developer_tools()

	problems_panel.visible = false

# Bind all listeners of session signal to the session
func _bind_session_signals():
	current_session.project_issues_changed.connect(_on_project_issues_changed)
	current_session.class_added.connect(uml_canvas._on_class_added)

#region on signals received
func _on_project_issues_changed(issues: Array[ProjectIssue]):
	project_issues_changed.emit(issues)

func _on_toolbar_action_requested(action: ToolbarAction.Type) -> void:
	match action:
		ToolbarAction.Type.ADD_CLASS:
			_add_class_request()
			
func _on_canvas_selection_changed(
	selected_classes: Array[UMLClass]
) -> void:
	inspector_panel.set_selection(selected_classes)

func _on_inspector_action_requested(action: InspectorElementAction):
	pass

func _on_issue_summary_pressed() -> void:
	problems_panel.visible = not problems_panel.visible

func _on_problems_close_requested() -> void:
	problems_panel.visible = false


	
#endregion

#region project session

func generate_project_id() -> String:
	var time_part := str(Time.get_unix_time_from_system())
	var random_part := str(randi())

	return "project_%s_%s" % [
		time_part,
		random_part
	]

func _create_new_project_session() -> ProjectSession:
	return ProjectSession.new(UMLProject.new(generate_project_id()))


func _add_class_request() -> void:
	#print("Add class signal received")
	var uml_class := UMLClass.new(
		"NewClass",
		uml_canvas.get_view_center()
	)
	var result : ProjectManagerActionResult = current_session.add_class(uml_class)
	#print(result.success, " ", result.message)
#endregion


#region developer tools
func _initialize_developer_tools():
	developer_tools.spawn_problem_requested.connect(
		_on_debug_spawn_problem
	)

	developer_tools.spawn_many_problems_requested.connect(
		_on_debug_spawn_many_problems
	)

	developer_tools.clear_problems_requested.connect(
		_on_debug_clear_problems
	)

	developer_tools.spawn_uml_class_requested.connect(
		_on_debug_spawn_uml_class
	)
	

func _on_debug_spawn_problem() -> void:
	# 调用真正的 ProblemsPanel API
	var debugIssue = ProjectIssue.new(
		ProjectIssue.Type.DEBUG_TEST,
		ProjectIssue.Severity.WARNING,
		[],
		"[Debug] A Test Problem"
	)
	current_session.add_issue(debugIssue)


func _on_debug_spawn_many_problems(amount: int) -> void:
	var debugIssue = ProjectIssue.new(
		ProjectIssue.Type.DEBUG_TEST,
		ProjectIssue.Severity.WARNING,
		[],
		"[Debug] A Test Problem"
	)
	for i in range(amount):
		current_session.add_issue(debugIssue)


func _on_debug_clear_problems() -> void:
	current_session.clear_issues()


func _on_debug_spawn_uml_class(name: String) -> void:
	var uml_class : UMLClass = UMLClass.new(name, uml_canvas.get_view_center())
	current_session.add_class(uml_class)

#endregion
