class_name OrderBell
extends Interactible

signal selected


func _on_button_pressed() -> void:
	selected.emit()
	AudioManager.instance.bell_sound.play()
	wobble()


func _on_button_mouse_entered() -> void:
	focus()


func _on_button_mouse_exited() -> void:
	unfocus()
