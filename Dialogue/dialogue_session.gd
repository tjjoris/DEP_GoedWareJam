extends Node
class_name DialogueSession


@export var repeatable:bool = false #determins if a dialouge session can be repeated.
@export var pause_during_dialogue = false # this will pause all game processing while playing this dialogue
@export var load_next_level = false # when set to true, will load next scene upon end of dialogue.
var can_start_session = true   #determins if this dialogue session can be started, prevents from unwanted repeating dialogue

func start_dialogue():
	if can_start_session == false:
		return
	GameManager.start_dialogue(self)
	can_start_session = false
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		start_dialogue()
