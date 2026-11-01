class_name OptionsBox
extends PanelContainer

signal selected

@onready var master_vol_slider: HSlider = $MarginContainer2/PanelContainer/MarginContainer/PanelContainer/MarginContainer/PanelContainer/MarginContainer/pop_up_wrapper/SliderGroupMaster/MasterVol/MarginContainer2/PanelContainer/MarginContainer2/MasterVolSlider
@onready var sfx_vol_slider: HSlider = $MarginContainer2/PanelContainer/MarginContainer/PanelContainer/MarginContainer/PanelContainer/MarginContainer/pop_up_wrapper/SliderGroupSfx/MasterVol/MarginContainer2/PanelContainer/MarginContainer2/SfxVolSlider
@onready var music_vol_slider: HSlider = $MarginContainer2/PanelContainer/MarginContainer/PanelContainer/MarginContainer/PanelContainer/MarginContainer/pop_up_wrapper/SliderGroupMusic/MasterVol/MarginContainer2/PanelContainer/MarginContainer2/MusicVolSlider


@onready var MASTER_BUS : int = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS : int = AudioServer.get_bus_index("Music")
@onready var SFX_BUS : int = AudioServer.get_bus_index("Sfx")


func _ready() -> void:
	master_vol_slider.value = AudioServer.get_bus_volume_linear(MASTER_BUS)
	music_vol_slider.value = AudioServer.get_bus_volume_linear(MUSIC_BUS)
	sfx_vol_slider.value = AudioServer.get_bus_volume_linear(SFX_BUS)


func _on_master_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MASTER_BUS, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_BUS, value < 0.05)


func _on_music_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS, value < 0.05)


func _on_sfx_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS, value < 0.05)


func _on_button_done_pressed() -> void:
	selected.emit(self)
