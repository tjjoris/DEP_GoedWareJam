extends CharacterBody2D

signal do_phase_shift

@onready var movement_handler: MovementHandler = $Movement_Handler
@onready var jump_handler: JumpHandler = $Jump_Handler
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	GameManager.player_is_dead = false

func _physics_process(delta: float) -> void:
	movement_handler.handle_gravity(self, delta)
	var direction: float = 0.0
	if GameManager.player_can_move:
		direction = Input.get_axis("left", "right")
	set_animation(direction)
	movement_handler.handle_movement(self, direction, delta)
	handle_jump()
	move_and_slide()
	
func set_animation(direction: float):
	if GameManager.player_is_dead:
		# death animation triggered elsewhere, this prevents animation looping.
		return
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	if is_on_floor():
		if direction:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
	elif velocity.y > 0:
		animated_sprite.play("fall")
		

func handle_jump():
	if Input.is_action_just_pressed("jump") and GameManager.player_can_move:
		animated_sprite.play("jump")
		jump_handler.handle_jump(self)
	if Input.is_action_pressed("jump"):
		velocity.y -= jump_handler.HELD_JUMP_HEIGHT


func _unhandled_key_input(event: InputEvent) -> void:		
	if event.is_action_pressed("phase_shift") and GameManager.player_can_move:
		emit_signal("do_phase_shift")

func touched_shadow_monster_hitbox() -> void:
	GameManager.player_can_move = false
	GameManager.player_is_dead = true
	audio_player.play()
	animated_sprite.play("death")
	await get_tree().create_timer(3.0).timeout
	death()

func death() -> void:
	LevelLoader2.reload_current_scene()
	
