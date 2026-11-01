class_name DialogueBox
extends PanelContainer

@onready var shader: PanelContainer = $Shader

@onready var label: RichTextLabel = $Shader/DialogueContainer/Margin/Label
@onready var title_label: RichTextLabel = $MarginContainer2/TitleLabel

@export var min_size : Vector2 = Vector2(300, 100)

var stored_dialogue : String
var stored_translated : String

var text_tween : Tween
var prev : int

func _ready() -> void:
	shader.custom_minimum_size = min_size

func display_title(title : String) -> void:
	title_label.text = title

func display_stored_dialogue() -> void:
	label.text = stored_dialogue
	
func display_translated_dialogue() -> void:
	if stored_translated:
		label.text = stored_translated

func display_dialogue_animated(language : Enumerates.Species) -> void:
	match language:
		Enumerates.Species.HUMAN:
			AudioManager.instance.dialogue_sound.stream.set_stream(0, preload("uid://m8qjc6hk4245"))
		Enumerates.Species.GLORPI:
			AudioManager.instance.dialogue_sound.stream.set_stream(0, preload("uid://dixleppir6t15"))
		Enumerates.Species.CONSTRUCT:
			AudioManager.instance.dialogue_sound.stream.set_stream(0, preload("uid://cskryskkp6j6e"))
		Enumerates.Species.VASTER:
			AudioManager.instance.dialogue_sound.stream.set_stream(0, preload("uid://miwosq1gl7vj"))
	
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
	text_tween.tween_method(text_step, 0, text_size, text_size * .03)
	await text_tween.finished
	label.visible_characters = -1
	
func text_step(idx) -> void:
	if idx != prev:
		prev = idx
		AudioManager.instance.dialogue_sound.play()
		label.visible_characters = idx
