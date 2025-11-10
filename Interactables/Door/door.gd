extends StaticBody2D

@onready var sprite := $Sprite2D

const SPRITE_OPEN := preload("uid://devt8stwh7rjh")
const SPRITE_CLOSED := preload("uid://b65j7wlxi8o7a")

var _is_open := false



func _on_interacted(_source:Node2D)->void:
	_is_open = not _is_open
	if _is_open:
		sprite.texture = SPRITE_OPEN
		set_collision_layer_value(1, false)
	else:
		sprite.texture = SPRITE_CLOSED
		set_collision_layer_value(1, true)
