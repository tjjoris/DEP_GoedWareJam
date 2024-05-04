extends Node

var current_scene = null
#scene index is the current scene/levels index which increments
#as new levels are loaded.
var scene_index:int = 0  
#the following array stores the scenes in order:
var levels = ["res://levels/_main_menu.tscn",
"res://levels/game_levels/level_intro00.tscn",
"res://levels/game_levels/level_naomi_00.tscn",
"res://levels/game_levels/jacob_level_01.tscn",
"res://levels/game_levels/jacob_level_02.tscn",
]

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func start_game():
	load_scene(1)
	
func load_scene(index:int):
	scene_index = index
	if scene_index >= levels.size():
		scene_index = 0
	GameManager._current_level_collectables = 0
	GameManager.player_can_move = true
	get_tree().change_scene_to_file(levels[scene_index])


func goto_next_scene():
	scene_index += 1
	load_scene(scene_index)


func reload_current_scene():
	# unsafe to reload scene atm, using deferred call so this gets called after all other code has finished
	call_deferred("deferred_reload_current_scene")
		
func deferred_reload_current_scene():
	print("Reloading: " + get_tree().current_scene.name)
	# It is now safe to reload the scene
	
	GameManager._current_level_collectables = 0
	GameManager.player_can_move = true
	get_tree().reload_current_scene()

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	
	GameManager.player_can_move = true
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene = get_tree().current_scene
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
