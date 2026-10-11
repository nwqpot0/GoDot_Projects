class_name ProjectManagerActionResult
extends RefCounted

var success: bool
var message: String
var data: Variant


func _init(
	p_success: bool,
	p_message: String = "",
	p_data: Variant = null
) -> void:
	success = p_success
	message = p_message
	data = p_data

static func ok(
	data: Variant = null,
	message: String = ""
) -> ProjectManagerActionResult:
	return ProjectManagerActionResult.new(
		true,
		message,
		data
	)

static func failed(
	message: String
) -> ProjectManagerActionResult:
	return ProjectManagerActionResult.new(
		false,
		message
	)
