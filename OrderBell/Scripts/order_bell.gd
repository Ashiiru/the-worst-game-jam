class_name OrderBell
extends PanelContainer

signal selected


func _on_button_pressed() -> void:
	selected.emit()
