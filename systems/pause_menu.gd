extends CanvasLayer

@onready var bgm_slider: HSlider = $ReferenceRect/MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/BGM_slider
@onready var sfx_slider: HSlider = $ReferenceRect/MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/SFX_slider
@onready var BGM_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(BGM_BUS_ID))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(SFX_BUS_ID))
	hide()
	#GameManager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)

func _input(event : InputEvent):
	if(event.is_action_pressed("ui_cancel")):
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			show()
		else:
			hide()

func _on_restart_button_pressed() -> void:
	print("restart button pressed!")
	LevelLoader.reload_current_scene()


func _on_main_menu_button_pressed() -> void:
	LevelLoader.load_scene(0)


#func _on_game_manager_toggle_game_paused(is_paused : bool):
	#if is_paused:
		#show()
	#else:
		#hide()


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	hide()



func _on_bgm_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(BGM_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(BGM_BUS_ID, value < 0.05)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)
