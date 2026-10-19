class_name IngredientContainer
extends PanelContainer

signal selected

@export var ingredient : IngredientRes

func _on_button_pressed() -> void:
	selected.emit(ingredient)
