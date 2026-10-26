class_name Receipt
extends PanelContainer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var title: RichTextLabel = $MarginContainer/VBoxContainer2/VBoxContainer/MarginContainer/Title
@onready var starting_cash_value: RichTextLabel = $MarginContainer/VBoxContainer2/VBoxContainer/MarginContainer6/StartingCashValue
@onready var perfect_orders_value: RichTextLabel = $MarginContainer/VBoxContainer2/VBoxContainer/MarginContainer7/PerfectOrdersValue
@onready var missed_orders_value: RichTextLabel = $MarginContainer/VBoxContainer2/VBoxContainer/MarginContainer8/MissedOrdersValue
@onready var revenue_value: RichTextLabel = $MarginContainer/VBoxContainer2/VBoxContainer/MarginContainer2/RevenueValue
@onready var expenses_value: RichTextLabel = $MarginContainer/VBoxContainer2/VBoxContainer/MarginContainer3/ExpensesValue
@onready var quota_value: RichTextLabel = $MarginContainer/VBoxContainer2/VBoxContainer/MarginContainer4/QuotaValue
@onready var remaining_value: RichTextLabel = $MarginContainer/VBoxContainer2/VBoxContainer/MarginContainer5/RemainingValue
@onready var result: RichTextLabel = $MarginContainer/VBoxContainer2/MarginContainer/Result

const good_result_messages : Array[String] = ["GOOD JOB! :)", "NICE! :)", "WELL DONE! :)", "NANA IS PROUD! :)"]
const okay_result_messages : Array[String] = ["HANG IN THERE!", "LIVING ON THE EDGE!", "SCRAPING BY!"]
const bad_result_messages : Array[String] = ["IT'S SO OVER.", "GAME OVER.", "YOU'RE COOKED."]

func set_receipt(day : int, cash : float, perfect_orders : int, missed_orders : int, revenue : float, expenses : float, quota : float) -> void:
	var remainder : float = cash - quota
	title.text = "Day " + str(day) + " Results"
	starting_cash_value.text = str(cash) + "$"
	perfect_orders_value.text = str(perfect_orders)
	missed_orders_value.text = str(missed_orders)
	revenue_value.text = "+" + str(revenue) + "$"
	expenses_value.text = "-" + str(expenses) + "$"
	quota_value.text = "-" + str(quota) + "$"
	remaining_value.text = str(remainder) + "$"
	
	if remainder < 0.0:
		remaining_value.set("theme_override_colors/default_color", Color(0.788, 0.196, 0.404, 1.0))
		result.set("theme_override_colors/default_color", Color(0.788, 0.196, 0.404, 1.0))
		result.text = bad_result_messages.pick_random()
	elif remainder < 10.0:
		remaining_value.set("theme_override_colors/default_color", Color(0.623, 0.87, 0.164, 1.0))
		result.set("theme_override_colors/default_color", Color(0.87, 0.87, 0.87, 1.0))
		result.text = okay_result_messages.pick_random()
	else:
		remaining_value.set("theme_override_colors/default_color", Color(0.623, 0.87, 0.164, 1.0))
		result.set("theme_override_colors/default_color", Color(0.623, 0.87, 0.164, 1.0))
		result.text = good_result_messages.pick_random()

func appear() -> void:
	animation_player.play("appear")
	
func disappear() -> void:
	animation_player.play("disappear")
	
