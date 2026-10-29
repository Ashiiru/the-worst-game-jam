class_name IngredientContainer
extends Interactible

signal selected

@export var ingredient : IngredientRes

func _on_button_pressed() -> void:
	selected.emit(ingredient)
	wobble()


func _on_button_mouse_entered() -> void:
	focus()


func _on_button_mouse_exited() -> void:
	unfocus()
