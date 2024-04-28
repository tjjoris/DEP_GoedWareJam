extends Sprite2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_parent().visibility = false
	set_process(false)
	
	
