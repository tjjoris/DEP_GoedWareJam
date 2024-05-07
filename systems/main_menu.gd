extends Node2D

@onready var bgm_slider: HSlider = $CanvasLayer/ColorRect/ReferenceRect/Panel/VBoxContainer/PanelContainer/VBoxContainer/BGM_slider
@onready var sfx_slider: HSlider = $CanvasLayer/ColorRect/ReferenceRect/Panel/VBoxContainer/PanelContainer/VBoxContainer/SFX_slider

@onready var BGM_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

@onready var main_menu: ReferenceRect = $CanvasLayer/ColorRect/ReferenceRect
@onready var level_select: ReferenceRect = $CanvasLayer/ColorRect/LevelSelect
@onready var about_page: ReferenceRect = $CanvasLayer/ColorRect/AboutPage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(BGM_BUS_ID))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(SFX_BUS_ID))
	main_menu.visible = true
	level_select.visible = false
	about_page.visible = false


func _on_button_pressed() -> void:
	LevelLoader.start_game()


func _on_bgm_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(BGM_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(BGM_BUS_ID, value < 0.05)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)


func _on_level_select_pressed() -> void:
	main_menu.visible = false
	level_select.visible = true


func _on_back_from_level_select_pressed() -> void:
	main_menu.visible = true
	level_select.visible = false


func _on_back_from_about_pressed() -> void:
	about_page.visible = false
	main_menu.visible = true


func _on_about_pressed() -> void:
	about_page.visible = true
	main_menu.visible = false
