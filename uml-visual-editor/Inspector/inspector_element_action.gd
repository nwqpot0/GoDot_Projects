class_name InspectorElementAction
extends RefCounted

enum Type {
	CHANGE_CLASS_NAME,
	ADD_PROPERTY,
	UPDATE_PROPERTY,
	REMOVE_PROPERTY,
	ADD_METHOD,
	UPDATE_METHOD,
	REMOVE_METHOD,
}

var type: Type
var target: Variant
var payload: Variant


func _init(
	p_type: Type,
	p_target: Variant = null,
	p_payload: Variant = null
) -> void:
	type = p_type
	target = p_target
	payload = p_payload
