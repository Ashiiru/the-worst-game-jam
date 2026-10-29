class_name Interactible
extends PanelContainer

var scale_tween : Tween

func unfocus() -> void:
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	scale_tween.tween_property(self, "scale", Vector2(1.0, 1.0), .3)
	
func focus() -> void:
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	scale_tween.tween_property(self, "scale", Vector2(1.2, 1.2), .3)

func wobble() -> void:
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	scale_tween.tween_property(self, "scale", Vector2(1.0, 1.0), .1)
	scale_tween.tween_property(self, "scale", Vector2(1.4, 1.4), .1)
	scale_tween.tween_property(self, "scale", Vector2(1.2, 1.2), .1)
