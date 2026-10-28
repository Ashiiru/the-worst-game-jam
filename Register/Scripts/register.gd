class_name Register
extends PanelContainer

@onready var cash_label: RichTextLabel = $VBoxContainer/MarginContainer/CashLabel
@onready var quota_label: RichTextLabel = $VBoxContainer/MarginContainer2/QuotaLabel


func set_cash(amount : float) -> void:
	cash_label.text = str(amount) + "$"

func set_quota(amount : float) -> void:
	quota_label.text = "Quota: " + str(amount) + "$"
