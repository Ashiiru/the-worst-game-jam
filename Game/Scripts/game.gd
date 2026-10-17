class_name Game
extends Node2D

@onready var world: CanvasLayer = $World

@onready var game_camera: GameCamera = $World/GameCamera
@onready var screen_swapper_main: ScreenSwapper = $HUD/ScreenSwapperMain
@onready var screen_swapper_assembly: ScreenSwapper = $HUD/ScreenSwapperAssembly

@onready var client: Client = $World/Client
@onready var dialogue_box: DialogueBox = $World/DialogueBox

@onready var register: Register = $World/Register
@onready var order_bell: OrderBell = $World/OrderBell

@onready var burger: Burger = $World/Burger
@onready var ingredient_container: IngredientContainer = $World/IngredientContainer
@onready var ingredient_container_2: IngredientContainer = $World/IngredientContainer2


var cash : float = 0.0
var selected_ingredient : Ingredient = null


func _ready() -> void:
	screen_swapper_main.selected.connect(_on_screen_swapper_selected)
	screen_swapper_assembly.selected.connect(_on_screen_swapper_selected)
	
	order_bell.selected.connect(_on_order_bell_selected)
	
	burger.selected.connect(_on_burger_selected)
	ingredient_container.selected.connect(_on_ingredient_selected)
	ingredient_container_2.selected.connect(_on_ingredient_selected)
	
	add_client()
	

func add_client() -> void:
	#TODO: missing code to pick out a random client
	client.update_resource(preload("res://Client/Resources/test_client.tres"))
	#TODO: adding needs to place it in the right layer
	display_client_dialogue()


func display_client_dialogue() -> void:
	#TODO: missing cypher system
	dialogue_box.store_dialogue(client.client_resource.dialogue)


func _on_screen_swapper_selected(location : String) -> void:
	var new_location : Vector2 = game_camera.positions.get(location)
	print(new_location)
	if new_location != null:
		game_camera.move_to(new_location)


func add_cash(amount : float) -> void:
	cash += amount
	register.set_cash(cash)


func _on_order_bell_selected() -> void:
	#TODO rate order based on burger contents and timer left
	pass


func select_ingredient(ingredientres : IngredientRes) -> void:
	var new_ingredient : Ingredient = preload("res://Ingredient/Scenes/Ingredient.tscn").instantiate()
	new_ingredient.ingredient_resource = ingredientres
	selected_ingredient = new_ingredient
	world.add_child(selected_ingredient)
	add_cash(-selected_ingredient.ingredient_resource.cost)
	

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
