class_name Inventory extends Node

const INVENTORY_UI : PackedScene = preload("uid://bhjhobr55mp1p")

var data : Dictionary[Item, int]
var order : Array[Item]
var size := 1
var visualization : Control = null
@export var style : InventoryStyle

signal updated(inventory : Inventory)

func _ready() -> void:
	if style:
		size = style.dimensions.x * style.dimensions.y

func add_item(item : Item, amount : int = 1)->int:
	if data.has(item):
		data[item]+=amount
		updated.emit(self)
		return data[item]
	if order.size() >= size:
		return 0
	order.push_front(item)
	data[item] = amount
	updated.emit(self)
	return amount

func get_item(item:Item, amount:int = 1)->int:
	if not data.has(item):
		return 0
	if data[item] > amount:
		data[item] -= amount
		updated.emit(self)
		return data[item]
	var remain := data[item]
	data.erase(item)
	order.erase(item)
	updated.emit(self)
	return remain

func _to_string() -> String:
	return str(data)

func visualize()->Control:
	if not visualization:
		visualization = INVENTORY_UI.instantiate()
		visualization.inventory = self
	return visualization
