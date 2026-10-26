class_name DialogueBox
extends PanelContainer

@onready var label: RichTextLabel = $Margin/Label

var stored_dialogue : String
var stored_translated : String

var text_tween : Tween

func display_stored_dialogue() -> void:
	label.text = stored_dialogue
	
func display_translated_dialogue() -> void:
	if stored_translated:
		label.text = stored_translated

func display_dialogue_animated() -> void:
	label.visible_characters = 0
	label.text = stored_dialogue
	if text_tween:
		text_tween.kill()
	text_tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	var text_size : float = 0.0
	var in_parenthesis : bool = false
	for c in label.text:
		if in_parenthesis:
			if c == "]":
				in_parenthesis = false
		else:
			if c == "[":
				in_parenthesis = true
				text_size -= 1
			text_size += 1
	text_tween.tween_property(label, "visible_characters", text_size, text_size * .1)
	await text_tween.finished
	label.visible_characters = -1
