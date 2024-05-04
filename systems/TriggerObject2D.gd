extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var is_phased = false
@export var destroyed_on_contact = true
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Player has collected a sample!")
		queue_free()



func _ready() -> void:
	handle_phase()

func do_phase_change(_entering_shadow_realm: bool):
	# can be called before node is ready
	if sprite_2d == null:
		return
	handle_phase()


func handle_phase():
	if is_phased == GameManager.is_shifted:
		sprite_2d.visible = true
		collision_shape_2d.set_process(true)
	else:
		sprite_2d.visible = false
		collision_shape_2d.set_process(false)
