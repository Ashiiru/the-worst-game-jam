class_name OrderBell
extends Interactible

signal selected


func _on_button_pressed() -> void:
	selected.emit()
	wobble()


func _on_button_mouse_entered() -> void:
	focus()


func _on_button_mouse_exited() -> void:
	unfocus()
