class_name UpgradeDisplay
extends PanelContainer

signal selected

@export var upgrade : Upgrade

@onready var sprite: TextureRect = $Sprite
@onready var button: Button = $Button
@onready var name_label: RichTextLabel = $MarginContainer/VBoxContainer/MarginContainer/NameLabel
@onready var price_label: RichTextLabel = $MarginContainer/VBoxContainer/MarginContainer2/PriceLabel


func update_upgrade(u : Upgrade) -> void:
	upgrade = u
	sprite.texture = upgrade.sprite
	name_label.text = upgrade.name
	price_label.text = upgrade.name
	
func _on_button_pressed() -> void:
	selected.emit(self)

func buy(run : Game) -> void:
	upgrade.upgrade(run)
	queue_free()
