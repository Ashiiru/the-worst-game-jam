class_name Client
extends Node2D

const baseline_size : float = 120.0
const stool : float = 70.0

var move_tween : Tween

@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var client_profile : ClientProfile
@export var client_order : ClientOrder

func update_client(new_profile : ClientProfile, new_order : ClientOrder) -> void:
	client_profile = new_profile
	client_order = new_order
	sprite.texture = client_profile.sprite
	var sprite_size : Vector2 = sprite.texture.get_size()
	if sprite_size.y < 70:
		sprite.offset.x = 30
	else:
		sprite.offset.x = 0
	if sprite_size.x >= sprite_size.y:
		sprite.scale = sprite_size / Vector2(baseline_size, sprite_size.y * baseline_size / sprite_size.x)
	else:
		sprite.scale = sprite_size / Vector2(sprite_size.x * baseline_size / sprite_size.y, baseline_size)

func emote(anim : String) -> void:
	animation_player.play(anim)

func animate_appear() -> void:
	sprite.visible = true
	move_sprite_to(Vector2(0, (-sprite.texture.get_size().y * sprite.scale.y) / 2 - stool))

func animate_disappear() -> void:
	move_sprite_to(Vector2(0, (sprite.texture.get_size().y * sprite.scale.y) / 2 + stool))
	await move_tween.finished
	sprite.visible = false


func move_sprite_to(spot : Vector2) -> void:
	if move_tween:
		move_tween.kill()
	move_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	move_tween.tween_property(sprite, "position", spot, 1.).from_current()
