class_name Translator
extends Interactible

signal selected

@onready var label: RichTextLabel = $MarginContainer/Label

var online : bool = false
var translating : bool = false
var max_charges : int = 1
var charges : int = 1

func turn_on() -> void:
	online = true
	translating = true
	charges -= 1
	display_on()

func turn_off() -> void:
	online = false
	translating = false
	update_display_charges()
	
func reset_charges() -> void:
	charges = max_charges
	update_display_charges()

func _on_button_pressed() -> void:
	selected.emit()
	wobble()

func update_display_charges() -> void:
	if charges == 0:
		label.set("theme_override_colors/default_color", Color(0.788, 0.196, 0.404, 1.0))
	else:
		label.set("theme_override_colors/default_color", Color(0.631, 0.875, 0.165, 1.0))
	label.text = str(charges)

func display_on() -> void:
	label.set("theme_override_colors/default_color", Color("0ca8a4"))
	label.text = ":)"


func _on_button_mouse_entered() -> void:
	focus()

func _on_button_mouse_exited() -> void:
	unfocus()
