class_name Game
extends Node2D

@onready var world: CanvasLayer = $World
@onready var animation_player: AnimationPlayer = $World/AnimationPlayer

@onready var game_camera: GameCamera = $World/GameCamera
@onready var game_timer: GameTimer = $World/GameTimer

@onready var screen_swapper_main: ScreenSwapper = $HUD/ScreenSwapperMain
@onready var screen_swapper_assembly: ScreenSwapper = $HUD/ScreenSwapperAssembly
@onready var input_blocker: ColorRect = $HUD/InputBlocker

@onready var client: Client = $World/Client
@onready var dialogue_box: DialogueBox = $World/DialogueBox

@onready var register: Register = $World/Register
@onready var order_bell: OrderBell = $World/OrderBell
@onready var translator: Translator = $World/Translator

@onready var burger: Burger = $World/Burger
@onready var grill: Grill = $World/Grill

@onready var ingredient_container: IngredientContainer = $World/IngredientContainer
@onready var ingredient_container_2: IngredientContainer = $World/IngredientContainer2
@onready var ingredient_container_3: IngredientContainer = $World/IngredientContainer3

@onready var upgrade_displays : Array[UpgradeDisplay] = [$World/UpgradeDisplay1,$World/UpgradeDisplay2, $World/UpgradeDisplay3, $World/UpgradeDisplay4]

@onready var receipt: Receipt = $World/Receipt

@onready var upgrades: ResourcePreloader = $Upgrades

#Its very important that client orders follow the naming convention of having the day the order is meant
#to appear on as the first character of their key in this node
@onready var client_orders: ResourcePreloader = $ClientOrders
@onready var client_profiles: ResourcePreloader = $ClientProfiles

var run_seed : Array[int] = []
var day : int = 0

var day_quota : float = 0.0
var day_expenses : float = 0.0
var day_revenue : float = 0.0
var day_perfect_orders : int = 0
var day_missed_orders : int = 0

var cash : float = 0.0
var selected_ingredient : Ingredient = null

var day_time : float = 70.0
var client_patience : float = 0.0

var max_errors : int = 2

#upgrade related variables
var upgrade_patience_multiplier : float = 1.0


func _ready() -> void:
	screen_swapper_main.selected.connect(_on_screen_swapper_selected)
	screen_swapper_assembly.selected.connect(_on_screen_swapper_selected)
	
	order_bell.selected.connect(_on_order_bell_selected)
	translator.selected.connect(_on_translator_selected)
	
	burger.selected.connect(_on_burger_selected)
	grill.selected.connect(_on_grill_selected)
	ingredient_container.selected.connect(_on_ingredient_selected)
	ingredient_container_2.selected.connect(_on_ingredient_selected)
	ingredient_container_3.selected.connect(_on_ingredient_selected)
	
	for display in upgrade_displays:
		display.selected.connect(_on_upgrade_selected)
	
	begin_run()
	begin_day()


func begin_run() -> void:
	for species in Enumerates.Species:
		run_seed.append(randi())


func begin_day() -> void:
	day += 1
	game_timer.start_day_timer(day_time)
	
	#TODO: Calculate day quota
	register.set_quota(day_quota)
	
	animation_player.play("day_start")
	

func add_client() -> void:
	if translator.online:
		translator.turn_off()
	
	var orders : PackedStringArray = client_orders.get_resource_list()
	var i : int = 0
	for o in orders:
		if int(o[0]) > day:
			break
		i += 1
	var client_order : ClientOrder = client_orders.get_resource(orders.get(randi_range(0, i)))
	i = 0
	var profiles : PackedStringArray = client_profiles.get_resource_list()
	var j : int = 0
	var found : bool = false
	for p in profiles:
		if p.contains(str(Enumerates.Species.find_key(client_order.species)).to_lower()):
			found = true
			j += 1
		else:
			if found:
				break
			i += 1
	var client_profile : ClientProfile = client_profiles.get_resource(profiles.get(randi_range(i, i + j - 1)))
	client.update_client(client_profile, client_order)
	animation_player.play("order_start")


