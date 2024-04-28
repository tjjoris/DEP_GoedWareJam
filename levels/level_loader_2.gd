extends Node

#var next_scene: PackedScene = preload("res://levels/_level_blueprint.tscn")


func _my_level_was_completed():
	#print(next_scene)
	#sets next level to load to level_luke2
	get_tree().change_scene_to_file("res://levels/level_luke2.tscn")


func _on_load_level_2_button_pressed():
	_my_level_was_completed()


func _on_button_pressed():
	_my_level_was_completed()
	pass # Replace with function body.
