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
	var was_on_floor = is_on_floor()
	move_and_slide()
	if was_on_floor && !is_on_floor():
		jump_handler.start_coyote_timer()
	
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
	if not GameManager.player_can_move:
		return
	if Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("up"):
		animated_sprite.play("jump")
		jump_handler.handle_jump(self)
	if Input.is_action_pressed("jump") || Input.is_action_pressed("up"):
		velocity.y -= jump_handler.HELD_JUMP_HEIGHT


#func _unhandled_key_input(event: InputEvent) -> void:		
	#if event.is_action_pressed("phase_shift") and GameManager.player_can_move:
		#emit_signal("do_phase_shift")

func touched_shadow_monster_hitbox() -> void:
	# You can't kill what is already dead.
	if GameManager.player_is_dead:
		return
	GameManager.player_can_move = false
	GameManager.player_is_dead = true
	audio_player.play()
	animated_sprite.play("death")
	await get_tree().create_timer(2.0).timeout
	death()

func death() -> void:
	await get_tree().create_timer(2.0).timeout
	LevelLoader.reload_current_scene()


func _on_rift_shard_detector_body_entered(_body: Node2D) -> void:
	if GameManager.player_can_phase and GameManager.player_can_move:
		emit_signal("do_phase_shift")
