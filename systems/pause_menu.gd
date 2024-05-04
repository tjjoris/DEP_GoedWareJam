extends CanvasLayer

func _ready() -> void:
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

