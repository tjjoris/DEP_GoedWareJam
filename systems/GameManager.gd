extends Node

static var player_can_move: bool = true
static var player_is_dead: bool = false
static var player_can_phase: bool = true

static var dialogue_canvas: CanvasLayer

func start_dialogue(dialogue:DialogueSession):
	if dialogue_canvas:
		dialogue_canvas.play_dialogue(dialogue)
