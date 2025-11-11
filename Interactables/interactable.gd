class_name Interactable extends Area2D

signal interacted(source:Node2D)
@export var parent : Node2D
@export var sprite : Sprite2D

const OUTLINE_SHADER : Shader = preload("uid://bbqd5o24ax3fj")

func _ready() -> void:
	if not parent:
		parent = get_parent() as Node2D
	if parent.has_method("_on_interacted"):
		interacted.connect(parent._on_interacted)
	_find_sprite()

func interact(_source:Node2D) -> void:
	interacted.emit(_source)

func highlight()->void:
	if not sprite:
		return
	if not sprite.material is ShaderMaterial:
		return
	sprite.material.set_shader_parameter("enable", true)

func unhighlight()->void:
	if not sprite:
		return
	if not sprite.material is ShaderMaterial:
		return
	sprite.material.set_shader_parameter("enable", false)

func _find_sprite()->bool:
	if not parent:
		return false
	for child_node in parent.get_children():
		if child_node is Sprite2D:
			sprite = child_node
			if not sprite.material:
				sprite.material = ShaderMaterial.new()
				sprite.material.shader = OUTLINE_SHADER
			return true
	return false
	
