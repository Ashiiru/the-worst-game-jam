class_name UpgradeTranslatorUses
extends Upgrade

func upgrade(run : Game) -> void:
	run.translator.max_charges += 1
