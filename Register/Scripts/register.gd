class_name Register
extends PanelContainer

@onready var label: RichTextLabel = $Label

func set_cash(amount : float) -> void:
	label.text = str(amount) + "$"
