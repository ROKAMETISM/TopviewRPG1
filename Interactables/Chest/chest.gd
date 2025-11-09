extends StaticBody2D

@onready var sprite := $Sprite2D

@onready var inventory : Inventory = $Inventory

const APPLE := preload("uid://dntdbofhnh8a4")
const STICK := preload("uid://dojy3w0dx33x6")

func _ready() -> void:
	inventory.add_item(APPLE, 32)
	inventory.add_item(STICK, 196)

func _on_interacted(source:Node2D)->void:
	if source.has_method("access_inventory"):
		source.access_inventory(inventory)
