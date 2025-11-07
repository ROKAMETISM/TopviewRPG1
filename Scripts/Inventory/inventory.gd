class_name Inventory extends Node

var data : Dictionary[Item, int]
var order : Array[Item]


func add_item(item : Item, amount : int = 1)->int:
	if not data.has(item):
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

func get_visualization()->GridContainer:
	var grid : GridContainer = GridContainer.new()
	for item in order:
		var icon : TextureRect = TextureRect.new()
		icon.texture = item.icon
		grid.add_child(icon)
	return grid
