class_name UpgradeDaytime
extends Upgrade

func upgrade(run : Game) -> void:
	run.day_time = run.day_time * 1.2
