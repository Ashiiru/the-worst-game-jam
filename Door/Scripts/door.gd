class_name Door
extends TextureRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func appear() -> void:
	animation_player.play("appear")

func dissappear() -> void:
	animation_player.play_backwards("appear")
