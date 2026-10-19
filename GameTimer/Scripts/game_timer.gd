class_name GameTimer
extends PanelContainer

signal client_timeout
signal day_timeout

@onready var face: Sprite2D = $Face
@onready var ship: Sprite2D = $Ship

@onready var text: RichTextLabel = $MarginContainer/Text

@onready var client_timer: Timer = $ClientTimer
@onready var day_timer: Timer = $DayTimer

const ship_start : float = 31.0
const ship_end : float = 83.0

var max_client_timer : float
var max_day_timer : float

func _process(_delta: float) -> void:
	var client_time_left : float = client_timer.time_left
	if client_time_left > 0.0:
		text.text = str(snapped(client_time_left, .1)) + "0"
		if client_time_left > max_client_timer / 2:
			face.frame = 0
		elif client_time_left > max_client_timer / 4:
			face.frame = 1
		else:
			face.frame = 2
	
	var day_time_left : float = day_timer.time_left
	if day_time_left > 0.0:
		ship.position.x = (day_time_left * (ship_start - ship_end) / max_day_timer) + ship_end


func start_day_timer(time : float) -> void:
	max_day_timer = time
	day_timer.start(max_day_timer)

func start_client_timer(time : float) -> void:
	max_client_timer = time
	client_timer.start(max_client_timer)
	face.visible = true

#TODO order needs to be discarded when client timer ends
func _on_client_timer_timeout() -> void:
	client_timeout.emit()
	face.visible = false
	text.text = "0.00"

func _on_day_timer_timeout() -> void:
	day_timeout.emit()
