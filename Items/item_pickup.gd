class_name ItemPickup extends Node2D

@export var item_type : Item
@onready var sprite : Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.texture = item_type.icon

func interact(source:Node2D) -> void:
	source.inventory.add_item(item_type, 1)
	queue_free()

func highlight()->void:
	modulate.a = 0.3

func unhighlight()->void:
	modulate.a = 1.0
