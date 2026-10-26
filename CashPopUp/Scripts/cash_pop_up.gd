class_name CashPopUp
extends Label

var value : float = 0.0
var modulate_tween : Tween

func _ready() -> void:
	if value >= 0.0:
		set("theme_override_colors/font_color", Color(0.623, 0.87, 0.164, 1.0))
		text = "+" + str(value) + "$"
	else:
		set("theme_override_colors/font_color", Color(0.788, 0.196, 0.404, 1.0))
		text = str(value) + "$"
	position = get_global_mouse_position() - size/2
	modulate_tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	modulate_tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), .7)
	await modulate_tween.finished
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position -= Vector2(0, 40*delta)
