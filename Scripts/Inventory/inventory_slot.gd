class_name InventorySlot extends TextureRect

var index : int = -1
var _is_selected : bool = false

func _on_mouse_entered() -> void:
	print(index)
	_is_selected = true
	self_modulate.v = 0.0
	


func _on_mouse_exited() -> void:
	_is_selected = false
	self_modulate.v = 1.0
	
