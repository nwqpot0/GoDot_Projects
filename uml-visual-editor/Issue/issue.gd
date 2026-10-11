class_name Issue
extends RefCounted

enum Severity {
	INFO,
	WARNING,
	ERROR,
	FATAL
}

var severity: Severity
var message: String
var source: String


func _init(
	_severity: Severity,
	_message: String,
	_source: String = ""
) -> void:
	severity = _severity
	message = _message
	source = _source
