extends Camera2D

var mouse_starting_pos = Vector2.ZERO
var starting_cam_pos = Vector2.ZERO
var dragging := false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			mouse_starting_pos = get_global_mouse_position()
			starting_cam_pos = position#.clamp(Vector2(limit_left, limit_top), Vector2(limit_right, limit_bottom))
			dragging = true
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			dragging = false
	elif event is InputEventMouseMotion:
		if dragging:
			var viewport_size = get_viewport().get_visible_rect().size
			position = (starting_cam_pos + (mouse_starting_pos - get_global_mouse_position())).clamp(Vector2(limit_left+viewport_size.x, limit_top+viewport_size.y), Vector2(limit_right-viewport_size.x, limit_bottom-viewport_size.y))
			#position.clamp(Vector2(limit_left, limit_top), Vector2(limit_right, limit_bottom))
