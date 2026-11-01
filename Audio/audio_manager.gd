extends Node2D

@onready var menu_music: AudioStreamPlayer = $MenuMusic
@onready var game_music: AudioStreamPlayer = $GameMusic

@onready var bell_sound: AudioStreamPlayer = $BellSound
@onready var food_sound: AudioStreamPlayer = $FoodSound

@onready var receipt_sound: AudioStreamPlayer = $ReceiptSound
@onready var cookie_sound: AudioStreamPlayer = $CookieSound
@onready var garage_sound: AudioStreamPlayer = $GarageSound
@onready var translator_sound: AudioStreamPlayer = $TranslatorSound
@onready var dialogue_sound: AudioStreamPlayer = $DialogueSound


static var instance

var current_music : AudioStreamPlayer

var out_tween : Tween
var in_tween : Tween

func _ready() -> void:
	instance = self


func fade_out(sound : AudioStreamPlayer, duration : float) -> void:
	if out_tween:
		out_tween.kill()
	out_tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	out_tween.tween_property(sound, "volume_db", -80.0, duration)
	#await out_tween.finished
	#sound.stop()
	#sound.volume_db = 0.0


func fade_in(sound : AudioStreamPlayer, duration : float, from : float) -> void:
	if in_tween:
		in_tween.kill()
	sound.volume_db = -80.0
	sound.play()
	sound.seek(from)
	in_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	in_tween.tween_property(sound, "volume_db", -20.0, duration)
	#await in_tween.finished


func swap_music(music : AudioStreamPlayer) -> void:
	var pos : float = 0.0
	if current_music:
		pos = current_music.get_playback_position()
		fade_out(current_music, 2)
	fade_in(music, 2, pos)
	current_music = music
