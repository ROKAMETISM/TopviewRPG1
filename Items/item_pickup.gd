class_name ItemPickup extends Node2D

@export var item_type : Item
@export var amount : int = 1
@onready var sprite : Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.texture = item_type.icon

func _on_interacted(source:Node2D) -> void:
	if source.has_method("pickup_item"):
		source.pickup_item(item_type, amount)
		queue_free()
		return
	source.inventory.add_item(item_type, amount)
	queue_free()
