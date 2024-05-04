extends Node2D

@onready var bgm_slider: HSlider = $CanvasLayer/ColorRect/ReferenceRect/Panel/VBoxContainer/PanelContainer/VBoxContainer/BGM_slider
@onready var sfx_slider: HSlider = $CanvasLayer/ColorRect/ReferenceRect/Panel/VBoxContainer/PanelContainer/VBoxContainer/SFX_slider

@onready var BGM_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(BGM_BUS_ID))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(SFX_BUS_ID))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	LevelLoader.start_game()


func _on_bgm_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(BGM_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(BGM_BUS_ID, value < 0.05)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)
