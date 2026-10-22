class_name Grill
extends PanelContainer

signal selected

@onready var ingredient_container: HBoxContainer = $IngredientContainer

func add_ingredient(ingredient : Ingredient) -> void:
	var i : Ingredient = ingredient.duplicate()
	ingredient_container.add_child(i)
	i.cook()

func pop_ingredient() -> IngredientRes:
	var popped : IngredientRes = ingredient_container.get_child(0).ingredient_resource
	ingredient_container.get_child(0).queue_free()
	return popped

func _on_button_pressed() -> void:
	selected.emit()
