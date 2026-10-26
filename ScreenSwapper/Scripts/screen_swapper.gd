class_name ScreenSwapper
extends PanelContainer

@onready var label: Label = $Label

signal selected

@export var location : Enumerates.Locations

func _ready() -> void:
	label.text = Enumerates.Locations.find_key(location)

func _on_button_pressed() -> void:
	selected.emit(location)
