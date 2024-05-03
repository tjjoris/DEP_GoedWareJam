extends CharacterBody2D

signal do_phase_shift

@onready var movement_handler: MovementHandler = $Movement_Handler
@onready var jump_handler: JumpHandler = $Jump_Handler
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	movement_handler.handle_gravity(self, delta)
	if GameManager.player_can_move:
		
		# Get the input direction and handle the movement/deceleration.
		var direction: float = Input.get_axis("left", "right")
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		if is_on_floor() and GameManager.player_can_move:
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
	else:
		movement_handler.handle_movement(self, 0, delta)
	move_and_slide()

func _unhandled_key_input(event: InputEvent) -> void:		
	if event.is_action_pressed("phase_shift") and GameManager.player_can_move:
		emit_signal("do_phase_shift")

func touched_shadow_monster_hitbox() -> void:
	GameManager.player_can_move = false
	audio_player.play()
	animated_sprite.play("death")
	await get_tree().create_timer(3.0).timeout
	death()

func death() -> void:
	LevelLoader2.reload_current_scene()
	
