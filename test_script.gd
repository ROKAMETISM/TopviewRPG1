extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		pass
