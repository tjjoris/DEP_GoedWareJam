extends Node2D


@export var clip = preload("res://audio/music/BGM_LumberingCall_0.wav")
@export var dialogue: DialogueSession

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if LevelLoader.bgm_audio.stream != clip:
		LevelLoader.bgm_audio.stream = clip
		LevelLoader.bgm_audio.play()
		
	if dialogue:
		GameManager.start_dialogue(dialogue)
		
	

