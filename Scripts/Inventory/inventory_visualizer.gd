#class_name InventoryVisualizer
extends Node

const SLOT_SIZE := 32
const MARGIN := 2

func visualize(inventory : Inventory) -> Control:
	if inventory.style == null or not is_instance_valid(inventory.style):
		#inventory cannot be visualized since its style is undefined.
		return null
	if not inventory.updated.is_connected(_on_inventory_updated):
		inventory.updated.connect(_on_inventory_updated)
	
	var root : Control
	if inventory.visualization and is_instance_valid(inventory.visualization):
		root = inventory.visualization
		for root_element in root.get_children():
			root.remove_child(root_element)
			root_element.queue_free()
	else:
		root = Control.new()
	var style : InventoryStyle = inventory.style
	var background := NinePatchRect.new()
	background.texture = style.background_texture
	background.axis_stretch_horizontal = NinePatchRect.AXIS_STRETCH_MODE_TILE
	background.axis_stretch_vertical = NinePatchRect.AXIS_STRETCH_MODE_TILE
	background.patch_margin_left = 7
	background.patch_margin_right = 7
	background.patch_margin_top = 7
	background.patch_margin_bottom = 7
	var background_size := Vector2i.ZERO
	background_size = (SLOT_SIZE+MARGIN)*style.dimensions
	background_size += Vector2i(MARGIN, MARGIN)
	background.size = background_size
	background.set_anchors_preset(Control.PRESET_CENTER)
	background.position = - background_size / 2
	background.self_modulate.a = inventory.style.alpha
	
	var grid := GridContainer.new()
	grid.set_anchors_preset(Control.PRESET_TOP_LEFT)
	grid.position = Vector2(MARGIN, MARGIN)
	grid.columns = style.dimensions.x
	grid.add_theme_constant_override("h_separation", MARGIN)
	grid.add_theme_constant_override("v_separation", MARGIN)
	
	for i in inventory.size:
		var slot := TextureRect.new()
		slot.texture = style.slot_texture
		slot.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
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
	
	background.add_child(grid)
	root.add_child(background)
	
	root.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	root.z_index = 200
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	inventory.visualization = root
	return root

func _on_inventory_updated(inventory : Inventory)->void:
	visualize(inventory)
