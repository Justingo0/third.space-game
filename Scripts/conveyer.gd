extends Area2D

@export var held:bool

var SPEED:float = 5000

var items = []

func _ready() -> void:
	$Body.frame = GameManager.conveyer_frame

func _on_body_frame_changed() -> void:
	if held:
		GameManager.conveyer_frame = $Body.frame

func _process(delta: float) -> void:
	if not items.is_empty() and not held:
		var direction = Vector2.UP.rotated(rotation)
		for item in items:
			item.velocity = direction * SPEED * delta
			item.velocity.clamp(Vector2(-SPEED, -SPEED), Vector2(SPEED, SPEED))

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ore") and not held:
		items.append(body)
		items = items

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Ore") and not held:
		body.velocity = Vector2.ZERO
		items.erase(body)
		items = items
