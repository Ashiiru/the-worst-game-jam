class_name Door
extends TextureRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func appear() -> void:
	AudioManager.instance.garage_sound.play()
	animation_player.play("appear")

func dissappear() -> void:
	AudioManager.instance.garage_sound.play()
	animation_player.play_backwards("appear")
