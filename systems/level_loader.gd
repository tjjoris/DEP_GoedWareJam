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
"res://levels/game_levels/andrew_level_01.tscn",
]


func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)


func start_game():
	load_scene(1)


func goto_next_scene():
	scene_index += 1
	load_scene(scene_index)


func load_scene(index:int):
	scene_index = index
	if scene_index >= levels.size():
		scene_index = 0
	initialize_play()
	get_tree().change_scene_to_file(levels[scene_index])


func reload_current_scene():
	# unsafe to reload scene atm, using deferred call so this gets called after all other code has finished
	call_deferred("deferred_reload_current_scene")


func deferred_reload_current_scene():
	print("Reloading: " + get_tree().current_scene.name)
	# It is now safe to reload the scene
	initialize_play()
	get_tree().reload_current_scene()


func initialize_play():
	get_tree().paused = false
	GameManager._current_level_collectables = 0
	GameManager.player_can_move = true

