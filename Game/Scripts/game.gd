class_name Game
extends Node2D

@onready var burger: Burger = $Burger
@onready var ingredient_container: IngredientContainer = $IngredientContainer
@onready var ingredient_container_2: IngredientContainer = $IngredientContainer2



var selected_ingredient : Ingredient = null


func _ready() -> void:
	burger.selected.connect(_on_burger_selected)
	ingredient_container.selected.connect(_on_ingredient_selected)
	ingredient_container_2.selected.connect(_on_ingredient_selected)


func select_ingredient(ingredientres : IngredientRes) -> void:
	var new_ingredient : Ingredient = preload("res://Ingredient/Scenes/Ingredient.tscn").instantiate()
	new_ingredient.ingredient_resource = ingredientres
	selected_ingredient = new_ingredient
	add_child(selected_ingredient)


func clear_selected_ingredient() -> void:
	selected_ingredient.queue_free()
	selected_ingredient = null


func _on_ingredient_selected(ingredientres : IngredientRes) -> void:
	if selected_ingredient:
		if not (ingredientres.name == selected_ingredient.ingredient_resource.name):
			clear_selected_ingredient()
			select_ingredient(ingredientres)
		else:
			clear_selected_ingredient()
	else:
		select_ingredient(ingredientres)


func _on_burger_selected() -> void:
	if selected_ingredient:
		burger.add_ingredient(selected_ingredient.ingredient_resource)
		clear_selected_ingredient()
	elif burger.ingredients.size() > 0:
		select_ingredient(burger.pop_ingredient())
