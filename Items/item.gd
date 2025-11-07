class_name Item extends Resource

@export var item_name : String
@export var icon : Texture2D

func _to_string() -> String:
	return item_name
