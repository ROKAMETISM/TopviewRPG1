extends Node2D

var grip_position
var is_grip
var entered_mouse
var hand : Array

const HAND_ROTATION_RANGE : float = 2.5

func hand_sort()->void:
	if hand.size() <= 1:
		return
	for i in hand.size():
		# i : 0 -> hand.size()-1
		var card_rotation = -HAND_ROTATION_RANGE * hand.size() + i / (hand.size()-1) * 2 * HAND_ROTATION_RANGE * hand.size()
		hand[i].rotation = card_rotation
		



func _process(delta: float) -> void:
	
	if entered_mouse and Input.is_action_pressed("ui_accept"):
		if is_grip == false:
			grip_position = get_global_mouse_position() - position
		is_grip = true
	elif not Input.is_action_pressed("ui_accept"):
		is_grip = false
	if is_grip:
		position = get_global_mouse_position() - grip_position
