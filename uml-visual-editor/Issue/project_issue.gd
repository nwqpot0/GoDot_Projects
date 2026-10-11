# project_issue.gd
class_name ProjectIssue
extends Issue


enum Type {
	DEBUG_TEST,
	DUPLICATE_NAME,
}

var type: Type

# 哪些对象和这个 issue 有关
var targets: Array[Variant] = []

# 给 UI / 用户看的说明

var metadata: Dictionary = {}


func _init(
	_type: Type,
	_severity: Severity,
	_targets: Array[Variant] = [],
	_message: String = ""
) -> void:
	super(_severity, _message, "Project")
	type = _type
	targets = _targets
