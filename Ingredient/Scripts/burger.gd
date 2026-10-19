class_name Burger
extends PanelContainer

signal selected

var ingredients : Array[IngredientRes] = []


#debug
func print_ingredients() -> void:
	for i in ingredients:
		print(i.name)

func add_ingredient(ingredient : IngredientRes) -> void:
	ingredients.append(ingredient)

func pop_ingredient() -> IngredientRes:
	return ingredients.pop_back()

func _on_button_pressed() -> void:
	selected.emit()
