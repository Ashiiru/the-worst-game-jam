class_name UpgradeDisplay
extends Interactible

signal selected
signal hovered
signal unhovered

@export var upgrade : Upgrade

@onready var sprite: TextureRect = $Sprite
@onready var button: Button = $Button
@onready var name_label: RichTextLabel = $MarginContainer/VBoxContainer/MarginContainer/NameLabel
@onready var price_label: RichTextLabel = $MarginContainer/VBoxContainer/MarginContainer2/PriceLabel


func update_upgrade(u : Upgrade) -> void:
	upgrade = u
	sprite.texture = u.sprite
	name_label.text = u.name
	price_label.text = str(u.cost) + "$"
	
func _on_button_pressed() -> void:
	selected.emit(self)

func _on_button_mouse_entered() -> void:
	hovered.emit(self)
	focus()

func _on_button_mouse_exited() -> void:
	unhovered.emit()
	unfocus()

func buy(run : Game) -> void:
	upgrade.upgrade(run)
	self.visible = false
