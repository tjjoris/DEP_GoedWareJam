extends CharacterBody2D

@onready var movement_handler: MovementHandler = $Movement_Handler
@onready var jump_handler: JumpHandler = $Jump_Handler

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var _is_dead = false

func _physics_process(delta: float) -> void:
	if not _is_dead:
		movement_handler.handle_gravity(self, delta)
		
		# Get the input direction and handle the movement/deceleration.
		var direction: float = Input.get_axis("left", "right")
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		if is_on_floor() and not _is_dead:
			if direction:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
		#elif velocity.y < 0:
			#animated_sprite.play("jump")
		elif velocity.y > 0:
			animated_sprite.play("fall")
		movement_handler.handle_movement(self, direction, delta)
		
		# Handles jump.
		if Input.is_action_just_pressed("jump"):
			animated_sprite.play("jump")
			jump_handler.handle_jump(self)
		if Input.is_action_pressed("jump"):
			velocity.y -= jump_handler.HELD_JUMP_HEIGHT

	move_and_slide()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and _is_dead:
		death()

func touched_shadow_monster_hitbox() -> void:
	_is_dead = true
	animated_sprite.play("death")

func death() -> void:
	LevelLoader2.reload_current_scene()
	
