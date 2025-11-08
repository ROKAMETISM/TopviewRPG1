class_name Inventory extends Node

var data : Dictionary[Item, int]
var order : Array[Item]
var size := 1
@export var style : InventoryStyle

func _ready() -> void:
	if style:
		size = style.dimensions.x * style.dimensions.y

func add_item(item : Item, amount : int = 1)->int:
	if not data.has(item):
		if order.size() >= size:
			return 0
		order.push_front(item)
		data[item] = amount
		return amount
	data[item]+=amount
	return data[item]

func get_item(item:Item, amount:int = 1)->int:
	if not data.has(item):
		return 0
	if data[item] > amount:
		data[item] -= amount
		return data[item]
	var remain := data[item]
	data.erase(item)
	order.erase(item)
	return remain

func _to_string() -> String:
	return str(data)
