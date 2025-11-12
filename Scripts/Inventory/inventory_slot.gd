class_name InventorySlot extends TextureRect

var index : int = -1
var _is_selected : bool = false

signal selected(indx : int, shift : bool, ctrl : bool, type : int)

func _on_mouse_entered() -> void:
	_is_selected = true
	self_modulate.v = 0.0
	

func _on_mouse_exited() -> void:
	_is_selected = false
	self_modulate.v = 1.0
	


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selected.emit(index, Input.is_action_pressed("shift"), Input.is_action_pressed("ctrl"), 0)
			accept_event()
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			selected.emit(index, Input.is_action_pressed("shift"), Input.is_action_pressed("ctrl"), 1)
			accept_event()
