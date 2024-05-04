extends Node

# Tell Godot to ignore warnings of unused signals
#warning-ignore:unused_signal

signal collectable_value_changed(total_collectables)

static var is_shifted: bool = false
static var player_can_move: bool = true
static var player_is_dead: bool = false
static var player_can_phase: bool = true

var total_collectables: int = 0
var collectable_score: int:
	get:
		return total_collectables
	set(value):
		total_collectables = value
		collectable_value_changed.emit(total_collectables)

func _ready() -> void:
	collectable_score = 0

static var dialogue_canvas: CanvasLayer


func start_dialogue(dialogue:DialogueSession):
	if dialogue_canvas:
		dialogue_canvas.play_dialogue(dialogue)
