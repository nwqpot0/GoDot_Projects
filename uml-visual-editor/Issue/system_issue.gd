class_name SystemIssue
extends Issue

enum Type {
	MISSING_DEPENDENCY,
	INITIALIZATION_FAILED,
	INVALID_STATE
}

var type: Type


func _init(
	_type: Type,
	_severity: Severity,
	_message: String,
	_source: String
) -> void:
	super(_severity, _message, _source)

	type = _type
