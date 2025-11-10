extends Node

var hudlayer : CanvasLayer = CanvasLayer.new()

func _ready() -> void:
	add_child(hudlayer)

func add_hud(element : Control)->void:
	hudlayer.add_child(element)

func free_hud(element : Control)->void:
	element.queue_free()
