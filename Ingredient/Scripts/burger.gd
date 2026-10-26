class_name Burger
extends PanelContainer

signal selected

@onready var ingredient_container: VBoxContainer = $IngredientContainer

var ingredients : Array[IngredientRes] = []

#debug
func print_ingredients() -> void:
	for i in ingredients:
		print(i.name)

func add_ingredient(ingredient : Ingredient) -> void:
	var i : Ingredient = ingredient.duplicate()
	ingredient_container.add_child(i)
	if i.ingredient_resource.name == "Bread":
		for j in ingredients:
			if j.name == "Bread":
				i.texture = preload("res://Ingredient/Sprites/top_bun.png")
	i.z_index += ingredients.size()
	ingredient_container.move_child(i, 0)
	ingredients.append(ingredient.ingredient_resource)
		
func pop_ingredient() -> IngredientRes:
	var i : IngredientRes = ingredients.pop_back()
	ingredient_container.get_child(0).queue_free()
	return i

func clear_ingredients() -> void:
	ingredients.clear()
	for child in ingredient_container.get_children():
		child.queue_free()
		
func _on_button_pressed() -> void:
	selected.emit()
