extends Area2D

var interactables : Array[Area2D]

func _ready() -> void:
	area_entered.connect(_on_area_updated)
	area_exited.connect(_on_area_updated)

func _on_area_updated(area:Area2D)->void:
	interactables = get_overlapping_areas()
