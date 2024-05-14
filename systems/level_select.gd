extends ReferenceRect


func _on_button_pressed(level_index: int) -> void:
	# Because player is jumping to specific level, nuke total collected
	# TODO: specific score per level persistence. Would let people jump back to previous levels to collect samples they missed.
	GameManager.total_collectables = 0
	LevelLoader.load_scene(level_index)
