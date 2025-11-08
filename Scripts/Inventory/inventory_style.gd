class_name InventoryStyle extends Resource

@export var dimensions : Vector2i = Vector2i(1, 1)
@export var background_texture : Texture2D
@export var slot_texture : Texture2D
@export var alpha : float = 0.5 :
	set(value):
		alpha = clamp(value, 0.0, 1.0)
