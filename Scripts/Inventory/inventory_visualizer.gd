class_name InventoryVisualizer extends Node

const SLOT_SIZE := 16
const MARGIN := 2

static func visualize(inventory : Inventory) -> Control:
	if inventory.style == null or not is_instance_valid(inventory.style):
		return null
	var root := Control.new()
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
	root.add_child(background)
	
	var grid := GridContainer.new()
	grid.position = Vector2(MARGIN, MARGIN)
	grid.columns = style.dimensions.x
	grid.add_theme_constant_override("h_separation", MARGIN)
	grid.add_theme_constant_override("v_separation", MARGIN)
	
	for i in inventory.size:
		var slot := TextureRect.new()
		slot.texture = style.slot_texture
		grid.add_child(slot)
		if i >= inventory.order.size():
			continue
		var item_icon := TextureRect.new()
		item_icon.texture = inventory.order[i].icon
		slot.add_child(item_icon)
		var item_label := Label.new()
		item_label.text = str(inventory.data[inventory.order[i]])
		slot.add_child(item_label)
	
	root.add_child(grid)
	
	return root
	
