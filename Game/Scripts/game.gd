class_name Game
extends Node2D

@onready var world: CanvasLayer = $World

@onready var game_camera: GameCamera = $World/GameCamera
@onready var game_timer: GameTimer = $World/GameTimer

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

var day_time : float = 120.0
var client_patience : float = 0.0

var max_errors : int = 2

var day_timer : float = 0.0


func _ready() -> void:
	screen_swapper_main.selected.connect(_on_screen_swapper_selected)
	screen_swapper_assembly.selected.connect(_on_screen_swapper_selected)
	
	order_bell.selected.connect(_on_order_bell_selected)
	
	burger.selected.connect(_on_burger_selected)
	ingredient_container.selected.connect(_on_ingredient_selected)
	ingredient_container_2.selected.connect(_on_ingredient_selected)
	
	begin_day()
	add_client()
	begin_order()

func begin_day() -> void:
	game_timer.start_day_timer(day_time)
	

func begin_order() -> void:
	add_client()
	display_client_dialogue()
	start_client_timer()
	

func add_client() -> void:
	#TODO: missing code to pick out a random client
	client.update_resource(preload("res://Client/Resources/test_client.tres"))


func display_client_dialogue() -> void:
	#TODO: missing cypher system
	dialogue_box.store_dialogue(client.client_resource.dialogue)


func start_client_timer() -> void:
	#TODO: calculate initial client patience and start timer with that value
	client_patience = client.client_resource.patience
	game_timer.start_client_timer(client_patience)
	pass


func _on_screen_swapper_selected(location : String) -> void:
	var new_location : Vector2 = game_camera.positions.get(location)
	if new_location != null:
		game_camera.move_to(new_location)


func add_cash(amount : float) -> void:
	cash += amount
	register.set_cash(cash)


#returns the order's score and the max score it could have been worth
func rate_order() -> Vector2:
	var objective : Array[IngredientRes] = client.client_resource.order.duplicate()
	var construction : Array[IngredientRes] = burger.ingredients.duplicate()
	var perfect_score : float = objective.size() * 2.0
	var score : float = 0.0
	
	var remaining_objective : Dictionary
	var remaining_construction : Dictionary
	var correct : bool = false
	
	var errors : int = 0
	
	#rate matching ingredients and double points for order accuracy
	for i in range(max(len(objective), len(construction))):
		correct = false
		if i < len(objective) and i < len(construction) and objective[i] == construction[i]:
			correct = true
			score += 2
		if not correct and i < len(objective):
			var o_name : String = objective[i].name
			remaining_objective[o_name] = remaining_objective.get(o_name, 0) + 1
		if not correct and  i < len(construction):
			var c_name : String = construction[i].name
			remaining_construction[c_name] = remaining_construction.get(c_name, 0) + 1
			
	for k in remaining_objective.keys():
		var difference : float = abs(remaining_objective.get(k) - remaining_construction.get(k, 0))
		score += min(remaining_objective.get(k), remaining_construction.get(k, 0))
		errors += int(difference)
	
	#too many missed or extra ingredients results in instant fail
	if errors > max_errors:
		return Vector2(0, perfect_score)
	
	#rate time, if more than half the time is taken the score is penalized
	var curr_time : float = game_timer.client_timer.time_left
	if curr_time < client_patience / 2.0:
		score = score * curr_time / client_patience
		print("time penalty " + str(curr_time/client_patience))
	
	return Vector2(score, perfect_score)


func _on_order_bell_selected() -> void:
	#TODO only submit order if there is a burger built and if client is ordering
	#TODO award player money and call next client
	print(rate_order())
	burger.ingredients.clear()


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
