extends Node
class_name DialogueSession

@export var dialogue_instances: Array = []
@export var repeatable:bool = false #determins if a dialouge session can be repeated.
var can_start_session = true   #determins if this dialogue session can be started, prevents from unwanted repeating dialogue
#var last_instance:DialogueInstance #stores the current dialogue instance not used
var instance_index:int = 0

func start_dialogue():
	if can_start_session == false:
		return
	can_start_session = false
	instance_index = 0
	get_parent().current_session = self
	
	for child in get_children():
		if child is DialogueInstance:
			dialogue_instances.append(child)
	set_dialogue()

	
	
func continue_dialogue():
	instance_index += 1
	if dialogue_instances == null:
		end_dialogue()
		return
	if instance_index >= dialogue_instances.size():
		end_dialogue()
		return
	if not dialogue_instances[instance_index] is DialogueInstance:
		end_dialogue()
		return
	set_dialogue()
	

func set_dialogue():
	if dialogue_instances[instance_index] == null:
		get_parent().visible = false
		end_dialogue()
		return
	get_parent().visible = true
	get_parent().set_dialogue_label(dialogue_instances[instance_index].message)
	if not dialogue_instances[instance_index].image == null:
		get_parent().set_dialogue_texture(dialogue_instances[instance_index].image)
	
	
func end_dialogue():
	get_parent().visible = false
	if repeatable:
		can_start_session = true
	#set_physics_process(true)


func _on_area_2d_body_entered(body: Node2D) -> void:
	start_dialogue()
	# Pause physics process until dialogue concluded?
	#set_physics_process(false)
	pass # Replace with function body.
