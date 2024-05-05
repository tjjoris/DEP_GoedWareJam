extends Area2D

@export var is_phased = false
@export var destroyed_on_contact = true
@onready var sprite_2d: Sprite2D = %Sprite2D

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

func _ready() -> void:
	handle_phase()


func _on_body_entered(body):
	if body.is_in_group("Player"):
		if self.is_in_group("IsCollectableSample"):
			GameManager.picked_up_collectable_sample()
			remove_object()
		if self.is_in_group("IsDeathTrap"):
			body.touched_shadow_monster_hitbox()


func remove_object():
	queue_free()


func do_phase_change(_entering_shadow_realm: bool):
	# can be called before node is ready
	#print(name + " sample phase changed called.")
	if sprite_2d == null:
		#print(name + "was not ready for phase change.")
		return
	handle_phase()


func handle_phase():
	#print(name+ " attempting to handle phase")
	if is_phased == GameManager.is_shifted:
		sprite_2d.visible = true
		collision_shape_2d.disabled = false
	else:
		sprite_2d.visible = false
		collision_shape_2d.disabled = true
