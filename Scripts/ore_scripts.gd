extends CharacterBody2D

var is_on_conveyor:bool = false

func _physics_process(_delta: float) -> void:
	move_and_slide()
