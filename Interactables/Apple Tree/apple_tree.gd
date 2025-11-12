extends StaticBody2D

const ITEM_SPAWN_RANGE_MAX : float = 64.0
const ITEM_SPAWN_RANGE_MIN : float = 32.0

func _on_interacted(_source:Node2D)->void:
	if not get_tree() or not get_tree().current_scene:
		return
	var item_to_spawn : Item
	var item_amount : int = 1
	if randi_range(0, 1):
		item_to_spawn = Preloads.ITEM_APPLE
		item_amount = randi_range(1, 2)
	else:
		item_to_spawn = Preloads.ITEM_STICK
		item_amount = randi_range(1, 3)
	var item_pickup : ItemPickup = Preloads.SCENE_PICKUP.instantiate()
	item_pickup.item_type = item_to_spawn
	item_pickup.amount = item_amount
	item_pickup.global_position = global_position + \
			Vector2(randf_range(ITEM_SPAWN_RANGE_MIN, ITEM_SPAWN_RANGE_MAX), 0.0).\
			rotated(randf_range(0, 2*PI))
	get_tree().current_scene.add_child(item_pickup)
	
