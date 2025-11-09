class_name Dummy extends CharacterBody2D

@onready var interaction_area : Area2D = %InteractionArea
@onready var inventory : Inventory = $Inventory
var external_inventory : Inventory = null
var inventory_visualizer : Control = null
var external_inventory_visualizer : Control = null

var _object_to_interact : Interactable = null

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
	
func access_inventory(target_inventory : Inventory)->void:
	external_inventory = target_inventory
	_visualize_inventory()


func _connect_signals()->void:
	pass

func _process_move(delta:float)->void:
	var move_direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_direction * 200
	move_and_collide(velocity * delta)

func _find_interactable():
	if interaction_area.interactables.size() == 0:
		if _object_to_interact and _object_to_interact.has_method("unhighlight"):
			_object_to_interact.unhighlight()
		_object_to_interact = null
		return
	var min_dist := 0.0
	var closest : Interactable = null
	for _area in interaction_area.interactables:
		if not is_instance_valid(_area):
			continue
		if not _area is Interactable:
			continue
		var _interactable = _area as Interactable
		var object : Node2D = _interactable.parent
		var dist = (global_position.distance_to(object.global_position))
		if closest == null or dist < min_dist:
			closest = _interactable
			min_dist = dist
	if closest == _object_to_interact:
		return
	if _object_to_interact and _object_to_interact.has_method("unhighlight"):
		_object_to_interact.unhighlight()
	_object_to_interact = closest
	
func _interact()->void:
	if not _object_to_interact:
		return
	if _object_to_interact.has_method("interact"):
		_object_to_interact.interact(self)


func _highlight_interactable():
	if _object_to_interact == null:
		return
	if _object_to_interact.has_method("highlight"):
		_object_to_interact.highlight()


func _visualize_inventory():
	if not _visualizing_inventory():
		inventory_visualizer = InventoryVisualizer.visualize(inventory)
		add_child(inventory_visualizer)
		if external_inventory:
			external_inventory_visualizer = InventoryVisualizer.visualize(external_inventory)
			add_child(external_inventory_visualizer)
		return
	if inventory_visualizer:
		remove_child(inventory_visualizer)
		inventory_visualizer.queue_free()
		inventory_visualizer = null
	if external_inventory_visualizer:
		remove_child(external_inventory_visualizer)
		external_inventory_visualizer.queue_free()
		external_inventory_visualizer = null

func _visualizing_inventory()->bool:
	return (inventory_visualizer and is_instance_valid(inventory_visualizer)) or (external_inventory_visualizer and is_instance_valid(external_inventory_visualizer))
