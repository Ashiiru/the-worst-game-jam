class_name ScreenSwapper
extends PanelContainer

@onready var label: Label = $Label

signal selected

@export var title : String = "Test"

func _ready() -> void:
	label.text = title

func _on_button_pressed() -> void:
	selected.emit(title)
