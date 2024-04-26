extends Node

var next_scene: PackedScene = preload("res://levels/_level_blueprint.tscn")


func _my_level_was_completed():
	print(next_scene)
	#get_tree().change_scene_to_packed(next_scene)
	get_tree().change_scene_to_file("res://levels/level_luke_2.tscn")


func _on_load_level_2_button_pressed():
	#var test = next_scene.instantiate()
	#add_child(test)
	_my_level_was_completed()
	pass # Replace with function body.
