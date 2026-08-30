extends Camera2D

var target_zoom = Vector2(1, 1)

var zoom_step = 0.1
var min_zoom = 0.5
var max_zoom = 2.0
var zoom_speed = 8.0

func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		target_zoom += Vector2(zoom_step, zoom_step)

	if Input.is_action_just_pressed("zoom_out"):
		target_zoom -= Vector2(zoom_step, zoom_step)

	target_zoom.x = clamp(target_zoom.x, min_zoom, max_zoom)
	target_zoom.y = clamp(target_zoom.y, min_zoom, max_zoom)

	zoom = zoom.lerp(target_zoom, zoom_speed * delta)
