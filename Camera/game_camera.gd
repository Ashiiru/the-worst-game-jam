class_name GameCamera
extends Camera2D

var positions : Dictionary = {
	"Main" : Vector2(0,0),
	"Assembly" : Vector2(0, 360),
	"Grill" : Vector2(640, 360)
}

@export var move_time : float = .5

var move_tween : Tween


func move_to(location : Vector2) -> void:
	if move_tween:
		move_tween.kill()
	move_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	move_tween.tween_property(self, "position", location, move_time)
