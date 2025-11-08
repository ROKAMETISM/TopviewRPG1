class_name Dummy extends CharacterBody2D

@onready var interaction_area : Area2D = %InteractionArea
@onready var inventory : Inventory = $Inventory
var inventory_visualizer : Control = null

var _object_to_interact : Node2D = null

func _ready() -> void:
	_connect_signals()


func _physics_process(delta: float) -> void:
	_process_move(delta)
	_find_interactable()
	_highlight_interactable()
	
	if Input.is_action_just_pressed("interact"):
		_interact()
	if Input.is_action_just_pressed("open_inventory"):
		_visualize_inventory()
	

func _connect_signals()->void:
	pass

func _process_move(delta:float)->void:
	var move_direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_direction * 200
	move_and_collide(velocity * delta)

func _interact()->void:
	if not _object_to_interact:
		return
	if _object_to_interact.has_method("interact"):
		_object_to_interact.interact(self)

func _find_interactable():
	if interaction_area.interactables.size() == 0:
		if _object_to_interact and _object_to_interact.has_method("unhighlight"):
			_object_to_interact.unhighlight()
		_object_to_interact = null
		return
	var min_dist := 0.0
	var closest : Node2D = null
	for _area in interaction_area.interactables:
		if not is_instance_valid(_area):
			continue
		var object : Node2D = _area.get_parent() as Node2D
		var dist = (global_position.distance_to(object.global_position))
		if closest == null or dist < min_dist:
			closest = object
			min_dist = dist
	if closest == _object_to_interact:
		return
	if _object_to_interact and _object_to_interact.has_method("unhighlight"):
		_object_to_interact.unhighlight()
	_object_to_interact = closest
	

func _highlight_interactable():
	if _object_to_interact == null:
		return
	if _object_to_interact.has_method("highlight"):
		_object_to_interact.highlight()
		

func _visualize_inventory():
	if inventory_visualizer:
		remove_child(inventory_visualizer)
		inventory_visualizer.queue_free()
		inventory_visualizer = null
		return
	inventory_visualizer = InventoryVisualizer.visualize(inventory)
	add_child(inventory_visualizer)
