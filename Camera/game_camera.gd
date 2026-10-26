class_name GameCamera
extends Camera2D

var positions : Dictionary = {
	Enumerates.Locations.MAIN : Vector2(0,0),
	Enumerates.Locations.ASSEMBLY : Vector2(0, 360),
	Enumerates.Locations.HOUSE : Vector2(-640, 0),
	Enumerates.Locations.SHOP : Vector2(640,0)
}

@export var move_time : float = .5

var move_tween : Tween

func move_to(location : Enumerates.Locations) -> void:
	if move_tween:
		move_tween.kill()
	move_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	move_tween.tween_property(self, "position", positions.get(location), move_time)
