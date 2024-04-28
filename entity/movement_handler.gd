class_name MovementHandler
extends Node2D

@onready var jump_handler: JumpHandler = $"../Jump_Handler"

# Exported movement variables
## The player's speed.
@export var SPEED: float = 220.0
## The player's movement acceleration.
@export var ACCELERATION: float = 1700.0
## The player's movement friction/deceleration.
@export var FRICTION: float = 1400.0
## The player's gravity.
@export var GRAVITY: float = 1700.0

var air_time = 0.0
const BONUS_GRAVITY = 1.2


# Handles movement for a given entity 
func handle_movement(entity: CharacterBody2D, direction: float, delta: float) -> void:
	# Moves in a given direction
	if direction:
		entity.velocity.x = move_toward(entity.velocity.x, direction * SPEED, ACCELERATION * delta)
	# Slows down to a stop
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0.0, FRICTION * delta)


func handle_gravity(entity: CharacterBody2D, delta: float) -> void:
	# Player is falling.
	if entity.is_on_floor():
		air_time = 0.0
		jump_handler.jumps_remaining = jump_handler.MAX_JUMPS
		jump_handler.has_jumped = false
	else:
		air_time += delta

	# Speeds up the players fall depending on how long they were in the air
	# Clamps fall speed to not go over a set amount
	entity.velocity.y += (GRAVITY + GRAVITY * air_time * BONUS_GRAVITY) * delta
	entity.velocity.y = clampf(entity.velocity.y, jump_handler.JUMP_VELOCITY, GRAVITY/2)
