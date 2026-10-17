class_name Ingredient
extends Node2D

@onready var sprite: Sprite2D = $Sprite

@export var ingredient_resource : IngredientRes


func _ready() -> void:
	sprite.texture = ingredient_resource.sprite
	
func _process(_delta: float) -> void:
	self.position = get_global_mouse_position()
