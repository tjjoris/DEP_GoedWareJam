class_name JumpHandler

extends Node2D

@export var sfx_jump = preload("res://audio/sfx/jump00.wav")
@export var sfx_double_jump = preload("res://audio/sfx/doublejump00.wav")
@onready var coyote_timer: Timer = %CoyoteTimer
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

# Exporrted jump related variables
## Height of the player's jump.
@export var JUMP_VELOCITY: float = -520.0
## Amount of jumps the player can make.
@export var MAX_JUMPS: int = 2
## Height of jump when jump button is held. 
## Amount of negative gravity added while holding jump.
@export var HELD_JUMP_HEIGHT = 8
var _was_on_floor: bool


# Internal jump related variables
var jumps_remaining: int = MAX_JUMPS
var has_jumped: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	jumps_remaining = MAX_JUMPS


func handle_jump(entity: CharacterBody2D) -> void:
	set_jump_audio(entity)
	
	# Allows you to jump after falling from ledge
	if entity.is_on_floor() == false and coyote_timer.is_stopped() and has_jumped == false:
		jumps_remaining -= 1

	# counts the amount of jumps remaining
	if jumps_remaining > 0:
		has_jumped = true
		jumps_remaining -= 1
		entity.velocity.y = JUMP_VELOCITY
		audio_player.play()
	print(jumps_remaining)


func is_coyote_time() -> bool:
	var is_coyote_time = false
	return is_coyote_time


func start_coyote_timer():
	coyote_timer.start()
	pass

func set_jump_audio(entity: CharacterBody2D):
	# check if audio files are wired up first
	if sfx_jump and sfx_double_jump:
		# Set the audio sample based on if grounded or mid-air
		if entity.is_on_floor() or not coyote_timer.is_stopped():
			audio_player.stream = sfx_jump
		else:
			audio_player.stream = sfx_double_jump
