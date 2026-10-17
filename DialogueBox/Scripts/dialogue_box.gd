class_name DialogueBox
extends PanelContainer

@onready var label: RichTextLabel = $Margin/Label

var stored_dialogue : Array[String]
var curr_dialogue : int

func store_dialogue(dialogue : Array[String]) -> void:
	stored_dialogue = dialogue
	curr_dialogue = 0
	display_dialogue()


func display_dialogue() -> void:
	label.text = stored_dialogue[curr_dialogue]


func _on_button_pressed() -> void:
	if curr_dialogue < stored_dialogue.size() - 1:
		curr_dialogue += 1
	else:
		curr_dialogue = 0
	display_dialogue()
