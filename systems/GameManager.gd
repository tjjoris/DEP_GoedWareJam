extends Node

# Tell Godot to ignore warnings of unused signals
#warning-ignore:unused_signal

signal collectable_value_changed(_current_level_collectables)
#signal toggle_game_paused(is_paused : bool)

static var is_shifted: bool = false
var total_collectables: int = 0
static var player_can_move: bool = true
static var player_is_dead: bool = false
static var player_can_phase: bool = true
static var dialogue_canvas: CanvasLayer
var _current_level_collectables = 0

var collectable_score: int:
	get:
		return _current_level_collectables
	set(value):
		_current_level_collectables = value
		collectable_value_changed.emit(_current_level_collectables)

#var game_paused : bool = false:
	#get:
		#return game_paused
	#set(value):
		#print("game paused request: " + str(value))
		#game_paused = value
		#get_tree().paused = game_paused
		#emit_signal("toggle_game_paused", game_paused)


func _ready() -> void:
	total_collectables = 0


#func _input(event : InputEvent):
	#if(event.is_action_pressed("ui_cancel")):
		#game_paused = !game_paused


func level_completed():
	total_collectables += _current_level_collectables
	print("Player has collected " + str(total_collectables) + " total samples!")
	_current_level_collectables = 0


func start_dialogue(dialogue:DialogueSession):
	if dialogue_canvas:
		dialogue_canvas.play_dialogue(dialogue)
