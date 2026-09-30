class_name BlinkEffect
extends AttackEffect

var duration := 0.5

func apply(context: AttackContext) -> void:
	context.target.blink(duration)
