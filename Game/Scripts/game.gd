class_name Game
extends Node2D

@onready var world: CanvasLayer = $World

@onready var game_camera: GameCamera = $World/GameCamera
@onready var screen_swapper_main: ScreenSwapper = $HUD/ScreenSwapperMain
@onready var screen_swapper_assembly: ScreenSwapper = $HUD/ScreenSwapperAssembly

@onready var burger: Burger = $World/Burger
@onready var ingredient_container: IngredientContainer = $World/IngredientContainer
@onready var ingredient_container_2: IngredientContainer = $World/IngredientContainer2



var selected_ingredient : Ingredient = null


func _ready() -> void:
	screen_swapper_main.selected.connect(_on_screen_swapper_selected)
	screen_swapper_assembly.selected.connect(_on_screen_swapper_selected)
	
	burger.selected.connect(_on_burger_selected)
	ingredient_container.selected.connect(_on_ingredient_selected)
	ingredient_container_2.selected.connect(_on_ingredient_selected)
	

func _on_screen_swapper_selected(location : String) -> void:
	var new_location : Vector2 = game_camera.positions.get(location)
	print(new_location)
	if new_location != null:
		game_camera.move_to(new_location)


func select_ingredient(ingredientres : IngredientRes) -> void:
	var new_ingredient : Ingredient = preload("res://Ingredient/Scenes/Ingredient.tscn").instantiate()
	new_ingredient.ingredient_resource = ingredientres
	selected_ingredient = new_ingredient
	world.add_child(selected_ingredient)


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
