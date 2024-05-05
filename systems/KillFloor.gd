extends Area2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@export var player_fall = preload("res://audio/sfx/LongFall00.wav")
@export var monster_fall = preload("res://audio/sfx/RoughLanding00.wav")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		audio_player.stream = player_fall
		audio_player.play()
		body.death()
	else:
		# kill any non-player entities that fall into the kill floor so they aren't falling forever.
		audio_player.stream = monster_fall
		audio_player.play()
		body.queue_free()
