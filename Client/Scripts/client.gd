class_name Client
extends Node2D

@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var client_resource : ClientResource

func update_resource(new_res : ClientResource) -> void:
	client_resource = new_res
	sprite.texture = client_resource.sprite

func emote(anim : String) -> void:
	animation_player.play(anim)

func animate_appear() -> void:
	animation_player.play("appear")

func animate_disappear() -> void:
	animation_player.play_backwards("appear")