#Can only be called by animations
func emote_client(emotion : String = "idle") -> void:
	var dialogue : String
	match emotion:
		"idle": 
			dialogue = client.client_order.dialogue
			client.emote("idle")
		"happy":
			dialogue = client.client_profile.dialogue_perfect
			client.emote("order_happy")
		"neutral":
			dialogue = client.client_profile.dialogue_okay
			client.emote("order_neutral")
		"angry":
			dialogue = client.client_profile.dialogue_bad
			client.emote("order_angry")
		"timeout":
			dialogue = client.client_profile.dialogue_timeout
			client.emote("order_angry")
	if not translator.translating and client.client_order.species != Enumerates.Species.HUMAN:
		dialogue_box.stored_translated = dialogue
		dialogue = encrypt_dialogue(dialogue)
	dialogue_box.stored_dialogue = dialogue
	dialogue_box.display_stored_dialogue()
	if animation_player.assigned_animation != "day_end":
		animation_player.pause()
	await dialogue_box.display_dialogue_animated()
	if animation_player.assigned_animation != "day_end":
		animation_player.play()


func encrypt_dialogue(dialogue : String) -> String:
	dialogue = dialogue.capitalize()
	for c in range(dialogue.length()):
		if dialogue[c] != " ":
			var new_unicode = ord(dialogue[c]) + run_seed[client.client_order.species]
			new_unicode = 65 + (new_unicode % 25)
			dialogue[c] = char(new_unicode)
	dialogue = "[font=" + Enumerates.get_species_font_path(client.client_order.species) + "]" + dialogue + "[/font]"
	return dialogue


func _on_translator_selected() -> void:
	if game_timer.client_timer.time_left > 0 and client.client_order.species != Enumerates.Species.HUMAN:
		if translator.online:
			if translator.translating:
				dialogue_box.display_stored_dialogue()
			else:
				dialogue_box.display_translated_dialogue()
			translator.translating = !translator.translating
		elif translator.charges > 0:
			translator.turn_on()
			dialogue_box.display_translated_dialogue()
		else:
			pass


func start_client_timer() -> void:
	#TODO: calculate initial client patience and start timer with that value
	client_patience = client.client_order.patience
	game_timer.start_client_timer(client_patience)


func _on_screen_swapper_selected(location : Enumerates.Locations) -> void:
	move_camera_to(location)

func move_camera_to(location : Enumerates.Locations) -> void:
	match location:
		Enumerates.Locations.MAIN:
			screen_swapper_main.visible = false
			screen_swapper_assembly.visible = true
		Enumerates.Locations.ASSEMBLY:
			screen_swapper_assembly.visible = false
			screen_swapper_main.visible = true
	game_camera.move_to(location)


func add_cash(amount : float) -> void:
	if amount == 0.0:
		return
	cash += amount
	register.set_cash(cash)
	var popup : CashPopUp = preload("res://CashPopUp/Scenes/CashPupUp.tscn").instantiate()
	popup.value = amount
	world.add_child(popup)


#returns the order's score and the max score it could have been worth
func rate_order() -> Vector2:
	var objective : Array[IngredientRes] = client.client_order.order.duplicate()
	var construction : Array[IngredientRes] = burger.ingredients.duplicate()
	var perfect_score : float = objective.size() * 2.0
	var score : float = 0.0
	var curr_time : float = game_timer.client_timer.time_left
	
	var remaining_objective : Dictionary
	var remaining_construction : Dictionary
	var correct : bool = false
	
	var errors : int = 0
	
	if curr_time == 0.0:
		return Vector2(-1.0, perfect_score)
	
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
	
	print("score is " + str(score))
	print("perfect score is: " + str(perfect_score))
	
	#too many missed or extra ingredients results in instant fail
	if errors > max_errors:
		print("too many errors, socre is 0")
		return Vector2(0.0,perfect_score)
	
	#rate time, if more than half the time is taken the score is penalized
	if curr_time < client_patience / 2.0:
		score = score * curr_time / client_patience
		print("time penalty " + str(curr_time/client_patience))
	
	return Vector2(score, perfect_score)


func _on_order_bell_selected() -> void:
	if not (game_timer.client_timer.time_left > 0.0 and burger.ingredients.size() > 0):
		return
	animation_player.play("order_end")


