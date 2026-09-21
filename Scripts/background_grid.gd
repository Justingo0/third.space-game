extends Node2D

# Code from https://forum.godotengine.org/t/drawing-an-infinite-grid-from-a-tool/27004/2 made by surferlul

@onready var camera = $"../Camera"

@export var on = true

var GRID_SIZE = 32
var GRID_COLOR = Color(0.0, 0.757, 1.0, 0.22)

func _draw():
	if on and camera:
		var size = get_viewport_rect().size  * camera.zoom / 2
		var cam = camera.position
		for i in range(int((cam.x - size.x) / GRID_SIZE) - 1, int((size.x + cam.x) / GRID_SIZE) + 1):
			draw_line(Vector2(i * GRID_SIZE, cam.y + size.y + 100), Vector2(i * GRID_SIZE, cam.y - size.y - 100), GRID_COLOR)
		for i in range(int((cam.y - size.y) / GRID_SIZE) - 1, int((size.y + cam.y) / GRID_SIZE) + 1):
			draw_line(Vector2(cam.x + size.x + 100, i * GRID_SIZE), Vector2(cam.x - size.x - 100, i * GRID_SIZE), GRID_COLOR)

#func _ready() -> void:
	#queue_redraw()

func _process(_delta):
	if camera:
		queue_redraw()
