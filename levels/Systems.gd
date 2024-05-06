extends Node2D


@export var clip = preload("res://audio/music/OverworldBGM_01.wav")

# On Level start
func _ready() -> void:
	if LevelLoader.bgm_audio.stream != clip:
		LevelLoader.bgm_audio.stream = clip
		LevelLoader.bgm_audio.play()
