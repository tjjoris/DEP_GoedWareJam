extends Node

# Tell Godot to ignore warnings of unused signals
#warning-ignore:unused_signal

signal collectable_value_changed(_current_level_collectables)

static var is_shifted: bool = false
var total_collectables: int = 0
static var player_can_move: bool = true
static var player_is_dead: bool = false
static var player_can_phase: bool = true

var _current_level_collectables = 0
var collectable_score: int:
	get:
		return _current_level_collectables
	set(value):
		_current_level_collectables = value
		collectable_value_changed.emit(_current_level_collectables)

func _ready() -> void:
	total_collectables = 0

static var dialogue_canvas: CanvasLayer

func level_completed():
	total_collectables += _current_level_collectables
	print("Player has collected " + str(total_collectables) + " total samples!")
	_current_level_collectables = 0


func start_dialogue(dialogue:DialogueSession):
	if dialogue_canvas:
		dialogue_canvas.play_dialogue(dialogue)
