extends Area2D

@onready var raycast = $Raycast

@export var held:bool

var SPEED:float = 5000

var item = null

var next_conveyor = null

func _ready() -> void:
	$Body.frame = GameManager.conveyor_frame

func _on_body_frame_changed() -> void:
	if held:
		GameManager.conveyor_frame = $Body.frame

func _process(delta: float) -> void:
	if item and not held:
		if not next_conveyor:
			next_conveyor = raycast.get_collider()
			print(next_conveyor)
		if not next_conveyor: return
		#var direction = Vector2.UP.rotated(rotation)
		item.velocity.move_toward(next_conveyor.global_position, SPEED*delta)
		print(item.velocity)
		#item.velocity = direction * SPEED * delta
		#item.velocity.clamp(Vector2(-SPEED, -SPEED), Vector2(SPEED, SPEED))

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ore") and not held:
		if body.is_on_conveyor == false:
			item = body
			body.is_on_conveyor = true
