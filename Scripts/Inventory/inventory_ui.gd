class_name InventoryUI
extends Control

const SLOT_SIZE := 32
const INVENTORY_SLOT : PackedScene = preload("uid://cklbnqtl3pcjn")

@onready var background : NinePatchRect = %Background
@onready var grid : GridContainer = %Grid
@export var inventory : Inventory


func _ready() -> void:
	if inventory:
		visualize(inventory)

func visualize(inventory_to_visualize : Inventory) -> Control:
	if inventory_to_visualize.style == null or not is_instance_valid(inventory_to_visualize.style):
		#inventory_to_visualize cannot be visualized since its style is undefined.
		print("Invalid Style")
		return null
	for slots : Control in grid.get_children():
		slots.queue_free()
	var style : InventoryStyle = inventory_to_visualize.style
	background.texture = style.background_texture
	background.patch_margin_bottom = style.slot_patch_margin
	background.patch_margin_top = style.slot_patch_margin
	background.patch_margin_left = style.slot_patch_margin
	background.patch_margin_right = style.slot_patch_margin
	var background_size := Vector2i.ZERO
	background_size = (SLOT_SIZE+style.grid_margin)*style.dimensions
	background_size -= Vector2i(style.grid_margin, style.grid_margin)
	background_size += 2 * Vector2i(style.background_margin, style.background_margin)
	background.size = Vector2(background_size)
	background.position = - background_size / 2
	background.self_modulate.a = inventory_to_visualize.style.alpha
	
	grid.position = Vector2(style.background_margin, style.background_margin)
	grid.size = background_size
	grid.columns = style.dimensions.x
	grid.add_theme_constant_override("h_separation", style.grid_margin)
	grid.add_theme_constant_override("v_separation", style.grid_margin)
	
	for i in inventory_to_visualize.size:
		var slot : InventorySlot = INVENTORY_SLOT.instantiate()
		slot.texture = style.slot_texture
		slot.custom_minimum_size = Vector2(SLOT_SIZE, SLOT_SIZE)
		slot.self_modulate.a = inventory_to_visualize.style.alpha
		slot.index = i
		slot.selected.connect(_on_slot_selected)
		grid.add_child(slot)
		if i >= inventory_to_visualize.order.size():
			continue
		var item_icon := TextureRect.new()
		item_icon.set_anchors_preset(Control.PRESET_FULL_RECT)
		item_icon.texture = inventory_to_visualize.order[i].icon
		slot.add_child(item_icon)
		var item_label := Label.new()
		item_label.set_anchors_preset(Control.PRESET_FULL_RECT)
		item_label.label_settings = preload("uid://cnnvutffqpqar")
		item_label.text = str(inventory_to_visualize.data[inventory_to_visualize.order[i]])
		item_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		item_label.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
		slot.add_child(item_label)
	return self

func _on_slot_selected(slot_index : int, shift : bool, ctrl : bool)->void:
	print("%d slot selected %s %s"%[slot_index, "Shift" if shift else "", "CTRL" if ctrl else ""])
	if slot_index >= inventory.order.size():
		return
	var item : Item = inventory.order[slot_index]
	var amount : int = 1
	if shift:
		amount = inventory.data[item]
	if ctrl:
		amount = ceil(inventory.data[item] / 2.0)
	UIEventManager.inventory_input.emit(inventory, item,amount)
