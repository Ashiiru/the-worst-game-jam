class_name TutorialBox
extends PanelContainer

@onready var image: TextureRect = $MarginContainer3/PanelContainer/MarginContainer/PanelContainer/MarginContainer/PanelContainer/MarginContainer/pop_up_wrapper/TextureRect
@onready var button_prev: Button = $MarginContainer3/PanelContainer/MarginContainer/PanelContainer/MarginContainer/PanelContainer/MarginContainer/pop_up_wrapper/HBoxContainer/DoneContainer/Done/MarginContainer/ButtonPrev
@onready var button_next: Button = $MarginContainer3/PanelContainer/MarginContainer/PanelContainer/MarginContainer/PanelContainer/MarginContainer/pop_up_wrapper/HBoxContainer/DoneContainer2/Done/MarginContainer/ButtonNext

signal selected

const pages : Array[Texture2D] = [preload("uid://c0ufsw62d3xin"), preload("uid://cgirg8ttjeg2u"), preload("uid://vy7yaf2f6157")]
var curr : int = 0

func _on_button_prev_pressed() -> void:
	if curr > 0:
		curr -= 1
		image.texture = pages[curr]
		button_next.text = "Next"

func _on_button_next_pressed() -> void:
	if curr < 2:
		curr += 1
		image.texture = pages[curr]
		if curr == 2:
			button_next.text = "Done"
	else:
		selected.emit(self)
