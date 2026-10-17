class_name Client
extends Node2D

@onready var sprite: Sprite2D = $Sprite

@export var client_resource : ClientResource


func _ready() -> void:
	sprite.texture = client_resource.sprite