func _on_game_timer_client_timeout() -> void:
	animation_player.play("order_end")


func _on_game_timer_day_timeout() -> void:
	game_timer.client_timer.stop()
	receipt.set_receipt(day, cash, day_perfect_orders, day_missed_orders, day_revenue, day_expenses, day_quota)
	animation_player.play("day_end")

func submit_quota() -> void:
	cash -= day_quota
	if cash < 0.0:
		animation_player.play("run_game_over")
	else:
		animation_player.play("run_day_pass")
		

func submit_order() -> void:
	var scores : Vector2 = rate_order()
	var score : float = scores.x
	var perfect_score : float = scores.y
	print("final score " + str(score))
	
	pay_order(score)
	
	var correctness : float = score / perfect_score
	if correctness == 1.0:
		emote_client("happy")
		day_perfect_orders += 1
	elif correctness > 0.0:
		emote_client("neutral")
	elif correctness == 0.0:
		emote_client("angry")
		day_missed_orders += 1
	else:
		emote_client("timeout")
		day_missed_orders += 1
	
	game_timer.client_timer.stop()
	burger.clear_ingredients()


func pay_order(score : float) -> void:
	#TODO money calculation from score
	var pay : float = max(0.0, snapped(score, .1))
	day_revenue += pay
	add_cash(pay)
	

func select_ingredient(ingredientres : IngredientRes) -> void:
	var new_ingredient : Ingredient = preload("res://Ingredient/Scenes/Ingredient.tscn").instantiate()
	new_ingredient.ingredient_resource = ingredientres
	selected_ingredient = new_ingredient
	world.add_child(selected_ingredient)
	selected_ingredient.hold()


func clear_selected_ingredient() -> void:
	selected_ingredient.queue_free()
	selected_ingredient = null


func _on_ingredient_selected(ingredientres : IngredientRes) -> void:
	if selected_ingredient:
		if not (ingredientres.name == selected_ingredient.ingredient_resource.name):
			add_cash(selected_ingredient.ingredient_resource.cost)
			day_expenses -= selected_ingredient.ingredient_resource.cost
			clear_selected_ingredient()
			select_ingredient(ingredientres)
			add_cash(-selected_ingredient.ingredient_resource.cost)
			day_expenses += selected_ingredient.ingredient_resource.cost
		else:
			add_cash(selected_ingredient.ingredient_resource.cost)
			day_expenses -= selected_ingredient.ingredient_resource.cost
			clear_selected_ingredient()
	else:
		select_ingredient(ingredientres)
		add_cash(-selected_ingredient.ingredient_resource.cost)
		day_expenses += selected_ingredient.ingredient_resource.cost


func _on_burger_selected() -> void:
	if selected_ingredient:
		burger.add_ingredient(selected_ingredient)
		clear_selected_ingredient()
	elif burger.ingredients.size() > 0:
		select_ingredient(burger.pop_ingredient())


func _on_grill_selected() -> void:
	if selected_ingredient and grill.ingredient_container.get_child_count() < 1:
		grill.add_ingredient(selected_ingredient)
		clear_selected_ingredient()
	elif selected_ingredient:
		var temp : Ingredient = selected_ingredient.duplicate()
		clear_selected_ingredient()
		select_ingredient(grill.pop_ingredient())
		grill.add_ingredient(temp)
	elif grill.ingredient_container.get_child_count() > 0:
		select_ingredient(grill.pop_ingredient())


func _on_continue_button_pressed() -> void:
	animation_player.play("shop_start")


func add_shop() -> void:
	var upgrade_names : PackedStringArray = upgrades.get_resource_list()
	for display in upgrade_displays:
		display.update_upgrade(upgrades.get_resource(upgrade_names[randi_range(0, upgrade_names.size() - 1)]))

func _on_upgrade_selected(upgrade_display : UpgradeDisplay) -> void:
	if cash >= upgrade_display.upgrade.cost:
		upgrade_display.buy(self)
	else:
		pass

func _on_next_day_button_pressed() -> void:
	animation_player.play("shop_end")
