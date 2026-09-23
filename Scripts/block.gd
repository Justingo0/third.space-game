extends Area2D

@export var held:bool

func _ready() -> void:
	$Body.frame = GameManager.conveyer_frame

func _on_body_frame_changed() -> void:
	if held:
		GameManager.conveyer_frame = $Body.frame
