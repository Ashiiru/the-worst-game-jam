class_name Burger
extends Control

signal selected

var ingredients : Array[IngredientRes] = []


#debug
func print_ingredients() -> void:
	for i in ingredients:
		print(i.name)

func add_ingredient(ingredient : IngredientRes) -> void:
	ingredients.append(ingredient)
	print_ingredients()

func pop_ingredient() -> IngredientRes:
	print_ingredients()
	return ingredients.pop_back()

func _on_button_pressed() -> void:
	print("burger pressed")
	selected.emit()
