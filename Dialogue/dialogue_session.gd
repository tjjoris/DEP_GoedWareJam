extends Node
class_name DialogueSession


@export var repeatable:bool = false #determins if a dialouge session can be repeated.
var can_start_session = true   #determins if this dialogue session can be started, prevents from unwanted repeating dialogue
#var last_instance:DialogueInstance #stores the current dialogue instance not used

func start_dialogue():
	if can_start_session == false:
		return
	get_parent().play_dialogue(self)
	can_start_session = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		start_dialogue()


func _on_level_exit_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		start_dialogue()
