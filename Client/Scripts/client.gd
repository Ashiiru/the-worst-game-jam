class_name Client
extends Node2D

@onready var sprite: Sprite2D = $Sprite

@export var client_resource : ClientResource


func update_resource(new_res : ClientResource) -> void:
	client_resource = new_res
	sprite.texture = client_resource.sprite
