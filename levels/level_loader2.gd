extends Node


#old unused level loading script which was causing problems
#func _my_level_was_completed():
	##print(next_scene)
	##sets next level to load to level_luke2
	#get_tree().change_scene_to_file("res://levels/level_luke2.tscn")




var current_scene = null
var scene_index:int = 0
signal goto_next_level
#this array stores the scenes in order:
var levels = ["res://levels/level_andrew.tscn",
"res://levels/level_ikhide.tscn",
"res://levels/level_jacob.tscn",
"res://levels/level_kay.tscn",
"res://levels/level_luke.tscn",
"res://levels/level_luke2.tscn",
"res://levels/level_naomi.tscn",
"res://levels/level_neff.tscn",
"res://levels/level_yan.tscn",
]

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)



func goto_next_scene():
	scene_index += 1
	goto_scene(levels[scene_index - 1])


func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
	
	# Add to 'scene_1.gd'.
