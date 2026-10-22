class_name Ingredient
extends TextureRect


@export var ingredient_resource : IngredientRes
@onready var cook_timer: Timer = $CookTimer

var held : bool = false

func _ready() -> void:
	texture = ingredient_resource.sprite

func hold() -> void:
	held = true
	if ingredient_resource.holding_sprite:
		texture = ingredient_resource.holding_sprite
		
func cook() -> void:
	cook_timer.start(ingredient_resource.cook_time)

func _process(_delta: float) -> void:
	if held:
		self.position = get_global_mouse_position() - (size / 2)

func _on_cook_timer_timeout() -> void:
	if ingredient_resource.cooks_into:
		ingredient_resource = ingredient_resource.cooks_into
		cook()
	else:
		ingredient_resource = preload("res://Ingredient/Resources/ashes.tres")
	texture = ingredient_resource.sprite
