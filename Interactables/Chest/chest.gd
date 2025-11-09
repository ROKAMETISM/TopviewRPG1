extends StaticBody2D

@onready var sprite := $Sprite2D

@onready var inventory : Inventory = $Inventory



func _on_interacted(source:Node2D)->void:
	if source.has_method("access_inventory"):
		source.access_inventory(inventory)
