class_name CreditsBox
extends PanelContainer

signal selected

func _on_button_done_pressed() -> void:
	selected.emit(self)
