extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var area : Area2D
	
	if not area.get_parent() is Card:
		return
	var card : Card = area.get_parent() as Card
	card.global_position
	card.select()
	
	var overlapping_cards : Array[Area2D] = get_overlapping_areas()
	
	if overlapping_cards.size() == 0:
		print("no card selected")
		var selected_card = null
		return
	
	
	var min_dist := 0
	var selected_card = null
	
	for card_area : Area2D in overlapping_cards:
		var c = card_area.get_parent()
		if selected_card == null or get_card_dist(card) < min_dist:
			selected_card = card
			min_dist = get_card_dist(selected_card)
	
	
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		pass

func get_card_dist(card : Node2D) -> float:
	var mouse_position := Vector2.ZERO
	return (card.global_position - mouse_position).length()
