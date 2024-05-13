extends Node

# Tell Godot to ignore warnings of unused signals
#warning-ignore:unused_signal

signal collectable_value_changed(_current_level_collectables)

static var is_shifted: bool = false
var total_collectables: int = 0
var max_total_collectables: int = 40
static var player_can_move: bool = true
static var player_is_dead: bool = false
static var player_can_phase: bool = true
static var dialogue_canvas: CanvasLayer
var _current_level_collectables = 0
var dialogue_sessions : Array[DialogueSession] = []

var collectable_score: int:
	get:
		return _current_level_collectables

func picked_up_collectable_sample():
	_current_level_collectables += 1
	collectable_value_changed.emit(_current_level_collectables)


func _ready() -> void:
	total_collectables = 0


func level_completed():
	total_collectables += _current_level_collectables
	print("Player has collected " + str(total_collectables) + " total samples!")
	_current_level_collectables = 0


func start_dialogue(dialogue:DialogueSession):
	if dialogue_canvas and not dialogue_sessions.has(dialogue):
		print_debug(dialogue_sessions.size())
		dialogue_sessions.append(dialogue)
		dialogue_canvas.play_dialogue(dialogue)
