extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "No Issues"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_issues(issues: Array[ProjectIssue]) -> void:
	var warning_count := 0
	var error_count := 0

	for issue in issues:
		match issue.severity:
			ProjectIssue.Severity.WARNING:
				warning_count += 1

			ProjectIssue.Severity.ERROR:
				error_count += 1

	var parts: Array[String] = []

	if warning_count > 0:
		parts.append("⚠ %d" % warning_count)

	if error_count > 0:
		parts.append("✕ %d" % error_count)

	if parts.is_empty():
		text = "No issues"
	else:
		text = "  ".join(parts)
	
	tooltip_text = \
	"%d warnings, %d errors" % [
		warning_count,
		error_count
	]
