class_name JumpHandler

extends Node2D

# Exporrted jump related variables
## Height of the player's jump.
@export var JUMP_VELOCITY: float = -520.0
## Amount of jumps the player can make.
@export var MAX_JUMPS: int = 2
## Height of jump when jump button is held. 
## Amount of negative gravity added while holding jump.
@export var HELD_JUMP_HEIGHT = 8

# Internal jump related variables
var jumps_remaining: int = MAX_JUMPS
var has_jumped: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	jumps_remaining = MAX_JUMPS


func handle_jump(entity: CharacterBody2D) -> void:
	# Allows you to jump after falling from ledge
	if entity.is_on_floor() == false and has_jumped == false:
		jumps_remaining -= 1

	# counts the amount of jumps remaining
	if jumps_remaining > 0:
		has_jumped = true
		jumps_remaining -= 1
		entity.velocity.y = JUMP_VELOCITY
