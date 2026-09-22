extends Camera2D

@onready var build_cursor = $BuildCursor

var mouse_starting_pos = Vector2.ZERO
var starting_cam_pos = Vector2.ZERO
var dragging := false

var building := false
var building_object:PackedScene = preload("res://Scenes/block.tscn"):
	set(new_object):
		building_object = new_object
		set_build_cursor(building_object)
	get:
		return building_object

func _ready() -> void:
	set_build_cursor(building_object)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if ((event.button_index == MOUSE_BUTTON_LEFT and not building) or event.button_index == MOUSE_BUTTON_MIDDLE) and event.is_pressed():
			mouse_starting_pos = get_global_mouse_position()
			starting_cam_pos = position#.clamp(Vector2(limit_left, limit_top), Vector2(limit_right, limit_bottom))
			dragging = true
		if ((event.button_index == MOUSE_BUTTON_LEFT and not building) or event.button_index == MOUSE_BUTTON_MIDDLE) and event.is_released():
			dragging = false
	elif event is InputEventMouseMotion:
		if dragging:
			var viewport_size = get_viewport().get_visible_rect().size
			position = (starting_cam_pos + (mouse_starting_pos - get_global_mouse_position())).clamp(Vector2(limit_left+viewport_size.x, limit_top+viewport_size.y), Vector2(limit_right-viewport_size.x, limit_bottom-viewport_size.y))
			#position.clamp(Vector2(limit_left, limit_top), Vector2(limit_right, limit_bottom))

func _physics_process(_delta: float) -> void:
	build_cursor.global_position = get_global_mouse_position().snapped(Vector2(64, 64))
	
	if Input.is_action_pressed("Place"):
		place(building_object)
	if Input.is_action_pressed("Delete"):
		delete()

func set_build_cursor(object:PackedScene):
	if build_cursor.get_child_count() > 1:
		for child in build_cursor.get_children():
			child.queue_free()
	
	if not object:
		building = false
		return
	building = true
	
	var highlight = object.instantiate()
	build_cursor.add_child(highlight)
	highlight.position = Vector2.ZERO

func place(object:PackedScene):
	if not object or not building: return
	if build_cursor.get_child(0).has_overlapping_areas(): return
	
	var placed_object = object.instantiate()
	get_tree().current_scene.add_child(placed_object)
	placed_object.global_position = build_cursor.global_position

func delete():
	var deleting_objects = build_cursor.get_child(0).get_overlapping_areas()
	if len(deleting_objects) >= 1:
		deleting_objects[0].queue_free()
