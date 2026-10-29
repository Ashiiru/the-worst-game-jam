class_name Grill
extends Interactible

signal selected

@onready var ingredient_container: GridContainer = $MarginContainer/IngredientContainer
@onready var texture_rect: TextureRect = $TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func add_ingredient(ingredient : Ingredient) -> void:
	var i : Ingredient = ingredient.duplicate()
	ingredient_container.add_child(i)
	i.cook()
	animation_player.play("on")

func pop_ingredient() -> IngredientRes:
	var popped : IngredientRes = ingredient_container.get_child(0).ingredient_resource
	ingredient_container.get_child(0).free()
	if ingredient_container.get_children().size() == 0:
		animation_player.play("off")
	return popped

func _on_button_pressed() -> void:
	selected.emit()
	wobble()

func _on_button_mouse_entered() -> void:
	focus()

func _on_button_mouse_exited() -> void:
	unfocus()
