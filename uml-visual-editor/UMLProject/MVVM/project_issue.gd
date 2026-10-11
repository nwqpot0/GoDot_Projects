# project_issue.gd
class_name ProjectIssue
extends RefCounted


enum Type {
	DEBUG_TEST,
	DUPLICATE_NAME,
	MISSING_RELATION_ENDPOINT,
}


enum Severity {
	WARNING,
	ERROR,
}


var type: Type
var severity: Severity

# 哪些对象和这个 issue 有关
var targets: Array[Variant] = []

# 给 UI / 用户看的说明
var message: String = ""

var metadata: Dictionary = {}


func _init(
	p_type: Type,
	p_severity: Severity,
	p_targets: Array[Variant] = [],
	p_message: String = ""
) -> void:
	type = p_type
	severity = p_severity
	targets = p_targets
	message = p_message
