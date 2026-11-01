class_name UpgradeTranslatorCost
extends Upgrade


func upgrade(run : Game) -> void:
	run.translator.price -= 0.05
