extends CanvasLayer

@onready var dialogue_container: MarginContainer = %DialogueContainer
@onready var message_label: Label = %MessageLabel
@onready var portrait_texture: TextureRect = %PortraitTexture
var current_session: DialogueSession
var dialogue_instances: Array[DialogueInstance] = []

var in_dialogue_state = false
var dialogue_next_ready = true
var pause_during_dialogue = false
var instance_index = 0


func _ready() -> void:
	GameManager.dialogue_canvas = self


func _input(_event) -> void:
	if not in_dialogue_state:
		return
	if Input.is_action_just_pressed("continue_dialogue") and dialogue_next_ready:
		print("continue dialogue pressed")
		continue_dialogue()


func play_dialogue(incoming_dialogue:DialogueSession):
	dialogue_instances.clear()
	current_session = incoming_dialogue
	instance_index = 0
	
	for child in current_session.get_children():
		if child is DialogueInstance:
			dialogue_instances.append(child)
	if dialogue_instances.size() > 0:
		initialize_dialogue()


func initialize_dialogue():
	in_dialogue_state = true
	setup_dialogue_panel()
	GameManager.player_can_move = false
	if pause_during_dialogue:
		get_tree().paused = true


func setup_dialogue_panel():
	message_label.text = dialogue_instances[instance_index].message
	if not dialogue_instances[instance_index].image == null:
		portrait_texture.texture = dialogue_instances[instance_index].image
	instance_index += 1
	dialogue_container.visible = true


func continue_dialogue():
	#instance_index += 1
	if dialogue_instances.is_empty():
		end_dialogue()
		return
	if instance_index >= dialogue_instances.size():
		end_dialogue()
		return
	setup_dialogue_panel()


func end_dialogue():
	# removes pesky inputs as you exit dialogue scene
	get_viewport().set_input_as_handled()
	dialogue_container.visible = false
	if current_session.repeatable:
		current_session.can_start_session = true
	in_dialogue_state = false
	# re-enable game state
	GameManager.player_can_move = true
	get_tree().paused = false
