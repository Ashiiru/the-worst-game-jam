class_name ScreenSwapper
extends PanelContainer

signal selected

@export var location : Enumerates.Locations

func _on_button_pressed() -> void:
	selected.emit(location)
