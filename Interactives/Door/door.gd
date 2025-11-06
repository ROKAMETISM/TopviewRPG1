extends StaticBody2D

@onready var sprite := $Sprite2D

const SPRITE_OPEN := preload("uid://devt8stwh7rjh")
const SPRITE_CLOSED := preload("uid://b65j7wlxi8o7a")

var _is_open := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact() -> void:
	_is_open = not _is_open
	if _is_open:
		sprite.texture = SPRITE_OPEN
	else:
		sprite.texture = SPRITE_CLOSED

func highlight()->void:
	modulate.a = 0.3

func unhighlight()->void:
	modulate.a = 1.0
