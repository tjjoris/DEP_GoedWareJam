extends CharacterBody2D

@onready var movement_handler: MovementHandler = $Movement_Handler
@onready var jump_handler: JumpHandler = $Jump_Handler


func _physics_process(delta: float) -> void:
	movement_handler.handle_gravity(self, delta)

	# Handles jump.
	if Input.is_action_just_pressed("jump"):
		jump_handler.handle_jump(self)
	if Input.is_action_pressed("jump"):
		velocity.y -= jump_handler.HELD_JUMP_HEIGHT

	# Get the input direction and handle the movement/deceleration.
	var direction: float = Input.get_axis("left", "right")
	movement_handler.handle_movement(self, direction, delta)

	move_and_slide()
	
func touched_shadow_monster_hitbox() -> void:
	death()
	
	
func death() -> void:
	LevelLoader2.reload_current_scene()
	
