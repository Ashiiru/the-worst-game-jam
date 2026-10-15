extends Area2D

var dentro_do_ingrediente = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	if Input.is_action_pressed("mouse_botao_esq") and dentro_do_ingrediente == true:
		print("click nas coordenadas :" , mouse_pos)
		global_position = mouse_pos


func _on_mouse_entered() -> void:
	dentro_do_ingrediente = true


func _on_mouse_exited() -> void:
	dentro_do_ingrediente = false
