class_name Translator
extends PanelContainer

signal selected

var online : bool = false
var translating : bool = false
var max_charges : int = 1
var charges : int = 1

func turn_on() -> void:
	online = true
	translating = true
	charges -= 1

func turn_off() -> void:
	online = false
	translating = false
	
func reset_charges() -> void:
	charges = max_charges

func _on_button_pressed() -> void:
	selected.emit()
