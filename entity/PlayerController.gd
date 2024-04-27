extends CharacterBody2D

# Exported movement variables
## The player's speed.
@export var SPEED: float = 220.0
## The player's movement acceleration.
@export var ACCELERATION: float = 1700.0
## The player's movement friction/deceleration.
@export var FRICTION: float = 1400.0

# Exporrted jump related variables
## Height of the player's jump.
@export var JUMP_VELOCITY: float = -520.0
## Amount of jumps the player can make.
@export var MAX_JUMPS: int = 2
## The player's gravity.
@export var GRAVITY: float = 1700.0
## Height of jump when jump button is held. 
## Amount of negative gravity added while holding jump.
@export var HELD_JUMP_HEIGHT = 8

# Internal jump related variables
var jumps_remaining: int = MAX_JUMPS
var has_jumped: bool = false

var air_time = 0.0
const BONUS_GRAVITY = 1.2

func _physics_process(delta: float) -> void:
	# Player is falling.
	if is_on_floor():
		air_time = 0.0
		jumps_remaining = MAX_JUMPS
		has_jumped = false
		# A possible way to limit the fall speed to not scale forever
		# clampf(velocity.y, JUMP_VELOCITY, GRAVITY)
	else:
		air_time += delta
	# Speeds up the players fall depending on how long they were in the air
	velocity.y += (GRAVITY + GRAVITY * air_time * BONUS_GRAVITY) * delta


	# Handles jump.
	if Input.is_action_just_pressed("jump"):# and is_on_floor():
		handle_jump(delta)
	if Input.is_action_pressed("jump"):
		velocity.y -= HELD_JUMP_HEIGHT

	# Get the input direction and handle the movement/deceleration.
	var direction: float = Input.get_axis("left", "right")	
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, FRICTION * delta)

	move_and_slide()


# Handles double jump
func handle_jump(delta: float) -> void:
	# Allows you to jump after falling from ledge
	if is_on_floor() == false and has_jumped == false:
		jumps_remaining -= 1

	# counts the amount of jumps remaining
	if jumps_remaining > 0:
		has_jumped = true
		jumps_remaining -= 1
		velocity.y = JUMP_VELOCITY
