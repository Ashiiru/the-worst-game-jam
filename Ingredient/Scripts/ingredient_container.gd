class_name IngredientContainer
extends Control

signal selected

@export var ingredient : IngredientRes

func _on_button_pressed() -> void:
	print("ingredient_pressed")
	selected.emit(ingredient)
