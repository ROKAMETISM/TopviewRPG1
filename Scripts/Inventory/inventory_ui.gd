class_name InventoryUI
extends Control

const SLOT_SIZE := 32
const MARGIN := 2

@onready var background : NinePatchRect = %Background
@onready var grid : GridContainer = %Grid


func visualize(inventory : Inventory) -> Control:
	if inventory.style == null or not is_instance_valid(inventory.style):
		#inventory cannot be visualized since its style is undefined.
		print("Invalid Style")
		return null
	
	var style : InventoryStyle = inventory.style
	background.texture = style.background_texture
	var background_size := Vector2i.ZERO
	background_size = (SLOT_SIZE+MARGIN)*style.dimensions
	background_size += Vector2i(MARGIN, MARGIN)
	background.size = background_size
	#background.position = - background_size / 2
	background.self_modulate.a = inventory.style.alpha
	
	grid.position = Vector2(MARGIN, MARGIN)
	grid.size = background_size
	grid.columns = style.dimensions.x
	grid.add_theme_constant_override("h_separation", MARGIN)
	grid.add_theme_constant_override("v_separation", MARGIN)
	
	for i in inventory.size:
		var slot := TextureRect.new()
		slot.texture = style.slot_texture
		slot.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		slot.set_anchors_preset(Control.PRESET_CENTER)
		slot.size = Vector2(SLOT_SIZE, SLOT_SIZE)
		slot.self_modulate.a = inventory.style.alpha
		grid.add_child(slot)
		if i >= inventory.order.size():
			continue
		var item_icon := TextureRect.new()
		#item_icon.size = Vector2(SLOT_SIZE, SLOT_SIZE)
		item_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		item_icon.set_anchors_preset(Control.PRESET_FULL_RECT)
		item_icon.texture = inventory.order[i].icon
		slot.add_child(item_icon)
		var item_label := Label.new()
		item_label.set_anchors_preset(Control.PRESET_FULL_RECT)
		item_label.label_settings = preload("uid://cnnvutffqpqar")
		item_label.text = str(inventory.data[inventory.order[i]])
		item_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		item_label.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
		slot.add_child(item_label)
	return self

func _on_inventory_updated(inventory : Inventory)->void:
	visualize(inventory)
